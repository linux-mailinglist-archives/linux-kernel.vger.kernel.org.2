Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2279341F2DD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 19:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbhJARSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 13:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355094AbhJARS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 13:18:27 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6533C06177F;
        Fri,  1 Oct 2021 10:16:42 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id dj4so38252930edb.5;
        Fri, 01 Oct 2021 10:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P8JQmOMEQkuJFUGXTus7HXI4JS/hSQsOjYtjeCOR59I=;
        b=AeIPoGpipBKrV3Os8gXxW3N5pLD0YHZMyUnxmNMMQ/TXc9qh1arbLTGhZvb2ke1xhz
         dLjxXR+HPcf0c4qw4htzsihot1nHsK2ub6OYRudBB06tNgKIj42E/XsnK0TaCLCK2FaU
         cF508NqVQWlFxRhB+OSWCU1Td4r7V3N5sfPFJxU+6NMTJ89p4wNC4ZfEPxkMb3RanA+H
         /cRKXwDsecF1SwLMGDIS7i+iDqIgdThPA1WYCrNjo0nEuOG55zDhtd8WU9cyak7y1Edx
         AKhEgTILgq60NSgG/6vI41zWOfW9ZTBcknigRj89dEwvMUJCRSNe0dl5edOhNH2jYVqU
         8tIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P8JQmOMEQkuJFUGXTus7HXI4JS/hSQsOjYtjeCOR59I=;
        b=J1Ce6w9jmBJZwrriRaWy60Dlb9OOKGYIxy43pQBwssp78hvqeZnydSkA/6/FSbs6Uk
         XtHmAYYsY0ewoYXhaV31XlbqpzJyIz5vYPd4BaZbpFuvqFg6vlwNZt2RzZYejHCHJm22
         gRrY2bRGRDbli566qMSh/c7/yifCaHJ3aQpUz1a9F1LamKTHqfqIl+lCnsjo+ushApg5
         Y2Y+fQW2ZNJxI1ZPrroTA/JWWzU87Prd0Gyb4dFo/20GzTVJj7HeNvxc+vxTLStjIGnW
         PoNPn/uM5fwSQJmLT3Qg7rM2ADCoaJnouqVxmdlF6llGJv//CyosfmYdqjOq+8ise49X
         Jqfw==
X-Gm-Message-State: AOAM531SsFZZY3ZVIeIVrQyi4mXcACkm9eOkgIXGkeR8U3rdvHHZSv+h
        DUaakR7FKZkGtIyJqzHo29M=
X-Google-Smtp-Source: ABdhPJz8bQw92xN8uAjG9YKIx+zsvFJ7MPKLOLMena/e+MWNKk0dCETamyCu1Vne5gkQFkXdq359ig==
X-Received: by 2002:a17:906:f6cf:: with SMTP id jo15mr7666504ejb.244.1633108601301;
        Fri, 01 Oct 2021 10:16:41 -0700 (PDT)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id h10sm3588130edf.85.2021.10.01.10.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 10:16:41 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 4/4] arm64: dts: rockchip: add analog audio on Quartz64
Date:   Fri,  1 Oct 2021 19:15:31 +0200
Message-Id: <20211001171531.178775-5-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211001171531.178775-1-frattaroli.nicolas@gmail.com>
References: <20211001171531.178775-1-frattaroli.nicolas@gmail.com>
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
 .../boot/dts/rockchip/rk3566-quartz64-a.dts   | 31 ++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
index a244f7b87e38..f1261f25cb35 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
@@ -58,6 +58,20 @@ led-diy {
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
@@ -199,8 +213,13 @@ rk817: pmic@20 {
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
@@ -392,6 +411,16 @@ regulator-state-mem {
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

