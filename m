Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C901A361B5D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 10:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239676AbhDPIIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 04:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239599AbhDPIIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 04:08:00 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E671AC061574;
        Fri, 16 Apr 2021 01:07:34 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id m3so31166159edv.5;
        Fri, 16 Apr 2021 01:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Nvdu3D+zJuMBxndIkEGSwtad6n9ZK3vplpCEOlMDRAY=;
        b=WJRLA0rR4Rf5Hc96wiAQqJO7DCqlma3jLz6amWfv5s170XKRLBOWTnK7Jrzfcgna9m
         9km7YoTyjHNyueM3vr3sAaINMARcP6Bf+gRCyZCTIt58rswNKqsO5WbqDUNJxcc1aEzo
         r8j6ygIw8tI/Noq0GfTevLQzyQcTZZ2TlJzC0YDSQH6J2rmmfJd/v6n4j9v8Zj0F/HXg
         x7wTD/f5shkItGppSLTmapdmECpbaj2C1nUQZVYy/+nNWBuNBw/KKnCFJH5HZMqssRyD
         W4DXDNYZtewi3O8j1fY7OliD4CfWJ5Dljv6ESoUKLGPCZmIJZB4IWnWPeuRs7MDiXKBt
         G9yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Nvdu3D+zJuMBxndIkEGSwtad6n9ZK3vplpCEOlMDRAY=;
        b=lYUJKBsUS4i8hfN259oNXskN8twRwgbvqXkOKc+wi/X/9g2Io/RYHgkTB/W6sWUYvc
         gWfWotquZ8P+Wsqywupu5feU6u1txhV2SQJKMs3wP2E1IkRTIMG+7KzGjNkGlUjIK1eD
         QD2rEIVu2QvvZtqM3b0z5IMHwc7zYpDYA97/W5BPGPf0Qitl2ZGQM8vijB/f4DCaVZU0
         DwCl0bUTezMCm5SlxRYYK5wwMJDWbiCgqwk5WzHXh4UoyFZKXIUn7+E9Idio7n0ewjmS
         kT7S/iQnNClMcWIO7WypZvdTIsmckI3F6aKudB+NdjhigE46j8H6k4/wb2STb/KtnrTG
         pxaQ==
X-Gm-Message-State: AOAM5314qx9Ise2z6paR7ppVLD7gxawiZwTyj2iGB9Fhy9Rh4T9iVjrL
        wB8v/p6KUj0sIsNVosVqnbo=
X-Google-Smtp-Source: ABdhPJycpiQVGoJSR9To3ZQSLrl2ywE+gRjYg43PJ61bvN9j9CO653VE9qBmN0xjlp27TJyArXacgA==
X-Received: by 2002:a05:6402:42c8:: with SMTP id i8mr8546671edc.386.1618560453592;
        Fri, 16 Apr 2021 01:07:33 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id q16sm4672303edv.61.2021.04.16.01.07.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Apr 2021 01:07:33 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, zhangqing@rock-chips.com,
        enric.balletbo@collabora.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 09/15] soc: rockchip: pm-domains: Add a meaningful power domain name
Date:   Fri, 16 Apr 2021 10:03:36 +0200
Message-Id: <20210416080342.18614-10-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210416080342.18614-1-jbx6244@gmail.com>
References: <20210416080342.18614-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Elaine Zhang <zhangqing@rock-chips.com>

Add the power domains names to the power domain info struct so we
have meaningful name for every power domain.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
Changed V7:
  Fix TAB warning
  Fix alignment
---
 drivers/soc/rockchip/pm_domains.c | 221 ++++++++++++++++++++------------------
 1 file changed, 114 insertions(+), 107 deletions(-)

diff --git a/drivers/soc/rockchip/pm_domains.c b/drivers/soc/rockchip/pm_domains.c
index 54eb6cfc5..1d1b06672 100644
--- a/drivers/soc/rockchip/pm_domains.c
+++ b/drivers/soc/rockchip/pm_domains.c
@@ -29,6 +29,7 @@
 #include <dt-bindings/power/rk3399-power.h>
 
 struct rockchip_domain_info {
+	const char *name;
 	int pwr_mask;
 	int status_mask;
 	int req_mask;
@@ -85,8 +86,9 @@ struct rockchip_pmu {
 
 #define to_rockchip_pd(gpd) container_of(gpd, struct rockchip_pm_domain, genpd)
 
-#define DOMAIN(pwr, status, req, idle, ack, wakeup)	\
+#define DOMAIN(_name, pwr, status, req, idle, ack, wakeup)	\
 {							\
+	.name = _name,				\
 	.pwr_mask = (pwr),				\
 	.status_mask = (status),			\
 	.req_mask = (req),				\
@@ -95,8 +97,9 @@ struct rockchip_pmu {
 	.active_wakeup = (wakeup),			\
 }
 
-#define DOMAIN_M(pwr, status, req, idle, ack, wakeup)	\
+#define DOMAIN_M(_name, pwr, status, req, idle, ack, wakeup)	\
 {							\
+	.name = _name,				\
 	.pwr_w_mask = (pwr) << 16,			\
 	.pwr_mask = (pwr),				\
 	.status_mask = (status),			\
@@ -107,8 +110,9 @@ struct rockchip_pmu {
 	.active_wakeup = wakeup,			\
 }
 
-#define DOMAIN_RK3036(req, ack, idle, wakeup)		\
+#define DOMAIN_RK3036(_name, req, ack, idle, wakeup)		\
 {							\
+	.name = _name,				\
 	.req_mask = (req),				\
 	.req_w_mask = (req) << 16,			\
 	.ack_mask = (ack),				\
@@ -116,20 +120,20 @@ struct rockchip_pmu {
 	.active_wakeup = wakeup,			\
 }
 
-#define DOMAIN_PX30(pwr, status, req, wakeup)		\
-	DOMAIN_M(pwr, status, req, (req) << 16, req, wakeup)
+#define DOMAIN_PX30(name, pwr, status, req, wakeup)		\
+	DOMAIN_M(name, pwr, status, req, (req) << 16, req, wakeup)
 
-#define DOMAIN_RK3288(pwr, status, req, wakeup)		\
-	DOMAIN(pwr, status, req, req, (req) << 16, wakeup)
+#define DOMAIN_RK3288(name, pwr, status, req, wakeup)		\
+	DOMAIN(name, pwr, status, req, req, (req) << 16, wakeup)
 
-#define DOMAIN_RK3328(pwr, status, req, wakeup)		\
-	DOMAIN_M(pwr, pwr, req, (req) << 10, req, wakeup)
+#define DOMAIN_RK3328(name, pwr, status, req, wakeup)		\
+	DOMAIN_M(name, pwr, pwr, req, (req) << 10, req, wakeup)
 
-#define DOMAIN_RK3368(pwr, status, req, wakeup)		\
-	DOMAIN(pwr, status, req, (req) << 16, req, wakeup)
+#define DOMAIN_RK3368(name, pwr, status, req, wakeup)		\
+	DOMAIN(name, pwr, status, req, (req) << 16, req, wakeup)
 
-#define DOMAIN_RK3399(pwr, status, req, wakeup)		\
-	DOMAIN(pwr, status, req, req, req, wakeup)
+#define DOMAIN_RK3399(name, pwr, status, req, wakeup)		\
+	DOMAIN(name, pwr, status, req, req, req, wakeup)
 
 static bool rockchip_pmu_domain_is_idle(struct rockchip_pm_domain *pd)
 {
@@ -490,7 +494,10 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
 		goto err_unprepare_clocks;
 	}
 
-	pd->genpd.name = node->name;
+	if (pd->info->name)
+		pd->genpd.name = pd->info->name;
+	else
+		pd->genpd.name = kbasename(node->full_name);
 	pd->genpd.power_off = rockchip_pd_power_off;
 	pd->genpd.power_on = rockchip_pd_power_on;
 	pd->genpd.attach_dev = rockchip_pd_attach_dev;
@@ -716,129 +723,129 @@ static int rockchip_pm_domain_probe(struct platform_device *pdev)
 }
 
 static const struct rockchip_domain_info px30_pm_domains[] = {
-	[PX30_PD_USB]		= DOMAIN_PX30(BIT(5),  BIT(5),  BIT(10), false),
-	[PX30_PD_SDCARD]	= DOMAIN_PX30(BIT(8),  BIT(8),  BIT(9),  false),
-	[PX30_PD_GMAC]		= DOMAIN_PX30(BIT(10), BIT(10), BIT(6),  false),
-	[PX30_PD_MMC_NAND]	= DOMAIN_PX30(BIT(11), BIT(11), BIT(5),  false),
-	[PX30_PD_VPU]		= DOMAIN_PX30(BIT(12), BIT(12), BIT(14), false),
-	[PX30_PD_VO]		= DOMAIN_PX30(BIT(13), BIT(13), BIT(7),  false),
-	[PX30_PD_VI]		= DOMAIN_PX30(BIT(14), BIT(14), BIT(8),  false),
-	[PX30_PD_GPU]		= DOMAIN_PX30(BIT(15), BIT(15), BIT(2),  false),
+	[PX30_PD_USB]		= DOMAIN_PX30("usb",      BIT(5),  BIT(5),  BIT(10), false),
+	[PX30_PD_SDCARD]	= DOMAIN_PX30("sdcard",   BIT(8),  BIT(8),  BIT(9),  false),
+	[PX30_PD_GMAC]		= DOMAIN_PX30("gmac",     BIT(10), BIT(10), BIT(6),  false),
+	[PX30_PD_MMC_NAND]	= DOMAIN_PX30("mmc_nand", BIT(11), BIT(11), BIT(5),  false),
+	[PX30_PD_VPU]		= DOMAIN_PX30("vpu",      BIT(12), BIT(12), BIT(14), false),
+	[PX30_PD_VO]		= DOMAIN_PX30("vo",       BIT(13), BIT(13), BIT(7),  false),
+	[PX30_PD_VI]		= DOMAIN_PX30("vi",       BIT(14), BIT(14), BIT(8),  false),
+	[PX30_PD_GPU]		= DOMAIN_PX30("gpu",      BIT(15), BIT(15), BIT(2),  false),
 };
 
 static const struct rockchip_domain_info rk3036_pm_domains[] = {
-	[RK3036_PD_MSCH]	= DOMAIN_RK3036(BIT(14), BIT(23), BIT(30), true),
-	[RK3036_PD_CORE]	= DOMAIN_RK3036(BIT(13), BIT(17), BIT(24), false),
-	[RK3036_PD_PERI]	= DOMAIN_RK3036(BIT(12), BIT(18), BIT(25), false),
-	[RK3036_PD_VIO]		= DOMAIN_RK3036(BIT(11), BIT(19), BIT(26), false),
-	[RK3036_PD_VPU]		= DOMAIN_RK3036(BIT(10), BIT(20), BIT(27), false),
-	[RK3036_PD_GPU]		= DOMAIN_RK3036(BIT(9),  BIT(21), BIT(28), false),
-	[RK3036_PD_SYS]		= DOMAIN_RK3036(BIT(8),  BIT(22), BIT(29), false),
+	[RK3036_PD_MSCH]	= DOMAIN_RK3036("msch", BIT(14), BIT(23), BIT(30), true),
+	[RK3036_PD_CORE]	= DOMAIN_RK3036("core", BIT(13), BIT(17), BIT(24), false),
+	[RK3036_PD_PERI]	= DOMAIN_RK3036("peri", BIT(12), BIT(18), BIT(25), false),
+	[RK3036_PD_VIO]		= DOMAIN_RK3036("vio",  BIT(11), BIT(19), BIT(26), false),
+	[RK3036_PD_VPU]		= DOMAIN_RK3036("vpu",  BIT(10), BIT(20), BIT(27), false),
+	[RK3036_PD_GPU]		= DOMAIN_RK3036("gpu",  BIT(9),  BIT(21), BIT(28), false),
+	[RK3036_PD_SYS]		= DOMAIN_RK3036("sys",  BIT(8),  BIT(22), BIT(29), false),
 };
 
 static const struct rockchip_domain_info rk3066_pm_domains[] = {
-	[RK3066_PD_GPU]		= DOMAIN(BIT(9), BIT(9), BIT(3), BIT(24), BIT(29), false),
-	[RK3066_PD_VIDEO]	= DOMAIN(BIT(8), BIT(8), BIT(4), BIT(23), BIT(28), false),
-	[RK3066_PD_VIO]		= DOMAIN(BIT(7), BIT(7), BIT(5), BIT(22), BIT(27), false),
-	[RK3066_PD_PERI]	= DOMAIN(BIT(6), BIT(6), BIT(2), BIT(25), BIT(30), false),
-	[RK3066_PD_CPU]		= DOMAIN(0,      BIT(5), BIT(1), BIT(26), BIT(31), false),
+	[RK3066_PD_GPU]		= DOMAIN("gpu",   BIT(9), BIT(9), BIT(3), BIT(24), BIT(29), false),
+	[RK3066_PD_VIDEO]	= DOMAIN("video", BIT(8), BIT(8), BIT(4), BIT(23), BIT(28), false),
+	[RK3066_PD_VIO]		= DOMAIN("vio",   BIT(7), BIT(7), BIT(5), BIT(22), BIT(27), false),
+	[RK3066_PD_PERI]	= DOMAIN("peri",  BIT(6), BIT(6), BIT(2), BIT(25), BIT(30), false),
+	[RK3066_PD_CPU]		= DOMAIN("cpu",   0,      BIT(5), BIT(1), BIT(26), BIT(31), false),
 };
 
 static const struct rockchip_domain_info rk3128_pm_domains[] = {
-	[RK3128_PD_CORE]	= DOMAIN_RK3288(BIT(0), BIT(0), BIT(4), false),
-	[RK3128_PD_MSCH]	= DOMAIN_RK3288(0,      0,      BIT(6), true),
-	[RK3128_PD_VIO]		= DOMAIN_RK3288(BIT(3), BIT(3), BIT(2), false),
-	[RK3128_PD_VIDEO]	= DOMAIN_RK3288(BIT(2), BIT(2), BIT(1), false),
-	[RK3128_PD_GPU]		= DOMAIN_RK3288(BIT(1), BIT(1), BIT(3), false),
+	[RK3128_PD_CORE]	= DOMAIN_RK3288("core",  BIT(0), BIT(0), BIT(4), false),
+	[RK3128_PD_MSCH]	= DOMAIN_RK3288("msch",  0,      0,      BIT(6), true),
+	[RK3128_PD_VIO]		= DOMAIN_RK3288("vio",   BIT(3), BIT(3), BIT(2), false),
+	[RK3128_PD_VIDEO]	= DOMAIN_RK3288("video", BIT(2), BIT(2), BIT(1), false),
+	[RK3128_PD_GPU]		= DOMAIN_RK3288("gpu",   BIT(1), BIT(1), BIT(3), false),
 };
 
 static const struct rockchip_domain_info rk3188_pm_domains[] = {
-	[RK3188_PD_GPU]		= DOMAIN(BIT(9), BIT(9), BIT(3), BIT(24), BIT(29), false),
-	[RK3188_PD_VIDEO]	= DOMAIN(BIT(8), BIT(8), BIT(4), BIT(23), BIT(28), false),
-	[RK3188_PD_VIO]		= DOMAIN(BIT(7), BIT(7), BIT(5), BIT(22), BIT(27), false),
-	[RK3188_PD_PERI]	= DOMAIN(BIT(6), BIT(6), BIT(2), BIT(25), BIT(30), false),
-	[RK3188_PD_CPU]		= DOMAIN(BIT(5), BIT(5), BIT(1), BIT(26), BIT(31), false),
+	[RK3188_PD_GPU]		= DOMAIN("gpu",   BIT(9), BIT(9), BIT(3), BIT(24), BIT(29), false),
+	[RK3188_PD_VIDEO]	= DOMAIN("video", BIT(8), BIT(8), BIT(4), BIT(23), BIT(28), false),
+	[RK3188_PD_VIO]		= DOMAIN("vio",   BIT(7), BIT(7), BIT(5), BIT(22), BIT(27), false),
+	[RK3188_PD_PERI]	= DOMAIN("peri",  BIT(6), BIT(6), BIT(2), BIT(25), BIT(30), false),
+	[RK3188_PD_CPU]		= DOMAIN("cpu",   BIT(5), BIT(5), BIT(1), BIT(26), BIT(31), false),
 };
 
 static const struct rockchip_domain_info rk3228_pm_domains[] = {
-	[RK3228_PD_CORE]	= DOMAIN_RK3036(BIT(0),  BIT(0),  BIT(16), true),
-	[RK3228_PD_MSCH]	= DOMAIN_RK3036(BIT(1),  BIT(1),  BIT(17), true),
-	[RK3228_PD_BUS]		= DOMAIN_RK3036(BIT(2),  BIT(2),  BIT(18), true),
-	[RK3228_PD_SYS]		= DOMAIN_RK3036(BIT(3),  BIT(3),  BIT(19), true),
-	[RK3228_PD_VIO]		= DOMAIN_RK3036(BIT(4),  BIT(4),  BIT(20), false),
-	[RK3228_PD_VOP]		= DOMAIN_RK3036(BIT(5),  BIT(5),  BIT(21), false),
-	[RK3228_PD_VPU]		= DOMAIN_RK3036(BIT(6),  BIT(6),  BIT(22), false),
-	[RK3228_PD_RKVDEC]	= DOMAIN_RK3036(BIT(7),  BIT(7),  BIT(23), false),
-	[RK3228_PD_GPU]		= DOMAIN_RK3036(BIT(8),  BIT(8),  BIT(24), false),
-	[RK3228_PD_PERI]	= DOMAIN_RK3036(BIT(9),  BIT(9),  BIT(25), true),
-	[RK3228_PD_GMAC]	= DOMAIN_RK3036(BIT(10), BIT(10), BIT(26), false),
+	[RK3228_PD_CORE]	= DOMAIN_RK3036("core", BIT(0),  BIT(0),  BIT(16), true),
+	[RK3228_PD_MSCH]	= DOMAIN_RK3036("msch", BIT(1),  BIT(1),  BIT(17), true),
+	[RK3228_PD_BUS]		= DOMAIN_RK3036("bus",  BIT(2),  BIT(2),  BIT(18), true),
+	[RK3228_PD_SYS]		= DOMAIN_RK3036("sys",  BIT(3),  BIT(3),  BIT(19), true),
+	[RK3228_PD_VIO]		= DOMAIN_RK3036("vio",  BIT(4),  BIT(4),  BIT(20), false),
+	[RK3228_PD_VOP]		= DOMAIN_RK3036("vop",  BIT(5),  BIT(5),  BIT(21), false),
+	[RK3228_PD_VPU]		= DOMAIN_RK3036("vpu",  BIT(6),  BIT(6),  BIT(22), false),
+	[RK3228_PD_RKVDEC]	= DOMAIN_RK3036("vdec", BIT(7),  BIT(7),  BIT(23), false),
+	[RK3228_PD_GPU]		= DOMAIN_RK3036("gpu",  BIT(8),  BIT(8),  BIT(24), false),
+	[RK3228_PD_PERI]	= DOMAIN_RK3036("peri", BIT(9),  BIT(9),  BIT(25), true),
+	[RK3228_PD_GMAC]	= DOMAIN_RK3036("gmac", BIT(10), BIT(10), BIT(26), false),
 };
 
 static const struct rockchip_domain_info rk3288_pm_domains[] = {
-	[RK3288_PD_VIO]		= DOMAIN_RK3288(BIT(7),  BIT(7),  BIT(4), false),
-	[RK3288_PD_HEVC]	= DOMAIN_RK3288(BIT(14), BIT(10), BIT(9), false),
-	[RK3288_PD_VIDEO]	= DOMAIN_RK3288(BIT(8),  BIT(8),  BIT(3), false),
-	[RK3288_PD_GPU]		= DOMAIN_RK3288(BIT(9),  BIT(9),  BIT(2), false),
+	[RK3288_PD_VIO]		= DOMAIN_RK3288("vio",   BIT(7),  BIT(7),  BIT(4), false),
+	[RK3288_PD_HEVC]	= DOMAIN_RK3288("hevc",  BIT(14), BIT(10), BIT(9), false),
+	[RK3288_PD_VIDEO]	= DOMAIN_RK3288("video", BIT(8),  BIT(8),  BIT(3), false),
+	[RK3288_PD_GPU]		= DOMAIN_RK3288("gpu",   BIT(9),  BIT(9),  BIT(2), false),
 };
 
 static const struct rockchip_domain_info rk3328_pm_domains[] = {
-	[RK3328_PD_CORE]	= DOMAIN_RK3328(0, BIT(0), BIT(0), false),
-	[RK3328_PD_GPU]		= DOMAIN_RK3328(0, BIT(1), BIT(1), false),
-	[RK3328_PD_BUS]		= DOMAIN_RK3328(0, BIT(2), BIT(2), true),
-	[RK3328_PD_MSCH]	= DOMAIN_RK3328(0, BIT(3), BIT(3), true),
-	[RK3328_PD_PERI]	= DOMAIN_RK3328(0, BIT(4), BIT(4), true),
-	[RK3328_PD_VIDEO]	= DOMAIN_RK3328(0, BIT(5), BIT(5), false),
-	[RK3328_PD_HEVC]	= DOMAIN_RK3328(0, BIT(6), BIT(6), false),
-	[RK3328_PD_VIO]		= DOMAIN_RK3328(0, BIT(8), BIT(8), false),
-	[RK3328_PD_VPU]		= DOMAIN_RK3328(0, BIT(9), BIT(9), false),
+	[RK3328_PD_CORE]	= DOMAIN_RK3328("core",  0, BIT(0), BIT(0), false),
+	[RK3328_PD_GPU]		= DOMAIN_RK3328("gpu",   0, BIT(1), BIT(1), false),
+	[RK3328_PD_BUS]		= DOMAIN_RK3328("bus",   0, BIT(2), BIT(2), true),
+	[RK3328_PD_MSCH]	= DOMAIN_RK3328("msch",  0, BIT(3), BIT(3), true),
+	[RK3328_PD_PERI]	= DOMAIN_RK3328("peri",  0, BIT(4), BIT(4), true),
+	[RK3328_PD_VIDEO]	= DOMAIN_RK3328("video", 0, BIT(5), BIT(5), false),
+	[RK3328_PD_HEVC]	= DOMAIN_RK3328("hevc",  0, BIT(6), BIT(6), false),
+	[RK3328_PD_VIO]		= DOMAIN_RK3328("vio",   0, BIT(8), BIT(8), false),
+	[RK3328_PD_VPU]		= DOMAIN_RK3328("vpu",   0, BIT(9), BIT(9), false),
 };
 
 static const struct rockchip_domain_info rk3366_pm_domains[] = {
-	[RK3366_PD_PERI]	= DOMAIN_RK3368(BIT(10), BIT(10), BIT(6), true),
-	[RK3366_PD_VIO]		= DOMAIN_RK3368(BIT(14), BIT(14), BIT(8), false),
-	[RK3366_PD_VIDEO]	= DOMAIN_RK3368(BIT(13), BIT(13), BIT(7), false),
-	[RK3366_PD_RKVDEC]	= DOMAIN_RK3368(BIT(11), BIT(11), BIT(7), false),
-	[RK3366_PD_WIFIBT]	= DOMAIN_RK3368(BIT(8),  BIT(8),  BIT(9), false),
-	[RK3366_PD_VPU]		= DOMAIN_RK3368(BIT(12), BIT(12), BIT(7), false),
-	[RK3366_PD_GPU]		= DOMAIN_RK3368(BIT(15), BIT(15), BIT(2), false),
+	[RK3366_PD_PERI]	= DOMAIN_RK3368("peri",   BIT(10), BIT(10), BIT(6), true),
+	[RK3366_PD_VIO]		= DOMAIN_RK3368("vio",    BIT(14), BIT(14), BIT(8), false),
+	[RK3366_PD_VIDEO]	= DOMAIN_RK3368("video",  BIT(13), BIT(13), BIT(7), false),
+	[RK3366_PD_RKVDEC]	= DOMAIN_RK3368("vdec",   BIT(11), BIT(11), BIT(7), false),
+	[RK3366_PD_WIFIBT]	= DOMAIN_RK3368("wifibt", BIT(8),  BIT(8),  BIT(9), false),
+	[RK3366_PD_VPU]		= DOMAIN_RK3368("vpu",    BIT(12), BIT(12), BIT(7), false),
+	[RK3366_PD_GPU]		= DOMAIN_RK3368("gpu",    BIT(15), BIT(15), BIT(2), false),
 };
 
 static const struct rockchip_domain_info rk3368_pm_domains[] = {
-	[RK3368_PD_PERI]	= DOMAIN_RK3368(BIT(13), BIT(12), BIT(6), true),
-	[RK3368_PD_VIO]		= DOMAIN_RK3368(BIT(15), BIT(14), BIT(8), false),
-	[RK3368_PD_VIDEO]	= DOMAIN_RK3368(BIT(14), BIT(13), BIT(7), false),
-	[RK3368_PD_GPU_0]	= DOMAIN_RK3368(BIT(16), BIT(15), BIT(2), false),
-	[RK3368_PD_GPU_1]	= DOMAIN_RK3368(BIT(17), BIT(16), BIT(2), false),
+	[RK3368_PD_PERI]	= DOMAIN_RK3368("peri",  BIT(13), BIT(12), BIT(6), true),
+	[RK3368_PD_VIO]		= DOMAIN_RK3368("vio",   BIT(15), BIT(14), BIT(8), false),
+	[RK3368_PD_VIDEO]	= DOMAIN_RK3368("video", BIT(14), BIT(13), BIT(7), false),
+	[RK3368_PD_GPU_0]	= DOMAIN_RK3368("gpu_0", BIT(16), BIT(15), BIT(2), false),
+	[RK3368_PD_GPU_1]	= DOMAIN_RK3368("gpu_1", BIT(17), BIT(16), BIT(2), false),
 };
 
 static const struct rockchip_domain_info rk3399_pm_domains[] = {
-	[RK3399_PD_TCPD0]	= DOMAIN_RK3399(BIT(8),  BIT(8),  0,	   false),
-	[RK3399_PD_TCPD1]	= DOMAIN_RK3399(BIT(9),  BIT(9),  0,	   false),
-	[RK3399_PD_CCI]		= DOMAIN_RK3399(BIT(10), BIT(10), 0,	   true),
-	[RK3399_PD_CCI0]	= DOMAIN_RK3399(0,	 0,	  BIT(15), true),
-	[RK3399_PD_CCI1]	= DOMAIN_RK3399(0,	 0,	  BIT(16), true),
-	[RK3399_PD_PERILP]	= DOMAIN_RK3399(BIT(11), BIT(11), BIT(1),  true),
-	[RK3399_PD_PERIHP]	= DOMAIN_RK3399(BIT(12), BIT(12), BIT(2),  true),
-	[RK3399_PD_CENTER]	= DOMAIN_RK3399(BIT(13), BIT(13), BIT(14), true),
-	[RK3399_PD_VIO]		= DOMAIN_RK3399(BIT(14), BIT(14), BIT(17), false),
-	[RK3399_PD_GPU]		= DOMAIN_RK3399(BIT(15), BIT(15), BIT(0),  false),
-	[RK3399_PD_VCODEC]	= DOMAIN_RK3399(BIT(16), BIT(16), BIT(3),  false),
-	[RK3399_PD_VDU]		= DOMAIN_RK3399(BIT(17), BIT(17), BIT(4),  false),
-	[RK3399_PD_RGA]		= DOMAIN_RK3399(BIT(18), BIT(18), BIT(5),  false),
-	[RK3399_PD_IEP]		= DOMAIN_RK3399(BIT(19), BIT(19), BIT(6),  false),
-	[RK3399_PD_VO]		= DOMAIN_RK3399(BIT(20), BIT(20), 0,	   false),
-	[RK3399_PD_VOPB]	= DOMAIN_RK3399(0,	 0,	  BIT(7),  false),
-	[RK3399_PD_VOPL]	= DOMAIN_RK3399(0, 	 0,	  BIT(8),  false),
-	[RK3399_PD_ISP0]	= DOMAIN_RK3399(BIT(22), BIT(22), BIT(9),  false),
-	[RK3399_PD_ISP1]	= DOMAIN_RK3399(BIT(23), BIT(23), BIT(10), false),
-	[RK3399_PD_HDCP]	= DOMAIN_RK3399(BIT(24), BIT(24), BIT(11), false),
-	[RK3399_PD_GMAC]	= DOMAIN_RK3399(BIT(25), BIT(25), BIT(23), true),
-	[RK3399_PD_EMMC]	= DOMAIN_RK3399(BIT(26), BIT(26), BIT(24), true),
-	[RK3399_PD_USB3]	= DOMAIN_RK3399(BIT(27), BIT(27), BIT(12), true),
-	[RK3399_PD_EDP]		= DOMAIN_RK3399(BIT(28), BIT(28), BIT(22), false),
-	[RK3399_PD_GIC]		= DOMAIN_RK3399(BIT(29), BIT(29), BIT(27), true),
-	[RK3399_PD_SD]		= DOMAIN_RK3399(BIT(30), BIT(30), BIT(28), true),
-	[RK3399_PD_SDIOAUDIO]	= DOMAIN_RK3399(BIT(31), BIT(31), BIT(29), true),
+	[RK3399_PD_TCPD0]	= DOMAIN_RK3399("tcpd0",     BIT(8),  BIT(8),  0,       false),
+	[RK3399_PD_TCPD1]	= DOMAIN_RK3399("tcpd1",     BIT(9),  BIT(9),  0,       false),
+	[RK3399_PD_CCI]		= DOMAIN_RK3399("cci",       BIT(10), BIT(10), 0,       true),
+	[RK3399_PD_CCI0]	= DOMAIN_RK3399("cci0",      0,       0,       BIT(15), true),
+	[RK3399_PD_CCI1]	= DOMAIN_RK3399("cci1",      0,       0,       BIT(16), true),
+	[RK3399_PD_PERILP]	= DOMAIN_RK3399("perilp",    BIT(11), BIT(11), BIT(1),  true),
+	[RK3399_PD_PERIHP]	= DOMAIN_RK3399("perihp",    BIT(12), BIT(12), BIT(2),  true),
+	[RK3399_PD_CENTER]	= DOMAIN_RK3399("center",    BIT(13), BIT(13), BIT(14), true),
+	[RK3399_PD_VIO]		= DOMAIN_RK3399("vio",       BIT(14), BIT(14), BIT(17), false),
+	[RK3399_PD_GPU]		= DOMAIN_RK3399("gpu",       BIT(15), BIT(15), BIT(0),  false),
+	[RK3399_PD_VCODEC]	= DOMAIN_RK3399("vcodec",    BIT(16), BIT(16), BIT(3),  false),
+	[RK3399_PD_VDU]		= DOMAIN_RK3399("vdu",       BIT(17), BIT(17), BIT(4),  false),
+	[RK3399_PD_RGA]		= DOMAIN_RK3399("rga",       BIT(18), BIT(18), BIT(5),  false),
+	[RK3399_PD_IEP]		= DOMAIN_RK3399("iep",       BIT(19), BIT(19), BIT(6),  false),
+	[RK3399_PD_VO]		= DOMAIN_RK3399("vo",        BIT(20), BIT(20), 0,       false),
+	[RK3399_PD_VOPB]	= DOMAIN_RK3399("vopb",      0,       0,       BIT(7),  false),
+	[RK3399_PD_VOPL]	= DOMAIN_RK3399("vopl",      0,       0,       BIT(8),  false),
+	[RK3399_PD_ISP0]	= DOMAIN_RK3399("isp0",      BIT(22), BIT(22), BIT(9),  false),
+	[RK3399_PD_ISP1]	= DOMAIN_RK3399("isp1",      BIT(23), BIT(23), BIT(10), false),
+	[RK3399_PD_HDCP]	= DOMAIN_RK3399("hdcp",      BIT(24), BIT(24), BIT(11), false),
+	[RK3399_PD_GMAC]	= DOMAIN_RK3399("gmac",      BIT(25), BIT(25), BIT(23), true),
+	[RK3399_PD_EMMC]	= DOMAIN_RK3399("emmc",      BIT(26), BIT(26), BIT(24), true),
+	[RK3399_PD_USB3]	= DOMAIN_RK3399("usb3",      BIT(27), BIT(27), BIT(12), true),
+	[RK3399_PD_EDP]		= DOMAIN_RK3399("edp",       BIT(28), BIT(28), BIT(22), false),
+	[RK3399_PD_GIC]		= DOMAIN_RK3399("gic",       BIT(29), BIT(29), BIT(27), true),
+	[RK3399_PD_SD]		= DOMAIN_RK3399("sd",        BIT(30), BIT(30), BIT(28), true),
+	[RK3399_PD_SDIOAUDIO]	= DOMAIN_RK3399("sdioaudio", BIT(31), BIT(31), BIT(29), true),
 };
 
 static const struct rockchip_pmu_info px30_pmu = {
-- 
2.11.0

