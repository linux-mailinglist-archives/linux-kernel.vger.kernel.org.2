Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 170EA341A61
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 11:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbhCSKs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 06:48:29 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:14406 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbhCSKsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 06:48:01 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4F20tp0y3jzkbCq;
        Fri, 19 Mar 2021 18:46:26 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Fri, 19 Mar 2021 18:47:49 +0800
From:   Hui Tang <tanghui20@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <xuzaibo@huawei.com>,
        <wangzhou1@hisilicon.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] crypto: hisilicon/hpre - fix "hpre_ctx_init" resource leak
Date:   Fri, 19 Mar 2021 18:45:27 +0800
Message-ID: <1616150727-11907-1-git-send-email-tanghui20@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling "hpre_ctx_set" fails, stop and put qp,
otherwise will leak qp resource.

Signed-off-by: Hui Tang <tanghui20@huawei.com>
---
 drivers/crypto/hisilicon/hpre/hpre_crypto.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/hisilicon/hpre/hpre_crypto.c b/drivers/crypto/hisilicon/hpre/hpre_crypto.c
index b77473b..d7a4adf 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_crypto.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_crypto.c
@@ -458,9 +458,16 @@ static void hpre_alg_cb(struct hisi_qp *qp, void *resp)
 	req->cb(ctx, resp);
 }
 
+static void hpre_stop_qp_and_put(struct hisi_qp *qp)
+{
+	hisi_qm_stop_qp(qp);
+	hisi_qm_free_qps(&qp, 1);
+}
+
 static int hpre_ctx_init(struct hpre_ctx *ctx, u8 type)
 {
 	struct hisi_qp *qp;
+	int ret;
 
 	qp = hpre_get_qp_and_start(type);
 	if (IS_ERR(qp))
@@ -469,7 +476,11 @@ static int hpre_ctx_init(struct hpre_ctx *ctx, u8 type)
 	qp->qp_ctx = ctx;
 	qp->req_cb = hpre_alg_cb;
 
-	return hpre_ctx_set(ctx, qp, QM_Q_DEPTH);
+	ret = hpre_ctx_set(ctx, qp, QM_Q_DEPTH);
+	if (ret)
+		hpre_stop_qp_and_put(qp);
+
+	return ret;
 }
 
 static int hpre_msg_request_set(struct hpre_ctx *ctx, void *req, bool is_rsa)
-- 
2.8.1

