Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35D52396D65
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 08:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233086AbhFAGfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 02:35:55 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2809 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233019AbhFAGft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 02:35:49 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FvMh55w3rzWpfF;
        Tue,  1 Jun 2021 14:29:25 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 14:34:07 +0800
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 14:34:06 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi <linux-sunxi@lists.linux.dev>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] mfd: sun6i-prcm: Use DEFINE_RES_MEM() to simplify code
Date:   Tue, 1 Jun 2021 14:34:01 +0800
Message-ID: <20210601063401.9830-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/mfd/sun6i-prcm.c | 30 +++++-------------------------
 1 file changed, 5 insertions(+), 25 deletions(-)

diff --git a/drivers/mfd/sun6i-prcm.c b/drivers/mfd/sun6i-prcm.c
index c31927d4bbbecde..ee03db0b8485266 100644
--- a/drivers/mfd/sun6i-prcm.c
+++ b/drivers/mfd/sun6i-prcm.c
@@ -20,43 +20,23 @@ struct prcm_data {
 };
 
 static const struct resource sun6i_a31_ar100_clk_res[] = {
-	{
-		.start = 0x0,
-		.end = 0x3,
-		.flags = IORESOURCE_MEM,
-	},
+	DEFINE_RES_MEM(0x0, 4)
 };
 
 static const struct resource sun6i_a31_apb0_clk_res[] = {
-	{
-		.start = 0xc,
-		.end = 0xf,
-		.flags = IORESOURCE_MEM,
-	},
+	DEFINE_RES_MEM(0xc, 4)
 };
 
 static const struct resource sun6i_a31_apb0_gates_clk_res[] = {
-	{
-		.start = 0x28,
-		.end = 0x2b,
-		.flags = IORESOURCE_MEM,
-	},
+	DEFINE_RES_MEM(0x28, 4)
 };
 
 static const struct resource sun6i_a31_ir_clk_res[] = {
-	{
-		.start = 0x54,
-		.end = 0x57,
-		.flags = IORESOURCE_MEM,
-	},
+	DEFINE_RES_MEM(0x54, 4)
 };
 
 static const struct resource sun6i_a31_apb0_rstc_res[] = {
-	{
-		.start = 0xb0,
-		.end = 0xb3,
-		.flags = IORESOURCE_MEM,
-	},
+	DEFINE_RES_MEM(0xb0, 4)
 };
 
 static const struct resource sun8i_codec_analog_res[] = {
-- 
2.26.0.106.g9fadedd


