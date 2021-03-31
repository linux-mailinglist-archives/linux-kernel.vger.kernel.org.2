Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48493349E9F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 02:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbhCZBXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 21:23:35 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:14880 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbhCZBX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 21:23:26 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4F641b24WFz9tC0;
        Fri, 26 Mar 2021 09:21:23 +0800 (CST)
Received: from huawei.com (10.67.165.24) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.498.0; Fri, 26 Mar 2021
 09:23:16 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <yekai13@huawei.com>
Subject: [PATCH 3/3] crypto: stm32 - use memzero_explicit() for clearing data
Date:   Fri, 26 Mar 2021 09:20:48 +0800
Message-ID: <1616721648-56258-4-git-send-email-yekai13@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1616721648-56258-1-git-send-email-yekai13@huawei.com>
References: <1616721648-56258-1-git-send-email-yekai13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

use memzero_explicit instead of memset to clear sensitive data

Signed-off-by: Kai Ye <yekai13@huawei.com>
---
 drivers/crypto/stm32/stm32-cryp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/stm32/stm32-cryp.c b/drivers/crypto/stm32/stm32-cryp.c
index 2a479317..c4297e80 100644
--- a/drivers/crypto/stm32/stm32-cryp.c
+++ b/drivers/crypto/stm32/stm32-cryp.c
@@ -675,7 +675,7 @@ static void stm32_cryp_finish_req(struct stm32_cryp *cryp, int err)
 		crypto_finalize_skcipher_request(cryp->engine, cryp->req,
 						   err);
 
-	memset(cryp->ctx->key, 0, cryp->ctx->keylen);
+	memzero_explicit(cryp->ctx->key, cryp->ctx->keylen);
 }
 
 static int stm32_cryp_cpu_start(struct stm32_cryp *cryp)
-- 
2.8.1

