Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7CA5331BC8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 01:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbhCIAiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 19:38:05 -0500
Received: from mx.socionext.com ([202.248.49.38]:24258 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230511AbhCIAhg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 19:37:36 -0500
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 09 Mar 2021 09:37:34 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 972062059035;
        Tue,  9 Mar 2021 09:37:34 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 9 Mar 2021 09:37:34 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 40D94B1D40;
        Tue,  9 Mar 2021 09:37:34 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 1/2] ARM: dts: uniphier: Change phy-mode to RGMII-ID to enable delay pins for RTL8211E
Date:   Tue,  9 Mar 2021 09:37:15 +0900
Message-Id: <1615250236-11349-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After applying the commit bbc4d71d6354
("net: phy: realtek: fix rtl8211e rx/tx delay config"), the configuration
register for TXDLY and RXDLY is set correctly.

Although PXs2 boards have RTL8211E for gigabit network PHY, it turrned out
that the phy-mode should be RGMII-ID mode. This changes 'phy-mode' property
to 'rgmii-id' as default.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 arch/arm/boot/dts/uniphier-pxs2.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/uniphier-pxs2.dtsi b/arch/arm/boot/dts/uniphier-pxs2.dtsi
index 4d9f69a..5ba831e 100644
--- a/arch/arm/boot/dts/uniphier-pxs2.dtsi
+++ b/arch/arm/boot/dts/uniphier-pxs2.dtsi
@@ -583,7 +583,7 @@
 			clocks = <&sys_clk 6>;
 			reset-names = "ether";
 			resets = <&sys_rst 6>;
-			phy-mode = "rgmii";
+			phy-mode = "rgmii-id";
 			local-mac-address = [00 00 00 00 00 00];
 			socionext,syscon-phy-mode = <&soc_glue 0>;
 
-- 
2.7.4

