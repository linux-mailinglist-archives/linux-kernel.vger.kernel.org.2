Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB2D041B77D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 21:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242519AbhI1TXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 15:23:37 -0400
Received: from mail-oi1-f170.google.com ([209.85.167.170]:33781 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240589AbhI1TXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 15:23:36 -0400
Received: by mail-oi1-f170.google.com with SMTP id 24so31326733oix.0;
        Tue, 28 Sep 2021 12:21:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j5A4LeOmmPoK/uUV5cWC5lIkgveZXiN0+RYsmShFM40=;
        b=qLFbmF8HilUVv1UMgdhp7XcNjpvVh7tAn2barMCnulxlUNrv1HGJNtaLdbSHDeE0bM
         GRkqRVcYoqNQsLadlggB5d3RVV6tOwd4ym62gfRVf/kIf6bPkHDmpb6ha2/tS9m1iw2G
         RBinKMVeKvrmeQWYrDu+u0w9MngX+gI+RbbGf5G6jtiavovs5D2voCKgd83A6DD3uU+t
         +VEo9R8AESOvmfjYRkdcVc5+PdXlbXsJJmnfXnb+nFAZS6TrhO1or4ClV2919vM9z1ve
         BWq1VJdBFuqDTMAjfVg7/gwDLBoPtkDbcHfvYu0P4/kPg9ltRS2FWHRGvT0aLEJZ33/1
         cZuQ==
X-Gm-Message-State: AOAM530rc4HkmEbIwuoGTbSUzpSKRzTOjXa2LuiKJcBjWO9Fd0j6dzq8
        H5EeV24EcO9+tpLoU+tbhg==
X-Google-Smtp-Source: ABdhPJwWIPJRWloMD5hhwwNzsn2Tx1Ty66mkS1fmyP3CoZUPguxpLpzQfJ20dju7tydlpuYxDw6Bxw==
X-Received: by 2002:a05:6808:2d0:: with SMTP id a16mr4890079oid.125.1632856916058;
        Tue, 28 Sep 2021 12:21:56 -0700 (PDT)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id t80sm5108oie.9.2021.09.28.12.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 12:21:55 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: freescale: Fix 'interrupt-map' parent address cells
Date:   Tue, 28 Sep 2021 14:21:54 -0500
Message-Id: <20210928192154.1841889-1-robh@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'interrupt-map' in several Layerscape SoCs is malformed. The
'#address-cells' size of the parent interrupt controller (the GIC) is not
accounted for.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Li Yang <leoyang.li@nxp.com>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 24 +++++++++----------
 .../arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 24 +++++++++----------
 .../arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 24 +++++++++----------
 3 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index f85e437f80b7..84a31372b3fa 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -241,18 +241,18 @@ extirq: interrupt-controller@14 {
 				interrupt-controller;
 				reg = <0x14 4>;
 				interrupt-map =
-					<0 0 &gic GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
-					<1 0 &gic GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
-					<2 0 &gic GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
-					<3 0 &gic GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
-					<4 0 &gic GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
-					<5 0 &gic GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
-					<6 0 &gic GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
-					<7 0 &gic GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
-					<8 0 &gic GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
-					<9 0 &gic GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
-					<10 0 &gic GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
-					<11 0 &gic GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+					<0 0 &gic 0 0 GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
+					<1 0 &gic 0 0 GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
+					<2 0 &gic 0 0 GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
+					<3 0 &gic 0 0 GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+					<4 0 &gic 0 0 GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
+					<5 0 &gic 0 0 GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
+					<6 0 &gic 0 0 GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+					<7 0 &gic 0 0 GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
+					<8 0 &gic 0 0 GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+					<9 0 &gic 0 0 GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
+					<10 0 &gic 0 0 GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
+					<11 0 &gic 0 0 GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-map-mask = <0xffffffff 0x0>;
 			};
 		};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
index 801ba9612d36..38aea4fce238 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -293,18 +293,18 @@ extirq: interrupt-controller@14 {
 				interrupt-controller;
 				reg = <0x14 4>;
 				interrupt-map =
-					<0 0 &gic GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
-					<1 0 &gic GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
-					<2 0 &gic GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
-					<3 0 &gic GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
-					<4 0 &gic GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
-					<5 0 &gic GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
-					<6 0 &gic GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
-					<7 0 &gic GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
-					<8 0 &gic GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
-					<9 0 &gic GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
-					<10 0 &gic GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
-					<11 0 &gic GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+					<0 0 &gic 0 0 GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
+					<1 0 &gic 0 0 GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
+					<2 0 &gic 0 0 GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
+					<3 0 &gic 0 0 GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+					<4 0 &gic 0 0 GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
+					<5 0 &gic 0 0 GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
+					<6 0 &gic 0 0 GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+					<7 0 &gic 0 0 GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
+					<8 0 &gic 0 0 GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+					<9 0 &gic 0 0 GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
+					<10 0 &gic 0 0 GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
+					<11 0 &gic 0 0 GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-map-mask = <0xffffffff 0x0>;
 			};
 		};
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index c4b1a59ba424..dc8661ebd1f6 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -680,18 +680,18 @@ extirq: interrupt-controller@14 {
 				interrupt-controller;
 				reg = <0x14 4>;
 				interrupt-map =
-					<0 0 &gic GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
-					<1 0 &gic GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
-					<2 0 &gic GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
-					<3 0 &gic GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
-					<4 0 &gic GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
-					<5 0 &gic GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
-					<6 0 &gic GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
-					<7 0 &gic GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
-					<8 0 &gic GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
-					<9 0 &gic GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
-					<10 0 &gic GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
-					<11 0 &gic GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+					<0 0 &gic 0 0 GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
+					<1 0 &gic 0 0 GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
+					<2 0 &gic 0 0 GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
+					<3 0 &gic 0 0 GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+					<4 0 &gic 0 0 GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
+					<5 0 &gic 0 0 GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
+					<6 0 &gic 0 0 GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+					<7 0 &gic 0 0 GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
+					<8 0 &gic 0 0 GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+					<9 0 &gic 0 0 GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
+					<10 0 &gic 0 0 GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
+					<11 0 &gic 0 0 GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-map-mask = <0xffffffff 0x0>;
 			};
 		};
-- 
2.30.2

