Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05411333D26
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 13:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbhCJM6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 07:58:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232091AbhCJM6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 07:58:08 -0500
X-Greylist: delayed 1742 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 10 Mar 2021 04:58:08 PST
Received: from mx0.chaotikum.eu (mx0.chaotikum.eu [IPv6:2a01:4f8:c2c:ce71::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1470C061760
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 04:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=chaotikum.eu; s=20200128.mx0; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=e+FszExSm2+EMZkgFJP/qRDz5nqeWE3dpwvkv4Wthek=; b=A1cNwIUZ8DRlzFSjthkkM7Ehei
        yymARAEb8neNldWvZ2UaKfMoH5jj84yWw6Q7Al366sSQ/fVtoHB0HpD37ndpNQ97c6s34Qu+gOmth
        feBb6xPb2w7jgjzn6USQ+DnQ7eQsxINL06CxkXQgXCSjzm+Gkf7kyePBlpEUdzWUwLEtte5wZuZky
        0o2qZg5KmgI+xNOJhrH20cbw/gMsDtdkdcYhBzSBK8FrZeqagAfo0n3lw0QiZTAUiGtPUgsZMXsqU
        tMpu2goRZOlRBlw1kJoWFEycZgJeFEj87mFfq16PSWU94buhvX9e9p9QsGZAEgm2/Momvya01Ziy/
        pestF14YFrmLNKgn3WghMKA8Ln+9WoG9mCVuYfeyPPW5Iv+uPQXK6igc+0G78cMP9UAcskvruuYdP
        0RLwz7x8pVtMR9dMK1o9OxnKKjSUFtCegRWS6IqKhBg0kRBsbCZfcnsHoCgTyb0HY1gVhEakcFcqm
        VAIr198V8AgwQp2U6VeMPmxcnKObH1Y9lWvjZK+0pMS/KvJ7y19d0olAI5DdKaMYZ1cQjBFvhSD1U
        EI6hB5siSah85v3Tc6gVi8UbOBf7s5YLj5EG/uu2naIWbqE2jj4xPueDNcwflvNAeXB5yaVBc/Xy9
        mcx3Gqu3OWSk6MEaiOMgnNv0xcEBKfOwVBzlpGcMY=;
X-Spam-Action: no action
X-Spam-Bar: /
X-Spam-Report: Action: no action
 Symbol: ARC_NA(0.00)
 Symbol: RCVD_VIA_SMTP_AUTH(0.00)
 Symbol: FROM_HAS_DN(0.00)
 Symbol: TO_DN_SOME(0.00)
 Symbol: TO_MATCH_ENVRCPT_ALL(0.00)
 Symbol: MIME_GOOD(-0.10)
 Symbol: RCPT_COUNT_FIVE(0.00)
 Symbol: MID_CONTAINS_FROM(1.00)
 Symbol: RCVD_COUNT_ONE(0.00)
 Symbol: FROM_EQ_ENVFROM(0.00)
 Symbol: MIME_TRACE(0.00)
 Symbol: ASN(0.00)
 Symbol: RCVD_TLS_ALL(0.00)
 Message-ID: 20210310122821.126408-1-qsx@chaotikum.eu
X-Spam-Score: 0.9 (/)
Received: from [2001:4dd0:4f8e:0:801a:7487:7f8e:9f57] (port=45816 helo=neptun.chaotikum.eu)
        by mx0.chaotikum.eu with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <qsx@chaotikum.eu>)
        id 1lJxxV-0002RO-Nf; Wed, 10 Mar 2021 13:29:02 +0100
From:   Thomas Schneider <qsx@chaotikum.eu>
To:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org
Cc:     Thomas Schneider <qsx@chaotikum.eu>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: add infrared receiver node to rockpro64
Date:   Wed, 10 Mar 2021 13:28:21 +0100
Message-Id: <20210310122821.126408-1-qsx@chaotikum.eu>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the RockPro64’s infrared receiver to its dtsi.  The configuration is
almost the same as on rk3328-rock64, except for the GPIO pins, and thus adapted
from there.

Signed-off-by: Thomas Schneider <qsx@chaotikum.eu>
---
 arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
index 5ab0b9edfc88..d42c75c6dcbd 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
@@ -36,6 +36,13 @@ power {
 		};
 	};
 
+	ir-receiver {
+		compatible = "gpio-ir-receiver";
+		gpios = <&gpio0 RK_PA6 GPIO_ACTIVE_LOW>;
+		pinctrl-0 = <&ir_int>;
+		pinctrl-names = "default";
+	};
+
 	leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
@@ -604,6 +611,12 @@ fusb0_int: fusb0-int {
 		};
 	};
 
+	ir {
+		ir_int: ir-int {
+			rockchip,pins = <0 RK_PA6 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
 	leds {
 		work_led_pin: work-led-pin {
 			rockchip,pins = <0 RK_PB3 RK_FUNC_GPIO &pcfg_pull_none>;
-- 
2.30.1

