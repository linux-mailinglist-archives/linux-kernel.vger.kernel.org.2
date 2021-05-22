Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2AD838D31F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 04:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbhEVCtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 22:49:15 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:3650 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbhEVCtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 22:49:08 -0400
Received: from dggems703-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Fn7BD6rKwzmXc4;
        Sat, 22 May 2021 10:45:24 +0800 (CST)
Received: from dggemi760-chm.china.huawei.com (10.1.198.146) by
 dggems703-chm.china.huawei.com (10.3.19.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Sat, 22 May 2021 10:47:42 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggemi760-chm.china.huawei.com (10.1.198.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Sat, 22 May 2021 10:47:42 +0800
From:   Hui Tang <tanghui20@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <xuzaibo@huawei.com>,
        <wangzhou1@hisilicon.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 3/4] crypto: ecdh - register NIST P384 tfm
Date:   Sat, 22 May 2021 10:44:30 +0800
Message-ID: <1621651471-42010-4-git-send-email-tanghui20@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1621651471-42010-1-git-send-email-tanghui20@huawei.com>
References: <1621651471-42010-1-git-send-email-tanghui20@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggemi760-chm.china.huawei.com (10.1.198.146)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ecdh_nist_p384_init_tfm and register and unregister P384 tfm.

Signed-off-by: Hui Tang <tanghui20@huawei.com>
---
 crypto/ecdh.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/crypto/ecdh.c b/crypto/ecdh.c
index e2c4808..70f312e 100644
--- a/crypto/ecdh.c
+++ b/crypto/ecdh.c
@@ -173,6 +173,31 @@ static struct kpp_alg ecdh_nist_p256 = {
 	},
 };
 
+static int ecdh_nist_p384_init_tfm(struct crypto_kpp *tfm)
+{
+	struct ecdh_ctx *ctx = ecdh_get_ctx(tfm);
+
+	ctx->curve_id = ECC_CURVE_NIST_P384;
+	ctx->ndigits = ECC_CURVE_NIST_P384_DIGITS;
+
+	return 0;
+}
+
+static struct kpp_alg ecdh_nist_p384 = {
+	.set_secret = ecdh_set_secret,
+	.generate_public_key = ecdh_compute_value,
+	.compute_shared_secret = ecdh_compute_value,
+	.max_size = ecdh_max_size,
+	.init = ecdh_nist_p384_init_tfm,
+	.base = {
+		.cra_name = "ecdh-nist-p384",
+		.cra_driver_name = "ecdh-nist-p384-generic",
+		.cra_priority = 100,
+		.cra_module = THIS_MODULE,
+		.cra_ctxsize = sizeof(struct ecdh_ctx),
+	},
+};
+
 static bool ecdh_nist_p192_registered;
 
 static int ecdh_init(void)
@@ -187,8 +212,15 @@ static int ecdh_init(void)
 	if (ret)
 		goto nist_p256_error;
 
+	ret = crypto_register_kpp(&ecdh_nist_p384);
+	if (ret)
+		goto nist_p384_error;
+
 	return 0;
 
+nist_p384_error:
+	crypto_unregister_kpp(&ecdh_nist_p256);
+
 nist_p256_error:
 	if (ecdh_nist_p192_registered)
 		crypto_unregister_kpp(&ecdh_nist_p192);
@@ -200,6 +232,7 @@ static void ecdh_exit(void)
 	if (ecdh_nist_p192_registered)
 		crypto_unregister_kpp(&ecdh_nist_p192);
 	crypto_unregister_kpp(&ecdh_nist_p256);
+	crypto_unregister_kpp(&ecdh_nist_p384);
 }
 
 subsys_initcall(ecdh_init);
-- 
2.8.1

