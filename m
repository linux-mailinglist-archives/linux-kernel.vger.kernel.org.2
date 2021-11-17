Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3272C45461E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 13:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237148AbhKQMJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 07:09:29 -0500
Received: from smtp95.ord1c.emailsrvr.com ([108.166.43.95]:60076 "EHLO
        smtp95.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237133AbhKQMJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 07:09:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1637150786;
        bh=aFVNKWDIjqY/p+jMzpUsrJx95Fbvc+3m9j/mU0AuLV0=;
        h=From:To:Subject:Date:From;
        b=S/18qZGtkx/JhlkWRPDvfB0t+6oi5SX7t4GQV9pCMV8ru9n5LV1rbG2Lkl+bb0/5t
         o7IAAIC+/ic12r0tsPIJqRfvD7DPyvCio9OXz6TWdEorGHIq98gMo1VZoRHVCjhyDk
         C22VRrxj3nkfNg+V68Q0zUEZq7rhRgDjFpAmHMXw=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp20.relay.ord1c.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 025ECE00F0;
        Wed, 17 Nov 2021 07:06:25 -0500 (EST)
From:   Ian Abbott <abbotti@mev.co.uk>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>
Subject: [PATCH 2/5] comedi: ni_routing: tools: Update due to moved COMEDI headers
Date:   Wed, 17 Nov 2021 12:06:00 +0000
Message-Id: <20211117120604.117740-3-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211117120604.117740-1-abbotti@mev.co.uk>
References: <20211117120604.117740-1-abbotti@mev.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: b7289a69-3998-4ed4-bad0-ca7f3c79a866-3-1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building of the tools for converting the NI routing information between
CSV files (for maintenance) and C files (for building) was broken by the
move of the main COMEDI header files to "include/uapi/linux/" and
"include/linux/".  (These tools are not built as part of the normal
kernel build process.)  Fix it in the Makefile.

A slight niggle is that `#include <linux/comedi.h>` needs to work when
compiling the `convert_c_to_py` program, but it cannot use a `-I` option
referring to the "uapi" include directory because that interferes with
inclusion of other system headers.  So it uses `-I.` and makes a local
copy (actually a symbolic link) as "./linux/comedi.h".

Also remove some unneeded cruft such as the `-D"BIT(x)=(1<<(x))"`
preprocessor flag.

Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
 .../drivers/ni_routing/tools/.gitignore       |  1 +
 .../comedi/drivers/ni_routing/tools/Makefile  | 29 ++++++++++++-------
 2 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/comedi/drivers/ni_routing/tools/.gitignore b/drivers/comedi/drivers/ni_routing/tools/.gitignore
index e3ebffcd900e..c12f825db266 100644
--- a/drivers/comedi/drivers/ni_routing/tools/.gitignore
+++ b/drivers/comedi/drivers/ni_routing/tools/.gitignore
@@ -5,4 +5,5 @@ ni_values.py
 convert_c_to_py
 c/
 csv/
+linux/
 all_cfiles.c
diff --git a/drivers/comedi/drivers/ni_routing/tools/Makefile b/drivers/comedi/drivers/ni_routing/tools/Makefile
index 6e92a06a44cb..31212101b3bc 100644
--- a/drivers/comedi/drivers/ni_routing/tools/Makefile
+++ b/drivers/comedi/drivers/ni_routing/tools/Makefile
@@ -3,7 +3,7 @@
 # 	ni_route_values.h
 #	ni_device_routes.h
 # in order to do this, we are also generating a python representation (using
-# ctypesgen) of ../../comedi.h.
+# ctypesgen) of ../../../../../include/uapi/linux/comedi.h.
 # This allows us to sort NI signal/terminal names numerically to use a binary
 # search through the device_routes tables to find valid routes.
 
@@ -30,13 +30,21 @@ ALL:
 
 everything : csv-files c-files csv-blank
 
-CPPFLAGS=-D"BIT(x)=(1UL<<(x))" -D__user=
+CPPFLAGS = -D__user=
+INC_UAPI = ../../../../../include/uapi
 
-comedi_h.py : ../../../comedi.h
+comedi_h.py: $(INC_UAPI)/linux/comedi.h
 	ctypesgen $< --include "sys/ioctl.h" --cpp 'gcc -E $(CPPFLAGS)' -o $@
 
-convert_c_to_py: all_cfiles.c
-	gcc -g convert_c_to_py.c -o convert_c_to_py -std=c99
+convert_c_to_py: all_cfiles.c linux/comedi.h
+	gcc -g -I. convert_c_to_py.c -o convert_c_to_py -std=c99
+
+# Create a local 'linux/comedi.h' for use when compiling 'convert_c_to_py.c'
+# with the '-I.' option.  (Cannot specify '-I../../../../../include/uapi'
+# because that interferes with inclusion of other system headers.)
+linux/comedi.h: $(INC_UAPI)/linux/comedi.h
+	mkdir -p linux
+	ln -snf ../$< $@
 
 ni_values.py: convert_c_to_py
 	./convert_c_to_py
@@ -44,7 +52,7 @@ ni_values.py: convert_c_to_py
 csv-files : ni_values.py comedi_h.py
 	./convert_py_to_csv.py
 
-csv-blank :
+csv-blank : comedi_h.py
 	./make_blank_csv.py
 	@echo New blank csv signal table in csv/blank_route_table.csv
 
@@ -62,17 +70,16 @@ clean-partial :
 	$(RM) -rf comedi_h.py ni_values.py convert_c_to_py all_cfiles.c *.pyc \
 		__pycache__/
 
-clean : partial_clean
-	$(RM) -rf c/ csv/
+clean : clean-partial
+	$(RM) -rf c/ csv/ linux/
 
 # Note:  One could also use ctypeslib in order to generate these files.  The
 # caveat is that ctypeslib does not do a great job at handling macro functions.
 # The make rules are as follows:
-# comedi.h.xml : ../../comedi.h
+# comedi.h.xml : $(INC_UAPI)/linux/comedi.h
 # 	# note that we have to use PWD here to avoid h2xml finding a system
 # 	# installed version of the comedilib/comedi.h file
-# 	h2xml ${PWD}/../../comedi.h -c -D__user="" -D"BIT(x)=(1<<(x))" \
-# 		-o comedi.h.xml
+# 	h2xml ${PWD}/$(INC_UAPI)/linux/comedi.h -c D__user="" -o comedi.h.xml
 #
 # comedi_h.py : comedi.h.xml
 # 	xml2py ./comedi.h.xml -o comedi_h.py
-- 
2.33.0

