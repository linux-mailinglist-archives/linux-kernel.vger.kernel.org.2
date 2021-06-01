Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A782396D81
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 08:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233025AbhFAGma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 02:42:30 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2811 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbhFAGm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 02:42:29 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FvMqn5zpWzWqMs
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 14:36:05 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 14:40:46 +0800
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 14:40:45 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Johannes Thumshirn <morbidrsa@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] mcb: Use DEFINE_RES_MEM() to simplify code
Date:   Tue, 1 Jun 2021 14:40:38 +0800
Message-ID: <20210601064038.9936-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The value of '.end' should be "start + size - 1". So the previous writing
should have omitted subtracted 1.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/mcb/mcb-lpc.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/mcb/mcb-lpc.c b/drivers/mcb/mcb-lpc.c
index 506676754538b9e..53decd89876ee1b 100644
--- a/drivers/mcb/mcb-lpc.c
+++ b/drivers/mcb/mcb-lpc.c
@@ -105,17 +105,8 @@ static int mcb_lpc_create_platform_device(const struct dmi_system_id *id)
 	return ret;
 }
 
-static struct resource sc24_fpga_resource = {
-	.start = 0xe000e000,
-	.end = 0xe000e000 + CHAM_HEADER_SIZE,
-	.flags = IORESOURCE_MEM,
-};
-
-static struct resource sc31_fpga_resource = {
-	.start = 0xf000e000,
-	.end = 0xf000e000 + CHAM_HEADER_SIZE,
-	.flags = IORESOURCE_MEM,
-};
+static struct resource sc24_fpga_resource = DEFINE_RES_MEM(0xe000e000, CHAM_HEADER_SIZE);
+static struct resource sc31_fpga_resource = DEFINE_RES_MEM(0xf000e000, CHAM_HEADER_SIZE);
 
 static struct platform_driver mcb_lpc_driver = {
 	.driver		= {
-- 
2.26.0.106.g9fadedd


