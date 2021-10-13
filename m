Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E671842CEE9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 00:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhJMXBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 19:01:14 -0400
Received: from phobos.denx.de ([85.214.62.61]:39082 "EHLO phobos.denx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229575AbhJMXBK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 19:01:10 -0400
Received: from crub.agik.hopto.org (pd95f1d7c.dip0.t-ipconnect.de [217.95.29.124])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: agust@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 962AF83637;
        Thu, 14 Oct 2021 00:59:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1634165946;
        bh=SeAa2jyjc7PWtTZOmeNlHFKytMn9TpnrK/xPF2MC5dc=;
        h=From:To:Cc:Subject:Date:From;
        b=KpYq53aVHyNIf0rM4fDbMA5Rd5A09mj4fU5gKNf5uZg8iSPzBb4hbIeJtnf5goKdj
         TxifS5dsiJv7JRSDLSLF6wGCdb8klqm9Wy+mWtyrl7Gy7iPnRSQ4LnjKgzB+D3YrFK
         Ykm7RQrKrosqjbgAajlvd4Jk/amBhJx146c5i9/2TCi0cgl0UR+X/ujqzdS2Y0DhXj
         QSVJD5Hj7dclGuC7nFWGjHgJqlyXpXbyqA17kWJjknn3jUn+lSZXGae+pkRC/jniiS
         7BV3XQ2FkFXuupas1AYG6xNuS54wSoCL4eKKv0Y8SOBE8zJ/qV4NFE3cCFLLxNIJtB
         5N4APjRRapMqg==
From:   Anatolij Gustschin <agust@denx.de>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] powerpc/5200: dts: fix psc node warning
Date:   Thu, 14 Oct 2021 00:59:04 +0200
Message-Id: <20211013225904.1548-1-agust@denx.de>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: clamav-milter 0.103.2 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix build warning:
Warning (spi_bus_bridge): /soc5200@f0000000/psc@2000: node name for SPI buses should be 'spi'

Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
 arch/powerpc/boot/dts/motionpro.dts | 4 ++++
 arch/powerpc/boot/dts/o2d.dtsi      | 6 +++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/dts/motionpro.dts b/arch/powerpc/boot/dts/motionpro.dts
index 09f0eaa4ad49..cc217ddd50a0 100644
--- a/arch/powerpc/boot/dts/motionpro.dts
+++ b/arch/powerpc/boot/dts/motionpro.dts
@@ -19,6 +19,8 @@
 	label = "motionpro-readyled";
 };
 
+/delete-node/ &psc2;
+
 / {
 	model = "promess,motionpro";
 	compatible = "promess,motionpro";
@@ -35,6 +37,8 @@
 		// PSC2 in spi master mode 
 		psc@2200 {		// PSC2
 			compatible = "fsl,mpc5200b-psc-spi","fsl,mpc5200-psc-spi";
+			reg = <0x2200 0x100>;
+			interrupts = <2 2 0>;
 			cell-index = <1>;
 		};
 
diff --git a/arch/powerpc/boot/dts/o2d.dtsi b/arch/powerpc/boot/dts/o2d.dtsi
index 898fe08a9fd0..34a836a37084 100644
--- a/arch/powerpc/boot/dts/o2d.dtsi
+++ b/arch/powerpc/boot/dts/o2d.dtsi
@@ -15,6 +15,8 @@
 };
 &gpt1 { gpio-controller; };
 
+/delete-node/ &psc1;
+
 / {
 	model = "ifm,o2d";
 	compatible = "ifm,o2d";
@@ -29,8 +31,10 @@
 			status = "disabled";
 		};
 
-		psc@2000 {		// PSC1
+		spi@2000 {		// PSC1
 			compatible = "fsl,mpc5200b-psc-spi","fsl,mpc5200-psc-spi";
+			reg = <0x2000 0x100>;
+			interrupts = <2 1 0>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			cell-index = <0>;
-- 
2.17.1

