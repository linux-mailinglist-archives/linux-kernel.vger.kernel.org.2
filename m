Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBBA4441CB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 13:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbhKCMqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 08:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbhKCMqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 08:46:13 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC4AC061714;
        Wed,  3 Nov 2021 05:43:36 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id r4so8710713edi.5;
        Wed, 03 Nov 2021 05:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ey+fmLtSC3uA15+54mAlN3+tzxLtFpUl71/u/YpV0Hw=;
        b=jh7UPCWDOBlGo8Kf5bYTauwH5U0iGi94Muyfdy69Sy7kl+dE/oU0Z1dbLeDaXGycTj
         1D63K3nxDdlxEMiYSyRLJmwPqfF80h3ERqQ0XWc9W5CUmqW84EIhlHX+TCxy9keZq4FX
         gbWBXoFsx9iV3N0ACOs6VvGVPg/0K7GYENveonTxMVZNQwgGNrkROeNGREvfKyaqwR4G
         cGUNxs7TutuklCzr8clJJLM/I2rmwW1Cc0gJ9pNBNy0HFMFAqMRFctHOzctOevH5p49o
         vGhikcaJ+rJEBhk+FwkhmLrSSNq7gaVQm1TsMSHCuJVjNQ9UMgg4NoYOV1Kuq6umD4UV
         s2EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ey+fmLtSC3uA15+54mAlN3+tzxLtFpUl71/u/YpV0Hw=;
        b=47Kz4r9MPu+rJraPkDTxWvGwuCh5soV5mSfJOcsbS4E8WDRU7AH1lSlfLluNeVHS0m
         EcQvhxbfSfQwsxqkDcDMqVgsratOQneaZno/inN1IqAyJkMXVUX3i6/IUKhHFK3VtAeb
         8M+0mXmvlYwzK8pvjHkBV7nFDaxvZmjCF6GtVJDqEGIm0hQEAKfoNh44Z8mYcb94EfXh
         GPLBqoAQVVy7NNlE+++FS9+wMupuaG4+DE0UjG0Az8BNp4aAogrvR94CNRgzQiiTGDwZ
         04xDAVlkbm0ptCWXbnY4h8VL3VVDejCM0Bba9R1R6bBGEHzynn03zUkS3DUb5wL+UGNE
         grlw==
X-Gm-Message-State: AOAM532xd9TWv5a0C2ygBdtUFS8b3/xFUvsvK8ZVNtfI3FogpCbPKUVt
        gkRcaH4GB3gIYGSqnZyU9u0=
X-Google-Smtp-Source: ABdhPJw0qOYJliPBxMwJVO0Dogvbir+w/I0cZJInh/6RvAaQWlYXkfBBJWHDEALgAHnLKVQqPAHrGA==
X-Received: by 2002:a50:9ee3:: with SMTP id a90mr54603729edf.224.1635943415520;
        Wed, 03 Nov 2021 05:43:35 -0700 (PDT)
Received: from tom-desktop.station (net-188-153-110-208.cust.vodafonedsl.it. [188.153.110.208])
        by smtp.gmail.com with ESMTPSA id lb12sm1097829ejc.28.2021.11.03.05.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 05:43:34 -0700 (PDT)
From:   Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     tomm.merciai@gmail.com, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Peng Fan <peng.fan@nxp.com>, Alice Guo <alice.guo@nxp.com>,
        Adam Ford <aford173@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: imx8mm: Add NOC node
Date:   Wed,  3 Nov 2021 13:43:28 +0100
Message-Id: <20211103124329.171124-1-tomm.merciai@gmail.com>
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
---
 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 25 +++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index c2f3f118f82e..c5f64abcecff 100644
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
+				opp-133M {
+					opp-hz = /bits/ 64 <133333333>;
+				};
+
+				opp-400M {
+					opp-hz = /bits/ 64 <400000000>;
+				};
+
+				opp-800M {
+					opp-hz = /bits/ 64 <800000000>;
+				};
+			};
+		};
+
 		aips2: bus@30400000 {
 			compatible = "fsl,aips-bus", "simple-bus";
 			reg = <0x30400000 0x400000>;
-- 
2.25.1

