Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85EF84442C6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 14:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbhKCN4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 09:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232033AbhKCNz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 09:55:58 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17583C06120A;
        Wed,  3 Nov 2021 06:53:22 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id m14so9528285edd.0;
        Wed, 03 Nov 2021 06:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dfUFmaE5TGftvuGL4qHxLuZZEptBzH+lcqE9KzsoXGM=;
        b=Jf1azWXHQGcZ+fZtVcffWmqE0TjjnOeYCBc6wWasWhsJPS+EyIlCb+E7Y2AVfH5ice
         J6OEjjELuwDgG1shxFq3RdyWucjescEqudtEDZBi6RbslrXYeluaIONomAzItMs50tZM
         R5ylYvz26n2YGNFk59UgnmDxpzF1yEKtQyYiEQ3vgNQzD2FM0VNcgSeV/zzgT0C/3bIL
         zVNfro6OK/cQz+Mp6Tas727z4AbqVHjfM+jaMREDMk0ypEcZtJ4WKrS3w8Xft0FuNT3t
         Bn5Ugdo9BQjKZBfFMoZb6FNo9DIjAov+k/NTsj5K4vlCJnZrE82g4iK7GcXRgCcoVcix
         H6ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dfUFmaE5TGftvuGL4qHxLuZZEptBzH+lcqE9KzsoXGM=;
        b=OXL+GVDuPliBnejD6NqJyv9jehHmnH4N0L01Q2Ic8HxK4SN8m8PvrRIys6W2d6HlBF
         g6P4PbB3SpRtBoBw+RmvxOdZLAQ6/Js0E95ximrXwdycoq4ENpYR/Kw1O7YD+Z4Hr8Ra
         4BWkkFv7sYobkzMkpd2r6Yi/d+clgAt4igvSG3AnsUxw62/ut1UQHEKPj9GcMXfw4cJ3
         swOpLaA7/isB/0nhx0S0ApUX/5ep+ZKOIw0tKm4kg82I/+HlnpBjYoGEEydo3wQ0+ftP
         Ch44MlQPnDdUFhzWUNYZWBrfYMJD5AZ4zcv9D0FeJF/v9LpO4ahaDsr5K2zDXPoPpja/
         Tq6A==
X-Gm-Message-State: AOAM531qmxidJ28Y9K6mLjQZGedxssWoHqSwU8Oq+Hf+5/Y7a1DNWMlh
        hKGk7Qbozne6I2h41gIhs1E=
X-Google-Smtp-Source: ABdhPJw4gowrGcHdX8t8zp8CVWwIrlYyg4ac+gAgxzIynDCzNMXgKm9Rk1nbNF17m7KktWbyFJvCiA==
X-Received: by 2002:a05:6402:438f:: with SMTP id o15mr197151edc.235.1635947597131;
        Wed, 03 Nov 2021 06:53:17 -0700 (PDT)
Received: from tom-desktop.station (net-188-153-110-208.cust.vodafonedsl.it. [188.153.110.208])
        by smtp.gmail.com with ESMTPSA id g10sm1341017edr.56.2021.11.03.06.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 06:53:16 -0700 (PDT)
From:   Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     tomm.merciai@gmail.com, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Adam Ford <aford173@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: imx8mm: Add NOC node
Date:   Wed,  3 Nov 2021 14:53:11 +0100
Message-Id: <20211103135313.6428-1-tomm.merciai@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for dynamic frequency scaling of the main NOC configuration
on imx8mm.

References:
 - i.MX 8M Mini Applications Processor RM, Rev. 3, 11/2020
 - f18e6d573b80 arm64: dts: imx8mq: Add NOC node
 - 912b9dacf3f0 arm64: dts: imx8mq: increase NOC clock to 800 MHz
 - https://source.codeaurora.org/external/imx/linux-imx/tree/arch/ \
   arm64/boot/dts/freescale/imx8mm.dtsi?h=lf-5.10.y

---
Changes since v1:
 - Fix noc_opp_table frequencies taking NXP bsp as reference
 - Add reference link to nxp imx8mm dtsi on commit body

 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 25 +++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index c2f3f118f82e..1bcc5e361ca3 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -719,6 +719,31 @@ pgc_mipi: power-domain@11 {
 			};
 		};
 
+		noc: interconnect@32700000 {
+			compatible = "fsl,imx8mm-noc", "fsl,imx8m-noc";
+			reg = <0x32700000 0x100000>;
+			clocks = <&clk IMX8MM_CLK_NOC>;
+			fsl,ddrc = <&ddrc>;
+			#interconnect-cells = <1>;
+			operating-points-v2 = <&noc_opp_table>;
+
+			noc_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-150M {
+					opp-hz = /bits/ 64 <150000000>;
+				};
+
+				opp-375M {
+					opp-hz = /bits/ 64 <375000000>;
+				};
+
+				opp-750M {
+					opp-hz = /bits/ 64 <750000000>;
+				};
+			};
+		};
+
 		aips2: bus@30400000 {
 			compatible = "fsl,aips-bus", "simple-bus";
 			reg = <0x30400000 0x400000>;
-- 
2.25.1

