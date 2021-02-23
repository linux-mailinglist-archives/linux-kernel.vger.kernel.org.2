Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46E22322647
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 08:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbhBWHQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 02:16:01 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:12640 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbhBWHNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 02:13:32 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Dl9FP1q6sz1679f;
        Tue, 23 Feb 2021 15:11:05 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Tue, 23 Feb 2021 15:12:33 +0800
From:   Meng Yu <yumeng18@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <marcel@holtmann.org>, <johan.hedberg@gmail.com>,
        <luiz.dentz@gmail.com>, <tudor.ambarus@microchip.com>
CC:     <linux-crypto@vger.kernel.org>, <xuzaibo@huawei.com>,
        <wangzhou1@hisilicon.com>, <yumeng18@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v9 4/7] crypto: and expose ecc curves
Date:   Tue, 23 Feb 2021 15:10:16 +0800
Message-ID: <1614064219-40701-5-git-send-email-yumeng18@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1614064219-40701-1-git-send-email-yumeng18@huawei.com>
References: <1614064219-40701-1-git-send-email-yumeng18@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move 'ecc_get_curve' to 'include/crypto/ecc_curve.h', so everyone
in kernel tree can easily get ecc curve params;

Signed-off-by: Meng Yu <yumeng18@huawei.com>
Reviewed-by: Zaibo Xu <xuzaibo@huawei.com>
---
 crypto/ecc.c               |  5 ++++-
 crypto/ecc.h               | 37 ++------------------------------
 include/crypto/ecc_curve.h | 53 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+), 36 deletions(-)
 create mode 100644 include/crypto/ecc_curve.h

diff --git a/crypto/ecc.c b/crypto/ecc.c
index c80aa25..4b55ad0 100644
--- a/crypto/ecc.c
+++ b/crypto/ecc.c
@@ -24,6 +24,7 @@
  * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
+#include <crypto/ecc_curve.h>
 #include <linux/module.h>
 #include <linux/random.h>
 #include <linux/slab.h>
@@ -42,7 +43,8 @@ typedef struct {
 	u64 m_high;
 } uint128_t;
 
-static inline const struct ecc_curve *ecc_get_curve(unsigned int curve_id)
+
+const struct ecc_curve *ecc_get_curve(unsigned int curve_id)
 {
 	switch (curve_id) {
 	/* In FIPS mode only allow P256 and higher */
@@ -54,6 +56,7 @@ static inline const struct ecc_curve *ecc_get_curve(unsigned int curve_id)
 		return NULL;
 	}
 }
+EXPORT_SYMBOL(ecc_get_curve);
 
 static u64 *ecc_alloc_digits_space(unsigned int ndigits)
 {
diff --git a/crypto/ecc.h b/crypto/ecc.h
index d4e546b..38a81d4 100644
--- a/crypto/ecc.h
+++ b/crypto/ecc.h
@@ -26,6 +26,8 @@
 #ifndef _CRYPTO_ECC_H
 #define _CRYPTO_ECC_H
 
+#include <crypto/ecc_curve.h>
+
 /* One digit is u64 qword. */
 #define ECC_CURVE_NIST_P192_DIGITS  3
 #define ECC_CURVE_NIST_P256_DIGITS  4
@@ -33,44 +35,9 @@
 
 #define ECC_DIGITS_TO_BYTES_SHIFT 3
 
-/**
- * struct ecc_point - elliptic curve point in affine coordinates
- *
- * @x:		X coordinate in vli form.
- * @y:		Y coordinate in vli form.
- * @ndigits:	Length of vlis in u64 qwords.
- */
-struct ecc_point {
-	u64 *x;
-	u64 *y;
-	u8 ndigits;
-};
-
 #define ECC_POINT_INIT(x, y, ndigits)	(struct ecc_point) { x, y, ndigits }
 
 /**
- * struct ecc_curve - definition of elliptic curve
- *
- * @name:	Short name of the curve.
- * @g:		Generator point of the curve.
- * @p:		Prime number, if Barrett's reduction is used for this curve
- *		pre-calculated value 'mu' is appended to the @p after ndigits.
- *		Use of Barrett's reduction is heuristically determined in
- *		vli_mmod_fast().
- * @n:		Order of the curve group.
- * @a:		Curve parameter a.
- * @b:		Curve parameter b.
- */
-struct ecc_curve {
-	char *name;
-	struct ecc_point g;
-	u64 *p;
-	u64 *n;
-	u64 *a;
-	u64 *b;
-};
-
-/**
  * ecc_is_key_valid() - Validate a given ECDH private key
  *
  * @curve_id:		id representing the curve to use
diff --git a/include/crypto/ecc_curve.h b/include/crypto/ecc_curve.h
new file mode 100644
index 0000000..19a35da
--- /dev/null
+++ b/include/crypto/ecc_curve.h
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2021 HiSilicon */
+
+#ifndef _CRYTO_ECC_CURVE_H
+#define _CRYTO_ECC_CURVE_H
+
+#include <linux/types.h>
+
+/**
+ * struct ecc_point - elliptic curve point in affine coordinates
+ *
+ * @x:		X coordinate in vli form.
+ * @y:		Y coordinate in vli form.
+ * @ndigits:	Length of vlis in u64 qwords.
+ */
+struct ecc_point {
+	u64 *x;
+	u64 *y;
+	u8 ndigits;
+};
+
+/**
+ * struct ecc_curve - definition of elliptic curve
+ *
+ * @name:	Short name of the curve.
+ * @g:		Generator point of the curve.
+ * @p:		Prime number, if Barrett's reduction is used for this curve
+ *		pre-calculated value 'mu' is appended to the @p after ndigits.
+ *		Use of Barrett's reduction is heuristically determined in
+ *		vli_mmod_fast().
+ * @n:		Order of the curve group.
+ * @a:		Curve parameter a.
+ * @b:		Curve parameter b.
+ */
+struct ecc_curve {
+	char *name;
+	struct ecc_point g;
+	u64 *p;
+	u64 *n;
+	u64 *a;
+	u64 *b;
+};
+
+/**
+ * ecc_get_curve() - get elliptic curve;
+ * @curve_id:           Curves IDs:
+ *                      defined in 'include/crypto/ecdh.h';
+ *
+ * Returns curve if get curve succssful, NULL otherwise
+ */
+const struct ecc_curve *ecc_get_curve(unsigned int curve_id);
+
+#endif
-- 
2.8.1

