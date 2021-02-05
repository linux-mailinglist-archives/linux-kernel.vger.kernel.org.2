Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D32C5310C4F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 14:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbhBEN5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 08:57:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:56302 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231576AbhBENyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 08:54:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 61D30ACAC;
        Fri,  5 Feb 2021 13:52:59 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     f.fainelli@gmail.com, Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Cc:     phil@raspberrypi.com, wahrenst@gmx.net,
        linux-kernel@vger.kernel.org
Subject: [RFC/PATCH 03/11] ARM: dts: bcm2711: Use proper compatible in PM/Watchdog node
Date:   Fri,  5 Feb 2021 14:52:39 +0100
Message-Id: <20210205135249.2924-4-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210205135249.2924-1-nsaenzjulienne@suse.de>
References: <20210205135249.2924-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A new compatible string was introduced specifically for BCM2711, so make
use of it.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 arch/arm/boot/dts/bcm2711.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm2711.dtsi b/arch/arm/boot/dts/bcm2711.dtsi
index 462b1dfb0385..537498a93a3a 100644
--- a/arch/arm/boot/dts/bcm2711.dtsi
+++ b/arch/arm/boot/dts/bcm2711.dtsi
@@ -107,7 +107,7 @@ dma: dma@7e007000 {
 		};
 
 		pm: watchdog@7e100000 {
-			compatible = "brcm,bcm2835-pm", "brcm,bcm2835-pm-wdt";
+			compatible = "brcm,bcm2711-pm", "brcm,bcm2835-pm-wdt";
 			#power-domain-cells = <1>;
 			#reset-cells = <1>;
 			reg = <0x7e100000 0x114>,
-- 
2.30.0

