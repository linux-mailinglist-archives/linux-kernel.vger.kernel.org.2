Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C68403EA583
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 15:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237826AbhHLNWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 09:22:54 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:32927 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236552AbhHLNSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 09:18:16 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0UinuYNY_1628774268;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0UinuYNY_1628774268)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 12 Aug 2021 21:17:48 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jia Zhang <zhang.jia@linux.alibaba.com>,
        "YiLin . Li" <YiLin.Li@linux.alibaba.com>
Cc:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Subject: [PATCH 1/3] crypto: tcrypt - Fix the wrong position of return value test statement
Date:   Thu, 12 Aug 2021 21:17:46 +0800
Message-Id: <20210812131748.81620-2-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.3.ge56e4f7
In-Reply-To: <20210812131748.81620-1-tianjia.zhang@linux.alibaba.com>
References: <20210812131748.81620-1-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The position of the return value test statement of crypto_aead_setkey()
is wrong, adjust to make it work properly.

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 crypto/tcrypt.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/crypto/tcrypt.c b/crypto/tcrypt.c
index d73a42fdaa9b..73c97e085baf 100644
--- a/crypto/tcrypt.c
+++ b/crypto/tcrypt.c
@@ -612,6 +612,12 @@ static void test_aead_speed(const char *algo, int enc, unsigned int secs,
 				}
 			}
 			ret = crypto_aead_setkey(tfm, key, *keysize);
+			if (ret) {
+				pr_err("setkey() failed flags=%x\n",
+						crypto_aead_get_flags(tfm));
+				goto out;
+			}
+
 			ret = crypto_aead_setauthsize(tfm, authsize);
 
 			iv_len = crypto_aead_ivsize(tfm);
@@ -622,15 +628,8 @@ static void test_aead_speed(const char *algo, int enc, unsigned int secs,
 			printk(KERN_INFO "test %u (%d bit key, %d byte blocks): ",
 					i, *keysize * 8, bs);
 
-
 			memset(tvmem[0], 0xff, PAGE_SIZE);
 
-			if (ret) {
-				pr_err("setkey() failed flags=%x\n",
-						crypto_aead_get_flags(tfm));
-				goto out;
-			}
-
 			sg_init_aead(sg, xbuf, bs + (enc ? 0 : authsize),
 				     assoc, aad_size);
 
-- 
2.19.1.3.ge56e4f7

