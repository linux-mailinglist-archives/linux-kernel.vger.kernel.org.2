Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF3B43F61FF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 17:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238457AbhHXPt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 11:49:57 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:45911 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238287AbhHXPt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 11:49:56 -0400
Received: from localhost.localdomain (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 17OFmRk4007583;
        Wed, 25 Aug 2021 00:48:28 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 17OFmRk4007583
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1629820108;
        bh=Ja3N+HjtjaIU5nLg+1JURr3ykjAZgyE44nlGlYY37IQ=;
        h=From:To:Cc:Subject:Date:From;
        b=gSXgU1uTCXcYG5tXWcfbjdJK9IpY2xDyCKYTmb9bG5yR3DMJddaJ8AcLwJdIa4PBK
         fshqAme+OGa1Sq0NE7F9oPEFaBORwgyuQo5DqbMl8qU6uAiX56rCBM2BwK8BW1eZWY
         I8NIFYS1nCzTybZA2XrQK9mH0XsATCrVTdvQJ3zIA2RyrkthM6FKomrsQWOBdzf/ZT
         QrcFFSPzZHYRduiX4V/AZ2ie/hjnAbQrVgTkpOGj6OQfcY0w2fkNBXBsf3G0DzFEVf
         wanSDLoj8y/JXUep4adWgoujPmwpXL1Ddq1KLGHCROpeLQzuseVZPg7blDAH3wAjYl
         Xsgwa5/Uj6ubA==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] parisc: remove unused arch/parisc/boot/install.sh and its phony target
Date:   Wed, 25 Aug 2021 00:48:20 +0900
Message-Id: <20210824154820.293290-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Parisc has two similar installation scripts:

  arch/parisc/install.sh
  arch/parisc/boot/install.sh

The latter is never used because 'make ARCH=parisc install' always
invokes the 'install' target in arch/parisc/Makefile.

The target in arch/parisc/boot/Makefile is not used either.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2:
  - Remove arch/parisc/boot/install.sh

 arch/parisc/boot/Makefile   |  4 ---
 arch/parisc/boot/install.sh | 65 -------------------------------------
 2 files changed, 69 deletions(-)
 delete mode 100644 arch/parisc/boot/install.sh

diff --git a/arch/parisc/boot/Makefile b/arch/parisc/boot/Makefile
index 61f44142cfe1..b873ee4720ca 100644
--- a/arch/parisc/boot/Makefile
+++ b/arch/parisc/boot/Makefile
@@ -15,7 +15,3 @@ $(obj)/bzImage: $(obj)/compressed/vmlinux FORCE
 
 $(obj)/compressed/vmlinux: FORCE
 	$(Q)$(MAKE) $(build)=$(obj)/compressed $@
-
-install: $(CONFIGURE) $(obj)/bzImage
-	sh -x  $(srctree)/$(obj)/install.sh $(KERNELRELEASE) $(obj)/bzImage \
-	      System.map "$(INSTALL_PATH)"
diff --git a/arch/parisc/boot/install.sh b/arch/parisc/boot/install.sh
deleted file mode 100644
index 8f7c365fad83..000000000000
--- a/arch/parisc/boot/install.sh
+++ /dev/null
@@ -1,65 +0,0 @@
-#!/bin/sh
-#
-# arch/parisc/install.sh, derived from arch/i386/boot/install.sh
-#
-# This file is subject to the terms and conditions of the GNU General Public
-# License.  See the file "COPYING" in the main directory of this archive
-# for more details.
-#
-# Copyright (C) 1995 by Linus Torvalds
-#
-# Adapted from code in arch/i386/boot/Makefile by H. Peter Anvin
-#
-# "make install" script for i386 architecture
-#
-# Arguments:
-#   $1 - kernel version
-#   $2 - kernel image file
-#   $3 - kernel map file
-#   $4 - default install path (blank if root directory)
-#
-
-verify () {
-	if [ ! -f "$1" ]; then
-		echo ""                                                   1>&2
-		echo " *** Missing file: $1"                              1>&2
-		echo ' *** You need to run "make" before "make install".' 1>&2
-		echo ""                                                   1>&2
-		exit 1
-	fi
-}
-
-# Make sure the files actually exist
-
-verify "$2"
-verify "$3"
-
-# User may have a custom install script
-
-if [ -n "${INSTALLKERNEL}" ]; then
-  if [ -x ~/bin/${INSTALLKERNEL} ]; then exec ~/bin/${INSTALLKERNEL} "$@"; fi
-  if [ -x /sbin/${INSTALLKERNEL} ]; then exec /sbin/${INSTALLKERNEL} "$@"; fi
-fi
-
-# Default install
-
-if [ "$(basename $2)" = "zImage" ]; then
-# Compressed install
-  echo "Installing compressed kernel"
-  base=vmlinuz
-else
-# Normal install
-  echo "Installing normal kernel"
-  base=vmlinux
-fi
-
-if [ -f $4/$base-$1 ]; then
-  mv $4/$base-$1 $4/$base-$1.old
-fi
-cat $2 > $4/$base-$1
-
-# Install system map file
-if [ -f $4/System.map-$1 ]; then
-  mv $4/System.map-$1 $4/System.map-$1.old
-fi
-cp $3 $4/System.map-$1
-- 
2.30.2

