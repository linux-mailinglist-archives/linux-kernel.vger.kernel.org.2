Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAEDB349E9E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 02:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhCZBXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 21:23:33 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14547 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbhCZBX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 21:23:26 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F640z2lCYzPm6m;
        Fri, 26 Mar 2021 09:20:51 +0800 (CST)
Received: from huawei.com (10.67.165.24) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.498.0; Fri, 26 Mar 2021
 09:23:16 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <yekai13@huawei.com>
Subject: [PATCH 2/3] crypto: qce - use memzero_explicit() for clearing data
Date:   Fri, 26 Mar 2021 09:20:47 +0800
Message-ID: <1616721648-56258-3-git-send-email-yekai13@huawei.com>
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

use memzero_explicit instead of memset to clear sensitive data.

Signed-off-by: Kai Ye <yekai13@huawei.com>
---
 drivers/crypto/qce/sha.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/crypto/qce/sha.c b/drivers/crypto/qce/sha.c
index 61c418c..cb9b3da 100644
--- a/drivers/crypto/qce/sha.c
+++ b/drivers/crypto/qce/sha.c
@@ -415,6 +415,7 @@ static int qce_ahash_hmac_setkey(struct crypto_ahash *tfm, const u8 *key,
 
 	ret = crypto_wait_req(crypto_ahash_digest(req), &wait);
 
+	memzero_explicit(buf, keylen + QCE_MAX_ALIGN_SIZE);
 	kfree(buf);
 err_free_req:
 	ahash_request_free(req);
-- 
2.8.1

