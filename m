Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 498A338E589
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 13:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232775AbhEXLhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 07:37:15 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5756 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbhEXLhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 07:37:11 -0400
Received: from dggems703-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FpZn25CH3zmkLp;
        Mon, 24 May 2021 19:32:06 +0800 (CST)
Received: from dggpemm500009.china.huawei.com (7.185.36.225) by
 dggems703-chm.china.huawei.com (10.3.19.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 19:35:41 +0800
Received: from huawei.com (10.175.113.32) by dggpemm500009.china.huawei.com
 (7.185.36.225) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 24 May
 2021 19:35:41 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH -next] crypto: algboss - Replaced simple_strtol() with kstrtouint()
Date:   Mon, 24 May 2021 20:08:34 +0800
Message-ID: <20210524120834.1580343-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500009.china.huawei.com (7.185.36.225)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The simple_strtol() function is deprecated in some situation since
it does not check for the range overflow. Use kstrtouint() instead.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 crypto/algboss.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/crypto/algboss.c b/crypto/algboss.c
index 5ebccbd6b74e..64bb8dab9584 100644
--- a/crypto/algboss.c
+++ b/crypto/algboss.c
@@ -140,8 +140,8 @@ static int cryptomgr_schedule_probe(struct crypto_larval *larval)
 			param->attrs[i].nu32.attr.rta_len =
 				sizeof(param->attrs[i].nu32);
 			param->attrs[i].nu32.attr.rta_type = CRYPTOA_U32;
-			param->attrs[i].nu32.data.num =
-				simple_strtol(name, NULL, 0);
+			if (unlikely(kstrtouint(name, 0, &param->attrs[i].nu32.data.num)))
+				goto err_free_param;
 		}
 
 		param->tb[i + 1] = &param->attrs[i].attr;
-- 
2.18.0.huawei.25

