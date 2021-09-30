Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEBF41DE40
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 17:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347715AbhI3P7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 11:59:08 -0400
Received: from mail.fris.de ([116.203.77.234]:36324 "EHLO mail.fris.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347587AbhI3P7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 11:59:02 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C6017BFBD8;
        Thu, 30 Sep 2021 17:57:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
        t=1633017437; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=jyAuLIRMAog5EPrq8Q6DzdCiAqb5jHM/M1xGrD1qs3s=;
        b=ZCipyBabp37loEmSOEbi58LA/tvlEqQsopYHv9zq5CjGIe4QhOB+XU56FA4FuTV9mElF+P
        DLSXohDDphGBu79I8Q43y7AxXF6wFaQQQjcfKHuq+uCgMaJnxXXfAnbjQXP4Z0OPxnXGCS
        Cqs3J7zYUjINrW43y6rSBMKfam4/MJ7/H12SOgorIz1bnOKjTSnazf3LHxUFnizjpu8uZZ
        qvhWLRHcOgvlDyiUAa8csYE6HvJbphr1871fZs/Yf4NpregKOSJDK1NLID9j7XbN++yEjr
        aIAes+1fnryTLiZq/qUIRBmVh6l1xypzksUwbufcsh8gXFGMno8HQdpeZ/7eGw==
From:   Frieder Schrempf <frieder@fris.de>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Frieder Schrempf <frieder.schrempf@kontron.de>,
        Heiko Thiery <heiko.thiery@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH 7/8] arm64: dts: imx8mm-kontron: Fix reset delays for ethernet PHY
Date:   Thu, 30 Sep 2021 17:56:30 +0200
Message-Id: <20210930155633.2745201-8-frieder@fris.de>
In-Reply-To: <20210930155633.2745201-1-frieder@fris.de>
References: <20210930155633.2745201-1-frieder@fris.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

According to the datasheet the VSC8531 PHY expects a reset pulse of 100 ns
and a delay of 15 ms after the reset has been deasserted. Set the matching
values in the devicetree.

Reported-by: Heiko Thiery <heiko.thiery@gmail.com>
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts
index 0e4509287a92..106e13945ae5 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts
@@ -124,8 +124,8 @@ mdio {
 
 		ethphy: ethernet-phy@0 {
 			reg = <0>;
-			reset-assert-us = <100>;
-			reset-deassert-us = <100>;
+			reset-assert-us = <1>;
+			reset-deassert-us = <15000>;
 			reset-gpios = <&gpio4 27 GPIO_ACTIVE_LOW>;
 		};
 	};
-- 
2.33.0

