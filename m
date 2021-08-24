Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34F513F5C80
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 12:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236410AbhHXK4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 06:56:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:38544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236320AbhHXK4C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 06:56:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4487361163;
        Tue, 24 Aug 2021 10:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629802518;
        bh=NsgaVcjwqPVDQvxpxv1KlOmUMb96K7W1aN79AbgQurQ=;
        h=From:To:Cc:Subject:Date:From;
        b=eFG1rBLaoSsSNEEGcCNos4mgcK48yTXWELBhHC8qEjuppOLF5ZAKsHbk2TC5nCf4G
         lfHj9+2wPQq/4fkJ4DEJQX9DniW1B+2cjWyFFrCZ1zkSaodpFz/FX+/aYmMaiftUkT
         d7XWD7QCMiiQvZ0IbuwRe/UcipyRE7EMengwhq1QQE9yptUzKDcqwUol5/J5taM3Z6
         +f/ByQCwTzDCzxE3Q2EJYl5QWQAswUtuJUGGW0hj1RKKsm1sE1LYMyTL9wI6iTuzaK
         JdthOJ5m6smxkqAeCDNZotZMm/X4kxBt0XvomqXdKpGSbnwSQRu7pn/300h9RFvRKz
         bM/ywsTSOdm0A==
From:   Roger Quadros <rogerq@kernel.org>
To:     nsekhar@ti.com
Cc:     bgolaszewski@baylibre.com, nm@ti.com, lokeshvutla@ti.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v2] ARM: dts: da850-evm: Change aemif node status from "ok" to "okay"
Date:   Tue, 24 Aug 2021 13:55:12 +0300
Message-Id: <20210824105512.19242-1-rogerq@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per Device Tree Specification [1], the status parameter of nodes can
be "okay", "disabled", etc. "ok" is not a valid parameter.

U-boot Driver Model does not recognize status="ok" either and treats
the node as disabled.

[1] https://github.com/devicetree-org/devicetree-specification/releases/tag/v0.3

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
Changelog:
v2
-refer to DT spec instead of schema in commit log.

 arch/arm/boot/dts/da850-evm.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
index 87c517d65f62..9dc79b5977bf 100644
--- a/arch/arm/boot/dts/da850-evm.dts
+++ b/arch/arm/boot/dts/da850-evm.dts
@@ -415,7 +415,7 @@
 &aemif {
 	pinctrl-names = "default";
 	pinctrl-0 = <&nand_pins>;
-	status = "ok";
+	status = "okay";
 	cs3 {
 		#address-cells = <2>;
 		#size-cells = <1>;
-- 
2.17.1

