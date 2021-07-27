Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04A663D6C2F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 04:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234592AbhG0CRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 22:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234438AbhG0CRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 22:17:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23E0C061757
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 19:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=ufowFuNuNaJGOwhEapir9LnGgTlR2Oi9Tx8Pe0vf55g=; b=BOSwQuuPUdyAZFAVenkYytT3Iq
        lQOLCO36GFpL3jwsGKfcRH5hSYrA4E+r7VNJVLpNYuXLsvycqYDgu9IEHjcXWOuTmJUDj+zBYuj+Q
        cfa1zAO5G1HURxS+WlHkDY/JQ3/CIRZB3uT1UT6z/jILe2Efi6twrKQl2B/dcyUTpfCpS8RIrqiYO
        WfwLhmEHKGreRS+zxAcVTm5qU60gv/1pgnNO17lvGzAyeZtFGBkIrugmrmSXL9TOPd9CR7GIh+Ch5
        MdLFQ5k55DQLFfZ8s2OnIuaphZOh8RKEY0ZRimSX3lr3kfV//WOZATlVNb6IE36/yGumzU1ZD8A9w
        p2uB+MDQ==;
Received: from [2601:1c0:6280:3f0::aefb] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m8DHm-00CuPT-Cz; Tue, 27 Jul 2021 02:57:38 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] scripts: checkversion: modernize linux/version.h search strings
Date:   Mon, 26 Jul 2021 19:57:37 -0700
Message-Id: <20210727025737.30553-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update scripts/checkversion.pl to recognize the current contents
of <linux/version.h> and both of its current locations.

Also update my email address.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 scripts/checkversion.pl |   18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

--- linux-next-20210723.orig/scripts/checkversion.pl
+++ linux-next-20210723/scripts/checkversion.pl
@@ -1,10 +1,10 @@
 #! /usr/bin/env perl
 # SPDX-License-Identifier: GPL-2.0
 #
-# checkversion find uses of LINUX_VERSION_CODE or KERNEL_VERSION
-# without including <linux/version.h>, or cases of
-# including <linux/version.h> that don't need it.
-# Copyright (C) 2003, Randy Dunlap <rdunlap@xenotime.net>
+# checkversion finds uses of all macros in <linux/version.h>
+# where the source files do not #include <linux/version.h>; or cases
+# of including <linux/version.h> where it is not needed.
+# Copyright (C) 2003, Randy Dunlap <rdunlap@infradead.org>
 
 use strict;
 
@@ -13,7 +13,8 @@ $| = 1;
 my $debugging;
 
 foreach my $file (@ARGV) {
-    next if $file =~ "include/linux/version\.h";
+    next if $file =~ "include/generated/uapi/linux/version\.h";
+    next if $file =~ "usr/include/linux/version\.h";
     # Open this file.
     open( my $f, '<', $file )
       or die "Can't open $file: $!\n";
@@ -41,8 +42,11 @@ foreach my $file (@ARGV) {
 	    $iLinuxVersion      = $. if m/^\s*#\s*include\s*<linux\/version\.h>/o;
 	}
 
-	# Look for uses: LINUX_VERSION_CODE, KERNEL_VERSION, UTS_RELEASE
-	if (($_ =~ /LINUX_VERSION_CODE/) || ($_ =~ /\WKERNEL_VERSION/)) {
+	# Look for uses: LINUX_VERSION_CODE, KERNEL_VERSION,
+	# LINUX_VERSION_MAJOR, LINUX_VERSION_PATCHLEVEL, LINUX_VERSION_SUBLEVEL
+	if (($_ =~ /LINUX_VERSION_CODE/) || ($_ =~ /\WKERNEL_VERSION/) ||
+	    ($_ =~ /LINUX_VERSION_MAJOR/) || ($_ =~ /LINUX_VERSION_PATCHLEVEL/) ||
+	    ($_ =~ /LINUX_VERSION_SUBLEVEL/)) {
 	    $fUseVersion = 1;
             last if $iLinuxVersion;
         }
