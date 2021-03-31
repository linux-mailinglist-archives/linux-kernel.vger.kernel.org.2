Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 432CA34B57B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 09:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbhC0IfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 04:35:00 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15070 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbhC0Iew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 04:34:52 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F6sXv22Xkz1BHy1;
        Sat, 27 Mar 2021 16:32:47 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Sat, 27 Mar 2021 16:34:39 +0800
From:   Hui Tang <tanghui20@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <xuzaibo@huawei.com>,
        <wangzhou1@hisilicon.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] crypto: hisilicon/hpre - fix a typo and delete redundant blank line
Date:   Sat, 27 Mar 2021 16:32:08 +0800
Message-ID: <1616833928-9389-1-git-send-email-tanghui20@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/shoul/should/

Signed-off-by: Hui Tang <tanghui20@huawei.com>
---
 drivers/crypto/hisilicon/hpre/hpre_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/crypto/hisilicon/hpre/hpre_main.c b/drivers/crypto/hisilicon/hpre/hpre_main.c
index f2605c4..8aae921 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_main.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_main.c
@@ -323,7 +323,7 @@ static int hpre_set_cluster(struct hisi_qm *qm)
 }
 
 /*
- * For Kunpeng 920, we shoul disable FLR triggered by hardware (BME/PM/SRIOV).
+ * For Kunpeng 920, we should disable FLR triggered by hardware (BME/PM/SRIOV).
  * Or it may stay in D3 state when we bind and unbind hpre quickly,
  * as it does FLR triggered by hardware.
  */
@@ -1019,7 +1019,6 @@ static void hpre_remove(struct pci_dev *pdev)
 	hisi_qm_uninit(qm);
 }
 
-
 static const struct pci_error_handlers hpre_err_handler = {
 	.error_detected		= hisi_qm_dev_err_detected,
 	.slot_reset		= hisi_qm_dev_slot_reset,
-- 
2.8.1

