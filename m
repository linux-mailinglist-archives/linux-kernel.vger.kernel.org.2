Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8617396E33
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 09:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233193AbhFAHvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 03:51:25 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:3313 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbhFAHvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 03:51:23 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4FvPMH5Q40z19S69;
        Tue,  1 Jun 2021 15:44:59 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 15:49:41 +0800
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 15:49:40 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Lee Jones <lee.jones@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] mfd: tc6387xb: Use DEFINE_RES_MEM() and DEFINE_RES_IRQ() to simplify code
Date:   Tue, 1 Jun 2021 15:49:37 +0800
Message-ID: <20210601074937.10478-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/mfd/tc6387xb.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/mfd/tc6387xb.c b/drivers/mfd/tc6387xb.c
index e846e4d26b6eb2a..5676949354643ed 100644
--- a/drivers/mfd/tc6387xb.c
+++ b/drivers/mfd/tc6387xb.c
@@ -26,16 +26,8 @@ struct tc6387xb {
 };
 
 static const struct resource tc6387xb_mmc_resources[] = {
-	{
-		.start = 0x800,
-		.end   = 0x9ff,
-		.flags = IORESOURCE_MEM,
-	},
-	{
-		.start = 0,
-		.end   = 0,
-		.flags = IORESOURCE_IRQ,
-	},
+	DEFINE_RES_MEM(0x800, 0x200),
+	DEFINE_RES_IRQ(0)
 };
 
 /*--------------------------------------------------------------------------*/
-- 
2.26.0.106.g9fadedd


