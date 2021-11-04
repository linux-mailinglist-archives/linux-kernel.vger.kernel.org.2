Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02C2D445723
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 17:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbhKDQWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 12:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231904AbhKDQVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 12:21:24 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11766C06120A;
        Thu,  4 Nov 2021 09:18:46 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id e144so7552512iof.3;
        Thu, 04 Nov 2021 09:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y9XxMc0AW0nUNdHcfJkj/uuu844Le++RkXiLQplVbGE=;
        b=aFFzU/j2Hx2x+vwio0g3bTtFnf7f21A3aMN9pXjbZMMnUlXvlCKY8y8MfFJYYChnvR
         Rd5v6X1keqCA/J16sFbMP3PBKlXLYz3EhgXj9OVz0w6hq7sVuL6Cmb8n+YzH0+qSHvzl
         SWq9J7KkKu5YQdXrs+UZq5xU8oJAHEFvs8n50dDkpZUo0V2JkpVQPB/fd/a7w8JAPwJI
         LsHQMzIqlzbnLFva0Jrrmip+cz7Qhykj13kWRdhHA8q4v2OYdVzVcK3h+Elk9YM9ig3B
         A4ydVRc3rpQfnaKszIJ70hMkHUOwdKRfDl0E7QrVpr+I9u+NzBShYF+TYMde6EDwFSRo
         ObQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y9XxMc0AW0nUNdHcfJkj/uuu844Le++RkXiLQplVbGE=;
        b=csn0SgJYuU7sc+yg0PfKX0XFmgRuMY/ljrrxnxA2kaCzT2rVb0Wl0CnpOss3aN4Kws
         rGtPrZJU84xr8QrjtCp3cEPglbC502LpuJAsykGC3kZeIxM90gXjJ1KuRzwBDjHmROP2
         bWNglDc1rjKkOEu2c/TlNZYO0pVeCO7XI4PFybT9NtXYQHEITCgEXCRRD0cvcjxQ4JCm
         W2mEOZHab8jrIwaB6XFYiX7Kf9+0RgbsVmgUsn0nKrDCvZE8j6q2I4hXSOwaXFuOgmXL
         ppmpyEIEoO5IkMTcrMLxBHRDDHD/lqZuCSQ0jCUwbGtgH2VDUcOWPRSxjOofIKlfClOi
         QVvQ==
X-Gm-Message-State: AOAM532irXwXKMxtZYXi4kQ944dynwefkFv9x1j7YVZ4Pp8qEfi+3OaG
        phKcOPZOBlMChf7FJwkoIX8=
X-Google-Smtp-Source: ABdhPJxZZPvjYi+JgObfjguWEH1pUnrol/fQ9IwGxJzdNIHE/Y4iHuiOqOfgxDV4P5ciOOTzxBstiw==
X-Received: by 2002:a02:b796:: with SMTP id f22mr4683061jam.112.1636042725336;
        Thu, 04 Nov 2021 09:18:45 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:e81d:737a:bb84:83ba])
        by smtp.gmail.com with ESMTPSA id e17sm3266326iow.18.2021.11.04.09.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 09:18:44 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, ariel.dalessandro@collabora.com,
        krzk@kernel.org, tharvey@gateworks.com, l.stach@pengutronix.de,
        devicetree@vger.kernel.org, Adam Ford <aford173@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 9/9] arm64: dts: imx8mn: Enable GPU
Date:   Thu,  4 Nov 2021 11:18:04 -0500
Message-Id: <20211104161804.587250-10-aford173@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211104161804.587250-1-aford173@gmail.com>
References: <20211104161804.587250-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i.MX8M-Nano features a GC7000. The Etnaviv driver detects it as:

    etnaviv-gpu 38000000.gpu: model: GC7000, revision: 6203

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index 6ac14903bcef..2aafc17d8aa3 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -1089,6 +1089,31 @@ gpmi: nand-controller@33002000 {
 			status = "disabled";
 		};
 
+		gpu: gpu@38000000 {
+			compatible = "vivante,gc";
+			reg = <0x38000000 0x8000>;
+			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk IMX8MN_CLK_GPU_AHB>,
+				<&clk IMX8MN_CLK_GPU_BUS_ROOT>,
+				<&clk IMX8MN_CLK_GPU_CORE_ROOT>,
+				<&clk IMX8MN_CLK_GPU_SHADER>;
+			clock-names = "reg", "bus", "core", "shader";
+			assigned-clocks = <&clk IMX8MN_CLK_GPU_CORE>,
+					  <&clk IMX8MN_CLK_GPU_SHADER>,
+					  <&clk IMX8MN_CLK_GPU_AXI>,
+					  <&clk IMX8MN_CLK_GPU_AHB>,
+					  <&clk IMX8MN_GPU_PLL>,
+					  <&clk IMX8MN_CLK_GPU_CORE>,
+					  <&clk IMX8MN_CLK_GPU_SHADER>;
+			assigned-clock-parents = <&clk IMX8MN_GPU_PLL_OUT>,
+						  <&clk IMX8MN_GPU_PLL_OUT>,
+						  <&clk IMX8MN_SYS_PLL1_800M>,
+						  <&clk IMX8MN_SYS_PLL1_800M>;
+			assigned-clock-rates = <0>, <0>, <800000000>, <400000000>, <1200000000>,
+				<400000000>, <400000000>;
+			power-domains = <&pgc_gpumix>;
+		};
+
 		gic: interrupt-controller@38800000 {
 			compatible = "arm,gic-v3";
 			reg = <0x38800000 0x10000>,
-- 
2.32.0

