Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 630744465CE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 16:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbhKEPd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 11:33:28 -0400
Received: from mx1.tq-group.com ([93.104.207.81]:1241 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233555AbhKEPdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 11:33:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1636126239; x=1667662239;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=smjkwLa0iULnX/yQS3CbKRH8HUH+rdoQF0nLd0zpmtg=;
  b=DEo93tTieq/LBxBuZWxlLr01pDsyGwy5ERddQrgiYh/8SLuJbUi7HRaP
   Pj1m23lO1nC4H/ifPJhPUWaBd+rgL9Y32goSzeXBiCqGLDEZOqUeLiv9Y
   tmXkZc0vTUhV3tuM0AWKKCZbXLRvApa7NubJMwCgRN67paMXQYTFLZxw7
   BNfLw3urDNo+RJMOW5TdK5kHuZ34v8KxI5zARPkbJi1eIHes8R6K8Gt4/
   Br28NmQOz3S6LfB8ZTfPgPulfQkdWJqRcWSTus5ckEXh8VaYZMb4U3jYU
   TcpxRq1TWWWFeL//CAJzCke00WyKfdhVxl9wVT8AZRHXwSXMuc6xzoyil
   Q==;
X-IronPort-AV: E=Sophos;i="5.87,212,1631570400"; 
   d="scan'208";a="20358802"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 05 Nov 2021 16:30:34 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 05 Nov 2021 16:30:34 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 05 Nov 2021 16:30:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1636126234; x=1667662234;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=smjkwLa0iULnX/yQS3CbKRH8HUH+rdoQF0nLd0zpmtg=;
  b=D+YK3o/SyC8tZXNWF+s5dM+IBCIh4H1DJCSkCnD4Vexrlo8ardbxOdqv
   FXm6luOsHbtAQ5YR2w1ZoNHgRUohze/Rk6isvfREKzpYwlBiqqJ2qqAke
   gTNPWDMY/5vQQPqLKLvTioI15mIa8R0BQJK+Sa8zOBuTxaZJESFSv2erJ
   wdydNStCLZivoQ0vrQnhqZnsBzrncvNFv6WQw9fgvm+M1lhRXrq9Q87vi
   s0+J/JJzP8/vhUnXO0nFseWYwE3vH+vuajyY7FkSxZrOwwRjzXTci6Wt1
   uWU1hlDosEeSh/ekfNaSaI2/cm+YQekqWb1c6BoCj7/90vMxzxyYp6dSZ
   A==;
X-IronPort-AV: E=Sophos;i="5.87,212,1631570400"; 
   d="scan'208";a="20358801"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 05 Nov 2021 16:30:34 +0100
Received: from steina-w.tq-net.de (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 6B7CE280075;
        Fri,  5 Nov 2021 16:30:34 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 3/7] arm64: defconfig: enable drivers for TQ TQMa8MxML-MBa8Mx
Date:   Fri,  5 Nov 2021 16:30:21 +0100
Message-Id: <20211105153025.187106-4-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211105153025.187106-1-alexander.stein@ew.tq-group.com>
References: <20211105153025.187106-1-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the device tree in place, enable missing drivers as modules, if
possible. PHY driver needs built-in for interrupt support.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
Changes in v2:
* Add interconnect driver for imx8mm and imx8mn

 arch/arm64/configs/defconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index f2e2b9bdd702..d8d4b13040f3 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -363,6 +363,7 @@ CONFIG_MICROSEMI_PHY=y
 CONFIG_AT803X_PHY=y
 CONFIG_REALTEK_PHY=y
 CONFIG_ROCKCHIP_PHY=y
+CONFIG_DP83867_PHY=y
 CONFIG_VITESSE_PHY=y
 CONFIG_USB_PEGASUS=m
 CONFIG_USB_RTL8150=m
@@ -397,6 +398,7 @@ CONFIG_TOUCHSCREEN_EDT_FT5X06=m
 CONFIG_INPUT_MISC=y
 CONFIG_INPUT_PM8941_PWRKEY=y
 CONFIG_INPUT_PM8XXX_VIBRATOR=m
+CONFIG_INPUT_PWM_BEEPER=m
 CONFIG_INPUT_PWM_VIBRA=m
 CONFIG_INPUT_HISI_POWERKEY=y
 # CONFIG_SERIO_SERPORT is not set
@@ -555,6 +557,7 @@ CONFIG_BATTERY_MAX17042=m
 CONFIG_CHARGER_BQ25890=m
 CONFIG_CHARGER_BQ25980=m
 CONFIG_SENSORS_ARM_SCPI=y
+CONFIG_SENSORS_JC42=m
 CONFIG_SENSORS_LM90=m
 CONFIG_SENSORS_PWM_FAN=m
 CONFIG_SENSORS_RASPBERRYPI_HWMON=m
@@ -792,6 +795,7 @@ CONFIG_SND_SOC_RT5659=m
 CONFIG_SND_SOC_SIMPLE_AMPLIFIER=m
 CONFIG_SND_SOC_SIMPLE_MUX=m
 CONFIG_SND_SOC_TAS571X=m
+CONFIG_SND_SOC_TLV320AIC32X4_I2C=m
 CONFIG_SND_SOC_WCD934X=m
 CONFIG_SND_SOC_WM8904=m
 CONFIG_SND_SOC_WM8960=m
@@ -907,6 +911,7 @@ CONFIG_RTC_DRV_DS1307=m
 CONFIG_RTC_DRV_HYM8563=m
 CONFIG_RTC_DRV_MAX77686=y
 CONFIG_RTC_DRV_RK808=m
+CONFIG_RTC_DRV_PCF85063=m
 CONFIG_RTC_DRV_PCF85363=m
 CONFIG_RTC_DRV_M41T80=m
 CONFIG_RTC_DRV_RX8581=m
@@ -1174,6 +1179,8 @@ CONFIG_SLIM_QCOM_NGD_CTRL=m
 CONFIG_MUX_MMIO=y
 CONFIG_INTERCONNECT=y
 CONFIG_INTERCONNECT_IMX=m
+CONFIG_INTERCONNECT_IMX8MM=m
+CONFIG_INTERCONNECT_IMX8MN=m
 CONFIG_INTERCONNECT_IMX8MQ=m
 CONFIG_INTERCONNECT_QCOM=y
 CONFIG_INTERCONNECT_QCOM_MSM8916=m
-- 
2.25.1

