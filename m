Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96CB23FA62C
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 16:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234451AbhH1ODf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 10:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234436AbhH1ODe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 10:03:34 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8903CC0613D9;
        Sat, 28 Aug 2021 07:02:43 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id mf2so20302877ejb.9;
        Sat, 28 Aug 2021 07:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0ynkhuMfoq8DWmPzT9LpIH9te0RlyWltDsyURvZ4GFQ=;
        b=WXYsOBvNLvecil2uBWEWlJk7vK1PIV6a6v7sMtXpoaBBntJcsywk3oE3VCbRiV5TOF
         yj4BDYuZOHQUsCIRfXfCBKDfvyKe1PqTsGJtiaFOZvpaavjsKk/lCPCkhJCUiCh3KdzF
         wWwOxVM4pvzuhcTaqXxnCARr/7n/K0ZC+ZiGZyNapRC2FYT/0/lI4d9Ds2VVV5lJAKyE
         wjDCHjARZXw52quChOv0luNIYx7BgD0tGNCh3wqxo9zxAyqHVwJ5koLvYItKo3fjHjvW
         v6EXZNUyUQHpio7bN99lbzjpfyUyURksUirpAh2IZLTY+RCYQEIH1nAxnXAgEPgRimFH
         DYTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0ynkhuMfoq8DWmPzT9LpIH9te0RlyWltDsyURvZ4GFQ=;
        b=PDd7fxB5JdkMmjnOBEmzvuqqFGL1JOu4veJZDdxwrYKIme20Zs1NV7Ywyk0A2VgNh5
         mGHDRcoWOV/KYbAamM2RIqmIdCa9nuvoRD4S7wU0HwWWJDM7rj3nCgbWE40W/oV+K2qv
         ZenYb/ehGvMnuEmkIUrIAM3ZqfjQfYEuJAEUO10GpRCDZ3fdiOWUEywe+siAmmKLtASf
         rYHqC8vvN6+G9eeR7DPeTVrbrSRnKzaG1/UaV+VcWEt6lr8Wpm3IQjU975Nec78B71QT
         JYx6Mls1/q2xNuHRMwaRCIXPR4L/MmWWZM1YB5hfhqfQob+kRmYKf2Kvk0+GcL5PNZWw
         8YLg==
X-Gm-Message-State: AOAM5319HUqCAyWmm/c6vDxF6ss2FCZsy3nNvyxxicJ9PFr5ksgvJxVi
        EnPhhVZfe+GC2ckSLZmeook=
X-Google-Smtp-Source: ABdhPJz9dW2L7uBwqDxr1u6iX12tYpKwwjG4sNxBoGqA//OYMDo3NzxVkobfVlc+80Ecfmm2cTWkmw==
X-Received: by 2002:a17:907:92c:: with SMTP id au12mr15634084ejc.523.1630159362125;
        Sat, 28 Aug 2021 07:02:42 -0700 (PDT)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id cn16sm4953982edb.87.2021.08.28.07.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Aug 2021 07:02:41 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] arm64: dts: rockchip: add analog audio on Quartz64
Date:   Sat, 28 Aug 2021 16:02:04 +0200
Message-Id: <20210828140205.21973-5-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210828140205.21973-1-frattaroli.nicolas@gmail.com>
References: <20210828140205.21973-1-frattaroli.nicolas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the Quartz64 Model A, the I2S1 TDM controller is connected
to the rk817 codec in I2S mode. Enabling it and adding the
necessary simple-sound-card and codec nodes allows for analog
audio output on the PINE64 Quartz64 Model A SBC.

Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
---
 .../boot/dts/rockchip/rk3566-quartz64-a.dts   | 35 ++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
index b239f314b38a..c974b0e22ac0 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
@@ -50,6 +50,20 @@ led-diy {
 		};
 	};
 
+	rk817-sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,name = "Analog RK817";
+		simple-audio-card,mclk-fs = <256>;
+
+		simple-audio-card,cpu {
+			sound-dai = <&i2s1_8ch>;
+		};
+		simple-audio-card,codec {
+			sound-dai = <&rk817>;
+		};
+	};
+
 	vcc12v_dcin: vcc12v_dcin {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc12v_dcin";
@@ -174,8 +188,13 @@ rk817: pmic@20 {
 		interrupts = <RK_PA3 IRQ_TYPE_LEVEL_LOW>;
 		clock-output-names = "rk808-clkout1", "rk808-clkout2";
 
+		#sound-dai-cells = <0>;
+		clock-names = "mclk";
+		clocks = <&cru I2S1_MCLKOUT_TX>;
+		assigned-clocks = <&cru I2S1_MCLKOUT_TX>;
+		assigned-clock-parents = <&cru CLK_I2S1_8CH_TX>;
 		pinctrl-names = "default";
-		pinctrl-0 = <&pmic_int_l>;
+		pinctrl-0 = <&pmic_int_l>, <&i2s1m0_mclk>;
 		rockchip,system-power-controller;
 		wakeup-source;
 		#clock-cells = <1>;
@@ -364,9 +383,23 @@ regulator-state-mem {
 				};
 			};
 		};
+
+		rk817_codec: codec {
+		};
+
 	};
 };
 
+&i2s1_8ch {
+	status = "okay";
+	rockchip,trcm-sync-tx-only;
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2s1m0_sclktx
+		     &i2s1m0_lrcktx
+		     &i2s1m0_sdi0
+		     &i2s1m0_sdo0>;
+};
+
 &mdio1 {
 	rgmii_phy1: ethernet-phy@0 {
 		compatible = "ethernet-phy-ieee802.3-c22";
-- 
2.33.0

