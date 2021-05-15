Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 014C63817BF
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 12:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbhEOKtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 06:49:23 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3694 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbhEOKtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 06:49:17 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Fj28p1gMHz16QD6;
        Sat, 15 May 2021 18:44:58 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Sat, 15 May 2021 18:47:34 +0800
From:   Weili Qian <qianweili@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <xuzaibo@huawei.com>, <wangzhou1@hisilicon.com>,
        <liulongfang@huawei.com>
Subject: [PATCH 1/4] crypto: hisilicon/qm - initialize the device before doing tasks
Date:   Sat, 15 May 2021 18:44:37 +0800
Message-ID: <1621075480-52869-2-git-send-email-qianweili@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1621075480-52869-1-git-send-email-qianweili@huawei.com>
References: <1621075480-52869-1-git-send-email-qianweili@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device needs to be initialized first, and then restart the queue to
execute tasks after PF reset.

Signed-off-by: Weili Qian <qianweili@huawei.com>
---
 drivers/crypto/hisilicon/qm.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index ce439a0..6a9c18f 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -4085,6 +4085,14 @@ void hisi_qm_reset_done(struct pci_dev *pdev)
 	struct hisi_qm *qm = pci_get_drvdata(pdev);
 	int ret;
 
+	if (qm->fun_type == QM_HW_PF) {
+		ret = qm_dev_hw_init(qm);
+		if (ret) {
+			pci_err(pdev, "Failed to init PF, ret = %d.\n", ret);
+			goto flr_done;
+		}
+	}
+
 	hisi_qm_dev_err_init(pf_qm);
 
 	ret = qm_restart(qm);
@@ -4094,12 +4102,6 @@ void hisi_qm_reset_done(struct pci_dev *pdev)
 	}
 
 	if (qm->fun_type == QM_HW_PF) {
-		ret = qm_dev_hw_init(qm);
-		if (ret) {
-			pci_err(pdev, "Failed to init PF, ret = %d.\n", ret);
-			goto flr_done;
-		}
-
 		if (!qm->vfs_num)
 			goto flr_done;
 
-- 
2.8.1

