Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56D3C3122FE
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 10:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbhBGJJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 04:09:44 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:41189 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229510AbhBGJJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 04:09:41 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R891e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UO3K6Ob_1612688920;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UO3K6Ob_1612688920)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 07 Feb 2021 17:08:40 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     bleung@chromium.org
Cc:     enric.balletbo@collabora.com, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] platform/chrome: wilco_ec: convert stream-like files from nonseekable_open -> stream_open
Date:   Sun,  7 Feb 2021 17:08:38 +0800
Message-Id: <1612688918-63132-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate the following coccicheck warning:
./drivers/platform/chrome/wilco_ec/telemetry.c:259:1-17: WARNING:
telem_fops: .read() and .write() have stream semantic; safe to change
nonseekable_open -> stream_open.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/platform/chrome/wilco_ec/telemetry.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/wilco_ec/telemetry.c b/drivers/platform/chrome/wilco_ec/telemetry.c
index e06d96f..60da7a2 100644
--- a/drivers/platform/chrome/wilco_ec/telemetry.c
+++ b/drivers/platform/chrome/wilco_ec/telemetry.c
@@ -256,7 +256,7 @@ static int telem_open(struct inode *inode, struct file *filp)
 	sess_data->dev_data = dev_data;
 	sess_data->has_msg = false;
 
-	nonseekable_open(inode, filp);
+	stream_open(inode, filp);
 	filp->private_data = sess_data;
 
 	return 0;
-- 
1.8.3.1

