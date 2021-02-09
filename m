Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84A9A314FAE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 14:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbhBINCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 08:02:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:42046 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230259AbhBINBZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 08:01:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 95646AF7F;
        Tue,  9 Feb 2021 13:00:42 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     f.fainelli@gmail.com, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
Cc:     linux-rpi-kernel@lists.infradead.org, phil@raspberrypi.com,
        wahrenst@gmx.net, linux-arm-kernel@lists.infradead.org,
        mripard@kernel.org, eric@anholt.net, devicetree@vger.kernel.org
Subject: [RFC/PATCH v2 04/16] ARM: dts: bcm2835/bcm2711: Introduce reg-names in watchdog node
Date:   Tue,  9 Feb 2021 13:59:00 +0100
Message-Id: <20210209125912.3398-5-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210209125912.3398-1-nsaenzjulienne@suse.de>
References: <20210209125912.3398-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bcm2835-pm's bindings now support explicitly setting 'reg-names,' so use
them.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 arch/arm/boot/dts/bcm2711.dtsi        | 1 +
 arch/arm/boot/dts/bcm2835-common.dtsi | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/bcm2711.dtsi b/arch/arm/boot/dts/bcm2711.dtsi
index 462b1dfb0385..4033818f6a26 100644
--- a/arch/arm/boot/dts/bcm2711.dtsi
+++ b/arch/arm/boot/dts/bcm2711.dtsi
@@ -113,6 +113,7 @@ pm: watchdog@7e100000 {
 			reg = <0x7e100000 0x114>,
 			      <0x7e00a000 0x24>,
 			      <0x7ec11000 0x20>;
+			reg-names = "pm", "rpivid_asb", "argon_asb";
 			clocks = <&clocks BCM2835_CLOCK_V3D>,
 				 <&clocks BCM2835_CLOCK_PERI_IMAGE>,
 				 <&clocks BCM2835_CLOCK_H264>,
diff --git a/arch/arm/boot/dts/bcm2835-common.dtsi b/arch/arm/boot/dts/bcm2835-common.dtsi
index 4119271c979d..8d5f3b59ed35 100644
--- a/arch/arm/boot/dts/bcm2835-common.dtsi
+++ b/arch/arm/boot/dts/bcm2835-common.dtsi
@@ -62,6 +62,7 @@ pm: watchdog@7e100000 {
 			#reset-cells = <1>;
 			reg = <0x7e100000 0x114>,
 			      <0x7e00a000 0x24>;
+			reg-names = "pm", "rpivid_asb";
 			clocks = <&clocks BCM2835_CLOCK_V3D>,
 				 <&clocks BCM2835_CLOCK_PERI_IMAGE>,
 				 <&clocks BCM2835_CLOCK_H264>,
-- 
2.30.0

