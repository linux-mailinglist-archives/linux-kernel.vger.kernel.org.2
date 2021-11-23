Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96004459DD7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 09:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234667AbhKWI02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 03:26:28 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:14972 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233807AbhKWI0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 03:26:21 -0500
Received: from dggeml709-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Hyxsj50K2zZd85;
        Tue, 23 Nov 2021 16:20:41 +0800 (CST)
Received: from localhost.localdomain (10.175.102.38) by
 dggeml709-chm.china.huawei.com (10.3.17.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Tue, 23 Nov 2021 16:23:11 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     <weiyongjun1@huawei.com>,
        Etienne Carriere <etienne.carriere@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next] firmware: arm_scmi: optee: Fix missing mutex_init()
Date:   Tue, 23 Nov 2021 08:36:20 +0000
Message-ID: <20211123083620.2366860-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.102.38]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggeml709-chm.china.huawei.com (10.3.17.139)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver allocates the mutex but not initialize it.
Use mutex_init() on it to initialize it correctly.

Fixes: 5f90f189a052 ("firmware: arm_scmi: Add optee transport")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/firmware/arm_scmi/optee.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/arm_scmi/optee.c b/drivers/firmware/arm_scmi/optee.c
index d9819b0197ec..901737c9f5f8 100644
--- a/drivers/firmware/arm_scmi/optee.c
+++ b/drivers/firmware/arm_scmi/optee.c
@@ -506,6 +506,7 @@ static int scmi_optee_service_probe(struct device *dev)
 	agent->dev = dev;
 	agent->tee_ctx = tee_ctx;
 	INIT_LIST_HEAD(&agent->channel_list);
+	mutex_init(&agent->mu);
 
 	ret = get_capabilities(agent);
 	if (ret)

