Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72ACC341A58
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 11:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbhCSKrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 06:47:25 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:14385 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbhCSKqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 06:46:50 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4F20s15D9zz91DM;
        Fri, 19 Mar 2021 18:44:53 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Fri, 19 Mar 2021 18:46:42 +0800
From:   Hui Tang <tanghui20@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <xuzaibo@huawei.com>,
        <wangzhou1@hisilicon.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] crypto: hisilicon/hpre - delete wrap of 'CONFIG_CRYPTO_DH'
Date:   Fri, 19 Mar 2021 18:44:18 +0800
Message-ID: <1616150659-10756-2-git-send-email-tanghui20@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1616150659-10756-1-git-send-email-tanghui20@huawei.com>
References: <1616150659-10756-1-git-send-email-tanghui20@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'CRYPTO_DH' has selected in 'Kconfig', so delete 'CONFIG_CRYPTO_DH'.

Signed-off-by: Hui Tang <tanghui20@huawei.com>
---
 drivers/crypto/hisilicon/hpre/hpre_crypto.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/crypto/hisilicon/hpre/hpre_crypto.c b/drivers/crypto/hisilicon/hpre/hpre_crypto.c
index 53068d2..50ccd10 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_crypto.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_crypto.c
@@ -546,7 +546,6 @@ static int hpre_send(struct hpre_ctx *ctx, struct hpre_sqe *msg)
 	return ret;
 }
 
-#ifdef CONFIG_CRYPTO_DH
 static int hpre_dh_compute_value(struct kpp_request *req)
 {
 	struct crypto_kpp *tfm = crypto_kpp_reqtfm(req);
@@ -719,7 +718,6 @@ static void hpre_dh_exit_tfm(struct crypto_kpp *tfm)
 
 	hpre_dh_clear_ctx(ctx, true);
 }
-#endif
 
 static void hpre_rsa_drop_leading_zeros(const char **ptr, size_t *len)
 {
@@ -1893,7 +1891,6 @@ static struct akcipher_alg rsa = {
 	},
 };
 
-#ifdef CONFIG_CRYPTO_DH
 static struct kpp_alg dh = {
 	.set_secret = hpre_dh_set_secret,
 	.generate_public_key = hpre_dh_compute_value,
@@ -1910,7 +1907,6 @@ static struct kpp_alg dh = {
 		.cra_module = THIS_MODULE,
 	},
 };
-#endif
 
 static struct kpp_alg ecdh_nist_p192 = {
 	.set_secret = hpre_ecdh_set_secret,
@@ -1995,13 +1991,12 @@ int hpre_algs_register(struct hisi_qm *qm)
 	ret = crypto_register_akcipher(&rsa);
 	if (ret)
 		return ret;
-#ifdef CONFIG_CRYPTO_DH
+
 	ret = crypto_register_kpp(&dh);
 	if (ret) {
 		crypto_unregister_akcipher(&rsa);
 		return ret;
 	}
-#endif
 
 	if (qm->ver >= QM_HW_V3) {
 		ret = hpre_register_ecdh();
@@ -2016,9 +2011,7 @@ int hpre_algs_register(struct hisi_qm *qm)
 	return 0;
 
 reg_err:
-#ifdef CONFIG_CRYPTO_DH
 	crypto_unregister_kpp(&dh);
-#endif
 	crypto_unregister_akcipher(&rsa);
 	return ret;
 }
@@ -2030,8 +2023,6 @@ void hpre_algs_unregister(struct hisi_qm *qm)
 		hpre_unregister_ecdh();
 	}
 
-#ifdef CONFIG_CRYPTO_DH
 	crypto_unregister_kpp(&dh);
-#endif
 	crypto_unregister_akcipher(&rsa);
 }
-- 
2.8.1

