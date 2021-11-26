Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A596245EFD6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 15:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377697AbhKZO3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 09:29:30 -0500
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:36563 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350913AbhKZO13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 09:27:29 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 64F11FF80D;
        Fri, 26 Nov 2021 14:24:14 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     bcousson@baylibre.com, Tony Lindgren <tony@atomide.com>
Cc:     Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        linux-omap@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        <linux-kernel@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [RESEND v6 1/3] ARM: dts: am437x-cm-t43: Use a correctly spelled DT property
Date:   Fri, 26 Nov 2021 15:24:11 +0100
Message-Id: <20211126142413.354770-2-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211126142413.354770-1-miquel.raynal@bootlin.com>
References: <20211126142413.354770-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Back in 2014 a property got misspelled "ti,coordiante-readouts" instead
of "ti,coordinate-readouts".

The year after it got fixed but both are still supported, although this
is not a reason to continue using this old deprecated property.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/am437x-cm-t43.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am437x-cm-t43.dts b/arch/arm/boot/dts/am437x-cm-t43.dts
index 5ce8e684e7d3..3e3354780db8 100644
--- a/arch/arm/boot/dts/am437x-cm-t43.dts
+++ b/arch/arm/boot/dts/am437x-cm-t43.dts
@@ -399,7 +399,7 @@ &tscadc {
 	tsc {
 		ti,wires = <4>;
 		ti,x-plate-resistance = <200>;
-		ti,coordiante-readouts = <5>;
+		ti,coordinate-readouts = <5>;
 		ti,wire-config = <0x00 0x11 0x22 0x33>;
 	};
 
-- 
2.27.0

