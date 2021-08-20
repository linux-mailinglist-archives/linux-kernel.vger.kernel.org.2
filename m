Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 804D33F2993
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 11:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237199AbhHTJyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 05:54:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:33796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238646AbhHTJy1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 05:54:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C0B0761075;
        Fri, 20 Aug 2021 09:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629453230;
        bh=YwVroQlCD3HpD8GroY9rflOTohiSOSTbQeX2JXJsH1o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GdUavER4oaQFGgBvYR1S13WNB2oTGGv8Q8QB4lS/+dwMXf4ZXn0FeZieizUvAcbxL
         hQZkaqq3UICI7J+x2du0nHSruVpbSvT7QmcWokHsVeFJhteapztbOcmbxodX+1DYBv
         tzDSER5qkoKyNRpiNjJzhVCjMAVCDccVVXie2FiajHRTjajlV/Imld69jCW6LqSVed
         W4eL7SlGiyuIyTcMz9dIv1s3WhLJJgxA6F+mLvWDdtxXyxsIu7y1zv4kUEmM86L6qR
         +R11c4gmCOOk8AWPLE9l17VbWJQFOonMeHYfjTbbVdODzKZnff7N4oqkHnmbQjnNqR
         EN4SoFamVv9Kw==
From:   Roger Quadros <rogerq@kernel.org>
To:     ssantosh@kernel.org
Cc:     nm@ti.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Roger Quadros <rogerq@kernel.org>
Subject: [PATCH 2/2] ARM: dts: keystone-k2g-evm: Fix dss node status to "okay"
Date:   Fri, 20 Aug 2021 12:53:41 +0300
Message-Id: <20210820095341.5619-3-rogerq@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210820095341.5619-1-rogerq@kernel.org>
References: <20210820095341.5619-1-rogerq@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per Device Tree core schema [1], status parameter of nodes can be either
"okay" or "disabled".

U-boot Driver Model does not recognize status="ok" either and treats
the node as disabled.

[1] https://github.com/devicetree-org/dt-schema/blob/master/schemas/dt-core.yaml#L36

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 arch/arm/boot/dts/keystone-k2g-evm.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/keystone-k2g-evm.dts b/arch/arm/boot/dts/keystone-k2g-evm.dts
index d800f26b6275..57680323e202 100644
--- a/arch/arm/boot/dts/keystone-k2g-evm.dts
+++ b/arch/arm/boot/dts/keystone-k2g-evm.dts
@@ -534,7 +534,7 @@
 &dss {
 	pinctrl-names = "default";
 	pinctrl-0 = <&vout_pins>;
-	status = "ok";
+	status = "okay";
 
 	port {
 		dpi_out: endpoint {
-- 
2.17.1

