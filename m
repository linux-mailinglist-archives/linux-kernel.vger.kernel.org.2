Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC7C134FAEA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 09:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234188AbhCaH5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 03:57:40 -0400
Received: from m12-17.163.com ([220.181.12.17]:52231 "EHLO m12-17.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234062AbhCaH5Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 03:57:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=zAzfg
        MCB84lghXYDIGQbpp5HO2ymY4H5sGYSlPibTME=; b=N3dQn2BLYgGfWk1yCKI4+
        +oB/d0JCR5BCMUdP7Uy9CDuHZ6iK/SqHRjn/xdCWdz9jSlmLiPlbvItZPJql9QJX
        BXmNzGupeuA2AYcL9v55g9TPZOLWi3NszH5wQ3ROJnn/u+tiOTduNwvmRAdxovoB
        rUjfEpztRv293EphJUpHk4=
Received: from COOL-20201222LC.ccdomain.com (unknown [218.94.48.178])
        by smtp13 (Coremail) with SMTP id EcCowAD3zmZWK2RgpYm_sw--.40060S2;
        Wed, 31 Mar 2021 15:57:11 +0800 (CST)
From:   dingsenjie@163.com
To:     akpm@linux-foundation.org, rppt@kernel.org
Cc:     linux-kernel@vger.kernel.org, dingsenjie <dingsenjie@yulong.com>
Subject: [PATCH] bus: mvebu: Convert to DEFINE_SHOW_ATTRIBUTE
Date:   Wed, 31 Mar 2021 15:57:00 +0800
Message-Id: <20210331075700.15832-1-dingsenjie@163.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EcCowAD3zmZWK2RgpYm_sw--.40060S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uw18Ww1fZr15Xw4rKF45Jrb_yoW8WrW7pa
        93uayqyr1UtrWUGFnYyanrZa4fuaySqrW2qFyv93yFqFZ8Zw1FqF1xtFWSkr48Xry8Wr1a
        qw45GFyxZa4jyrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07bYyIUUUUUU=
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: 5glqw25hqmxvi6rwjhhfrp/1tbiHhdmyFSItk9OwAAAsM
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: dingsenjie <dingsenjie@yulong.com>

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: dingsenjie <dingsenjie@yulong.com>
---
 drivers/bus/mvebu-mbus.c | 24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/drivers/bus/mvebu-mbus.c b/drivers/bus/mvebu-mbus.c
index 2519cee..4439612 100644
--- a/drivers/bus/mvebu-mbus.c
+++ b/drivers/bus/mvebu-mbus.c
@@ -470,17 +470,7 @@ static int mvebu_sdram_debug_show(struct seq_file *seq, void *v)
 	return mbus->soc->show_cpu_target(mbus, seq, v);
 }
 
-static int mvebu_sdram_debug_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, mvebu_sdram_debug_show, inode->i_private);
-}
-
-static const struct file_operations mvebu_sdram_debug_fops = {
-	.open = mvebu_sdram_debug_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(mvebu_sdram_debug);
 
 static int mvebu_devs_debug_show(struct seq_file *seq, void *v)
 {
@@ -520,17 +510,7 @@ static int mvebu_devs_debug_show(struct seq_file *seq, void *v)
 	return 0;
 }
 
-static int mvebu_devs_debug_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, mvebu_devs_debug_show, inode->i_private);
-}
-
-static const struct file_operations mvebu_devs_debug_fops = {
-	.open = mvebu_devs_debug_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(mvebu_devs_debug);
 
 /*
  * SoC-specific functions and definitions
-- 
1.9.1


