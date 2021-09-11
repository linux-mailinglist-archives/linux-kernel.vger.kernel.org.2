Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79C79407439
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 02:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235008AbhIKAk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 20:40:59 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38603 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234998AbhIKAk5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 20:40:57 -0400
Received: from tazenda.hos.anvin.org ([IPv6:2601:646:8600:3c70:7285:c2ff:fefb:fd4])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 18B0dDFO576094
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 10 Sep 2021 17:39:23 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 18B0dDFO576094
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021083001; t=1631320763;
        bh=2rBZECBKov87xFGRxHyEDUUoI5r7syQk370u0V8Njh8=;
        h=From:To:Cc:Subject:Date:From;
        b=SzGaOOJPWGcZue5OkxCBm2HtM96GbN+1i73y5I/pPyf4gB4U1Jrzz8nYkGCsqrwmR
         Gmv3/AHwbNeTXrX+qouB581R5Qd214s6av9mcNvEzVr8SCc09MbsQKGsXW4hZt3Cda
         jQLRZ8SPXEnG7fAiNeMvoLFoyijTxu2Y7W70UQx+wtvU8JtDmbhmfgM3puqlYGpxmw
         muBgflOd0YeXiswgVioYvC2v2Cy3cwI9N0KEG4xZwRWSH63F0Tx0PCs7hP6g3CAPCk
         K2bRDPeutW2cRyKdLEOztrmzBpXHiY86F9NPLt9vy8Dm0gfV2mvc72qCA2++/r+1D+
         4ccyb3WXQ2YRw==
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     x86 mailing list <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin (Intel)" <hpa@zytor.com>
Subject: [PATCH] x86/boot: fix make hdimage with older versions of mtools
Date:   Fri, 10 Sep 2021 17:39:06 -0700
Message-Id: <20210911003906.2700218-1-hpa@zytor.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "H. Peter Anvin (Intel)" <hpa@zytor.com>

Some versions of mtools (fixed somewhere between 4.0.31 and 4.0.35)
generates bad output for mformat when used with the partition=
option. Use the offset= option instead, but we *also* need an
mtools.conf entry with partition= to support mpartition; combining
them in one entry does not work either.

Don't specify the -t option to mpartition; it is unnecessary and seems
to confuse mpartition under some circumstances.

Also do a few minor optimizations:

Use a larger cluster size; there is no reason for the typical 4K
clusters when we are dealing mainly with comparatively huge files.

Start the partition at 32K. There is no reason to align it more than
that, since the internal FAT filesystem structures will at best be
cluster-aligned, and 32K is the maximum FAT cluster size.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
---
 arch/x86/boot/genimage.sh    | 15 ++++++++-------
 arch/x86/boot/mtools.conf.in |  5 +++--
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/x86/boot/genimage.sh b/arch/x86/boot/genimage.sh
index 0673fdfc1a11..c9299aeb7333 100644
--- a/arch/x86/boot/genimage.sh
+++ b/arch/x86/boot/genimage.sh
@@ -120,12 +120,13 @@ efiarch() {
 }
 
 # Get the combined sizes in bytes of the files given, counting sparse
-# files as full length, and padding each file to a 4K block size
+# files as full length, and padding each file to cluster size
+cluster=16384
 filesizes() {
 	local t=0
 	local s
 	for s in $(ls -lnL "$@" 2>/dev/null | awk '/^-/{ print $5; }'); do
-		t=$((t + ((s+4095)/4096)*4096))
+		t=$((t + ((s+cluster-1)/cluster)*cluster))
 	done
 	echo $t
 }
@@ -230,14 +231,14 @@ genhdimage() {
 		ptype='-T 0xef'	# EFI system partition, no GPT
 	fi
 	sizes=$(filesizes "$FBZIMAGE" "${FDINITRDS[@]}" "$efishell")
-	# Allow 1% + 1 MiB for filesystem and partition table overhead,
-	# syslinux, and config files
+	# Allow 1% + 2 MiB for filesystem and partition table overhead,
+	# syslinux, and config files; this is probably excessive...
 	megs=$(((sizes + sizes/100 + 2*1024*1024 - 1)/(1024*1024)))
 	$dd if=/dev/zero of="$FIMAGE" bs=$((1024*1024)) count=$megs 2>/dev/null
-	mpartition -I -c -s 32 -h 64 -t $megs $ptype -b 512 -a h:
+	mpartition -I -c -s 32 -h 64 $ptype -b 64 -a p:
 	$dd if="$mbr" of="$FIMAGE" bs=440 count=1 conv=notrunc 2>/dev/null
-	mformat -v 'LINUX_BOOT' -s 32 -h 64 -t $megs h:
-	syslinux --offset $((512*512)) "$FIMAGE"
+	mformat -v 'LINUX_BOOT' -s 32 -h 64 -c $((cluster/512)) -t $megs h:
+	syslinux --offset $((64*512)) "$FIMAGE"
 	do_mcopy h:
 }
 
diff --git a/arch/x86/boot/mtools.conf.in b/arch/x86/boot/mtools.conf.in
index 9e2662d01364..174c60508766 100644
--- a/arch/x86/boot/mtools.conf.in
+++ b/arch/x86/boot/mtools.conf.in
@@ -14,7 +14,8 @@ drive v:
 drive w:
   file="@OBJ@/fdimage" cylinders=80 heads=2 sectors=36 filter
 
-# Hard disk
+# Hard disk (h: for the filesystem, p: for format - old mtools bug?)
 drive h:
+  file="@OBJ@/hdimage" offset=32768 mformat_only
+drive p:
   file="@OBJ@/hdimage" partition=1 mformat_only
-
-- 
2.31.1

