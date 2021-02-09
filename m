Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B447131451D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 01:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbhBIAyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 19:54:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbhBIAyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 19:54:07 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139A9C061786;
        Mon,  8 Feb 2021 16:53:27 -0800 (PST)
Received: from mwalle01.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:fa59:71ff:fe9b:b851])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 9598723E5F;
        Tue,  9 Feb 2021 01:53:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1612832002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Xgt/MD7lKvLeSdMrNW2NdaeIS7qBuvz02NxmMJCjUuk=;
        b=AlYYcVqr/hhtNPyBbatwGVW1XWsZlAHSXOtECFJUPb/iCr+glXWMKcUnSog50JbM8rhhSs
        TZivp5HbbLvpVvKwM60um1j+4yDS2UJf5g4lUiPv9AyEja4rWxIDzkKa8wc1ZadhPiw2o3
        g4oIXtgHFnHzIbNcw32BCtg0h59HOu8=
From:   Michael Walle <michael@walle.cc>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH] arm64: dts: ls1028a: add interrupt to Root Complex Event Collector
Date:   Tue,  9 Feb 2021 01:52:59 +0100
Message-Id: <20210209005259.29725-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The legacy interrupt INT_A is hardwired to the event collector. RCEC is
bascially supported starting with v5.11. Having a correct interrupt, will
make RCEC at least probe correctly.

There are still issues with how RCEC is implemented in the RCiEP on the
LS1028A. RCEC will report an error, but it cannot find the correct
subdevice.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index 262fbad8f0ec..c1f2f402ad53 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -1114,6 +1114,12 @@
 					full-duplex;
 				};
 			};
+
+			rcec@1f,0 {
+				reg = <0x00f800 0 0 0 0>;
+				/* IEP INT_A */
+				interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
+			};
 		};
 
 		rcpm: power-controller@1e34040 {
-- 
2.20.1

