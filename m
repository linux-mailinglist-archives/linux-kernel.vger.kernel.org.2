Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B096C313319
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 14:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbhBHNRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 08:17:24 -0500
Received: from comms.puri.sm ([159.203.221.185]:42184 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230029AbhBHNQs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 08:16:48 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 2F1FDE0133;
        Mon,  8 Feb 2021 05:16:06 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id wAmX5A_nFngy; Mon,  8 Feb 2021 05:16:05 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     robh@kernel.org, shawnguo@kernel.org, kernel@pengutronix.de,
        festevam@gmail.com
Cc:     kernel@puri.sm, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH 3/5] arm64: defconfig: Enable devfreq support for i.MX8MQ
Date:   Mon,  8 Feb 2021 14:15:25 +0100
Message-Id: <20210208131527.24463-4-martin.kepplinger@puri.sm>
In-Reply-To: <20210208131527.24463-1-martin.kepplinger@puri.sm>
References: <20210208131527.24463-1-martin.kepplinger@puri.sm>
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
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 5348c0be2fcf..ceeb1c1c10ea 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1019,6 +1019,8 @@ CONFIG_ARCH_TEGRA_186_SOC=y
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

