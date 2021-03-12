Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F344339080
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 15:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbhCLO4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 09:56:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:41738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232009AbhCLO4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 09:56:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5DAD464FF9;
        Fri, 12 Mar 2021 14:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615560977;
        bh=EeQot5X//FjuQTal9q/g0ToHWZJHUtbmbREqHYseiwU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BrglqvdGLnT4e90Qla4OmZ5HdXHMJnRu9g4LanqFOzGayG1/hP6Q5NMsG01EYLmMj
         2iZOI5992QrM3G442A7hefaSW9W+CwKGfgb+uDywhsw5K0eCAPuDHdb60wvEX0zY88
         z88hDXffg58KzrectbLRthOqKaZuYP3id8kolp7uDKDAkOBvfPQGmv24ztFw3UQDna
         Rn0HIlvXdqLj8eqBZJ0v3WlsJOQis13pTGcbqykGrZ2vF6jj/5E+TsCm/O3ymXWaEa
         Qn/gn/FNXQjsIo41XGh9NSmZjCRLR/O0zLfgHQ5AaB7JhG917elCjeWvP7KxHUc4MI
         edZ82S9Sr7yIg==
From:   matthias.bgg@kernel.org
To:     lee.jones@linaro.org, robh+dt@kernel.org, matthias.bgg@gmail.com,
        lgirdwood@gmail.com, broonie@kernel.org
Cc:     devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <mbrugger@suse.com>
Subject: [PATCH 6/7] arm64: dts: mt6358: Drop compatible for regulators
Date:   Fri, 12 Mar 2021 15:55:44 +0100
Message-Id: <20210312145545.26050-6-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210312145545.26050-1-matthias.bgg@kernel.org>
References: <20210312145545.26050-1-matthias.bgg@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Brugger <mbrugger@suse.com>

The regulator framework does not need compatible, it's actually
superfluous. Drop it from the DT.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
---
 arch/arm64/boot/dts/mediatek/mt6358.dtsi | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt6358.dtsi b/arch/arm64/boot/dts/mediatek/mt6358.dtsi
index fa159b20379e4..e423feac0bc2e 100644
--- a/arch/arm64/boot/dts/mediatek/mt6358.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt6358.dtsi
@@ -15,9 +15,7 @@ mt6358codec: mt6358codec {
 			compatible = "mediatek,mt6358-sound";
 		};
 
-		mt6358regulator: mt6358regulator {
-			compatible = "mediatek,mt6358-regulator";
-
+		mt6358regulator {
 			mt6358_vdram1_reg: buck_vdram1 {
 				regulator-name = "vdram1";
 				regulator-min-microvolt = <500000>;
-- 
2.30.1

