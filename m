Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0455F34A199
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 07:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbhCZGQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 02:16:31 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14483 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbhCZGQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 02:16:13 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F6BWP5H8SzyNk2;
        Fri, 26 Mar 2021 14:14:09 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Fri, 26 Mar 2021 14:16:03 +0800
From:   Meng Yu <yumeng18@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <xuzaibo@huawei.com>,
        <wangzhou1@hisilicon.com>, <yumeng18@huawei.com>,
        <linux-kernel@vger.kernel.org>, <shenyang39@huawei.com>
Subject: [PATCH] crypto: hisilicon/hpre - rsa key should not be empty
Date:   Fri, 26 Mar 2021 14:13:32 +0800
Message-ID: <1616739212-7751-1-git-send-email-yumeng18@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should ensure key is not empty before we set key.

Signed-off-by: Meng Yu <yumeng18@huawei.com>
---
 drivers/crypto/hisilicon/hpre/hpre_crypto.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/crypto/hisilicon/hpre/hpre_crypto.c b/drivers/crypto/hisilicon/hpre/hpre_crypto.c
index 53068d2..7cf7d80 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_crypto.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_crypto.c
@@ -1093,6 +1093,9 @@ static int hpre_rsa_setpubkey(struct crypto_akcipher *tfm, const void *key,
 	struct hpre_ctx *ctx = akcipher_tfm_ctx(tfm);
 	int ret;
 
+	if (!key || !keylen)
+		return -EINVAL;
+
 	ret = crypto_akcipher_set_pub_key(ctx->rsa.soft_tfm, key, keylen);
 	if (ret)
 		return ret;
@@ -1106,6 +1109,9 @@ static int hpre_rsa_setprivkey(struct crypto_akcipher *tfm, const void *key,
 	struct hpre_ctx *ctx = akcipher_tfm_ctx(tfm);
 	int ret;
 
+	if (!key || !keylen)
+		return -EINVAL;
+
 	ret = crypto_akcipher_set_priv_key(ctx->rsa.soft_tfm, key, keylen);
 	if (ret)
 		return ret;
-- 
2.8.1

