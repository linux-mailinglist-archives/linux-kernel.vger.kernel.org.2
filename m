Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF148438803
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 11:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbhJXJqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 05:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbhJXJqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 05:46:14 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0BBC061764
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 02:43:54 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id t11so5843543plq.11
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 02:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=koX01uZWlNS6Kdoh31vOXRzgvcfPWXmHOS+HdaxihXo=;
        b=HSwL1A9YGktQJTMqsCMKdB9+CPrT6cUxMYh9g1WXPmwmMiGRXnoYwN24kz94Vnf67s
         4XSfRGhyCX7R0yDuzetkGxleNiqGyUPH+M8qQqZaRlIBAPUcNIJRlydbv39nWbePKa+Y
         0ypGKX1FeKxwoOBBjczq2S7F+PRNQzfgRr9oxTHgxPEXPcLhOOVYYa18CRYpVePm0iiZ
         ocDQv7XnhKeFFWGkPqDnP84sLuhXoIA0XVUbczGs5y9/Cri4iazqUJq5+mGEECx8T2V3
         baUUJy1rcMH7IraHuFbW2RxXExFHdIHafKMmE42mo7e1vhm5cLFlRdk4vpNw7FOm5LyN
         cofA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=koX01uZWlNS6Kdoh31vOXRzgvcfPWXmHOS+HdaxihXo=;
        b=lkHKA3Vr1887jKNylgqGfI1sDB/t+r2CdHGF0sy5kT5ev/ZltToFEtPyW4/QkwU5yH
         nZAHQ9CklMcmjYxjsYGieQYsWIwYF9LbzAsju6fdWaOH85FcYD3MxP2gdOk27REpuD8a
         MOtW0nBSlUVvPCfqPvkSkFmOuTryyepZoNiPSbQxJNrdtayKH7GAlUPZT5pntXacCn/i
         MiuPQoUZuiP24VSibaH/LEmBGWYUZlIe8jNWQ1UEKXWUceU4r2oN6nFF85mNlXVDrVQa
         fWcRLqzwPO8D1cJ/NsOxJfeTKSZIojyCe1HVWyVfxd13o/vo2U56hfNMCuOlV+Ucx+eJ
         s9VQ==
X-Gm-Message-State: AOAM531LyKwMX8cjUHrR16lb6NGXZ4u4p8N35XVo0+M1JBQuRO7hKyhi
        vj0fNPqIs9wPP5OFL8ucaOE=
X-Google-Smtp-Source: ABdhPJzAI733xx8YDzpNfnXppn57xPuG7NBFYIs//bB6I8NYhti9wOBCw/H9HAFq2+ukvRV3+fGunA==
X-Received: by 2002:a17:90a:5642:: with SMTP id d2mr27213022pji.200.1635068634203;
        Sun, 24 Oct 2021 02:43:54 -0700 (PDT)
Received: from lxb-server.lan ([2403:18c0:2:7e::1926:817])
        by smtp.gmail.com with ESMTPSA id p16sm17636619pfh.97.2021.10.24.02.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Oct 2021 02:43:53 -0700 (PDT)
From:   Yunhao Tian <t123yh.xyz@gmail.com>
X-Google-Original-From: Yunhao Tian <t123yh@outlook.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Yunhao Tian <t123yh.xyz@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/3] arm64: dts: rockchip: add spdifrx support to rk3308.dtsi
Date:   Sun, 24 Oct 2021 17:43:17 +0800
Message-Id: <20211024094317.1641949-4-t123yh@outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211024094317.1641949-1-t123yh@outlook.com>
References: <20211024094317.1641949-1-t123yh@outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunhao Tian <t123yh.xyz@gmail.com>

The Rockchip RK3308 features an integrated SPDIF receiver.
This patch adds support for it to rk3308.dtsi.

Signed-off-by: Yunhao Tian <t123yh.xyz@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3308.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3308.dtsi b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
index 0034312ef8f4..bbb0d2c74505 100644
--- a/arch/arm64/boot/dts/rockchip/rk3308.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
@@ -710,6 +710,22 @@ i2s_8ch_3: i2s@ff330000 {
 		status = "disabled";
 	};
 
+	spdif_rx: spdif-rx@ff3b0000 {
+		#sound-dai-cells = <0>;
+		compatible = "rockchip,rk3308-spdifrx";
+		reg = <0x0 0xff3b0000 0x0 0x1000>;
+		interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru SCLK_SPDIF_RX>, <&cru HCLK_SPDIFRX>;
+		clock-names = "mclk", "hclk";
+		dmas = <&dmac1 14>;
+		dma-names = "rx";
+		resets = <&cru SRST_SPDIFRX_M>;
+		reset-names = "spdifrx-m";
+		pinctrl-names = "default";
+		pinctrl-0 = <&spdif_in>;
+		status = "disabled";
+	};
+
 	spdif_tx: spdif-tx@ff3a0000 {
 		compatible = "rockchip,rk3308-spdif", "rockchip,rk3066-spdif";
 		reg = <0x0 0xff3a0000 0x0 0x1000>;
-- 
2.25.1

