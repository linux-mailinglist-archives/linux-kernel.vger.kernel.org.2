Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33DA53AE422
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 09:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhFUH1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 03:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbhFUH1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 03:27:35 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D435CC061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 00:25:20 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id v7so13442026pgl.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 00:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wE0EtFYsjB5vlJwRJRnVD3mRJGbikL6A/mq3nMXEQvo=;
        b=EXV22jysZtFBGfkOj6eka+mm+ScqN1Gb+9Drg+5vhkPlVJF+YFq3khisQeIp1MwM4k
         5+bruQxYxg1/hjhUZnCxLAXEl9Cc23GXlH0C4wty7MYRQPvGJBeGK7jU3QNvRNf2pqaP
         5Df8uMr4bfWCrKq4/osNjUUK3c5pmy/xMWy50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wE0EtFYsjB5vlJwRJRnVD3mRJGbikL6A/mq3nMXEQvo=;
        b=kY4IqZ08L0dPhLx0cOagGEClG8HD8tPui9rXlqO2bGMO+baZZQxOoHJ8CxA9Y7hSvl
         uEHAlvaRAj9YsSelPnvaVM9FhF1pT+UrkvQi0D2DZuBZQ/0A5oEDuK+EmASNHTjxhnUp
         PP40hKUm8uXscuFlg2G7V//h60tbHa//R3958TMPtg1Tayu+MV0y8yse0DdppM1CtF1J
         Uk6m97VXsoQzacRFfjB/sRTyxUu5X5axtzvdhATYQogLG1wRIjsBX+V/VXd9J1yJgAaf
         GrLEaxuzE3sy5yvFaprqFe3OOxY7R8eL15MaJV7Y03dNlPBjkau+4Fnv9S+y1g7Psh4F
         iyHg==
X-Gm-Message-State: AOAM531VMFH1IEYUEkDQO/syXHiCogtURoshtM90+3P3AvlFvWjtTbf0
        TCKjyER7osBfUOB/w4gnWjzFFA==
X-Google-Smtp-Source: ABdhPJzRHoAtTRbTlR5W+aeNHLX4JpicPLn++ox7Da1Q5l/obTH4wW4HwzGNFYk/GzMiTBnG3OWONg==
X-Received: by 2002:a63:4915:: with SMTP id w21mr22619815pga.363.1624260320470;
        Mon, 21 Jun 2021 00:25:20 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c00a:a884:139:e97f:a55d:7f66])
        by smtp.gmail.com with ESMTPSA id 21sm13951294pfh.103.2021.06.21.00.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 00:25:20 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Peng Fan <peng.fan@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Tomasz Figa <t.figa@samsung.com>,
        Fancy Fang <chen.fang@nxp.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        linux-amarula@amarulasolutions.com,
        Anthony Brandon <anthony@amarulasolutions.com>,
        Francis Laniel <francis.laniel@amarulasolutions.com>,
        Matteo Lisi <matteo.lisi@engicam.com>,
        Milco Pratesi <milco.pratesi@engicam.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [RFC PATCH 6/9] arm64: dts: imx8mm: Add display mix blk ctl
Date:   Mon, 21 Jun 2021 12:54:21 +0530
Message-Id: <20210621072424.111733-7-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210621072424.111733-1-jagan@amarulasolutions.com>
References: <20210621072424.111733-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add display mix blk control node for i.MX8MM.

Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 26 +++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index 849dd0250ba9..fe5485ee9419 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -663,6 +663,20 @@ pgc_gpu: power-domain@5 {
 						resets = <&src IMX8MQ_RESET_GPU_RESET>;
 						power-domains = <&pgc_gpumix>;
 					};
+
+					pgc_dispmix: power-domain@10 {
+						#power-domain-cells = <0>;
+						reg = <IMX8MM_POWER_DOMAIN_DISPMIX>;
+						clocks = <&clk IMX8MM_CLK_DISP_ROOT>,
+							 <&clk IMX8MM_CLK_DISP_AXI_ROOT>,
+							 <&clk IMX8MM_CLK_DISP_APB_ROOT>;
+					};
+
+					pgc_mipi: power-domain@11 {
+						#power-domain-cells = <0>;
+						reg = <IMX8MM_POWER_DOMAIN_MIPI>;
+						power-domains = <&pgc_dispmix>;
+					};
 				};
 			};
 		};
@@ -1016,6 +1030,18 @@ aips4: bus@32c00000 {
 			#size-cells = <1>;
 			ranges = <0x32c00000 0x32c00000 0x400000>;
 
+			dispmix_blk_ctl: blk-ctl@32e28000 {
+				compatible = "fsl,imx8mm-dispmix-blk-ctl", "syscon";
+				reg = <0x32e28000 0x100>;
+				#power-domain-cells = <1>;
+				power-domains = <&pgc_dispmix>, <&pgc_mipi>;
+				power-domain-names = "dispmix", "mipi";
+				clocks = <&clk IMX8MM_CLK_DISP_ROOT>,
+					 <&clk IMX8MM_CLK_DISP_AXI_ROOT>,
+					 <&clk IMX8MM_CLK_DISP_APB_ROOT>;
+				clock-names = "disp", "axi", "apb";
+			};
+
 			usbotg1: usb@32e40000 {
 				compatible = "fsl,imx8mm-usb", "fsl,imx7d-usb";
 				reg = <0x32e40000 0x200>;
-- 
2.25.1

