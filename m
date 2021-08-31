Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA0E3FC86B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 15:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237541AbhHaNlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 09:41:17 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:53395 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbhHaNlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 09:41:16 -0400
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 50C6622248;
        Tue, 31 Aug 2021 15:40:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1630417219;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/HVXIBSX2Qj4zS5UCLNer9YEe+Wp/U8hfs4EHMpxscY=;
        b=Abq6PXy93xQBsgg8wfdM5rZbMRm3kqa0tAwO1bfZ1CGeYKxndGUOPIBd7yHNXbev6CRXjg
        GNoBz34cbgAPSl6bSynziaTtgk/5guJhKK266PLra4IabSxLJv2CjC1wLCG4NnrjESt3gH
        DgjL7HNKGXEB6y4rvOjKFetazysVhS4=
From:   Michael Walle <michael@walle.cc>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH 1/7] arm64: dts: ls1028a: move pixel clock pll into /soc
Date:   Tue, 31 Aug 2021 15:40:07 +0200
Message-Id: <20210831134013.1625527-2-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210831134013.1625527-1-michael@walle.cc>
References: <20210831134013.1625527-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move it inside the /soc subnode because it is part of the CCSR space.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index 343ecf0e8973..9a65a7118faa 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -80,13 +80,6 @@ osc_27m: clock-osc-27m {
 		clock-output-names = "phy_27m";
 	};
 
-	dpclk: clock-controller@f1f0000 {
-		compatible = "fsl,ls1028a-plldig";
-		reg = <0x0 0xf1f0000 0x0 0xffff>;
-		#clock-cells = <0>;
-		clocks = <&osc_27m>;
-	};
-
 	firmware {
 		optee: optee  {
 			compatible = "linaro,optee-tz";
@@ -926,6 +919,13 @@ QORIQ_CLK_PLL_DIV(2)>,
 			status = "disabled";
 		};
 
+		dpclk: clock-controller@f1f0000 {
+			compatible = "fsl,ls1028a-plldig";
+			reg = <0x0 0xf1f0000 0x0 0x10000>;
+			#clock-cells = <0>;
+			clocks = <&osc_27m>;
+		};
+
 		tmu: tmu@1f80000 {
 			compatible = "fsl,qoriq-tmu";
 			reg = <0x0 0x1f80000 0x0 0x10000>;
-- 
2.30.2

