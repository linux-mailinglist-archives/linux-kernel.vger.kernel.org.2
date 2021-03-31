Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E42B34B57E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 09:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbhC0Ifd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 04:35:33 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15071 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbhC0IfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 04:35:04 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F6sY96jN8z1BHyb;
        Sat, 27 Mar 2021 16:33:01 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Sat, 27 Mar 2021 16:34:56 +0800
From:   Hui Tang <tanghui20@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <xuzaibo@huawei.com>,
        <wangzhou1@hisilicon.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] crypto: hisilicon/hpre - delete redundant log
Date:   Sat, 27 Mar 2021 16:32:26 +0800
Message-ID: <1616833946-9682-1-git-send-email-tanghui20@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'hpre_cfg_by_dsm' has checked and printed error path, so it is not
necessary at all.

Signed-off-by: Hui Tang <tanghui20@huawei.com>
---
 drivers/crypto/hisilicon/hpre/hpre_main.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/crypto/hisilicon/hpre/hpre_main.c b/drivers/crypto/hisilicon/hpre/hpre_main.c
index 8aae921..73ee997 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_main.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_main.c
@@ -384,10 +384,7 @@ static int hpre_set_user_domain_and_cache(struct hisi_qm *qm)
 
 	/* This setting is only needed by Kunpeng 920. */
 	if (qm->ver == QM_HW_V2) {
-		ret = hpre_cfg_by_dsm(qm);
-		if (ret)
-			dev_err(dev, "acpi_evaluate_dsm err.\n");
-
+		hpre_cfg_by_dsm(qm);
 		disable_flr_of_bme(qm);
 	}
 
-- 
2.8.1

