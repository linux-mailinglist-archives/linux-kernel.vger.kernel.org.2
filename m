Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EAA3423EA8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 15:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238712AbhJFNZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 09:25:21 -0400
Received: from mx1.tq-group.com ([93.104.207.81]:35555 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238664AbhJFNZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 09:25:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1633526602; x=1665062602;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X0Gv8u97w3HlkICcywbc27DpmsZK6gePDEWsVi2WA5U=;
  b=JmmAaWoc9yqa7jtO1ry9cIzuI6xhteBC7HXXVTbFxSdw7UwuCSl+UbHl
   nadPFtW+fy0euIx/OOH+xaa1cibIspRzHxvZuJGHFaSdFB1DBuhxsWMvo
   /MGnuYmhLjfFZeYV0hPeBYpZBKMKApoliyu61OPMA6QxM3kkwyP6tEczK
   pFkwnWgUSQjqqSds8X5bOYOwrd4Bkf7yK/d7sZKVI8o9DRDOnVBDF9gin
   vMi4wyF4JxICR4K8UGJ+PjVF11gZyljgEKOZdIz/ts4FsmzAguZFfCgqt
   kqnNv0AwMBoG8q9RtF5c/DJMV0O8B2rayc/Ma11uyr67xKjogyfHOCTS+
   w==;
X-IronPort-AV: E=Sophos;i="5.85,350,1624312800"; 
   d="scan'208";a="19897924"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 06 Oct 2021 15:23:19 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 06 Oct 2021 15:23:19 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 06 Oct 2021 15:23:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1633526599; x=1665062599;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X0Gv8u97w3HlkICcywbc27DpmsZK6gePDEWsVi2WA5U=;
  b=YO2PQ4qT9kbPihvyXDUtYn1omWYhDKVMP5HQFzxDqME1d+p4bl5nq59+
   w51QmjAF3YfwwHHgMkwBuAXeGUk78tvFg02/FZzI4Oy2O5LFwh0PDegaC
   E97DIVPcWTD5jYzTsB+8VRbxRxxnygvvM0SXKQUkrJr16t61cMYljlIYk
   ZTLrL3aE+FrgGRnX+q0vq0TijrsNjCcd5XfvTk5VGHYCGY8ELvMdgMXda
   AESBMN/MVg0BINDqQ4EOHJIQXHC4Qdy+6Z1g7WFVM2HcrLXzzzW4JxsqB
   F84SgrFnQa04tfK4P0/877r4+1sNJmDZAM3Kjq5c42+Ba0IIHY/QFExrX
   w==;
X-IronPort-AV: E=Sophos;i="5.85,350,1624312800"; 
   d="scan'208";a="19897923"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 06 Oct 2021 15:23:19 +0200
Received: from steina-w.tq-net.de (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 85A85280065;
        Wed,  6 Oct 2021 15:23:19 +0200 (CEST)
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
Subject: [PATCH 3/7] arm64: defconfig: enable drivers for TQ TQMa8MxML-MBa8Mx
Date:   Wed,  6 Oct 2021 15:23:05 +0200
Message-Id: <20211006132309.1239708-4-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211006132309.1239708-1-alexander.stein@ew.tq-group.com>
References: <20211006132309.1239708-1-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the device tree in place, enable missing drivers as modules, if
possible. PHY driver needs built-in for interrupt support.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm64/configs/defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 156d96afbbfc..2e5de4456725 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -366,6 +366,7 @@ CONFIG_MICROSEMI_PHY=y
 CONFIG_AT803X_PHY=y
 CONFIG_REALTEK_PHY=y
 CONFIG_ROCKCHIP_PHY=y
+CONFIG_DP83867_PHY=y
 CONFIG_VITESSE_PHY=y
 CONFIG_USB_PEGASUS=m
 CONFIG_USB_RTL8150=m
@@ -399,6 +400,7 @@ CONFIG_TOUCHSCREEN_EDT_FT5X06=m
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
@@ -784,6 +787,7 @@ CONFIG_SND_SOC_RT5659=m
 CONFIG_SND_SOC_SIMPLE_AMPLIFIER=m
 CONFIG_SND_SOC_SIMPLE_MUX=m
 CONFIG_SND_SOC_TAS571X=m
+CONFIG_SND_SOC_TLV320AIC32X4_I2C=m
 CONFIG_SND_SOC_WCD934X=m
 CONFIG_SND_SOC_WM8904=m
 CONFIG_SND_SOC_WM8960=m
@@ -898,6 +902,7 @@ CONFIG_RTC_DRV_DS1307=m
 CONFIG_RTC_DRV_HYM8563=m
 CONFIG_RTC_DRV_MAX77686=y
 CONFIG_RTC_DRV_RK808=m
+CONFIG_RTC_DRV_PCF85063=m
 CONFIG_RTC_DRV_PCF85363=m
 CONFIG_RTC_DRV_M41T80=m
 CONFIG_RTC_DRV_RX8581=m
-- 
2.25.1

