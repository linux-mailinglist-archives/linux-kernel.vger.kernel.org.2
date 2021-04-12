Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDC1A35C65A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 14:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241078AbhDLMer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 08:34:47 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:16574 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241047AbhDLMep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 08:34:45 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FJp5l1WSgz18H5l;
        Mon, 12 Apr 2021 20:32:11 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.498.0; Mon, 12 Apr 2021 20:34:19 +0800
From:   Weili Qian <qianweili@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <xuzaibo@huawei.com>, <wangzhou1@hisilicon.com>,
        <liulongfang@huawei.com>, Weili Qian <qianweili@huawei.com>
Subject: [PATCH 4/4] crypto: hisilicon - enable new error types for QM
Date:   Mon, 12 Apr 2021 20:31:35 +0800
Message-ID: <1618230695-22775-5-git-send-email-qianweili@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1618230695-22775-1-git-send-email-qianweili@huawei.com>
References: <1618230695-22775-1-git-send-email-qianweili@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QM adds 'qm_mailbox_timeout' and 'qm_flr_timeout' hardware error types on
Kunpeng930. This patch enables the new error types and configures the error
types as NFE.

Signed-off-by: Weili Qian <qianweili@huawei.com>
---
 drivers/crypto/hisilicon/qm.c | 6 ++++--
 drivers/crypto/hisilicon/qm.h | 5 ++++-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index deab797..20dbd13 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -135,9 +135,9 @@
 #define QM_DFX_CNT_CLR_CE		0x100118
 
 #define QM_ABNORMAL_INT_SOURCE		0x100000
-#define QM_ABNORMAL_INT_SOURCE_CLR	GENMASK(12, 0)
+#define QM_ABNORMAL_INT_SOURCE_CLR	GENMASK(14, 0)
 #define QM_ABNORMAL_INT_MASK		0x100004
-#define QM_ABNORMAL_INT_MASK_VALUE	0x1fff
+#define QM_ABNORMAL_INT_MASK_VALUE	0x7fff
 #define QM_ABNORMAL_INT_STATUS		0x100008
 #define QM_ABNORMAL_INT_SET		0x10000c
 #define QM_ABNORMAL_INF00		0x100010
@@ -389,6 +389,8 @@ static const struct hisi_qm_hw_error qm_hw_error[] = {
 	{ .int_msk = BIT(10), .msg = "qm_db_timeout" },
 	{ .int_msk = BIT(11), .msg = "qm_of_fifo_of" },
 	{ .int_msk = BIT(12), .msg = "qm_db_random_invalid" },
+	{ .int_msk = BIT(13), .msg = "qm_mailbox_timeout" },
+	{ .int_msk = BIT(14), .msg = "qm_flr_timeout" },
 	{ /* sentinel */ }
 };
 
diff --git a/drivers/crypto/hisilicon/qm.h b/drivers/crypto/hisilicon/qm.h
index 8c67712..acefdf8 100644
--- a/drivers/crypto/hisilicon/qm.h
+++ b/drivers/crypto/hisilicon/qm.h
@@ -64,10 +64,13 @@
 #define QM_DB_TIMEOUT			BIT(10)
 #define QM_OF_FIFO_OF			BIT(11)
 #define QM_DB_RANDOM_INVALID		BIT(12)
+#define QM_MAILBOX_TIMEOUT		BIT(13)
+#define QM_FLR_TIMEOUT			BIT(14)
 
 #define QM_BASE_NFE	(QM_AXI_RRESP | QM_AXI_BRESP | QM_ECC_MBIT | \
 			 QM_ACC_GET_TASK_TIMEOUT | QM_DB_TIMEOUT | \
-			 QM_OF_FIFO_OF | QM_DB_RANDOM_INVALID)
+			 QM_OF_FIFO_OF | QM_DB_RANDOM_INVALID | \
+			 QM_MAILBOX_TIMEOUT | QM_FLR_TIMEOUT)
 #define QM_BASE_CE			QM_ECC_1BIT
 
 #define QM_Q_DEPTH			1024
-- 
2.8.1

