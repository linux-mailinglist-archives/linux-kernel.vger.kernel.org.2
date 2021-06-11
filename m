Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E03CC3A3EAD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 11:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbhFKJJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 05:09:32 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3961 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbhFKJJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 05:09:15 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G1Zdz6wwxz6xYL;
        Fri, 11 Jun 2021 17:04:07 +0800 (CST)
Received: from dggpeml500012.china.huawei.com (7.185.36.15) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 11 Jun 2021 17:07:09 +0800
Received: from huawei.com (10.69.192.56) by dggpeml500012.china.huawei.com
 (7.185.36.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 11 Jun
 2021 17:07:09 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <yekai13@huawei.com>
Subject: [PATCH 6/8] crypto: hisilicon/sec - adds the max shaper type rate
Date:   Fri, 11 Jun 2021 17:06:48 +0800
Message-ID: <1623402410-63906-7-git-send-email-yekai13@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1623402410-63906-1-git-send-email-yekai13@huawei.com>
References: <1623402410-63906-1-git-send-email-yekai13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500012.china.huawei.com (7.185.36.15)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SEC driver support configure each function's QoS in the Host
for Kunpeng930. The SEC driver needs to configure the maximum shaper
type rate.

Signed-off-by: Kai Ye <yekai13@huawei.com>
---
 drivers/crypto/hisilicon/sec2/sec_main.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/crypto/hisilicon/sec2/sec_main.c b/drivers/crypto/hisilicon/sec2/sec_main.c
index 8ab4e67..d120ce3 100644
--- a/drivers/crypto/hisilicon/sec2/sec_main.c
+++ b/drivers/crypto/hisilicon/sec2/sec_main.c
@@ -98,6 +98,7 @@
 
 #define SEC_SQE_MASK_OFFSET		64
 #define SEC_SQE_MASK_LEN		48
+#define SEC_SHAPER_TYPE_RATE		128
 
 struct sec_hw_error {
 	u32 int_msk;
@@ -874,6 +875,7 @@ static void sec_qm_uninit(struct hisi_qm *qm)
 
 static int sec_probe_init(struct sec_dev *sec)
 {
+	u32 type_rate = SEC_SHAPER_TYPE_RATE;
 	struct hisi_qm *qm = &sec->qm;
 	int ret;
 
@@ -881,6 +883,11 @@ static int sec_probe_init(struct sec_dev *sec)
 		ret = sec_pf_probe_init(sec);
 		if (ret)
 			return ret;
+		/* enable shaper type 0 */
+		if (qm->ver >= QM_HW_V3) {
+			type_rate |= QM_SHAPER_ENABLE;
+			qm->type_rate = type_rate;
+		}
 	}
 
 	return 0;
-- 
2.7.4

