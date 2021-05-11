Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCD3B379FA3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 08:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbhEKGVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 02:21:34 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:2439 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbhEKGVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 02:21:32 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FfSQH67CMzCr4w;
        Tue, 11 May 2021 14:17:43 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Tue, 11 May 2021 14:20:12 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <wangzhou1@hisilicon.com>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] crypto: hisilicon -: switch to memdup_user_nul()
Date:   Tue, 11 May 2021 14:37:11 +0800
Message-ID: <1620715031-107265-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use memdup_user_nul() helper instead of open-coding to
simplify the code.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 drivers/crypto/hisilicon/qm.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index ce439a0..83a5d30 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -1570,17 +1570,10 @@ static ssize_t qm_cmd_write(struct file *filp, const char __user *buffer,
 	if (count > QM_DBG_WRITE_LEN)
 		return -ENOSPC;
 
-	cmd_buf = kzalloc(count + 1, GFP_KERNEL);
-	if (!cmd_buf)
+	cmd_buf = memdup_user_nul(buffer, count);
+	if (IS_ERR(cmd_buf))
 		return -ENOMEM;
 
-	if (copy_from_user(cmd_buf, buffer, count)) {
-		kfree(cmd_buf);
-		return -EFAULT;
-	}
-
-	cmd_buf[count] = '\0';
-
 	cmd_buf_tmp = strchr(cmd_buf, '\n');
 	if (cmd_buf_tmp) {
 		*cmd_buf_tmp = '\0';
-- 
2.6.2

