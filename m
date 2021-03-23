Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E947434599E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 09:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbhCWIZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 04:25:15 -0400
Received: from lucky1.263xmail.com ([211.157.147.133]:46982 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhCWIYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 04:24:36 -0400
Received: from localhost (unknown [192.168.167.16])
        by lucky1.263xmail.com (Postfix) with ESMTP id 05576CCDFF;
        Tue, 23 Mar 2021 16:24:24 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P13109T139928883160832S1616487860290898_;
        Tue, 23 Mar 2021 16:24:24 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <8977f7fba130945709e54be4d799c56b>
X-RL-SENDER: zhangqing@rock-chips.com
X-SENDER: zhangqing@rock-chips.com
X-LOGIN-NAME: zhangqing@rock-chips.com
X-FST-TO: robh+dt@kernel.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   Elaine Zhang <zhangqing@rock-chips.com>
To:     robh+dt@kernel.org, heiko@sntech.de
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        cl@rock-chips.com, huangtao@rock-chips.com,
        kever.yang@rock-chips.com, tony.xie@rock-chips.com,
        finley.xiao@rock-chips.com, Elaine Zhang <zhangqing@rock-chips.com>
Subject: [PATCH v2 3/3] soc: rockchip: power-domain: add rk3568 powerdomains
Date:   Tue, 23 Mar 2021 16:24:10 +0800
Message-Id: <20210323082410.22818-4-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210323082410.22818-1-zhangqing@rock-chips.com>
References: <20210323082410.22818-1-zhangqing@rock-chips.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add power-domains found on rk3568 socs.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 drivers/soc/rockchip/pm_domains.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/soc/rockchip/pm_domains.c b/drivers/soc/rockchip/pm_domains.c
index 54eb6cfc5d5b..a2c19c845cf2 100644
--- a/drivers/soc/rockchip/pm_domains.c
+++ b/drivers/soc/rockchip/pm_domains.c
@@ -27,6 +27,7 @@
 #include <dt-bindings/power/rk3366-power.h>
 #include <dt-bindings/power/rk3368-power.h>
 #include <dt-bindings/power/rk3399-power.h>
+#include <dt-bindings/power/rk3568-power.h>
 
 struct rockchip_domain_info {
 	int pwr_mask;
@@ -131,6 +132,9 @@ struct rockchip_pmu {
 #define DOMAIN_RK3399(pwr, status, req, wakeup)		\
 	DOMAIN(pwr, status, req, req, req, wakeup)
 
+#define DOMAIN_RK3568(pwr, req, wakeup)		\
+	DOMAIN_M(pwr, pwr, req, req, req, wakeup)
+
 static bool rockchip_pmu_domain_is_idle(struct rockchip_pm_domain *pd)
 {
 	struct rockchip_pmu *pmu = pd->pmu;
@@ -841,6 +845,18 @@ static const struct rockchip_domain_info rk3399_pm_domains[] = {
 	[RK3399_PD_SDIOAUDIO]	= DOMAIN_RK3399(BIT(31), BIT(31), BIT(29), true),
 };
 
+static const struct rockchip_domain_info rk3568_pm_domains[] = {
+	[RK3568_PD_NPU]		= DOMAIN_RK3568(BIT(1), BIT(2), false),
+	[RK3568_PD_GPU]		= DOMAIN_RK3568(BIT(0), BIT(1), false),
+	[RK3568_PD_VI]		= DOMAIN_RK3568(BIT(6), BIT(3), false),
+	[RK3568_PD_VO]		= DOMAIN_RK3568(BIT(7),  BIT(4), false),
+	[RK3568_PD_RGA]		= DOMAIN_RK3568(BIT(5),  BIT(5), false),
+	[RK3568_PD_VPU]		= DOMAIN_RK3568(BIT(2), BIT(6), false),
+	[RK3568_PD_RKVDEC]	= DOMAIN_RK3568(BIT(4), BIT(8), false),
+	[RK3568_PD_RKVENC]	= DOMAIN_RK3568(BIT(3), BIT(7), false),
+	[RK3568_PD_PIPE]	= DOMAIN_RK3568(BIT(8), BIT(11), false),
+};
+
 static const struct rockchip_pmu_info px30_pmu = {
 	.pwr_offset = 0x18,
 	.status_offset = 0x20,
@@ -976,6 +992,17 @@ static const struct rockchip_pmu_info rk3399_pmu = {
 	.domain_info = rk3399_pm_domains,
 };
 
+static const struct rockchip_pmu_info rk3568_pmu = {
+	.pwr_offset = 0xa0,
+	.status_offset = 0x98,
+	.req_offset = 0x50,
+	.idle_offset = 0x68,
+	.ack_offset = 0x60,
+
+	.num_domains = ARRAY_SIZE(rk3568_pm_domains),
+	.domain_info = rk3568_pm_domains,
+};
+
 static const struct of_device_id rockchip_pm_domain_dt_match[] = {
 	{
 		.compatible = "rockchip,px30-power-controller",
@@ -1021,6 +1048,10 @@ static const struct of_device_id rockchip_pm_domain_dt_match[] = {
 		.compatible = "rockchip,rk3399-power-controller",
 		.data = (void *)&rk3399_pmu,
 	},
+	{
+		.compatible = "rockchip,rk3568-power-controller",
+		.data = (void *)&rk3568_pmu,
+	},
 	{ /* sentinel */ },
 };
 
-- 
2.17.1



