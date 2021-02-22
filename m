Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E08A3219A1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 15:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbhBVOBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 09:01:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbhBVMzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 07:55:20 -0500
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE74C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 04:54:39 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:254f:253d:debc:790b])
        by xavier.telenet-ops.be with bizsmtp
        id YCuW2400U1v7dkx01CuW3m; Mon, 22 Feb 2021 13:54:31 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lEAjO-000kTO-BO; Mon, 22 Feb 2021 13:54:30 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lEAjN-00HUMY-Ns; Mon, 22 Feb 2021 13:54:29 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Nick Terrell <terrelln@fb.com>, Ingo Molnar <mingo@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] initramfs: Remove redundant dependency of RD_ZSTD on BLK_DEV_INITRD
Date:   Mon, 22 Feb 2021 13:54:28 +0100
Message-Id: <20210222125428.4168247-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit be1859bdc660213b ("initramfs: remove redundant dependency on
BLK_DEV_INITRD") removed all redundant dependencies on BLK_DEV_INITRD,
but the recent addition of zstd support introduced a new one.

Fixes: a30d8a39f0571425 ("usr: Add support for zstd compressed initramfs")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 usr/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/usr/Kconfig b/usr/Kconfig
index 2599bc21c1b227ba..8bbcf699fe3bebec 100644
--- a/usr/Kconfig
+++ b/usr/Kconfig
@@ -103,7 +103,6 @@ config RD_LZ4
 config RD_ZSTD
 	bool "Support initial ramdisk/ramfs compressed using ZSTD"
 	default y
-	depends on BLK_DEV_INITRD
 	select DECOMPRESS_ZSTD
 	help
 	  Support loading of a ZSTD encoded initial ramdisk or cpio buffer.
-- 
2.25.1

