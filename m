Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26F0145D803
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 11:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354532AbhKYKPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 05:15:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354609AbhKYKNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 05:13:15 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149AEC0613F3;
        Thu, 25 Nov 2021 02:09:29 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 133so5112507wme.0;
        Thu, 25 Nov 2021 02:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JtO60bk1RCy4qMnS1/rQRVPFrbrpTCMvxJUpVoIqlWA=;
        b=ReGBe7+5AvucSDE2RMRe5whSP0SAb8lWJ5R/KQNu4gOzSMIVWWo8n4AEi2CAsOG+9C
         uT5lCxuRrHfNXGsy4hMnBGvq59ZDMERw0+e7nOYaEJERSDd8Kb+Bsia/8lQVEdKt79H+
         +jQChXvEmRcQtGbDpqbJTuQgXAZJYA15oa74+hpAfOxd8vphXFG0U3wr2r5MdvwVsCjw
         hRL9GYS5W8sHfVStw+KXnTNCxcYZUNOAqrluKAKeMhA5rL5Ke8WWEWsOLZGorPt+Y2rn
         zi38of35vQIKl7TCWldclrKRxMjFbXq0F8SQ+VcOCR/+Vzr9jfinZZNXjiYIzm95kuM0
         Zq6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JtO60bk1RCy4qMnS1/rQRVPFrbrpTCMvxJUpVoIqlWA=;
        b=IoY+Aqwg5HwBt70InOJBT6HsFxojjywAf43wwwu8j74iJ1CdRBTTFUqOhriqpJB4RO
         XSTpD/nn2g+xtYYY73rq8B75MwzN5sc9NOlajC53RoqD2v7WAjA3iCn09Rfo7qRUhhn5
         ESxqxFpvmOGi+9HeWnLoMFr+kgbVTwqpd67wuHt6mFr65nAknQsUPR9skS1gGpxR1i8b
         uIeSfuJ9k2iyBsonskG92vnK6N4S8pzrXzfk+ypmoNu6faBv0ujDx7TgTS1X7BnQs4IO
         TcDVmnpbj/+NwkxjWkGgEwgG5wk0jQDHy519rGmpXH4+VnSR9QSru+Z1xCbP34NGgKVP
         zxzg==
X-Gm-Message-State: AOAM530XEwWbYDnmKJuo0619jITofKQhzwP75V2TBQO6SW8TCeEgFMhi
        WU5kcXEkmtdV2w7GMBkSE8w=
X-Google-Smtp-Source: ABdhPJzZLPDc2HewTHumJfbaWU/Daj4OM99frT8vDFf8AI3I960W9RaDktVTqGH9eNyMTYFmOMcx0Q==
X-Received: by 2002:a05:600c:1e1c:: with SMTP id ay28mr5726488wmb.131.1637834967755;
        Thu, 25 Nov 2021 02:09:27 -0800 (PST)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id l7sm2903533wry.86.2021.11.25.02.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 02:09:27 -0800 (PST)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] arm64: dts: rockchip: rk356x: Add HDMI audio nodes
Date:   Thu, 25 Nov 2021 11:08:34 +0100
Message-Id: <20211125100836.423808-2-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211125100836.423808-1-frattaroli.nicolas@gmail.com>
References: <20211125100836.423808-1-frattaroli.nicolas@gmail.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the i2s0 node and an hdmi-sound sound device to the
rk356x device tree. On the rk356[68], the i2s0 controller is
connected to HDMI audio.

Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk356x.dtsi | 32 ++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
index 3c09cf6d4c37..ad4053402eef 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
@@ -614,6 +614,21 @@ hdmi_in_vp2: endpoint@2 {
 		};
 	};
 
+	hdmi_sound: hdmi-sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,mclk-fs = <256>;
+		simple-audio-card,name = "hdmi-sound";
+		status = "disabled";
+
+		simple-audio-card,cpu {
+			sound-dai = <&i2s0_8ch>;
+		};
+		simple-audio-card,codec {
+			sound-dai = <&hdmi>;
+		};
+	};
+
 	qos_gpu: qos@fe128000 {
 		compatible = "rockchip,rk3568-qos", "syscon";
 		reg = <0x0 0xfe128000 0x0 0x20>;
@@ -789,6 +804,23 @@ spdif: spdif@fe460000 {
 		status = "disabled";
 	};
 
+	i2s0_8ch: i2s@fe400000 {
+		compatible = "rockchip,rk3568-i2s-tdm";
+		reg = <0x0 0xfe400000 0x0 0x1000>;
+		interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
+		assigned-clocks = <&cru CLK_I2S0_8CH_TX_SRC>, <&cru CLK_I2S0_8CH_RX_SRC>;
+		assigned-clock-rates = <1188000000>, <1188000000>;
+		clocks = <&cru MCLK_I2S0_8CH_TX>, <&cru MCLK_I2S0_8CH_RX>, <&cru HCLK_I2S0_8CH>;
+		clock-names = "mclk_tx", "mclk_rx", "hclk";
+		dmas = <&dmac1 0>;
+		dma-names = "tx";
+		resets = <&cru SRST_M_I2S0_8CH_TX>, <&cru SRST_M_I2S0_8CH_RX>;
+		reset-names = "tx-m", "rx-m";
+		rockchip,grf = <&grf>;
+		#sound-dai-cells = <0>;
+		status = "disabled";
+	};
+
 	i2s1_8ch: i2s@fe410000 {
 		compatible = "rockchip,rk3568-i2s-tdm";
 		reg = <0x0 0xfe410000 0x0 0x1000>;
-- 
2.34.0

