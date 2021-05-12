Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C428A37BD47
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 14:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbhELMxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 08:53:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:52626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231274AbhELMww (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 08:52:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5F3C361425;
        Wed, 12 May 2021 12:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620823902;
        bh=2FDMIArPOpuk55O7C3w/LcLh1KAxn8zpOct9V1QDSls=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pT6D1Z015Ck6zlMR43tAeDWfUuFg2MzmLs3rq+RBbuzv6SmWjDOfXC4iha8tH9rwG
         lCzokfbvmLfnvVgmtFR8oOVIMh2VqGCyWfGqIlMDs3B6xMPwLIRKtGWwDghO4mcy/Y
         SQjC3RCgJN+ICVuFh1Aib799sXcLaZ9XaevUAtMgnC4YFiIG6WOcwUhstQqsE1M+el
         lP25WHLX8q7JHsc4sOPF02Y5OXRjONLm9RL8SHZ2eSxwBWLXFDV5srP8EaghXzdGI6
         24IXFMKNcGejHUtvNY3eSDot2ljGyd4fJ3rH8NL28I/dfeiK3BrhIs5pZxDLEaE/BG
         CGKngjI9q1oBw==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lgoKy-0018hZ-Ga; Wed, 12 May 2021 14:51:40 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH v2 12/40] docs: usb: Use ASCII subset instead of UTF-8 alternate symbols
Date:   Wed, 12 May 2021 14:50:16 +0200
Message-Id: <8fbbe15863ac0bfdeab799fd03333d13e25c11c3.1620823573.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1620823573.git.mchehab+huawei@kernel.org>
References: <cover.1620823573.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The conversion tools used during DocBook/LaTeX/Markdown->ReST conversion
and some automatic rules which exists on certain text editors like
LibreOffice turned ASCII characters into some UTF-8 alternatives that
are better displayed on html and PDF.

While it is OK to use UTF-8 characters in Linux, it is better to
use the ASCII subset instead of using an UTF-8 equivalent character
as it makes life easier for tools like grep, and are easier to edit
with the some commonly used text/source code editors.

Also, Sphinx already do such conversion automatically outside literal blocks:
   https://docutils.sourceforge.io/docs/user/smartquotes.html

So, replace the occurences of the following UTF-8 characters:

	- U+201c ('“'): LEFT DOUBLE QUOTATION MARK
	- U+201d ('”'): RIGHT DOUBLE QUOTATION MARK
	- U+feff ('﻿'): ZERO WIDTH NO-BREAK SPACE

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/usb/ehci.rst           |  2 +-
 Documentation/usb/gadget_printer.rst |  2 +-
 Documentation/usb/mass-storage.rst   | 36 ++++++++++++++--------------
 3 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/Documentation/usb/ehci.rst b/Documentation/usb/ehci.rst
index 31f650e7c1b4..76190501907a 100644
--- a/Documentation/usb/ehci.rst
+++ b/Documentation/usb/ehci.rst
@@ -1,4 +1,4 @@
-﻿===========
+===========
 EHCI driver
 ===========
 
diff --git a/Documentation/usb/gadget_printer.rst b/Documentation/usb/gadget_printer.rst
index 5e5516c69075..e611a6d91093 100644
--- a/Documentation/usb/gadget_printer.rst
+++ b/Documentation/usb/gadget_printer.rst
@@ -1,4 +1,4 @@
-﻿===============================
+===============================
 Linux USB Printer Gadget Driver
 ===============================
 
diff --git a/Documentation/usb/mass-storage.rst b/Documentation/usb/mass-storage.rst
index d181b47c3cb6..71dfd09b50a4 100644
--- a/Documentation/usb/mass-storage.rst
+++ b/Documentation/usb/mass-storage.rst
@@ -40,7 +40,7 @@ Module parameters
     This parameter lists paths to files or block devices used for
     backing storage for each logical unit.  There may be at most
     FSG_MAX_LUNS (8) LUNs set.  If more files are specified, they will
-    be silently ignored.  See also “luns” parameter.
+    be silently ignored.  See also "luns" parameter.
 
     *BEWARE* that if a file is used as a backing storage, it may not
     be modified by any other process.  This is because the host
@@ -56,18 +56,18 @@ Module parameters
   - removable=b[,b...]
 
     This parameter specifies whether each logical unit should be
-    removable.  “b” here is either “y”, “Y” or “1” for true or “n”,
-    “N” or “0” for false.
+    removable.  "b" here is either "y", "Y" or "1" for true or "n",
+    "N" or "0" for false.
 
     If this option is set for a logical unit, gadget will accept an
-    “eject” SCSI request (Start/Stop Unit).  When it is sent, the
+    "eject" SCSI request (Start/Stop Unit).  When it is sent, the
     backing file will be closed to simulate ejection and the logical
     unit will not be mountable by the host until a new backing file is
-    specified by userspace on the device (see “sysfs entries”
+    specified by userspace on the device (see "sysfs entries"
     section).
 
     If a logical unit is not removable (the default), a backing file
-    must be specified for it with the “file” parameter as the module
+    must be specified for it with the "file" parameter as the module
     is loaded.  The same applies if the module is built in, no
     exceptions.
 
@@ -76,13 +76,13 @@ Module parameters
     and because it seems like a saner default after all.  Thus to
     maintain compatibility with older kernels, it's best to specify
     the default values.  Also, if one relied on old default, explicit
-    “n” needs to be specified now.
+    "n" needs to be specified now.
 
-    Note that “removable” means the logical unit's media can be
+    Note that "removable" means the logical unit's media can be
     ejected or removed (as is true for a CD-ROM drive or a card
     reader).  It does *not* mean that the entire gadget can be
     unplugged from the host; the proper term for that is
-    “hot-unpluggable”.
+    "hot-unpluggable".
 
   - cdrom=b[,b...]
 
@@ -107,7 +107,7 @@ Module parameters
     This parameter specifies whether FUA flag should be ignored in SCSI
     Write10 and Write12 commands sent to given logical units.
 
-    MS Windows mounts removable storage in “Removal optimised mode” by
+    MS Windows mounts removable storage in "Removal optimised mode" by
     default.  All the writes to the media are synchronous, which is
     achieved by setting the FUA (Force Unit Access) bit in SCSI
     Write(10,12) commands.  This forces each write to wait until the
@@ -127,11 +127,11 @@ Module parameters
     capped.
 
     If this parameter is provided, and the number of files specified
-    in “file” argument is greater then the value of “luns”, all excess
+    in "file" argument is greater then the value of "luns", all excess
     files will be ignored.
 
     If this parameter is not present, the number of logical units will
-    be deduced from the number of files specified in the “file”
+    be deduced from the number of files specified in the "file"
     parameter.  If the file parameter is missing as well, one is
     assumed.
 
@@ -217,18 +217,18 @@ Relation to file storage gadget
   All users need to transition to the Mass Storage Gadget.  The two
   gadgets behave mostly the same from the outside except:
 
-  1. In FSG the “removable” and “cdrom” module parameters set the flag
+  1. In FSG the "removable" and "cdrom" module parameters set the flag
      for all logical units whereas in MSG they accept a list of y/n
      values for each logical unit.  If one uses only a single logical
      unit this does not matter, but if there are more, the y/n value
      needs to be repeated for each logical unit.
 
-  2. FSG's “serial”, “vendor”, “product” and “release” module
+  2. FSG's "serial", "vendor", "product" and "release" module
      parameters are handled in MSG by the composite layer's parameters
-     named respectively: “iSerialnumber”, “idVendor”, “idProduct” and
-     “bcdDevice”.
+     named respectively: "iSerialnumber", "idVendor", "idProduct" and
+     "bcdDevice".
 
-  3. MSG does not support FSG's test mode, thus “transport”,
-     “protocol” and “buflen” FSG's module parameters are not
+  3. MSG does not support FSG's test mode, thus "transport",
+     "protocol" and "buflen" FSG's module parameters are not
      supported.  MSG always uses SCSI protocol with bulk only
      transport mode and 16 KiB buffers.
-- 
2.30.2

