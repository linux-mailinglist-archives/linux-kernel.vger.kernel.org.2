Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEC1335FD2F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 23:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbhDNVUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 17:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232234AbhDNVTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 17:19:40 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFAEC061761;
        Wed, 14 Apr 2021 14:19:18 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id w3so33609221ejc.4;
        Wed, 14 Apr 2021 14:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/8ue3C3/vuHzsBzvGcphBwhbaDZVSjtTH0PvrnAwtIQ=;
        b=RAkpedgieo6Ep13Sekr7CIB6n2IGq56zyrXBeiWUrr2oaya8aJkAKWfASE4K5bS00H
         DWRn9AUmEhtk5eME+Qz7CaqMUtTx1Xh7ril0pwoO0rlrCn/hllD4+MR4ZQcSozMhpmzB
         uulq8AT0pEMugzmHuD3KpNnsJFzobZT6ZaqH1iM2E1SFXbYiMbuhjPT8PynnbFtE/0rI
         9CUjU+K6t9b6K9UZsT5nN/HwMEcHVOMk0+/UydcQX3kXBbJzwvbEWuYAY6jIiZ8J+7VQ
         fVNRtaMMS0ZsmeCBbH+C+k83s+kg9EU4nZc6LrfIdzMB2Ty5aGTK2HfuK0mUUPeqwzge
         E1Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/8ue3C3/vuHzsBzvGcphBwhbaDZVSjtTH0PvrnAwtIQ=;
        b=FSr1fyEtrTfrYXmElATTb5GjuGCq8yDk05aLSpvD2Bu0sHNDeRTPvgnupb5zGKEKXX
         YmEueyrrewsa+8h7IJkwJkKS7YtkEjN23pgiWMQuKuVWxeTXSypp0bvs2WY+5fJ0B/Gj
         haEDemDSyASbXD2dq52vU/f7LU8rDFFyhvh6QqeA8jvsuXPJDIlB3Pwo/YfczPePA9ji
         MBHLR/FylofWQI5H3caSZ+7/XFRPtSzzmQl59MWG8MBDwtEQXbwkqaxCIO90U57Z5Sc+
         AlHxzQJZi8cnFcQQ7fUYaZtYcSp/SiAq7MHkqpsRiZ6CcKYMa1t63R+B7r9U0nuxcnx0
         rI5w==
X-Gm-Message-State: AOAM533n7xtUJrFLWKONRvyZIqgAwddCORfXP1Qt1PzcXfJPOZViiqKC
        VsmV83WNQwl/RopSwN5QY3M=
X-Google-Smtp-Source: ABdhPJz2txx79S14UfZsdJsSo99HGS9ws7jO5YHAS05dEXTpL7Ecbzn0sBBXV2TkQI9iZtVZy/sD4w==
X-Received: by 2002:a17:906:b2cf:: with SMTP id cf15mr60523ejb.233.1618435157199;
        Wed, 14 Apr 2021 14:19:17 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id v5sm568222edx.87.2021.04.14.14.19.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Apr 2021 14:19:16 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, zhangqing@rock-chips.com,
        enric.balletbo@collabora.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 11/11] soc: rockchip: power-domain: add rk3568 powerdomains
Date:   Wed, 14 Apr 2021 23:18:56 +0200
Message-Id: <20210414211856.12104-12-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210414211856.12104-1-jbx6244@gmail.com>
References: <20210414211856.12104-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Elaine Zhang <zhangqing@rock-chips.com>

Add power-domains found on rk3568 socs.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
Changed V7:
  Fix alignment
---
 drivers/soc/rockchip/pm_domains.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/soc/rockchip/pm_domains.c b/drivers/soc/rockchip/pm_domains.c
index 1d1b06672..0868b7d40 100644
--- a/drivers/soc/rockchip/pm_domains.c
+++ b/drivers/soc/rockchip/pm_domains.c
@@ -27,6 +27,7 @@
 #include <dt-bindings/power/rk3366-power.h>
 #include <dt-bindings/power/rk3368-power.h>
 #include <dt-bindings/power/rk3399-power.h>
+#include <dt-bindings/power/rk3568-power.h>
 
 struct rockchip_domain_info {
 	const char *name;
@@ -135,6 +136,9 @@ struct rockchip_pmu {
 #define DOMAIN_RK3399(name, pwr, status, req, wakeup)		\
 	DOMAIN(name, pwr, status, req, req, req, wakeup)
 
+#define DOMAIN_RK3568(name, pwr, req, wakeup)		\
+	DOMAIN_M(name, pwr, pwr, req, req, req, wakeup)
+
 static bool rockchip_pmu_domain_is_idle(struct rockchip_pm_domain *pd)
 {
 	struct rockchip_pmu *pmu = pd->pmu;
@@ -848,6 +852,18 @@ static const struct rockchip_domain_info rk3399_pm_domains[] = {
 	[RK3399_PD_SDIOAUDIO]	= DOMAIN_RK3399("sdioaudio", BIT(31), BIT(31), BIT(29), true),
 };
 
+static const struct rockchip_domain_info rk3568_pm_domains[] = {
+	[RK3568_PD_NPU]		= DOMAIN_RK3568("npu",  BIT(1), BIT(2),  false),
+	[RK3568_PD_GPU]		= DOMAIN_RK3568("gpu",  BIT(0), BIT(1),  false),
+	[RK3568_PD_VI]		= DOMAIN_RK3568("vi",   BIT(6), BIT(3),  false),
+	[RK3568_PD_VO]		= DOMAIN_RK3568("vo",   BIT(7), BIT(4),  false),
+	[RK3568_PD_RGA]		= DOMAIN_RK3568("rga",  BIT(5), BIT(5),  false),
+	[RK3568_PD_VPU]		= DOMAIN_RK3568("vpu",  BIT(2), BIT(6),  false),
+	[RK3568_PD_RKVDEC]	= DOMAIN_RK3568("vdec", BIT(4), BIT(8),  false),
+	[RK3568_PD_RKVENC]	= DOMAIN_RK3568("venc", BIT(3), BIT(7),  false),
+	[RK3568_PD_PIPE]	= DOMAIN_RK3568("pipe", BIT(8), BIT(11), false),
+};
+
 static const struct rockchip_pmu_info px30_pmu = {
 	.pwr_offset = 0x18,
 	.status_offset = 0x20,
@@ -983,6 +999,17 @@ static const struct rockchip_pmu_info rk3399_pmu = {
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
@@ -1028,6 +1055,10 @@ static const struct of_device_id rockchip_pm_domain_dt_match[] = {
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
2.11.0

