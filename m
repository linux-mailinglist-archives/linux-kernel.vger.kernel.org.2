Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDE97328845
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 18:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238713AbhCARiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 12:38:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:60806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234788AbhCAQ3A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 11:29:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 61C5564E62;
        Mon,  1 Mar 2021 16:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614615795;
        bh=qy4o8aOaG+e/js/CS8OTDNQPLBMrdqSFXahX3iD8ALE=;
        h=From:To:Cc:Subject:Date:From;
        b=WXhDQUVw44ZB6VY7h+dbRBbUVliiJxijCsEWdxBY77vV05dEl0CY4nF6LIVZieX+c
         9UGl2zRY3GJbRRxZLcT8Ti6gyld1VnA0fM0w/jkes5fG0Ahupu/IKW/bLyVmRNTPty
         GIw1eGHIYY5bb5kuSYzjVyX9lQCOVZJx+UHSBB6VLxam2R79aQx6ssOPlPK5/ewVKs
         EzVBg8+VhiNaBmtnEP0vFWntsWXTCMWQ4eVMhb4SOYeoMvOzuVMtfKjhfAdQUTa+gN
         VaHSLi0cfzMPZj1InGkMbIMHO5pkeiGQbO+P0S+VPsrOEpEG/sdVoTWiPPwu5rMmcR
         VFX8h+ttClhMw==
Received: by wens.tw (Postfix, from userid 1000)
        id 8634D5FB7F; Tue,  2 Mar 2021 00:23:12 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Maxime Ripard <mripard@kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: allwinner: h6: Switch to macros for RSB clock/reset indices
Date:   Tue,  2 Mar 2021 00:23:09 +0800
Message-Id: <20210301162309.1225-1-wens@kernel.org>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

The macros for the clock and reset indices for the RSB hardware block
were replaced with raw numbers when the RSB controller node was added.
This was done to avoid cross-tree dependencies.

Now that both the clk and DT changes have been merged, we can switch
back to using the macros.

Fixes: aaad900757a6 ("arm64: dts: allwinner: h6: Add RSB controller node")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

Small patch split out from the H6 RSB clock support patch.
This should be merged for v5.12.

---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index 49e979794094..af8b7d0ef750 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -995,9 +995,9 @@ r_rsb: rsb@7083000 {
 			compatible = "allwinner,sun8i-a23-rsb";
 			reg = <0x07083000 0x400>;
 			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&r_ccu 13>;
+			clocks = <&r_ccu CLK_R_APB2_RSB>;
 			clock-frequency = <3000000>;
-			resets = <&r_ccu 7>;
+			resets = <&r_ccu RST_R_APB2_RSB>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&r_rsb_pins>;
 			status = "disabled";
-- 
2.30.1

