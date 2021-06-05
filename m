Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39C6139C5F2
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 07:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhFEFIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 01:08:43 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:7108 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhFEFIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 01:08:42 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Fxnbm0lnMzYpvc;
        Sat,  5 Jun 2021 13:04:04 +0800 (CST)
Received: from dggpemm500009.china.huawei.com (7.185.36.225) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 5 Jun 2021 13:06:50 +0800
Received: from huawei.com (10.175.113.32) by dggpemm500009.china.huawei.com
 (7.185.36.225) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Sat, 5 Jun 2021
 13:06:50 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Eric Biggers <ebiggers@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH -next] crypto: remove CRYPTOA_U32 and related functions
Date:   Sat, 5 Jun 2021 13:39:02 +0800
Message-ID: <20210605053902.2017295-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500009.china.huawei.com (7.185.36.225)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the advice of Eric and Herbert, type CRYPTOA_U32
has been unused for over a decade, so remove the code related to
CRYPTOA_U32.

After removing CRYPTOA_U32, the type of the variable attrs can be
changed from union to struct.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 crypto/algapi.c         | 18 ------------------
 crypto/algboss.c        | 32 +++++++-------------------------
 include/crypto/algapi.h |  1 -
 include/linux/crypto.h  |  5 -----
 4 files changed, 7 insertions(+), 49 deletions(-)

diff --git a/crypto/algapi.c b/crypto/algapi.c
index fdabf2675b63..43f999dba4dc 100644
--- a/crypto/algapi.c
+++ b/crypto/algapi.c
@@ -868,24 +868,6 @@ const char *crypto_attr_alg_name(struct rtattr *rta)
 }
 EXPORT_SYMBOL_GPL(crypto_attr_alg_name);
 
-int crypto_attr_u32(struct rtattr *rta, u32 *num)
-{
-	struct crypto_attr_u32 *nu32;
-
-	if (!rta)
-		return -ENOENT;
-	if (RTA_PAYLOAD(rta) < sizeof(*nu32))
-		return -EINVAL;
-	if (rta->rta_type != CRYPTOA_U32)
-		return -EINVAL;
-
-	nu32 = RTA_DATA(rta);
-	*num = nu32->num;
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(crypto_attr_u32);
-
 int crypto_inst_setname(struct crypto_instance *inst, const char *name,
 			struct crypto_alg *alg)
 {
diff --git a/crypto/algboss.c b/crypto/algboss.c
index 5ebccbd6b74e..71016a923a79 100644
--- a/crypto/algboss.c
+++ b/crypto/algboss.c
@@ -28,16 +28,9 @@ struct cryptomgr_param {
 		struct crypto_attr_type data;
 	} type;
 
-	union {
+	struct {
 		struct rtattr attr;
-		struct {
-			struct rtattr attr;
-			struct crypto_attr_alg data;
-		} alg;
-		struct {
-			struct rtattr attr;
-			struct crypto_attr_u32 data;
-		} nu32;
+		struct crypto_attr_alg data;
 	} attrs[CRYPTO_MAX_ATTRS];
 
 	char template[CRYPTO_MAX_ALG_NAME];
@@ -104,12 +97,10 @@ static int cryptomgr_schedule_probe(struct crypto_larval *larval)
 
 	i = 0;
 	for (;;) {
-		int notnum = 0;
-
 		name = ++p;
 
 		for (; isalnum(*p) || *p == '-' || *p == '_'; p++)
-			notnum |= !isdigit(*p);
+			;
 
 		if (*p == '(') {
 			int recursion = 0;
@@ -123,7 +114,6 @@ static int cryptomgr_schedule_probe(struct crypto_larval *larval)
 					break;
 			}
 
-			notnum = 1;
 			p++;
 		}
 
@@ -131,18 +121,10 @@ static int cryptomgr_schedule_probe(struct crypto_larval *larval)
 		if (!len)
 			goto err_free_param;
 
-		if (notnum) {
-			param->attrs[i].alg.attr.rta_len =
-				sizeof(param->attrs[i].alg);
-			param->attrs[i].alg.attr.rta_type = CRYPTOA_ALG;
-			memcpy(param->attrs[i].alg.data.name, name, len);
-		} else {
-			param->attrs[i].nu32.attr.rta_len =
-				sizeof(param->attrs[i].nu32);
-			param->attrs[i].nu32.attr.rta_type = CRYPTOA_U32;
-			param->attrs[i].nu32.data.num =
-				simple_strtol(name, NULL, 0);
-		}
+		param->attrs[i].attr.rta_len =
+			sizeof(param->attrs[i]);
+		param->attrs[i].attr.rta_type = CRYPTOA_ALG;
+		memcpy(param->attrs[i].data.name, name, len);
 
 		param->tb[i + 1] = &param->attrs[i].attr;
 		i++;
diff --git a/include/crypto/algapi.h b/include/crypto/algapi.h
index 86f0748009af..41d42e649da4 100644
--- a/include/crypto/algapi.h
+++ b/include/crypto/algapi.h
@@ -118,7 +118,6 @@ void *crypto_spawn_tfm2(struct crypto_spawn *spawn);
 struct crypto_attr_type *crypto_get_attr_type(struct rtattr **tb);
 int crypto_check_attr_type(struct rtattr **tb, u32 type, u32 *mask_ret);
 const char *crypto_attr_alg_name(struct rtattr *rta);
-int crypto_attr_u32(struct rtattr *rta, u32 *num);
 int crypto_inst_setname(struct crypto_instance *inst, const char *name,
 			struct crypto_alg *alg);
 
diff --git a/include/linux/crypto.h b/include/linux/crypto.h
index da5e0d74bb2f..3b9263d6122f 100644
--- a/include/linux/crypto.h
+++ b/include/linux/crypto.h
@@ -647,7 +647,6 @@ enum {
 	CRYPTOA_UNSPEC,
 	CRYPTOA_ALG,
 	CRYPTOA_TYPE,
-	CRYPTOA_U32,
 	__CRYPTOA_MAX,
 };
 
@@ -665,10 +664,6 @@ struct crypto_attr_type {
 	u32 mask;
 };
 
-struct crypto_attr_u32 {
-	u32 num;
-};
-
 /* 
  * Transform user interface.
  */
-- 
2.18.0.huawei.25

