Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75A043AAA87
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 06:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbhFQEwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 00:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbhFQEwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 00:52:09 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1887AC061574;
        Wed, 16 Jun 2021 21:50:02 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id e22so1496971wrc.1;
        Wed, 16 Jun 2021 21:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G8xBS3pgbjn1u0NzXrJPbnHQ5MKIiawbeczldYN/4uY=;
        b=gRZDlpwJC98qkdPgrOJkADH6IP23iv9SrTRmpkw2AkJwJ+KoAtVQFY5MmhSCAgzXAP
         CQz3L5elU7d+jI1qjhW5wSKAeqqhaKHpG5zGPQYTJsPxU+uyYo8xdEWOD3FyBVrz6U4T
         t9kdWVXw9nJkuoavkjqU2+EaWpZ15IsQXvOuIGJAjqyXo3CIA+iBOegeI61ukmYECbBA
         VUW32LtiG9zLQrTt3ks8Fa4r3tiOjyYN9J63rQSGwNvTPLBf3nLnPijM1+6SkPYs3BVv
         vw1c8ANYTHxRNeSFxUpKblCz+MmmUnte44HQ4js1hQ8cAY7Qu9JEN0KWpf2qg60dvjy4
         vMDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G8xBS3pgbjn1u0NzXrJPbnHQ5MKIiawbeczldYN/4uY=;
        b=K2GEvE5ukp11trGPmK8CjDvCvWLiFGm/JvJF7CFIbYZ01cXDSBKfbUgLK2hZkc8jCO
         XmpJXCE4f7bkdOC+0ki0qHm6fimnw3MT0/VIQTj4G2G+iifcmOAHa18S5+2HERlY0I3+
         HSRlgy1S7xTLt+c81/ioSgBydgxy6Tptcn54jxIeb3sZ+8+x6jdYaNtYzM+BEktpwVmN
         KryTJy40zTTp/Cwa2SFcRqr71ACB0PeQBJwfT6WkfYgUPq1ac49tX/aaFUge5f4L5YRL
         Hqr89wZbz0xc4EPsySzByW/9pKq085PcfKVkGNKMHxsN8UKXo2f7njJU6rO1CP5LDCUF
         GqWQ==
X-Gm-Message-State: AOAM533MtpfQBlZ7WvDwJssoWew4KrKbEzuTDRMXj7twYpMMvJQdk6pM
        8nPpFf04qN2bT6wtC+YBew==
X-Google-Smtp-Source: ABdhPJx88fGa0319NJTKdbmepy1yUaY/3BNtC2Mjf2cyEjMmkgRDpZVAMMnOMoXSvFjVc38WHmCZMQ==
X-Received: by 2002:adf:facf:: with SMTP id a15mr3278608wrs.308.1623905400757;
        Wed, 16 Jun 2021 21:50:00 -0700 (PDT)
Received: from localhost.localdomain (ip5b434b8b.dynamic.kabel-deutschland.de. [91.67.75.139])
        by smtp.googlemail.com with ESMTPSA id n13sm4587460wrg.75.2021.06.16.21.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 21:50:00 -0700 (PDT)
From:   Alex Bee <knaerzche@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     devicetree@vger.kernel.org, balbi@kernel.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        Alex Bee <knaerzche@gmail.com>
Subject: [PATCH 1/3] arm64: dts: rockchip: add ES8316 codec for Rock Pi4
Date:   Thu, 17 Jun 2021 06:49:53 +0200
Message-Id: <20210617044955.598994-1-knaerzche@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rock Pi4 boards have the codec connected to i2s0 and it is accessible
via i2c1 address 0x11.
Add an audio-graph-card it.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 .../boot/dts/rockchip/rk3399-rock-pi-4.dtsi   | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
index 7d0a7c697703..e5c1083174ff 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
@@ -36,6 +36,12 @@ sdio_pwrseq: sdio-pwrseq {
 		reset-gpios = <&gpio0 RK_PB2 GPIO_ACTIVE_LOW>;
 	};
 
+	sound {
+		compatible = "audio-graph-card";
+		label = "rockchip,rk3399";
+		dais = <&i2s0_p0>;
+	};
+
 	vcc12v_dcin: dc-12v {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc12v_dcin";
@@ -422,6 +428,20 @@ &i2c1 {
 	i2c-scl-rising-time-ns = <300>;
 	i2c-scl-falling-time-ns = <15>;
 	status = "okay";
+
+	es8316: codec@11 {
+		compatible = "everest,es8316";
+		reg = <0x11>;
+		clocks = <&cru SCLK_I2S_8CH_OUT>;
+		clock-names = "mclk";
+		#sound-dai-cells = <0>;
+
+		port {
+			es8316_p0_0: endpoint {
+				remote-endpoint = <&i2s0_p0_0>;
+			};
+		};
+	};
 };
 
 &i2c3 {
@@ -441,6 +461,14 @@ &i2s0 {
 	rockchip,capture-channels = <2>;
 	rockchip,playback-channels = <2>;
 	status = "okay";
+
+	i2s0_p0: port {
+		i2s0_p0_0: endpoint {
+			dai-format = "i2s";
+			mclk-fs = <256>;
+			remote-endpoint = <&es8316_p0_0>;
+		};
+	};
 };
 
 &i2s1 {
-- 
2.27.0

