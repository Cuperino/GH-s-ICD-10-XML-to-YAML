#!/usr/bin/awk -f

# GH's ICD-10 XML to YAML
# Copyright (C) 2020 Imaginary Sense Inc.
# Written by Javier O. Cordero Pérez <javier@imaginary.tech>

# GH's ICD-10 XML to YAML is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# GH's ICD-10 XML to YAML is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with GH's ICD-10 XML to YAML.  If not, see <https://www.gnu.org/licenses/>.

# The following program extracts ICD-10 data from GNU Health's diseases.xml and
# converts it into a valid YAML file that fits our use requirements.  ICD-10 data
# is copyrighted by the WHO, it is up to you to license ICD-10 from WHO if you are
# to include ICD-10 in comercialy used software.  For more information on how to
# license ICD-10, see <https://www.who.int/about/licensing/Internettext_FAQ.pdf>.

# BEGIN { action; }  # Left for reference

# Pattern matching

/<record/ {
	print "- model: medicalorders.diagnosis\n	fields: "
}

/<field/ {

	# Changes to the entire line

	# Delete unnecesary text
	gsub("\"></field>", "", $0)
	gsub("</field>", "", $0)
	gsub("<field name=\"", "", $0)

	# Replace entire line portions
	gsub("\">", ": ", $0)
	gsub("\" ref=\"", ": ", $0)

	# Changes to individual columns

	# Conditional field name changes
	if ($1=="code:") $1="\ticd_10:"
	if ($1=="category:") $1="\ticd_10_cat:"

	# Generate output
	print "\t" $0
}

# END { action; }'  # Left for reference

# Accept file input argument
input_file
