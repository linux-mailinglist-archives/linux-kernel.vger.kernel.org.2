Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A88835AC8F
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 11:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234642AbhDJJu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 05:50:59 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:16562 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbhDJJux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 05:50:53 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FHVYg2Kmgz17RFh;
        Sat, 10 Apr 2021 17:48:23 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Sat, 10 Apr 2021 17:50:27 +0800
From:   Hui Tang <tanghui20@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <xuzaibo@huawei.com>,
        <wangzhou1@hisilicon.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] crypto: hisilicon/hpre - use the correct variable type
Date:   Sat, 10 Apr 2021 17:47:00 +0800
Message-ID: <1618048021-50335-3-git-send-email-tanghui20@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1618048021-50335-1-git-send-email-tanghui20@huawei.com>
References: <1618048021-50335-1-git-send-email-tanghui20@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return value of 'le32_to_cpu' is unsigned, so change the
variable type from 'int' to 'unsigned int'.

Signed-off-by: Hui Tang <tanghui20@huawei.com>
---
 drivers/crypto/hisilicon/hpre/hpre_crypto.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/hisilicon/hpre/hpre_crypto.c b/drivers/crypto/hisilicon/hpre/hpre_crypto.c
index b312a38..0adaf92 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_crypto.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_crypto.c
@@ -326,7 +326,8 @@ static int hpre_alg_res_post_hf(struct hpre_ctx *ctx, struct hpre_sqe *sqe,
 				void **kreq)
 {
 	struct hpre_asym_request *req;
-	int err, id, done;
+	unsigned int err, done;
+	int id;
 
 #define HPRE_NO_HW_ERR		0
 #define HPRE_HW_TASK_DONE	3
-- 
2.8.1

