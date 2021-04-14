Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65DEC35F68B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 16:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351923AbhDNOrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 10:47:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:46248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351896AbhDNOrN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 10:47:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 07D2D61164;
        Wed, 14 Apr 2021 14:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618411611;
        bh=YLtyAFJeomBajzoh5PxbskaF/iR0wrKupgy2VNPOWTg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=megLohX3SKAY66HWnNTjxa6YAMzgksi/MPeucbEd+FPELgZMGaMk8nrQj0gmlVAY0
         fWdpMbIaj5EEsLFmWNX7B6Se1WBd7iSELBcqFqCLm9zrnfWsVh0h+Tck2i9CNnbXQr
         lWFf/0R1wmp04b8LVYUDEIEjDzsDNXhQ6G3ncqpcYBGwfw9cQAKxTGR1us2eh3BU8Q
         pB5IkkmaNz2ilMxv55IT9+kScVY/kdvTk5QXMGkPIr/D3f44i7mEPSmo4xl/ksXBic
         jiDy3EgMlHUk2kKul5DMK6YHbAgc5uUMET7ATH9Nts2o+KOL3bBfiRWbHz3vMZoSq0
         peSohydKJrk4w==
From:   matthias.bgg@kernel.org
To:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Fabien Parent <fparent@baylibre.com>
Cc:     linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] arm64: dts: mt8183: fix dtbs_check warning
Date:   Wed, 14 Apr 2021 16:46:41 +0200
Message-Id: <20210414144643.17435-2-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210414144643.17435-1-matthias.bgg@kernel.org>
References: <20210414144643.17435-1-matthias.bgg@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Brugger <matthias.bgg@gmail.com>

Fix unit names to make dtbs_check happy.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---

 arch/arm64/boot/dts/mediatek/mt8183.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index 0ff7b67a6806..c5e822b6b77a 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -681,13 +681,13 @@ cpu_thermal: cpu_thermal {
 				sustainable-power = <5000>;
 
 				trips {
-					threshold: trip-point@0 {
+					threshold: trip-point0 {
 						temperature = <68000>;
 						hysteresis = <2000>;
 						type = "passive";
 					};
 
-					target: trip-point@1 {
+					target: trip-point1 {
 						temperature = <80000>;
 						hysteresis = <2000>;
 						type = "passive";
@@ -1103,7 +1103,7 @@ u2port0: usb-phy@0 {
 				status = "okay";
 			};
 
-			u3port0: usb-phy@0700 {
+			u3port0: usb-phy@700 {
 				reg = <0x0700 0x900>;
 				clocks = <&clk26m>;
 				clock-names = "ref";
-- 
2.30.2

