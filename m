Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20E25388B88
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 12:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347864AbhESKTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 06:19:34 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:49285 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232933AbhESKT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 06:19:26 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R341e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0UZOs6SD_1621419484;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UZOs6SD_1621419484)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 19 May 2021 18:18:05 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     rmk+kernel@armlinux.org.uk
Cc:     linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] fs/adfs: bigdir: Fix an error code in adfs_fplus_read()
Date:   Wed, 19 May 2021 18:18:03 +0800
Message-Id: <1621419483-9339-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This code accidentally returns 0, but it should return the
-EIO error code to show a I/O error.

Clean up smatch warning:

fs/adfs/dir_fplus.c:146 adfs_fplus_read() warn: missing error code 'ret'

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 fs/adfs/dir_fplus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/adfs/dir_fplus.c b/fs/adfs/dir_fplus.c
index 4a15924..4334279 100644
--- a/fs/adfs/dir_fplus.c
+++ b/fs/adfs/dir_fplus.c
@@ -143,6 +143,7 @@ static int adfs_fplus_read(struct super_block *sb, u32 indaddr,
 
 	if (adfs_fplus_checkbyte(dir) != t->bigdircheckbyte) {
 		adfs_error(sb, "dir %06x checkbyte mismatch\n", indaddr);
+		ret = -EIO;
 		goto out;
 	}
 
-- 
1.8.3.1

