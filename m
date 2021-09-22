Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 560FB4153B9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 01:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238443AbhIVXGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 19:06:25 -0400
Received: from gloria.sntech.de ([185.11.138.130]:53528 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238293AbhIVXGG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 19:06:06 -0400
Received: from ip5f5a6e92.dynamic.kabel-deutschland.de ([95.90.110.146] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1mTBI2-0002xp-Q6; Thu, 23 Sep 2021 01:04:34 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-rockchip@lists.infradead.org
Cc:     heiko@sntech.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
Subject: [PATCH 3/3] arm64: dts: rockchip: add phandles to muxed i2c buses on rk3368-lion
Date:   Thu, 23 Sep 2021 01:04:29 +0200
Message-Id: <20210922230429.2162535-3-heiko@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210922230429.2162535-1-heiko@sntech.de>
References: <20210922230429.2162535-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>

Other DTS files that include the dtsi will want to to add children
to the i2c buses from the i2c-mus. Without a label they would have to
specify the full path.

Signed-off-by: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
[add phandles for first mux as well]
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm64/boot/dts/rockchip/rk3368-lion.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3368-lion.dtsi b/arch/arm64/boot/dts/rockchip/rk3368-lion.dtsi
index 8e82ca3f1c6f..5753e57fd716 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368-lion.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368-lion.dtsi
@@ -29,15 +29,15 @@ i2cmux1 {
 		i2c-parent = <&i2c1>;
 		mux-gpios = <&gpio1 RK_PA7 GPIO_ACTIVE_HIGH>;
 
-		/* Q7_GPO_I2C */
-		i2c@0 {
+		/* Q7_GP0_I2C */
+		i2c_gp0: i2c@0 {
 			reg = <0>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
 
 		/* Q7_SMB */
-		i2c@1 {
+		i2c_smb: i2c@1 {
 			reg = <1>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -52,7 +52,7 @@ i2cmux2 {
 		mux-gpios = <&gpio1 RK_PB4 GPIO_ACTIVE_HIGH>;
 
 		/* Q7_LVDS_BLC_I2C */
-		i2c@0 {
+		i2c_lvds_blc: i2c@0 {
 			reg = <0>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -69,8 +69,8 @@ rtc_twi: rtc@6f {
 			};
 		};
 
-		/* Q7_GP2_I2C */
-		i2c@1 {
+		/* Q7_GP2_I2C = LVDS_DID_CLK/DAT */
+		i2c_gp2: i2c@1 {
 			reg = <1>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
2.29.2

