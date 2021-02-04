Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65F4F30EF37
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 10:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233668AbhBDJFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 04:05:09 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12024 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233567AbhBDJCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 04:02:46 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DWXZc2vYMzjJlJ;
        Thu,  4 Feb 2021 17:00:40 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Thu, 4 Feb 2021 17:01:50 +0800
From:   Hui Tang <tanghui20@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <xuzaibo@huawei.com>,
        <wangzhou1@hisilicon.com>, <tanghui20@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/4] crypto: hisilicon/hpre - tiny fix
Date:   Thu, 4 Feb 2021 16:59:34 +0800
Message-ID: <1612429176-28084-3-git-send-email-tanghui20@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1612429176-28084-1-git-send-email-tanghui20@huawei.com>
References: <1612429176-28084-1-git-send-email-tanghui20@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update since some special settings only for Kunpeng920.

Signed-off-by: Hui Tang <tanghui20@huawei.com>
---
 drivers/crypto/hisilicon/hpre/hpre_main.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/crypto/hisilicon/hpre/hpre_main.c b/drivers/crypto/hisilicon/hpre/hpre_main.c
index 0045261..06448b8 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_main.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_main.c
@@ -318,7 +318,7 @@ static int hpre_set_cluster(struct hisi_qm *qm)
 }

 /*
- * For Hi1620, we shoul disable FLR triggered by hardware (BME/PM/SRIOV).
+ * For Kunpeng 920, we shoul disable FLR triggered by hardware (BME/PM/SRIOV).
  * Or it may stay in D3 state when we bind and unbind hpre quickly,
  * as it does FLR triggered by hardware.
  */
@@ -376,11 +376,14 @@ static int hpre_set_user_domain_and_cache(struct hisi_qm *qm)
 	if (ret)
 		return -ETIMEDOUT;

-	ret = hpre_cfg_by_dsm(qm);
-	if (ret)
-		dev_err(dev, "acpi_evaluate_dsm err.\n");
+	/* This setting is only needed by Kunpeng 920. */
+	if (qm->ver == QM_HW_V2) {
+		ret = hpre_cfg_by_dsm(qm);
+		if (ret)
+			dev_err(dev, "acpi_evaluate_dsm err.\n");

-	disable_flr_of_bme(qm);
+		disable_flr_of_bme(qm);
+	}

 	return ret;
 }
--
2.8.1

