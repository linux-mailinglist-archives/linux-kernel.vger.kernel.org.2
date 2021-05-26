Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3A7390DAA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 03:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbhEZBCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 21:02:33 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:33158 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbhEZBCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 21:02:32 -0400
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 1A7E02AB85; Tue, 25 May 2021 21:01:00 -0400 (EDT)
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org
Message-Id: <fc397a7074d627e22974ef8927910ad08744db5c.1621988847.git.fthain@linux-m68k.org>
From:   Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH] MAINTAINERS, .mailmap: Update my email address
Date:   Wed, 26 May 2021 10:27:27 +1000
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 .mailmap    | 1 +
 MAINTAINERS | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/.mailmap b/.mailmap
index 2d93232ed72b..1f1ab3328a80 100644
--- a/.mailmap
+++ b/.mailmap
@@ -101,6 +101,7 @@ Felipe W Damasio <felipewd@terra.com.br>
 Felix Kuhling <fxkuehl@gmx.de>
 Felix Moeller <felix@derklecks.de>
 Filipe Lautert <filipe@icewall.org>
+Finn Thain <fthain@linux-m68k.org> <fthain@telegraphics.com.au>
 Franck Bui-Huu <vagabon.xyz@gmail.com>
 Frank Rowand <frowand.list@gmail.com> <frank.rowand@am.sony.com>
 Frank Rowand <frowand.list@gmail.com> <frank.rowand@sonymobile.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index 9450e052f1b1..8d3fbcdb2ebf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12314,7 +12314,7 @@ S:	Orphan
 F:	drivers/net/ethernet/natsemi/natsemi.c
 
 NCR 5380 SCSI DRIVERS
-M:	Finn Thain <fthain@telegraphics.com.au>
+M:	Finn Thain <fthain@linux-m68k.org>
 M:	Michael Schmitz <schmitzmic@gmail.com>
 L:	linux-scsi@vger.kernel.org
 S:	Maintained
@@ -12776,7 +12776,7 @@ F:	Documentation/filesystems/ntfs.rst
 F:	fs/ntfs/
 
 NUBUS SUBSYSTEM
-M:	Finn Thain <fthain@telegraphics.com.au>
+M:	Finn Thain <fthain@linux-m68k.org>
 L:	linux-m68k@lists.linux-m68k.org
 S:	Maintained
 F:	arch/*/include/asm/nubus.h
-- 
2.26.3

