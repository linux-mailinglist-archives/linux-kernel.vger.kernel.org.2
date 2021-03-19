Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1FC8341A57
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 11:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbhCSKrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 06:47:24 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:14384 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbhCSKqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 06:46:50 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4F20s14qHJz90QZ;
        Fri, 19 Mar 2021 18:44:53 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Fri, 19 Mar 2021 18:46:42 +0800
From:   Hui Tang <tanghui20@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <xuzaibo@huawei.com>,
        <wangzhou1@hisilicon.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] crypto: hisilicon/hpre - optimise 'hpre_algs_register' error path
Date:   Fri, 19 Mar 2021 18:44:19 +0800
Message-ID: <1616150659-10756-3-git-send-email-tanghui20@huawei.com>
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

There is redundant code especially when registing new algorithms
in the future.

Signed-off-by: Hui Tang <tanghui20@huawei.com>
---
 drivers/crypto/hisilicon/hpre/hpre_crypto.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/crypto/hisilicon/hpre/hpre_crypto.c b/drivers/crypto/hisilicon/hpre/hpre_crypto.c
index 50ccd10..b77473b 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_crypto.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_crypto.c
@@ -1993,25 +1993,24 @@ int hpre_algs_register(struct hisi_qm *qm)
 		return ret;
 
 	ret = crypto_register_kpp(&dh);
-	if (ret) {
-		crypto_unregister_akcipher(&rsa);
-		return ret;
-	}
+	if (ret)
+		goto unreg_rsa;
 
 	if (qm->ver >= QM_HW_V3) {
 		ret = hpre_register_ecdh();
 		if (ret)
-			goto reg_err;
+			goto unreg_dh;
 		ret = crypto_register_kpp(&curve25519_alg);
-		if (ret) {
-			hpre_unregister_ecdh();
-			goto reg_err;
-		}
+		if (ret)
+			goto unreg_ecdh;
 	}
 	return 0;
 
-reg_err:
+unreg_ecdh:
+	hpre_unregister_ecdh();
+unreg_dh:
 	crypto_unregister_kpp(&dh);
+unreg_rsa:
 	crypto_unregister_akcipher(&rsa);
 	return ret;
 }
-- 
2.8.1

