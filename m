Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF7EB3AE429
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 09:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbhFUH1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 03:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbhFUH1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 03:27:41 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF2FC061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 00:25:27 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id g6so12962926pfq.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 00:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YJ2BOKG4ZuRZzTmg7DTj1V1Pqbxgkeavbg3ssOxVb6g=;
        b=fX1ZJt96WAd4vRX3HAW5JB6IFaEpc6ds6BifeNqKd67P4GhSIaHwUwMKGYfTQubqaO
         rYNb3xKyLfMQbmIYkKZ6ZLncSewZGnbevs5wAd69cCJ/1og7oi2rD6xdDjOmjmod6RJk
         tKJXDL3Bt7X1qd46HFdU0XHLwqlgoUqlK4qD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YJ2BOKG4ZuRZzTmg7DTj1V1Pqbxgkeavbg3ssOxVb6g=;
        b=ATloEUngyXe2SM85+06NXfljR8oxDaUb1wl00eWot/HYnKpnsQFZkFj/Mxq0eWggTq
         kBgkEq0XpZEjYriCLzayp4mqR3zEIJp3jiSWQHJboAl1NVmwWtSgoh/xSXhxfQkZchHC
         shIbTWOlmrqkgFHrD7ZdagF/hDo5modsO9Yuv7yKIK9Cz+Dolv07/ecp+4X5eixn8SLI
         l0sln89AC160hk2SjlM38QshVrzDY4xbHxv/SrBhSH77V075KjNIH5WoEyEeE2dBs0CQ
         t64tf5WmfUEba/OWI5JcOa5qxCR2/JHgH6j1hOYtEOQSRiSFUaUFdOMoOBACEZHZRdCw
         GLjA==
X-Gm-Message-State: AOAM530qTTVbjxTsE3DCj5flOl9r+1XT3VIPTksfEaX9EE9AeX/5oFo4
        ciWyQLBgJeukrsLkcNEst3gV/Q==
X-Google-Smtp-Source: ABdhPJxO5ope055OQIE0W7ZNCvoDUKS4owJmThC4DHHcVxxsn4DRsp0AP4Iw8Hajh4T0x7B8NxDxow==
X-Received: by 2002:aa7:8615:0:b029:303:4428:9dbe with SMTP id p21-20020aa786150000b029030344289dbemr4319621pfn.17.1624260327279;
        Mon, 21 Jun 2021 00:25:27 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c00a:a884:139:e97f:a55d:7f66])
        by smtp.gmail.com with ESMTPSA id 21sm13951294pfh.103.2021.06.21.00.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 00:25:26 -0700 (PDT)
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
Subject: [RFC PATCH 7/9] arm64: dts: imx8mm: Add eLCDIF node support
Date:   Mon, 21 Jun 2021 12:54:22 +0530
Message-Id: <20210621072424.111733-8-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210621072424.111733-1-jagan@amarulasolutions.com>
References: <20210621072424.111733-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add eLCDIF controller node for i.MX8MM.

Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index fe5485ee9419..5f68182ed3a6 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -1030,6 +1030,25 @@ aips4: bus@32c00000 {
 			#size-cells = <1>;
 			ranges = <0x32c00000 0x32c00000 0x400000>;
 
+			lcdif: lcdif@32e00000 {
+				compatible = "fsl,imx8mm-lcdif", "fsl,imx6sx-lcdif";
+				reg = <0x32e00000 0x10000>;
+				clocks = <&clk IMX8MM_CLK_LCDIF_PIXEL>,
+					 <&clk IMX8MM_CLK_DISP_AXI_ROOT>,
+					 <&clk IMX8MM_CLK_DISP_APB_ROOT>;
+				clock-names = "pix", "disp_axi", "axi";
+				assigned-clocks = <&clk IMX8MM_CLK_LCDIF_PIXEL>,
+						  <&clk IMX8MM_CLK_DISP_AXI>,
+						  <&clk IMX8MM_CLK_DISP_APB>;
+				assigned-clock-parents = <&clk IMX8MM_VIDEO_PLL1_OUT>,
+							 <&clk IMX8MM_SYS_PLL2_1000M>,
+							 <&clk IMX8MM_SYS_PLL1_800M>;
+				assigned-clock-rate = <594000000>, <500000000>, <200000000>;
+				interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
+				power-domains = <&dispmix_blk_ctl IMX8MM_BLK_CTL_PD_DISPMIX_LCDIF>;
+				status = "disabled";
+			};
+
 			dispmix_blk_ctl: blk-ctl@32e28000 {
 				compatible = "fsl,imx8mm-dispmix-blk-ctl", "syscon";
 				reg = <0x32e28000 0x100>;
-- 
2.25.1

