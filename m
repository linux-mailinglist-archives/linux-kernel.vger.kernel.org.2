Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED7730EF41
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 10:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234898AbhBDJGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 04:06:48 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:12398 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234692AbhBDJDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 04:03:35 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DWXbY3wk6z7gdH;
        Thu,  4 Feb 2021 17:01:29 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Thu, 4 Feb 2021 17:02:36 +0800
From:   Hui Tang <tanghui20@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <xuzaibo@huawei.com>,
        <wangzhou1@hisilicon.com>, <tanghui20@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] crypto: hisilicon/hpre - enable Elliptic curve cryptography
Date:   Thu, 4 Feb 2021 17:00:24 +0800
Message-ID: <1612429224-30388-1-git-send-email-tanghui20@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable x25519/x448/ecdh/ecdsa/sm2 algorithm on Kunpeng 930.

Signed-off-by: Hui Tang <tanghui20@huawei.com>
---
 drivers/crypto/hisilicon/hpre/hpre_main.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/hisilicon/hpre/hpre_main.c b/drivers/crypto/hisilicon/hpre/hpre_main.c
index 67f1fca..db170fc 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_main.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_main.c
@@ -30,6 +30,8 @@
 #define HPRE_BD_ARUSR_CFG		0x301030
 #define HPRE_BD_AWUSR_CFG		0x301034
 #define HPRE_TYPES_ENB			0x301038
+#define HPRE_RSA_ENB			BIT(0)
+#define HPRE_ECC_ENB			BIT(1)
 #define HPRE_DATA_RUSER_CFG		0x30103c
 #define HPRE_DATA_WUSER_CFG		0x301040
 #define HPRE_INT_MASK			0x301400
@@ -348,7 +350,12 @@ static int hpre_set_user_domain_and_cache(struct hisi_qm *qm)
 	val |= BIT(HPRE_TIMEOUT_ABNML_BIT);
 	writel_relaxed(val, HPRE_ADDR(qm, HPRE_QM_ABNML_INT_MASK));

-	writel(0x1, HPRE_ADDR(qm, HPRE_TYPES_ENB));
+	if (qm->ver >= QM_HW_V3)
+		writel(HPRE_RSA_ENB | HPRE_ECC_ENB,
+			HPRE_ADDR(qm, HPRE_TYPES_ENB));
+	else
+		writel(HPRE_RSA_ENB, HPRE_ADDR(qm, HPRE_TYPES_ENB));
+
 	writel(HPRE_QM_VFG_AX_MASK, HPRE_ADDR(qm, HPRE_VFG_AXCACHE));
 	writel(0x0, HPRE_ADDR(qm, HPRE_BD_ENDIAN));
 	writel(0x0, HPRE_ADDR(qm, HPRE_INT_MASK));
--
2.8.1

