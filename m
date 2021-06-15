Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 602073A7F08
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 15:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbhFONTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 09:19:51 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:4788 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbhFONTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 09:19:49 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G47yx23z1zXgDv;
        Tue, 15 Jun 2021 21:12:41 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 15 Jun 2021 21:17:41 +0800
Received: from thunder-town.china.huawei.com (10.174.179.0) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 15 Jun 2021 21:17:40 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2 1/1] arm64: dts: lx2160a: Fix the compatible string of LX2160A UART
Date:   Tue, 15 Jun 2021 21:16:05 +0800
Message-ID: <20210615131605.616-2-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20210615131605.616-1-thunder.leizhen@huawei.com>
References: <20210615131605.616-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.179.0]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Kettenis told us that:
According to the NXP documentation, the LX2160A has a real PL011 UART.

Therefore, rewrite it to the compatible string of pl011. The property
"current-speed" specific to "arm,sbsa-uart" is also deleted.

Suggested-by: Shawn Guo <shawnguo@kernel.org>
Suggested-by: Mark Kettenis <mark.kettenis@xs4all.nl>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index c4b1a59ba424..d2e6f7285674 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -920,34 +920,30 @@ QORIQ_CLK_PLL_DIV(8)>,
 		};
 
 		uart0: serial@21c0000 {
-			compatible = "arm,sbsa-uart","arm,pl011";
+			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x0 0x21c0000 0x0 0x1000>;
 			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
-			current-speed = <115200>;
 			status = "disabled";
 		};
 
 		uart1: serial@21d0000 {
-			compatible = "arm,sbsa-uart","arm,pl011";
+			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x0 0x21d0000 0x0 0x1000>;
 			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
-			current-speed = <115200>;
 			status = "disabled";
 		};
 
 		uart2: serial@21e0000 {
-			compatible = "arm,sbsa-uart","arm,pl011";
+			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x0 0x21e0000 0x0 0x1000>;
 			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
-			current-speed = <115200>;
 			status = "disabled";
 		};
 
 		uart3: serial@21f0000 {
-			compatible = "arm,sbsa-uart","arm,pl011";
+			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x0 0x21f0000 0x0 0x1000>;
 			interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
-			current-speed = <115200>;
 			status = "disabled";
 		};
 
-- 
2.25.1


