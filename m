Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA06403EED
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 20:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349825AbhIHSPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 14:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349732AbhIHSPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 14:15:12 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C19C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 11:14:04 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id w8so3489346pgf.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 11:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/7V7rRemEpda86gCcDXaw5uz6xMLDav/RoQNN2RSOuU=;
        b=jbFgaVCKgsth2Y9eV65+J3eCvsvNnESvcC/38soujbnVAZbIves1S8586ELAEnx/ID
         A5sxB4nM77/ls5NTbEsxSlx8qIWyPGI+vnIqe+DUiCNLmiPcXL5zS6ex55pZBLAJEuSt
         3j3hlsVfGVIHw1ntIBzcRfPc+OpG472RPgryk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/7V7rRemEpda86gCcDXaw5uz6xMLDav/RoQNN2RSOuU=;
        b=DjeUlsGb1GvZk1XLT3vTWN4XQ14r0hWAh7Uqa7bkYEVFkiZnwsUx5fHvQlgUV/XWO5
         mFjgEJ24svxdpMMPBIX1fopAujgR3DTCeNtjWS+SFYDRJPsFdPWdRR/EH7/WbWSn7ybB
         GFZAOYc8yv36nm3bZ71Lp5dfOsVQovqhacRKouY4HpjaYOp/Iz+lWDyDQOpq3eo8rXRV
         cLFurPd6c/HD/wIihvh+XTqlXlozrxX3nbcT/fzzztOszf/9u9Qsj3C8i+Io8tvLlQI/
         OcrdzSC24KTm7yGNhePeFjCKlpsFj/r55LZvSJvvES0ywR3i9xzzh99mbPcUXJStgky5
         HGrA==
X-Gm-Message-State: AOAM531+QW5nA6Bz4sIJDp2w+SqiGN8snLntD0q84n3R9MqrA0fi39ul
        jOR6PhcPsGSo3X+P4nKElnE9DxIIKHTkEA==
X-Google-Smtp-Source: ABdhPJzS2hRYQ/VhBHUhz7s035X8SA+E503rKFk/O4ISrGfbPXO5LNPQ7UfPtBSGHGxa3j0HeaCRPQ==
X-Received: by 2002:a63:d814:: with SMTP id b20mr5014888pgh.268.1631124844338;
        Wed, 08 Sep 2021 11:14:04 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:7556:e88d:6fba:e1d0])
        by smtp.gmail.com with UTF8SMTPSA id k190sm3564254pgc.11.2021.09.08.11.14.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Sep 2021 11:14:03 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-clk@vger.kernel.org,
        Chen-Yu Tsai <wenst@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 3/3] arm64: dts: rockchip: add Coresight debug range for RK3399
Date:   Wed,  8 Sep 2021 11:13:40 -0700
Message-Id: <20210908111337.v2.3.Ibc87b4785709543c998cc852c1edaeb7a08edf5c@changeid>
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24-goog
In-Reply-To: <20210908111337.v2.1.I006bb36063555079b1a88f01d20e38d7e4705ae0@changeid>
References: <20210908111337.v2.1.I006bb36063555079b1a88f01d20e38d7e4705ae0@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Per Documentation/devicetree/bindings/arm/coresight-cpu-debug.txt.

This IP block can be used for sampling the PC of any given CPU, which is
useful in certain panic scenarios where you can't get the CPU to stop
cleanly (e.g., hard lockup).

Reviewed-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

Changes in v2:
- Sort properly

 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 48 ++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 3871c7fd83b0..c5fe2d440114 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -361,6 +361,54 @@ usb_host1_ohci: usb@fe3e0000 {
 		status = "disabled";
 	};
 
+	debug@fe430000 {
+		compatible = "arm,coresight-cpu-debug", "arm,primecell";
+		reg = <0 0xfe430000 0 0x1000>;
+		clocks = <&cru PCLK_COREDBG_L>;
+		clock-names = "apb_pclk";
+		cpu = <&cpu_l0>;
+	};
+
+	debug@fe432000 {
+		compatible = "arm,coresight-cpu-debug", "arm,primecell";
+		reg = <0 0xfe432000 0 0x1000>;
+		clocks = <&cru PCLK_COREDBG_L>;
+		clock-names = "apb_pclk";
+		cpu = <&cpu_l1>;
+	};
+
+	debug@fe434000 {
+		compatible = "arm,coresight-cpu-debug", "arm,primecell";
+		reg = <0 0xfe434000 0 0x1000>;
+		clocks = <&cru PCLK_COREDBG_L>;
+		clock-names = "apb_pclk";
+		cpu = <&cpu_l2>;
+	};
+
+	debug@fe436000 {
+		compatible = "arm,coresight-cpu-debug", "arm,primecell";
+		reg = <0 0xfe436000 0 0x1000>;
+		clocks = <&cru PCLK_COREDBG_L>;
+		clock-names = "apb_pclk";
+		cpu = <&cpu_l3>;
+	};
+
+	debug@fe610000 {
+		compatible = "arm,coresight-cpu-debug", "arm,primecell";
+		reg = <0 0xfe610000 0 0x1000>;
+		clocks = <&cru PCLK_COREDBG_B>;
+		clock-names = "apb_pclk";
+		cpu = <&cpu_b0>;
+	};
+
+	debug@fe710000 {
+		compatible = "arm,coresight-cpu-debug", "arm,primecell";
+		reg = <0 0xfe710000 0 0x1000>;
+		clocks = <&cru PCLK_COREDBG_B>;
+		clock-names = "apb_pclk";
+		cpu = <&cpu_b1>;
+	};
+
 	usbdrd3_0: usb@fe800000 {
 		compatible = "rockchip,rk3399-dwc3";
 		#address-cells = <2>;
-- 
2.33.0.153.gba50c8fa24-goog

