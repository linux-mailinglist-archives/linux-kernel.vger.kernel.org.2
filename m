Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28E4135101C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 09:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233444AbhDAHcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 03:32:19 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:15843 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233024AbhDAHbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 03:31:41 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4F9vvY3jrvz9v2Q;
        Thu,  1 Apr 2021 15:29:29 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Thu, 1 Apr 2021 15:31:26 +0800
From:   Zhiqi Song <songzhiqi1@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <fanghao11@huawei.com>,
        <prime.zeng@hisilicon.com>
Subject: [PATCH] crypto: cbc - fix coding style
Date:   Thu, 1 Apr 2021 15:31:41 +0800
Message-ID: <1617262301-47010-1-git-send-email-songzhiqi1@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed following checkpatch error:
- do not use assignment in if condition

Signed-off-by: Zhiqi Song <songzhiqi1@huawei.com>
---
 crypto/cbc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/crypto/cbc.c b/crypto/cbc.c
index 6c03e96..152d48d 100644
--- a/crypto/cbc.c
+++ b/crypto/cbc.c
@@ -140,7 +140,8 @@ static int crypto_cbc_decrypt_inplace(struct skcipher_walk *walk,
 
 	for (;;) {
 		fn(tfm, src, src);
-		if ((nbytes -= bsize) < bsize)
+		nbytes -= bsize;
+		if (nbytes < bsize)
 			break;
 		crypto_xor(src, src - bsize, bsize);
 		src -= bsize;
-- 
2.7.4

