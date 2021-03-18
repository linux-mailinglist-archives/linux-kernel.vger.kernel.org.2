Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3927E340114
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 09:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbhCRIfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 04:35:13 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:54879 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhCRIeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 04:34:50 -0400
Received: from mwalle01.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:fa59:71ff:fe9b:b851])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 6DF7F22234;
        Thu, 18 Mar 2021 09:34:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1616056485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=UkQYujCU5/ac5fJri9Y/OOHb2OqCHcjc2jWw+xBSdVM=;
        b=HQC1T4OJAEEUv1WdFlzJXd9zeKiQS9JkKIefdijT/SdmYrQkAkzqetVkbI4IcSf3TnWNtH
        1CXdqL61XWaDWpVso6CALC32Il9slf7Q24rKFdQTpSoQjz0aN63sKpNEaYdGk2Ru1RHRpw
        /q3GkmQqxFHnu8zZ5elitSqjup20XKQ=
From:   Michael Walle <michael@walle.cc>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sahil Malhotra <sahil.malhotra@nxp.com>,
        Michael Walle <michael@walle.cc>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        "kernelci.org bot" <bot@kernelci.org>
Subject: [PATCH] arm64: dts: ls1028a: fix optee node
Date:   Thu, 18 Mar 2021 09:34:38 +0100
Message-Id: <20210318083438.26536-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't enable the optee node in the SoC include. It is an optional
component and actually, if enabled, breaks boards which doesn't have it.

This reverts commit 48787485f8de ("arm64: dts: ls1028a: enable optee
node") and enables the node per board, assuming the intend of the
original author was to enable OPTEE for the LS1028A-RDB and the
LS1028A-QDS.

Fixes: 48787485f8de ("arm64: dts: ls1028a: enable optee node")
Reported-by: Guillaume Tucker <guillaume.tucker@collabora.com>
Reported-by: "kernelci.org bot" <bot@kernelci.org>
Tested-by: Michael Walle <michael@walle.cc>
Signed-off-by: Michael Walle <michael@walle.cc>
---
 arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts | 4 ++++
 arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts | 4 ++++
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi    | 3 ++-
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
index fbcba9cb8503..060d3c79244d 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
@@ -327,6 +327,10 @@
 	status = "okay";
 };
 
+&optee {
+	status = "okay";
+};
+
 &sai1 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
index 41ae6e7675ba..1bdf0104d492 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
@@ -274,6 +274,10 @@
 	status = "okay";
 };
 
+&optee {
+	status = "okay";
+};
+
 &sai4 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index 50d277eb2a54..e2007ebacd69 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -92,9 +92,10 @@
 	};
 
 	firmware {
-		optee {
+		optee: optee {
 			compatible = "linaro,optee-tz";
 			method = "smc";
+			status = "disabled";
 		};
 	};
 
-- 
2.20.1

