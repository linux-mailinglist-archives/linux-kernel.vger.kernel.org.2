Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 665633AD1EB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 20:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236241AbhFRSPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 14:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236221AbhFRSPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 14:15:39 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71571C061574;
        Fri, 18 Jun 2021 11:13:28 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id n35-20020a05600c3ba3b02901cdecb6bda8so9232828wms.5;
        Fri, 18 Jun 2021 11:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UG1JOqqWkVJ7vxd2JTkW+ImSRr+NkC9K3MMi/AjrjDU=;
        b=Xkzn6Ksrnwia97J/BpCY2xkdPjNlvHd3y9vejcoRWCqvmOR5xUiorCQaI4mZHvnynm
         ndNXHy78Pt50Vj0fpMqY0cKIjesMEhZqGdSCPdM1C33Zrr58lXAs8I1oS3u6d9DnTbdi
         JynaoBGH76QpwwnaPxxjR4OF2Q410iJvw//1dOKAldVJkG8H9hUREd9FvIRu0MVLG3ui
         kHKvmqYumEQR0pk/igFV/JJbUO1msDEZmobaIE68/X4FZOFtoZ5bfYzXXwnP4E1S05PS
         xOiIHCgJ447PcpCF2Ev3DPAD38SX/Q7BQolquiS6nQwo79jFVq916zxilq558Laiwfzo
         B0fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UG1JOqqWkVJ7vxd2JTkW+ImSRr+NkC9K3MMi/AjrjDU=;
        b=Nd+12RJMZnqHD0tQEQkVQGvUIwCjWEI665FUTw5XsHRWulffz+wcUQXDGOt3Pw5qvx
         xExccaX25vrRG+9Uge4Zkz/E4001X+Pkros09SGKFNOpzMPPye2gGnzB0O6M7UbmaUEE
         aGsuQ2Tjq5rkTFiUQ+GH/p3b3JWYkfRBMWXoGUo2Kh8fOFkyB659OvHwkT6mdAAwlA+b
         tyJQ+kP0uPh8oZJWYTPwdW9403RQTiPYisfAEZg7KzJ0h+qitqRfziHu7qvAGxJ9WAzR
         /6qMjP2FJ/p8DD2aGXdANWtZfBp4pjdDDzobET7ecODKguRiYLQlOyNMTHezSEVLPNtb
         ySMg==
X-Gm-Message-State: AOAM533+2nhL0BAzd7UEu6/5kJaUqtHRgLOxi2jXn0NFfqND1V5jKlPk
        tyf1EBHkc8rvj/0aRh1k9Q==
X-Google-Smtp-Source: ABdhPJx+u7DyeUluCInilWHRKBpThJKW9LLFAGMQfBOa+7iNfIt8TIajVsZ3oq20Lw7RsABn3ZHwhA==
X-Received: by 2002:a05:600c:4f09:: with SMTP id l9mr13253406wmq.114.1624040007086;
        Fri, 18 Jun 2021 11:13:27 -0700 (PDT)
Received: from localhost.localdomain (ip5b434b8b.dynamic.kabel-deutschland.de. [91.67.75.139])
        by smtp.googlemail.com with ESMTPSA id l10sm9306782wrv.82.2021.06.18.11.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 11:13:26 -0700 (PDT)
From:   Alex Bee <knaerzche@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>
Cc:     Johan Jonker <jbx6244@gmail.com>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alex Bee <knaerzche@gmail.com>
Subject: [PATCH v2 4/5] arm64: dts: rockchip: add ES8316 codec for ROCK Pi 4
Date:   Fri, 18 Jun 2021 20:12:55 +0200
Message-Id: <20210618181256.27992-5-knaerzche@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210618181256.27992-1-knaerzche@gmail.com>
References: <20210618181256.27992-1-knaerzche@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ROCK Pi 4 boards have the codec connected to i2s0 and it is accessible
via i2c1 address 0x11.
Add an audio-graph-card for it.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 .../boot/dts/rockchip/rk3399-rock-pi-4.dtsi   | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
index 7d0a7c697703..80925a58e470 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
@@ -36,6 +36,12 @@ sdio_pwrseq: sdio-pwrseq {
 		reset-gpios = <&gpio0 RK_PB2 GPIO_ACTIVE_LOW>;
 	};
 
+	sound {
+		compatible = "audio-graph-card";
+		label = "Analog";
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

