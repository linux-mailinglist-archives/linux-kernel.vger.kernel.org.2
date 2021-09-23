Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D17A041666F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 22:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243109AbhIWUOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 16:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243059AbhIWUOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 16:14:34 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72BFC061757;
        Thu, 23 Sep 2021 13:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=LBxpQQCQ2q0k/Lx/uWtNrN2YoUaygdqdi6Befd2S/HI=; b=LlFpiziqPsNoxCv4dVcp0Ti1r2
        sIfcaq+xtJuXQ4Ji6KEe0jrkMy/YL9I1GSmm3E7uPnIbX8OjffiwM+RHUEMQA4fM2FoQbDGTXOYb8
        n62w2bTlY2EgKs7xv6a8BhYgXCMDFfNNHUgEeBIg4O2dn2SSCiaRGxkY/m4oyi/G8RgU=;
Received: from p200300ccff12c8001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff12:c800:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1mTV5X-00028p-2B; Thu, 23 Sep 2021 22:12:59 +0200
Received: from andi by aktux with local (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1mTV5W-00AYlE-L2; Thu, 23 Sep 2021 22:12:58 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH 1/5] ARM: dts: imx: e60k02: correct led node name
Date:   Thu, 23 Sep 2021 22:12:34 +0200
Message-Id: <20210923201238.2516844-2-andreas@kemnade.info>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210923201238.2516844-1-andreas@kemnade.info>
References: <20210923201238.2516844-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only led-X or led are allowed according to bindings definition.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 arch/arm/boot/dts/e60k02.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/e60k02.dtsi b/arch/arm/boot/dts/e60k02.dtsi
index cfb239d5186a..1a49f15f2df2 100644
--- a/arch/arm/boot/dts/e60k02.dtsi
+++ b/arch/arm/boot/dts/e60k02.dtsi
@@ -41,7 +41,7 @@ cover {
 	leds: leds {
 		compatible = "gpio-leds";
 
-		on {
+		led {
 			label = "e60k02:white:on";
 			gpios = <&gpio5 7 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "timer";
-- 
2.30.2

