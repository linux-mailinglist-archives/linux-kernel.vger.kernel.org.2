Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E232335AC8D
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 11:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234627AbhDJJuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 05:50:55 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:16561 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbhDJJux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 05:50:53 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FHVYg2WXjz17RFl;
        Sat, 10 Apr 2021 17:48:23 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Sat, 10 Apr 2021 17:50:27 +0800
From:   Hui Tang <tanghui20@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <xuzaibo@huawei.com>,
        <wangzhou1@hisilicon.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] crypto: hisilicon/hpre - delete the rudundant space after return
Date:   Sat, 10 Apr 2021 17:46:59 +0800
Message-ID: <1618048021-50335-2-git-send-email-tanghui20@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1618048021-50335-1-git-send-email-tanghui20@huawei.com>
References: <1618048021-50335-1-git-send-email-tanghui20@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two spaces after return, just keep one.

Signed-off-by: Hui Tang <tanghui20@huawei.com>
---
 drivers/crypto/hisilicon/hpre/hpre_crypto.c | 2 +-
 drivers/crypto/hisilicon/hpre/hpre_main.c   | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/hisilicon/hpre/hpre_crypto.c b/drivers/crypto/hisilicon/hpre/hpre_crypto.c
index d23893a..b312a38 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_crypto.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_crypto.c
@@ -344,7 +344,7 @@ static int hpre_alg_res_post_hf(struct hpre_ctx *ctx, struct hpre_sqe *sqe,
 		HREE_SQE_DONE_MASK;
 
 	if (likely(err == HPRE_NO_HW_ERR && done == HPRE_HW_TASK_DONE))
-		return  0;
+		return 0;
 
 	return -EINVAL;
 }
diff --git a/drivers/crypto/hisilicon/hpre/hpre_main.c b/drivers/crypto/hisilicon/hpre/hpre_main.c
index 264684a..916af3f 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_main.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_main.c
@@ -472,7 +472,7 @@ static int hpre_clear_enable_write(struct hpre_debugfs_file *file, u32 val)
 	       ~HPRE_CTRL_CNT_CLR_CE_BIT) | val;
 	writel(tmp, qm->io_base + HPRE_CTRL_CNT_CLR_CE);
 
-	return  0;
+	return 0;
 }
 
 static u32 hpre_cluster_inqry_read(struct hpre_debugfs_file *file)
@@ -494,7 +494,7 @@ static int hpre_cluster_inqry_write(struct hpre_debugfs_file *file, u32 val)
 
 	writel(val, qm->io_base + offset + HPRE_CLUSTER_INQURY);
 
-	return  0;
+	return 0;
 }
 
 static ssize_t hpre_ctrl_debug_read(struct file *filp, char __user *buf,
-- 
2.8.1

