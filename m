Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB80335E2F2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 17:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344438AbhDMPeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 11:34:19 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:49361 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231641AbhDMPeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 11:34:16 -0400
Received: from mwalle01.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:fa59:71ff:fe9b:b851])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 82A732224E;
        Tue, 13 Apr 2021 17:33:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1618328035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aIH+b0GcZ8y25PBNAB55HaGHxbJE5IpyGf18xNdDBl0=;
        b=X8Bdc14pR2wQAIvEIJEEvIqRcgI1ssm70zhKrAfmsH97t+LJBG6F54hIAfexkvNjM03QpZ
        Mmvcbh6Mb2cY4JjgP6MJx43C//x3e1sVO18mIb6AebhzqVI407PYOkt2zSkqHjkRTnW1av
        bMhazEhQmgw6gmsAh0uwOlmsrG/SkqU=
From:   Michael Walle <michael@walle.cc>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH 1/2] arm64: dts: freescale: sl28: fix RGMII clock and voltage
Date:   Tue, 13 Apr 2021 17:33:48 +0200
Message-Id: <20210413153349.29119-2-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210413153349.29119-1-michael@walle.cc>
References: <20210413153349.29119-1-michael@walle.cc>
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

Also, the RGMII pad voltage is wrong. It was configured to 2.5V (that is
the VDDH regulator). The correct voltage is 1.8V, i.e. the VDDIO
regulator.

This fix is for the freescale/fsl-ls1028a-kontron-sl28-var4.dts.

Fixes: 815364d0424e ("arm64: dts: freescale: add Kontron sl28 support")
Signed-off-by: Michael Walle <michael@walle.cc>
---
 .../boot/dts/freescale/fsl-ls1028a-kontron-sl28-var4.dts     | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var4.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var4.dts
index df212ed5bb94..e65d1c477e2c 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var4.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var4.dts
@@ -31,11 +31,10 @@
 			reg = <0x4>;
 			eee-broken-1000t;
 			eee-broken-100tx;
-
 			qca,clk-out-frequency = <125000000>;
 			qca,clk-out-strength = <AR803X_STRENGTH_FULL>;
-
-			vddio-supply = <&vddh>;
+			qca,keep-pll-enabled;
+			vddio-supply = <&vddio>;
 
 			vddio: vddio-regulator {
 				regulator-name = "VDDIO";
-- 
2.20.1

