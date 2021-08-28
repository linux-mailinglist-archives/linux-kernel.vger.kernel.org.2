Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 725EB3FA409
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 08:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233336AbhH1Gnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 02:43:43 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:9377 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232788AbhH1Gnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 02:43:42 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GxRk618NRz8vwr;
        Sat, 28 Aug 2021 14:38:38 +0800 (CST)
Received: from dggpemm500004.china.huawei.com (7.185.36.219) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 28 Aug 2021 14:42:49 +0800
Received: from huawei.com (10.174.28.241) by dggpemm500004.china.huawei.com
 (7.185.36.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Sat, 28 Aug
 2021 14:42:48 +0800
From:   Bixuan Cui <cuibixuan@huawei.com>
To:     <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>
CC:     <will@kernel.org>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
        <jean-philippe@linaro.org>, <Jonathan.Cameron@huawei.com>,
        <thunder.leizhen@huawei.com>, <maz@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH -next v3 1/2] platform-msi: Save the msg context to desc in platform_msi_write_msg()
Date:   Sat, 28 Aug 2021 14:39:14 +0800
Message-ID: <20210828063916.39633-1-cuibixuan@huawei.com>
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

Save the msg context to desc when the msi interrupt is requested.
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

