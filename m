Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBBD32C049
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1578278AbhCCSQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:16:59 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:60637 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343964AbhCCP61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 10:58:27 -0500
Received: from mwalle01.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:fa59:71ff:fe9b:b851])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 84BB32223A;
        Wed,  3 Mar 2021 16:57:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1614787063;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=4p1DEoVyZ0ul8zQDDAxlxC/Kk9l9swD/AvRf7fZLd+4=;
        b=XZ+1FoQBNNGvpzi04s+0FINOgnBBSq2AMuVWXQnR+eSts0E2Znv9gr9YMLNazvAgnfovB1
        Bp8BykjoDDmRDmeOAD4g/Cx9xW+ENvb1TMupm/IiOa5WSe/C3lGcECXI8fxT40lrS61997
        r0ynvzFZk/7FTTJZr5jyuHHwT1bTPBg=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH] mtd: require write permissions for locking and badblock ioctls
Date:   Wed,  3 Mar 2021 16:57:35 +0100
Message-Id: <20210303155735.25887-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MEMLOCK, MEMUNLOCK and OTPLOCK modify protection bits. Thus require
write permission. Depending on the hardware MEMLOCK might even be
write-once, e.g. for SPI-NOR flashes with their WP# tied to GND. OTPLOCK
is always write-once.

MEMSETBADBLOCK modifies the bad block table.

Fixes: f7e6b19bc764 ("mtd: properly check all write ioctls for permissions")
Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/mtd/mtdchar.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/mtdchar.c b/drivers/mtd/mtdchar.c
index 57c4a2f0b703..30c8273c1eff 100644
--- a/drivers/mtd/mtdchar.c
+++ b/drivers/mtd/mtdchar.c
@@ -643,16 +643,12 @@ static int mtdchar_ioctl(struct file *file, u_int cmd, u_long arg)
 	case MEMGETINFO:
 	case MEMREADOOB:
 	case MEMREADOOB64:
-	case MEMLOCK:
-	case MEMUNLOCK:
 	case MEMISLOCKED:
 	case MEMGETOOBSEL:
 	case MEMGETBADBLOCK:
-	case MEMSETBADBLOCK:
 	case OTPSELECT:
 	case OTPGETREGIONCOUNT:
 	case OTPGETREGIONINFO:
-	case OTPLOCK:
 	case ECCGETLAYOUT:
 	case ECCGETSTATS:
 	case MTDFILEMODE:
@@ -663,9 +659,13 @@ static int mtdchar_ioctl(struct file *file, u_int cmd, u_long arg)
 	/* "dangerous" commands */
 	case MEMERASE:
 	case MEMERASE64:
+	case MEMLOCK:
+	case MEMUNLOCK:
+	case MEMSETBADBLOCK:
 	case MEMWRITEOOB:
 	case MEMWRITEOOB64:
 	case MEMWRITE:
+	case OTPLOCK:
 		if (!(file->f_mode & FMODE_WRITE))
 			return -EPERM;
 		break;
-- 
2.20.1

