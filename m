Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D31C3312E08
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 10:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbhBHJzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 04:55:40 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12497 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbhBHJp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 04:45:27 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DZ1GJ2N4XzjL0D;
        Mon,  8 Feb 2021 17:40:08 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.498.0; Mon, 8 Feb 2021 17:41:21 +0800
From:   Meng Yu <yumeng18@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <marcel@holtmann.org>, <johan.hedberg@gmail.com>,
        <luiz.dentz@gmail.com>, <tudor.ambarus@microchip.com>
CC:     <linux-crypto@vger.kernel.org>, <xuzaibo@huawei.com>,
        <wangzhou1@hisilicon.com>, <yumeng18@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v8 8/9] crypto: add curve25519 params and expose them
Date:   Mon, 8 Feb 2021 17:38:56 +0800
Message-ID: <1612777137-51067-9-git-send-email-yumeng18@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1612777137-51067-1-git-send-email-yumeng18@huawei.com>
References: <1612777137-51067-1-git-send-email-yumeng18@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Add curve 25519 parameters;
2. Add curve25519 function 'ecc_get_curve25519_param', to make
   its parameters be exposed to everyone in kernel tree.

Signed-off-by: Meng Yu <yumeng18@huawei.com>
Reviewed-by: Zaibo Xu <xuzaibo@huawei.com>
---
 crypto/ecc.c               |  6 ++++++
 crypto/ecc_curve_defs.h    | 18 ++++++++++++++++++
 include/crypto/ecc_curve.h |  7 +++++++
 3 files changed, 31 insertions(+)

diff --git a/crypto/ecc.c b/crypto/ecc.c
index a631d3e..d8dbe7a 100644
--- a/crypto/ecc.c
+++ b/crypto/ecc.c
@@ -43,6 +43,12 @@ typedef struct {
 	u64 m_high;
 } uint128_t;
 
+/* Returns curv25519 curve param */
+const struct ecc_curve *ecc_get_curve25519(void)
+{
+	return &ecc_25519;
+}
+EXPORT_SYMBOL(ecc_get_curve25519);
 
 const struct ecc_curve *ecc_get_curve(unsigned int curve_id)
 {
diff --git a/crypto/ecc_curve_defs.h b/crypto/ecc_curve_defs.h
index bcd7b58..f37eced 100644
--- a/crypto/ecc_curve_defs.h
+++ b/crypto/ecc_curve_defs.h
@@ -160,4 +160,22 @@ static struct ecc_curve nist_p521 = {
 	.b = nist_p521_b
 };
 
+/* curve25519 */
+static u64 curve25519_g_x[] = { 0x0000000000000009, 0x0000000000000000,
+				0x0000000000000000, 0x0000000000000000 };
+static u64 curve25519_p[] = { 0xffffffffffffffed, 0xffffffffffffffff,
+				0xffffffffffffffff, 0x7fffffffffffffff };
+static u64 curve25519_a[] = { 0x000000000001DB41, 0x0000000000000000,
+				0x0000000000000000, 0x0000000000000000 };
+static const struct ecc_curve ecc_25519 = {
+	.name = "curve25519",
+	.g = {
+		.x = curve25519_g_x,
+		.ndigits = 4,
+	},
+	.p = curve25519_p,
+	.a = curve25519_a,
+};
+
+
 #endif
diff --git a/include/crypto/ecc_curve.h b/include/crypto/ecc_curve.h
index 19a35da..7096478 100644
--- a/include/crypto/ecc_curve.h
+++ b/include/crypto/ecc_curve.h
@@ -50,4 +50,11 @@ struct ecc_curve {
  */
 const struct ecc_curve *ecc_get_curve(unsigned int curve_id);
 
+/**
+ * ecc_get_curve25519() - get curve25519 curve;
+ *
+ * Returns curve25519
+ */
+const struct ecc_curve *ecc_get_curve25519(void);
+
 #endif
-- 
2.8.1

