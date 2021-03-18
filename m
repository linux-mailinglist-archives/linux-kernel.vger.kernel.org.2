Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 029DF340B9A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 18:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbhCRRTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 13:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232316AbhCRRTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 13:19:14 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E249EC06174A;
        Thu, 18 Mar 2021 10:19:13 -0700 (PDT)
Received: from mwalle01.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:fa59:71ff:fe9b:b851])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id B97CD22205;
        Thu, 18 Mar 2021 18:19:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1616087951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=zScicOu5h1kWopVKEvc+11eswp5j64QDoz9ikr8fwU4=;
        b=U6FKg4DlCfe2ajUlm/m/Cgc78Udvwjo8n0R2mvrm77eRcTHE0LZy6D14pP3Bp3Ugpb/JL3
        Om1IkqK3Kf5s/thsoE31k/ofLkhvACIZsbv7axClaWuPkX0TnMaF92LKzYdrtUFKIKkKKg
        ddDZ+WqFCZwRvi4G+4n64HIGPGyTg1A=
From:   Michael Walle <michael@walle.cc>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH 1/2] arm64: dts: fsl-ls1028a-kontron-sl28: move MTD partitions
Date:   Thu, 18 Mar 2021 18:18:55 +0100
Message-Id: <20210318171856.3487-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the MTD partitions to the partitions subnode. This is the new way
to specify the partitions, see
  Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml

Signed-off-by: Michael Walle <michael@walle.cc>
---
 .../freescale/fsl-ls1028a-kontron-sl28.dts    | 94 ++++++++++---------
 1 file changed, 49 insertions(+), 45 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
index 0516076087ae..7e3a33eb2045 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
@@ -115,8 +115,6 @@
 	status = "okay";
 
 	flash@0 {
-		#address-cells = <1>;
-		#size-cells = <1>;
 		compatible = "jedec,spi-nor";
 		m25p,fast-read;
 		spi-max-frequency = <133000000>;
@@ -125,49 +123,55 @@
 		spi-rx-bus-width = <2>; /* 2 SPI Rx lines */
 		spi-tx-bus-width = <1>; /* 1 SPI Tx line */
 
-		partition@0 {
-			reg = <0x000000 0x010000>;
-			label = "rcw";
-			read-only;
-		};
-
-		partition@10000 {
-			reg = <0x010000 0x0f0000>;
-			label = "failsafe bootloader";
-			read-only;
-		};
-
-		partition@100000 {
-			reg = <0x100000 0x040000>;
-			label = "failsafe DP firmware";
-			read-only;
-		};
-
-		partition@140000 {
-			reg = <0x140000 0x0a0000>;
-			label = "failsafe trusted firmware";
-			read-only;
-		};
-
-		partition@1e0000 {
-			reg = <0x1e0000 0x020000>;
-			label = "reserved";
-			read-only;
-		};
-
-		partition@200000 {
-			reg = <0x200000 0x010000>;
-			label = "configuration store";
-		};
-
-		partition@210000 {
-			reg = <0x210000 0x1d0000>;
-			label = "bootloader";
-		};
-
-		partition@3e0000 {
-			reg = <0x3e0000 0x020000>;
-			label = "bootloader environment";
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 {
+				reg = <0x000000 0x010000>;
+				label = "rcw";
+				read-only;
+			};
+
+			partition@10000 {
+				reg = <0x010000 0x0f0000>;
+				label = "failsafe bootloader";
+				read-only;
+			};
+
+			partition@100000 {
+				reg = <0x100000 0x040000>;
+				label = "failsafe DP firmware";
+				read-only;
+			};
+
+			partition@140000 {
+				reg = <0x140000 0x0a0000>;
+				label = "failsafe trusted firmware";
+				read-only;
+			};
+
+			partition@1e0000 {
+				reg = <0x1e0000 0x020000>;
+				label = "reserved";
+				read-only;
+			};
+
+			partition@200000 {
+				reg = <0x200000 0x010000>;
+				label = "configuration store";
+			};
+
+			partition@210000 {
+				reg = <0x210000 0x1d0000>;
+				label = "bootloader";
+			};
+
+			partition@3e0000 {
+				reg = <0x3e0000 0x020000>;
+				label = "bootloader environment";
+			};
 		};
 	};
 };
-- 
2.20.1

