Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC943A3EB1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 11:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbhFKJJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 05:09:43 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:9078 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbhFKJJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 05:09:25 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G1ZfW2kymzZcpv;
        Fri, 11 Jun 2021 17:04:35 +0800 (CST)
Received: from dggpeml500012.china.huawei.com (7.185.36.15) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
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
Subject: [PATCH 4/8] crypto: hisilicon/qm - add pf ping single vf function
Date:   Fri, 11 Jun 2021 17:06:46 +0800
Message-ID: <1623402410-63906-5-git-send-email-yekai13@huawei.com>
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

According to the function communication, add pf ping single
vf function to be used in the vf read QoS.

Signed-off-by: Kai Ye <yekai13@huawei.com>
---
 drivers/crypto/hisilicon/qm.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index 9b8e09e..72648dc 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -2142,6 +2142,42 @@ static void qm_trigger_pf_interrupt(struct hisi_qm *qm)
 	writel(val, qm->io_base + QM_IFC_INT_SET_V);
 }
 
+static int qm_ping_single_vf(struct hisi_qm *qm, u64 cmd, u32 fun_num)
+{
+	struct device *dev = &qm->pdev->dev;
+	struct qm_mailbox mailbox;
+	int cnt = 0;
+	u64 val;
+	int ret;
+
+	qm_mb_pre_init(&mailbox, QM_MB_CMD_SRC, cmd, fun_num, 0);
+	mutex_lock(&qm->mailbox_lock);
+	ret = qm_mb_nolock(qm, &mailbox);
+	if (ret) {
+		dev_err(dev, "failed to send command to vf(%u)!\n", fun_num);
+		goto err_unlock;
+	}
+
+	qm_trigger_vf_interrupt(qm, fun_num);
+	while (true) {
+		msleep(QM_WAIT_DST_ACK);
+		val = readq(qm->io_base + QM_IFC_READY_STATUS);
+		/* if VF respond, PF notifies VF successfully. */
+		if (!(val & BIT(fun_num)))
+			goto err_unlock;
+
+		if (++cnt > QM_MAX_PF_WAIT_COUNT) {
+			dev_err(dev, "failed to get response from VF(%u)!\n", fun_num);
+			ret = -ETIMEDOUT;
+			break;
+		}
+	}
+
+err_unlock:
+	mutex_unlock(&qm->mailbox_lock);
+	return ret;
+}
+
 static int qm_ping_all_vfs(struct hisi_qm *qm, u64 cmd)
 {
 	struct device *dev = &qm->pdev->dev;
-- 
2.7.4

