Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 274A031D81B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 12:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbhBQLV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 06:21:56 -0500
Received: from comms.puri.sm ([159.203.221.185]:34038 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230467AbhBQLVT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 06:21:19 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id E5197E1315;
        Wed, 17 Feb 2021 03:20:08 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id pQeyA9pUI_dx; Wed, 17 Feb 2021 03:20:08 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     robh@kernel.org, shawnguo@kernel.org, festevam@gmail.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, krzk@kernel.org,
        kernel@puri.sm, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v2 3/5] arm64: defconfig: Enable devfreq support for i.MX8MQ
Date:   Wed, 17 Feb 2021 12:19:42 +0100
Message-Id: <20210217111944.1416-4-martin.kepplinger@puri.sm>
In-Reply-To: <20210217111944.1416-1-martin.kepplinger@puri.sm>
References: <20210217111944.1416-1-martin.kepplinger@puri.sm>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guido Günther <agx@sigxcpu.org>

This is needed to make DRAM frequency scaling via devfreq as used
on the Librem 5 and Librem 5 Devkit.

With the interconnect support enabled we now need imx devfreq on top
to make this work.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index d612f633b771..e9f3e47933d5 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1022,6 +1022,8 @@ CONFIG_ARCH_TEGRA_186_SOC=y
 CONFIG_ARCH_TEGRA_194_SOC=y
 CONFIG_ARCH_TEGRA_234_SOC=y
 CONFIG_TI_SCI_PM_DOMAINS=y
+CONFIG_ARM_IMX_BUS_DEVFREQ=m
+CONFIG_ARM_IMX8M_DDRC_DEVFREQ=m
 CONFIG_EXTCON_PTN5150=m
 CONFIG_EXTCON_USB_GPIO=y
 CONFIG_EXTCON_USBC_CROS_EC=y
-- 
2.20.1

