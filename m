Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50A043FB206
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 09:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233844AbhH3Hnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 03:43:31 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:9385 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233109AbhH3Hna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 03:43:30 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Gyhy56NSCz8sZd;
        Mon, 30 Aug 2021 15:38:21 +0800 (CST)
Received: from dggpemm500004.china.huawei.com (7.185.36.219) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 30 Aug 2021 15:42:34 +0800
Received: from huawei.com (10.174.28.241) by dggpemm500004.china.huawei.com
 (7.185.36.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 30 Aug
 2021 15:42:34 +0800
From:   Bixuan Cui <cuibixuan@huawei.com>
To:     <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>
CC:     <will@kernel.org>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
        <jean-philippe@linaro.org>, <Jonathan.Cameron@huawei.com>,
        <thunder.leizhen@huawei.com>, <maz@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH -next v4 1/2] platform-msi: Save the msg context to desc in platform_msi_write_msg()
Date:   Mon, 30 Aug 2021 15:38:57 +0800
Message-ID: <20210830073858.47084-1-cuibixuan@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.28.241]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500004.china.huawei.com (7.185.36.219)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Save the msg context to desc when when the msi interrupt is requested.
The drivers can use it in special scenarios(such as resume).

Signed-off-by: Bixuan Cui <cuibixuan@huawei.com>
---
 drivers/base/platform-msi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
index 3d6c8f9caf43..60962a224fcc 100644
--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -90,6 +90,9 @@ static void platform_msi_write_msg(struct irq_data *data, struct msi_msg *msg)
 
 	priv_data = desc->platform.msi_priv_data;
 
+	desc->msg.address_lo = msg->address_lo;
+	desc->msg.address_hi = msg->address_hi;
+	desc->msg.data = msg->data;
 	priv_data->write_msg(desc, msg);
 }
 
-- 
2.17.1

