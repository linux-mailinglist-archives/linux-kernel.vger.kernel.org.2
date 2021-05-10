Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50249378251
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 12:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbhEJKeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 06:34:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:60610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231476AbhEJKa3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 06:30:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BCFBB61876;
        Mon, 10 May 2021 10:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620642443;
        bh=DCzAPb0+P13G/K4ZTmc6PzdHY7JpS97/Ox5bBlyIV9E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p1d7hdSEXeDppD8E2FJiYio7zufy809l1/J1++10/fHk3ieJsd2N2dx5TafCz5EDZ
         t8G//iatXSGXjqP9hqrYAL09sLQK4XaYrGJqTIlGgGKrzukREjV5bJgdZZW5fNTMoA
         eDXdsjR1gL+WWJeLCjtA/Ko7yI2B2WLKNBQq5mHBamSy18xqxmud7ZirevCa5WZkKH
         6vq8xMsqbCpFmOraBfyfaLdFtlETQ7WvfjOIvdnkprgLxQ/T256dseHg3jsKbBvq1o
         GJwyLLrGQl76QiLHTQQg3N3C/w5MoSu5l5hvsQipM5LHZNy+Y5VYzeUT3jPRNPT9XW
         KK0ykIxhuJrow==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lg38D-000UPc-9W; Mon, 10 May 2021 12:27:21 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH 20/53] docs: usb: avoid using UTF-8 chars
Date:   Mon, 10 May 2021 12:26:32 +0200
Message-Id: <9bfd540aae6f2b0bb7791dd61af270f9e37033fd.1620641727.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1620641727.git.mchehab+huawei@kernel.org>
References: <cover.1620641727.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While UTF-8 characters can be used at the Linux documentation,
the best is to use them only when ASCII doesn't offer a good replacement.
So, replace the occurences of the following UTF-8 characters:

	- U+201c ('“'): LEFT DOUBLE QUOTATION MARK
	- U+201d ('”'): RIGHT DOUBLE QUOTATION MARK
	- U+feff ('﻿'): ZERO WIDTH NO-BREAK SPACE

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/usb/ehci.rst           |  2 +-
 Documentation/usb/gadget_printer.rst |  2 +-
 Documentation/usb/mass-storage.rst   | 36 ++++++++++++++--------------
 Documentation/usb/mtouchusb.rst      |  2 +-
 Documentation/usb/usb-serial.rst     |  2 +-
 5 files changed, 22 insertions(+), 22 deletions(-)

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
diff --git a/Documentation/usb/mtouchusb.rst b/Documentation/usb/mtouchusb.rst
index d1111b74bf75..5ae1f74fe74b 100644
--- a/Documentation/usb/mtouchusb.rst
+++ b/Documentation/usb/mtouchusb.rst
@@ -1,4 +1,4 @@
-﻿================
+================
 mtouchusb driver
 ================
 
diff --git a/Documentation/usb/usb-serial.rst b/Documentation/usb/usb-serial.rst
index 8fa7dbd3da9a..69586aeb60bb 100644
--- a/Documentation/usb/usb-serial.rst
+++ b/Documentation/usb/usb-serial.rst
@@ -1,4 +1,4 @@
-﻿==========
+==========
 USB serial
 ==========
 
-- 
2.30.2

