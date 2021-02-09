Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89972314F84
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 13:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbhBIMxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 07:53:21 -0500
Received: from m12-13.163.com ([220.181.12.13]:35096 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230177AbhBIMxS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 07:53:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=MrsoAV+zu1Ug+eSr1I
        X4k24NhUyAb/tUE5+u2X9r3EA=; b=MDt+zSZQfv+twSlD05f+I+zHUnP/gFes0L
        NweZkdMPBD5XtOK/Mk+mKy7qgj5JZyhBvnqB05Q5APUJKiSHKIJJ281XxaHTZcPC
        EBoP5rZBZtXXkJccLHT+iw+HlmQLFc93ihPVQ6aALVPc9nty+fQxMwod67piGJ/6
        Mpv6yTjg8=
Received: from localhost.localdomain.localdomain (unknown [182.150.160.182])
        by smtp9 (Coremail) with SMTP id DcCowADH09qyTCJgokJOeg--.59330S2;
        Tue, 09 Feb 2021 16:49:55 +0800 (CST)
From:   Liao Pingfang <winndows@163.com>
To:     akpm@linux-foundation.org, rppt@kernel.org
Cc:     linux-kernel@vger.kernel.org, Liao Pingfang <winndows@163.com>
Subject: [PATCH] bus: mvebu-mbus: Convert to use DEFINE_SHOW_ATTRIBUTE macro
Date:   Tue,  9 Feb 2021 16:49:41 +0800
Message-Id: <1612860581-3073-1-git-send-email-winndows@163.com>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: DcCowADH09qyTCJgokJOeg--.59330S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ArW7JFWxCr47ZF47ur15Jwb_yoW8Xw4xpa
        93uayjyr1UtrWUGFnYyFsrZa4fuaySq3y2qFyv93yFqF98Zw1YqF1xtFWSkr1rWry8Wr1a
        qw15GFyxZFWjyrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziPxhdUUUUU=
X-Originating-IP: [182.150.160.182]
X-CM-SenderInfo: hzlq0vxrzvqiywtou0bp/1tbiGRM0mVyPb2V17AAAsn
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Liao Pingfang <winndows@163.com>
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
1.8.3.1


