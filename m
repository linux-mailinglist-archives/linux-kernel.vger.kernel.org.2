Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C92C361ADF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 09:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238980AbhDPHwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 03:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238690AbhDPHwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 03:52:21 -0400
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA0BC061574;
        Fri, 16 Apr 2021 00:51:57 -0700 (PDT)
Received: from hatter.bewilderbeest.net (unknown [IPv6:2600:6c44:7f:ba20::7c6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id E4A4B72;
        Fri, 16 Apr 2021 00:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1618559516;
        bh=gtBYFQvU70xkjkpifpEydwzy9XaAEMFkL6adfGXPg28=;
        h=From:To:Cc:Subject:Date:From;
        b=l/rCgOR1d/8e5SiSClNjcrGxw1b3ZRW+8RbbwM7O975shSysOwFWVzXVMmbpFGAfG
         iU6Rjo4DQEtbe57u9qos1zR8RB+2y9SJOfNkKHtBaj5oL/e6irVPC+YNwZXUvY/e7B
         cHz6QgTb49XLVjxWlItYTOppxl/FsnEqZ7g1QHks=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Joel Stanley <joel@jms.id.au>
Cc:     openbmc@lists.ozlabs.org, Zev Weiss <zev@bewilderbeest.net>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: aspeed: update e3c246d4i vuart properties
Date:   Fri, 16 Apr 2021 02:51:13 -0500
Message-Id: <20210416075113.18047-1-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This device-tree was merged with a provisional vuart IRQ-polarity
property that was still under review and ended up taking a somewhat
different form.  This patch updates it to match the final form of the
new vuart properties, which additionally allow specifying the SIRQ
number and LPC address.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---

The relevant aspeed-vuart patches [0] have been merged into Greg KH's
tty-next tree, so I figure it's probably okay to proceed with the
corresponding dts adjustments now.

[0] https://lore.kernel.org/openbmc/20210412034712.16778-1-zev@bewilderbeest.net/

 arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts b/arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts
index dcab6e78dfa4..8be40c8283af 100644
--- a/arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts
@@ -4,6 +4,7 @@
 #include "aspeed-g5.dtsi"
 #include <dt-bindings/gpio/aspeed-gpio.h>
 #include <dt-bindings/i2c/i2c.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 
 /{
 	model = "ASRock E3C246D4I BMC";
@@ -73,7 +74,8 @@ &uart5 {
 
 &vuart {
 	status = "okay";
-	aspeed,sirq-active-high;
+	aspeed,lpc-io-reg = <0x2f8>;
+	aspeed,lpc-interrupts = <3 IRQ_TYPE_LEVEL_HIGH>;
 };
 
 &mac0 {
-- 
2.31.1

