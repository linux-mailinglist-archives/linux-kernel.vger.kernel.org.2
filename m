Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0A22412617
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 20:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386030AbhITSxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 14:53:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:38250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1385894AbhITSwh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 14:52:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B4B0361264;
        Mon, 20 Sep 2021 17:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632160613;
        bh=WosCvV1JmUK5ETxM63LC5LHc9UhJvmkbOb6SQ9HQRCY=;
        h=From:To:Cc:Subject:Date:From;
        b=Lp3JnVDw1ie0nEvoc6RjCG3ZSX8FmUH9p/imspF1stYQX8HxyIHinKZctWOAswonx
         YiM07jJiuAEwguX0rlonIvqyGRHPjDwOndVZZ7GA6aq3+fkEOHHieDzUOYXoUBpNEf
         T+aujHdp+VYjuxI3pQpw/An5IEAywA9OqGsLow3R/bkqbovuQSNxSrI5FtFZXzTJpx
         U3h8J9HwRn5dnGsmHq2ptSIbJv4zsPc73BnIvELmPDZae6+E1VQnlj/MI9940LHJ8V
         QiHAv+gxwpM4r3bNTYUzeTaB3tSOcJwBR+CrSBLYAp5t8Vj6tHyizdMwUGE1HR52JP
         Bw1bCeX2qSEyQ==
Received: by wens.tw (Postfix, from userid 1000)
        id 73B285FC6F; Tue, 21 Sep 2021 01:56:51 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Chen-Yu Tsai <wens@csie.org>, Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: nanopi4: decrease Bluetooth UART baud rate
Date:   Tue, 21 Sep 2021 01:56:46 +0800
Message-Id: <20210920175647.13008-1-wens@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

The RK3399 does not seem to be able to properly generate the required
64 MHz clock for the UART to operate at 4MBd.

Drop the baud rate down to 3MBd, which can be used as the clock
controller is able to produce a 48 MHz clock.

Fixes: 3e2f0bb72be3 ("arm64: dts: rockchip: Add nanopi4 bluetooth")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
index 8c0ff6c96e03..45ff053b119d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
@@ -699,7 +699,7 @@ bluetooth {
 		device-wakeup-gpios = <&gpio2 RK_PD2 GPIO_ACTIVE_HIGH>;
 		host-wakeup-gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_HIGH>;
 		shutdown-gpios = <&gpio0 RK_PB1 GPIO_ACTIVE_HIGH>;
-		max-speed = <4000000>;
+		max-speed = <3000000>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&bt_reg_on_h &bt_host_wake_l &bt_wake_l>;
 		vbat-supply = <&vcc3v3_sys>;
-- 
2.30.2

