Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B59E83FC870
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 15:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239065AbhHaNlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 09:41:25 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:42359 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238493AbhHaNlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 09:41:20 -0400
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id A24A92224D;
        Tue, 31 Aug 2021 15:40:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1630417223;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qeB/yDko0sQRCMba6GWK0EnCUBJypmy18QFaGdeIPH8=;
        b=s/FxZL5v0pUhDAVxdV073rqAauoc6zyYR2S0DRFEfiB9JLKy3QhakoOSAbX0kTxJsytZ43
        P3vqLAw/aEY7ITgrnjLHsRxUcUOTZTdE8Td/F0MEh8bif+gchNg5MHADfkxB6B6+GiE7ZL
        OdH6VrDODirRoVc/zd9bCzPnmAPr/t0=
From:   Michael Walle <michael@walle.cc>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH 3/7] arm64: dts: ls1028a: add Vivante GPU node
Date:   Tue, 31 Aug 2021 15:40:09 +0200
Message-Id: <20210831134013.1625527-4-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210831134013.1625527-1-michael@walle.cc>
References: <20210831134013.1625527-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently, support for this particular Vivante GC7000 GPU was added to the
linux kernel. Add the corresponding device tree node.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index 92e4f004c1c2..876dea668a90 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -814,6 +814,17 @@ dpi0_out: endpoint {
 			};
 		};
 
+		gpu: gpu@f0c0000 {
+			compatible = "vivante,gc";
+			reg = <0x0 0xf0c0000 0x0 0x10000>;
+			interrupts = <GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clockgen QORIQ_CLK_HWACCEL 2>,
+				 <&clockgen QORIQ_CLK_HWACCEL 2>,
+				 <&clockgen QORIQ_CLK_HWACCEL 2>;
+			clock-names = "core", "shader", "bus";
+			#cooling-cells = <2>;
+		};
+
 		sai1: audio-controller@f100000 {
 			#sound-dai-cells = <0>;
 			compatible = "fsl,vf610-sai";
-- 
2.30.2

