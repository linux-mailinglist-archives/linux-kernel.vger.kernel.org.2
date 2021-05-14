Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 869CB381023
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 20:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232328AbhENS5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 14:57:14 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:49409 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbhENS5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 14:57:13 -0400
Received: from mwalle01.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:fa59:71ff:fe9b:b851])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 71ADB22256;
        Fri, 14 May 2021 20:56:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1621018560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k+Vlef7jvOgvilVVGjBjjKMPscsAK3dgpBzI2L4C8Zg=;
        b=temU5cA4euB+8etpqOS7IPN8QBpLP6u4KNpnrSrAHUDNWCmYAC9nyDNdRLRpDmGu7cCtrR
        mm9SQt4YqribXXekS6sJOPjmx8WXPoVH/MI7w7CysuMdFfLyvSWp4h/RC4HeCUwXIST4Kb
        pv0+cEv9kS+8BetLr/R6NmAcBM8EMkw=
From:   Michael Walle <michael@walle.cc>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v2 2/2] arm64: dts: freescale: sl28: var1: fix RGMII clock and voltage
Date:   Fri, 14 May 2021 20:55:53 +0200
Message-Id: <20210514185553.10095-3-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210514185553.10095-1-michael@walle.cc>
References: <20210514185553.10095-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During hardware validation it was noticed that the clock isn't
continuously enabled when there is no link. This is because the 125MHz
clock is derived from the internal PLL which seems to go into some kind
of power-down mode every once in a while. The LS1028A expects a contiuous
clock. Thus enable the PLL all the time.

Also, the RGMII pad voltage is wrong, it was configured to 2.5V (that is
the VDDH regulator). The correct voltage is 1.8V, i.e. the VDDIO
regulator.

This fix is for the freescale/fsl-ls1028a-kontron-sl28-var1.dts.

Fixes: 642856097c18 ("arm64: dts: freescale: sl28: add variant 1")
Signed-off-by: Michael Walle <michael@walle.cc>
---
 .../arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var1.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var1.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var1.dts
index 6c309b97587d..e8d31279b7a3 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var1.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var1.dts
@@ -46,7 +46,8 @@
 			eee-broken-100tx;
 			qca,clk-out-frequency = <125000000>;
 			qca,clk-out-strength = <AR803X_STRENGTH_FULL>;
-			vddio-supply = <&vddh>;
+			qca,keep-pll-enabled;
+			vddio-supply = <&vddio>;
 
 			vddio: vddio-regulator {
 				regulator-name = "VDDIO";
-- 
2.20.1

