Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5B8A42D837
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 13:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbhJNLdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 07:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbhJNLda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 07:33:30 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4FEC061570;
        Thu, 14 Oct 2021 04:31:26 -0700 (PDT)
Received: from crub.agik.hopto.org (pd95f1d7c.dip0.t-ipconnect.de [217.95.29.124])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: agust@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 7119583576;
        Thu, 14 Oct 2021 13:31:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1634211084;
        bh=wUwWGnfkZkVFT+VA7IqdygubbkAZvHxKV85RjWrF1CU=;
        h=From:To:Cc:Subject:Date:From;
        b=R0j1OwtVl1r0stex4GJacsuKlV91aLCxzOb91t+N6b3m0Qim/1eXqjNAyMDu/agrc
         H4pvRDMBYm5RjRgqH6pGLQswYUa51bal9b9wes+MuHQkq4dgMhzf0fU4EUkNpV5Ry+
         HJnwt6Jh422ha3rE1qy81pzLecyrm0UU3xFseebiNk4OK40NZiDkJFBjyiZbQjG37q
         JC6jCGYfrfZ5pd9pevqbiGWRpE283fjDqYJe6dCTbfsZcA4rdpPOHGuuCxST+vxwae
         0bCbbEjAV5C1tFUaNfhcDAat80mWz2lw6FMjnlvjfogGJi3NqNXdpzAufxvS30qiS+
         5Z7pJHC7hXZBQ==
From:   Anatolij Gustschin <agust@denx.de>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH] powerpc/mpc512x: dts: fix PSC node warnings
Date:   Thu, 14 Oct 2021 13:31:23 +0200
Message-Id: <20211014113123.2358-1-agust@denx.de>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: clamav-milter 0.103.2 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix build warnings like:
mpc5121.dtsi:397.13-406.5: Warning (spi_bus_bridge): /soc@80000000/psc@11400: node name for SPI buses should be 'spi'
mpc5121.dtsi:409.13-418.5: Warning (spi_bus_bridge): /soc@80000000/psc@11500: node name for SPI buses should be 'spi'
mpc5121.dtsi:457.13-466.5: Warning (spi_bus_bridge): /soc@80000000/psc@11900: node name for SPI buses should be 'spi'

Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
 arch/powerpc/boot/dts/ac14xx.dts   | 17 +++++++++++++++--
 arch/powerpc/boot/dts/pdm360ng.dts | 11 ++++++++++-
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/boot/dts/ac14xx.dts b/arch/powerpc/boot/dts/ac14xx.dts
index 5d8877e1f4ad..662d7aa2e4e8 100644
--- a/arch/powerpc/boot/dts/ac14xx.dts
+++ b/arch/powerpc/boot/dts/ac14xx.dts
@@ -301,13 +301,21 @@
 			fsl,tx-fifo-size = <512>;
 		};
 
+		/delete-node/ psc@11400;
+		/delete-node/ psc@11500;
+
 		/* PSC4 in SPI mode */
-		spi4: psc@11400 {
+		spi4: spi@11400 {
 			compatible = "fsl,mpc5121-psc-spi", "fsl,mpc5121-psc";
+			reg = <0x11400 0x100>;
 			fsl,rx-fifo-size = <768>;
 			fsl,tx-fifo-size = <768>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			interrupts = <40 0x8>;
+			clocks = <&clks MPC512x_CLK_PSC4>,
+				 <&clks MPC512x_CLK_PSC4_MCLK>;
+			clock-names = "ipg", "mclk";
 			num-cs = <1>;
 			cs-gpios = <&gpio_pic 25 0>;
 
@@ -326,13 +334,18 @@
 		};
 
 		/* PSC5 in SPI mode */
-		spi5: psc@11500 {
+		spi5: spi@11500 {
 			compatible = "fsl,mpc5121-psc-spi", "fsl,mpc5121-psc";
+			reg = <0x11500 0x100>;
 			fsl,mode = "spi-master";
 			fsl,rx-fifo-size = <128>;
 			fsl,tx-fifo-size = <128>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			interrupts = <40 0x8>;
+			clocks = <&clks MPC512x_CLK_PSC5>,
+				 <&clks MPC512x_CLK_PSC5_MCLK>;
+			clock-names = "ipg", "mclk";
 
 			lcd@0 {
 				compatible = "ilitek,ili922x";
diff --git a/arch/powerpc/boot/dts/pdm360ng.dts b/arch/powerpc/boot/dts/pdm360ng.dts
index 67c3b9db75d7..2733d15079a9 100644
--- a/arch/powerpc/boot/dts/pdm360ng.dts
+++ b/arch/powerpc/boot/dts/pdm360ng.dts
@@ -169,10 +169,19 @@
 			compatible = "fsl,mpc5121-psc-uart", "fsl,mpc5121-psc";
 		};
 
-		psc@11900 {
+		/delete-node/ psc@11900;
+
+		spi@11900 {
 			compatible = "fsl,mpc5121-psc-spi", "fsl,mpc5121-psc";
+			reg = <0x11900 0x100>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			interrupts = <40 0x8>;
+			fsl,rx-fifo-size = <16>;
+			fsl,tx-fifo-size = <16>;
+			clocks = <&clks MPC512x_CLK_PSC9>,
+				 <&clks MPC512x_CLK_PSC9_MCLK>;
+			clock-names = "ipg", "mclk";
 
 			/* ADS7845 touch screen controller */
 			ts@0 {
-- 
2.17.1

