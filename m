Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF9A13821F0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 01:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232714AbhEPXH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 19:07:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:44076 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231997AbhEPXHh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 19:07:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6AA63B1EB;
        Sun, 16 May 2021 23:06:21 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-rockchip@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org
Subject: [PATCH 7/9] arm64: dts: rockchip: rk1808: Prepare eMMC node
Date:   Mon, 17 May 2021 01:05:49 +0200
Message-Id: <20210516230551.12469-8-afaerber@suse.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210516230551.12469-1-afaerber@suse.de>
References: <20210516230551.12469-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an eMMC DT node.

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 arch/arm64/boot/dts/rockchip/rk1808.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk1808.dtsi b/arch/arm64/boot/dts/rockchip/rk1808.dtsi
index af2b51afda7d..b4a71c5c8be7 100644
--- a/arch/arm64/boot/dts/rockchip/rk1808.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk1808.dtsi
@@ -199,5 +199,14 @@ uart7: serial@ff5c0000 {
 			interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
 		};
+
+		emmc: mmc@ffd00000 {
+			compatible = "rockchip,rk1808-dw-mshc", "rockchip,rk3288-dw-mshc";
+			reg = <0xffd00000 0x4000>;
+			interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
+			max-frequency = <150000000>;
+			fifo-depth = <0x100>;
+			status = "disabled";
+		};
 	};
 };
-- 
2.31.1

