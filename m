Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA32C3F2957
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 11:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236293AbhHTJjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 05:39:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:59210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237044AbhHTJjL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 05:39:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CC53F61051;
        Fri, 20 Aug 2021 09:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629452314;
        bh=lPtSAKvsIv3CyhlGu314fV64cL92G+LiHUK3PEAndog=;
        h=From:To:Cc:Subject:Date:From;
        b=gyzGEWmuUtMKH5zlfftIytM00J3wtakAddraI+rGbH+jgPr8wISss5tRm3n3q8OUj
         EKSHUCb1wIqO0/yCN/Rlp2Qrn6R14XCheAm6AR4Nx8r82FThJwiXQ2+3vDCFUBN4KU
         5wXJ22ZJ+PXEF0IViBrAWis5rRk6MkARwhIXcTNKpINF13sZWsH9n91I4XN3ObzNHX
         wknVIpXb1CA/JW/WMBlYSwwiEPUjQ7/l5J4fMJ/KeAISEfOu12PvN8X7pepDOuZilq
         Pf/0WTTDnyG6+pRB4TGTdl1s2x2e14vvcczH33e/0HA3aTXDDU6AMSuuPAf6nFrTMz
         5xHSOnNPW7Xwg==
From:   Roger Quadros <rogerq@kernel.org>
To:     nsekhar@ti.com
Cc:     bgolaszewski@baylibre.com, nm@ti.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roger Quadros <rogerq@kernel.org>
Subject: [PATCH] ARM: dts: da850-evm: Change aemif node status from "ok" to "okay"
Date:   Fri, 20 Aug 2021 12:37:44 +0300
Message-Id: <20210820093744.4877-1-rogerq@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per Device Tree core schema, status parameter of nodes can be either
"okay" or "disabled".

U-boot Driver Model does not recognize status="ok" either and treats
the node as disabled.

[1] https://github.com/devicetree-org/dt-schema/blob/master/schemas/dt-core.yaml#L36

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
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

