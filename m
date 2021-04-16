Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0919F361B73
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 10:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240258AbhDPIJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 04:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240296AbhDPIJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 04:09:16 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A568C061574;
        Fri, 16 Apr 2021 01:08:51 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id g5so34140028ejx.0;
        Fri, 16 Apr 2021 01:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/8ue3C3/vuHzsBzvGcphBwhbaDZVSjtTH0PvrnAwtIQ=;
        b=GJxNTmKCDg7Z923XplEfpvDRQSeRcE3jGB9BGTMk3H0R3ozQa6JIQtaSbC52d/VxFp
         5p6V9SyCrg4w0utuHtDRsUOn5I4VXrGPrrvNuzeLA3t+yj0obMMQ11aiJNWy7Lmt+QF2
         9Y0lHdolqDF4Zag/DBme2LJUnzxTJHLxkVRBP9u1bW23vss9A0dQi3eXoxtlyqE2g2rv
         Qid55Sf9EgMsDCM+8u8MBwrs0AUnha4EXZmkKbYUmeg2ICWHA46bx204EPqR2By0v/z8
         Yuhg5ZDbTeOCfod+hsG2Akt0lai3XFpAQPW1HY7ayIJApJ49mZUnXL3ua5fQMGM9f6Dj
         hOuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/8ue3C3/vuHzsBzvGcphBwhbaDZVSjtTH0PvrnAwtIQ=;
        b=ey7RQSHcilPfebUY1MiXlxxpzOS6dsf7M+1dPa67AJyxYz+AKoWSexfePpiUGQK0Jf
         MQDoZymZr/bYMpy5zvMrzqsLnASHKBV+fQjoSOLxOTfFhc0X4fQLsN7bD/P+TA+a3bQr
         FZV7LWVHisC8gdQTTWLEdkJ+5oa0AdQ8F9Fm0fyMJA16qWFkDCwqetTw9wJ7jsSYmn7l
         m9guQTYRIles8BcAnUpQ0vjr8fQEwq4m06bJmOOL74uougHTo071VNU/ffLQ1FMc2vNd
         38bSpy3vzieTByTZ4gJ5D2nYiLxE6JPitwaNQTsPlUTz5RGEGCdlNOh9lBN1wzMGxzkS
         MaQA==
X-Gm-Message-State: AOAM531t1J8BynGhYdBaTx8QX6z5t1hxtF+6A7yGzd2U/xQub7bfmOt+
        O6/wQ387YXTHxBSgWlrZ/mTwwnRyG2SF4xE/
X-Google-Smtp-Source: ABdhPJyV8avaJPgdMYyt8BtM3A2JV07Z/b7leScFYvGuVQMMxg1M5anegufoGAcJA1pXwugB//SGOQ==
X-Received: by 2002:a17:907:76c5:: with SMTP id kf5mr7033982ejc.526.1618560530253;
        Fri, 16 Apr 2021 01:08:50 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id q16sm4672303edv.61.2021.04.16.01.08.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Apr 2021 01:08:50 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, zhangqing@rock-chips.com,
        enric.balletbo@collabora.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 15/15] soc: rockchip: power-domain: add rk3568 powerdomains
Date:   Fri, 16 Apr 2021 10:03:42 +0200
Message-Id: <20210416080342.18614-16-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210416080342.18614-1-jbx6244@gmail.com>
References: <20210416080342.18614-1-jbx6244@gmail.com>
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

