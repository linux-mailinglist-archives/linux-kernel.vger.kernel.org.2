Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 058A441B778
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 21:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242503AbhI1TXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 15:23:06 -0400
Received: from mail-oo1-f48.google.com ([209.85.161.48]:44939 "EHLO
        mail-oo1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240589AbhI1TXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 15:23:05 -0400
Received: by mail-oo1-f48.google.com with SMTP id e16-20020a4ad250000000b002b5e1f1bc78so966270oos.11;
        Tue, 28 Sep 2021 12:21:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Asy4VBtwoQjm7KWp2ea2JXZi3+cF+fkgyojD8dhlf4w=;
        b=uXp3j3fg1LjL/D6U/b0ia4JEROpGkbxkXvOGrH1Ua6DpkkoXpTcVy1Wp8yXDjMCwlf
         8LnvbX3Xf0xDi+Aq4/qAQxhcVfbBfDJVA+aE7hVI2RjhZ/skvmaZtoKGuhkLwKiDVZG2
         MeoUTbKq/307jeS+khuiEXs1sUTSiH5m/vffnO0muiBr77ZJx0I6vYPyYpZVr9AVXm3k
         fRNoggOPaCyQu7yaIO1asdSFOVL2+Ew0Vb0UVRy4n09KNJ5j0Y0BAeJ9dKgM0suFAImh
         KgDvlqVpucXSKoebDNds72PyGFI5klV+S4Q7pk0BUTMevc6UQVEshaS9X2dEErxXX4kE
         /GtQ==
X-Gm-Message-State: AOAM532Sch6xrvkbaDKWgJ/HpsMcsPrvz9i1UwqYk9bo/x7PMlgfvglo
        yKa9kslCkhOxsQ/3cAsyd2hKAc66yQ==
X-Google-Smtp-Source: ABdhPJxAOo9C7PjGi4X6abzDTZ2bycTY1ZxVrnPvLGJTBsxzEFTG4jo8q5HX05EZy89Ps1NPmMjzig==
X-Received: by 2002:a4a:9784:: with SMTP id w4mr6446941ooi.90.1632856885153;
        Tue, 28 Sep 2021 12:21:25 -0700 (PDT)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id n4sm4818394otr.59.2021.09.28.12.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 12:21:24 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: ixp4xx: Group PCI interrupt properties together
Date:   Tue, 28 Sep 2021 14:21:22 -0500
Message-Id: <20210928192123.1840842-1-robh@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the PCI 'interrupt-map-mask' and '#interrupt-cells' properties
alongside the 'interrupt-map' property in each board dts. This avoids
having incomplete set of interrupt properties which may fail validation.

Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/boot/dts/intel-ixp42x-adi-coyote.dts        | 2 ++
 arch/arm/boot/dts/intel-ixp42x-arcom-vulcan.dts      | 2 ++
 arch/arm/boot/dts/intel-ixp42x-dlink-dsm-g600.dts    | 2 ++
 arch/arm/boot/dts/intel-ixp42x-freecom-fsg-3.dts     | 2 ++
 arch/arm/boot/dts/intel-ixp42x-gateworks-gw2348.dts  | 2 ++
 arch/arm/boot/dts/intel-ixp42x-iomega-nas100d.dts    | 2 ++
 arch/arm/boot/dts/intel-ixp42x-ixdpg425.dts          | 2 ++
 arch/arm/boot/dts/intel-ixp42x-linksys-nslu2.dts     | 2 ++
 arch/arm/boot/dts/intel-ixp42x-linksys-wrv54g.dts    | 2 ++
 arch/arm/boot/dts/intel-ixp42x-netgear-wg302v2.dts   | 2 ++
 arch/arm/boot/dts/intel-ixp43x-gateworks-gw2358.dts  | 2 ++
 arch/arm/boot/dts/intel-ixp4xx-reference-design.dtsi | 2 ++
 arch/arm/boot/dts/intel-ixp4xx.dtsi                  | 2 --
 13 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/intel-ixp42x-adi-coyote.dts b/arch/arm/boot/dts/intel-ixp42x-adi-coyote.dts
index 44c017b78008..bd4230d7dac9 100644
--- a/arch/arm/boot/dts/intel-ixp42x-adi-coyote.dts
+++ b/arch/arm/boot/dts/intel-ixp42x-adi-coyote.dts
@@ -63,6 +63,8 @@ pci@c0000000 {
 			 * We have slots (IDSEL) 1 and 2 with one assigned IRQ
 			 * each handling all IRQs.
 			 */
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0xf800 0 0 7>;
 			interrupt-map =
 			/* IDSEL 1 */
 			<0x0800 0 0 1 &gpio0 6 IRQ_TYPE_LEVEL_LOW>, /* INT A on slot 1 is irq 6 */
diff --git a/arch/arm/boot/dts/intel-ixp42x-arcom-vulcan.dts b/arch/arm/boot/dts/intel-ixp42x-arcom-vulcan.dts
index 7200126cb3b5..92b987bc3f99 100644
--- a/arch/arm/boot/dts/intel-ixp42x-arcom-vulcan.dts
+++ b/arch/arm/boot/dts/intel-ixp42x-arcom-vulcan.dts
@@ -120,6 +120,8 @@ pci@c0000000 {
 			 * We have 2 slots (IDSEL) 1 and 2 with one dedicated interrupt
 			 * per slot. This interrupt is shared (OR:ed) by all four pins.
 			 */
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0xf800 0 0 7>;
 			interrupt-map =
 			/* IDSEL 1 */
 			<0x0800 0 0 1 &gpio0 2 IRQ_TYPE_LEVEL_LOW>, /* INT A on slot 1 is irq 2 */
diff --git a/arch/arm/boot/dts/intel-ixp42x-dlink-dsm-g600.dts b/arch/arm/boot/dts/intel-ixp42x-dlink-dsm-g600.dts
index 8b32e9f22d81..5ab09fb10dae 100644
--- a/arch/arm/boot/dts/intel-ixp42x-dlink-dsm-g600.dts
+++ b/arch/arm/boot/dts/intel-ixp42x-dlink-dsm-g600.dts
@@ -129,6 +129,8 @@ pci@c0000000 {
 			 * We have slots (IDSEL) 1, 2, 3, 4 and pins 1, 2 and 3.
 			 * Only slot 3 have three IRQs.
 			 */
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0xf800 0 0 7>;
 			interrupt-map =
 			/* IDSEL 1 */
 			<0x0800 0 0 1 &gpio0 7  IRQ_TYPE_LEVEL_LOW>, /* INT E on slot 1 is irq 7 */
diff --git a/arch/arm/boot/dts/intel-ixp42x-freecom-fsg-3.dts b/arch/arm/boot/dts/intel-ixp42x-freecom-fsg-3.dts
index 77e78c6dc2cd..598586fc0862 100644
--- a/arch/arm/boot/dts/intel-ixp42x-freecom-fsg-3.dts
+++ b/arch/arm/boot/dts/intel-ixp42x-freecom-fsg-3.dts
@@ -106,6 +106,8 @@ pci@c0000000 {
 			 * Written based on the FSG-3 PCI boardfile.
 			 * We have slots 12, 13 & 14 (IDSEL) with one IRQ each.
 			 */
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0xf800 0 0 7>;
 			interrupt-map =
 			/* IDSEL 12 */
 			<0x6000 0 0 1 &gpio0 5 IRQ_TYPE_LEVEL_LOW>, /* INT A on slot 12 is irq 5 */
diff --git a/arch/arm/boot/dts/intel-ixp42x-gateworks-gw2348.dts b/arch/arm/boot/dts/intel-ixp42x-gateworks-gw2348.dts
index a20277ff0420..a5943f51e8c2 100644
--- a/arch/arm/boot/dts/intel-ixp42x-gateworks-gw2348.dts
+++ b/arch/arm/boot/dts/intel-ixp42x-gateworks-gw2348.dts
@@ -115,6 +115,8 @@ pci@c0000000 {
 			 *
 			 * We have up to 4 slots (IDSEL) with 4 swizzled IRQs.
 			 */
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0xf800 0 0 7>;
 			interrupt-map =
 			/* IDSEL 1 */
 			<0x0800 0 0 1 &gpio0 11 IRQ_TYPE_LEVEL_LOW>, /* INT A on slot 1 is irq 11 */
diff --git a/arch/arm/boot/dts/intel-ixp42x-iomega-nas100d.dts b/arch/arm/boot/dts/intel-ixp42x-iomega-nas100d.dts
index 8c18d802c849..cbc87b344f6a 100644
--- a/arch/arm/boot/dts/intel-ixp42x-iomega-nas100d.dts
+++ b/arch/arm/boot/dts/intel-ixp42x-iomega-nas100d.dts
@@ -115,6 +115,8 @@ pci@c0000000 {
 			 * Taken from NAS 100D PCI boardfile (nas100d-pci.c)
 			 * We have slots (IDSEL) 1, 2 and 3 and pins 1, 2 and 3.
 			 */
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0xf800 0 0 7>;
 			interrupt-map =
 			/* IDSEL 1 */
 			<0x0800 0 0 1 &gpio0 11 IRQ_TYPE_LEVEL_LOW>, /* INT A on slot 1 is irq 11 */
diff --git a/arch/arm/boot/dts/intel-ixp42x-ixdpg425.dts b/arch/arm/boot/dts/intel-ixp42x-ixdpg425.dts
index 002a8705abc9..f17cab12a64b 100644
--- a/arch/arm/boot/dts/intel-ixp42x-ixdpg425.dts
+++ b/arch/arm/boot/dts/intel-ixp42x-ixdpg425.dts
@@ -68,6 +68,8 @@ pci@c0000000 {
 			 * We have slots (IDSEL) 12, 13 and 14 with one assigned IRQ
 			 * for 12 & 13 and one for 14.
 			 */
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0xf800 0 0 7>;
 			interrupt-map =
 			/* IDSEL 12 */
 			<0x6000 0 0 1 &gpio0 7 IRQ_TYPE_LEVEL_LOW>, /* INT A on slot 12 is irq 7 */
diff --git a/arch/arm/boot/dts/intel-ixp42x-linksys-nslu2.dts b/arch/arm/boot/dts/intel-ixp42x-linksys-nslu2.dts
index e3a32b08d167..0edc5928e00b 100644
--- a/arch/arm/boot/dts/intel-ixp42x-linksys-nslu2.dts
+++ b/arch/arm/boot/dts/intel-ixp42x-linksys-nslu2.dts
@@ -122,6 +122,8 @@ pci@c0000000 {
 			 * Taken from NSLU2 PCI boardfile, INT A, B, C swizzled D constant
 			 * We have slots (IDSEL) 1, 2 and 3.
 			 */
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0xf800 0 0 7>;
 			interrupt-map =
 			/* IDSEL 1 */
 			<0x0800 0 0 1 &gpio0 11 IRQ_TYPE_LEVEL_LOW>, /* INT A on slot 1 is irq 11 */
diff --git a/arch/arm/boot/dts/intel-ixp42x-linksys-wrv54g.dts b/arch/arm/boot/dts/intel-ixp42x-linksys-wrv54g.dts
index 6b28dda747fd..5e7e31b74b04 100644
--- a/arch/arm/boot/dts/intel-ixp42x-linksys-wrv54g.dts
+++ b/arch/arm/boot/dts/intel-ixp42x-linksys-wrv54g.dts
@@ -123,6 +123,8 @@ pci@c0000000 {
 			 * We have up to 2 slots (IDSEL) with 2 swizzled IRQs.
 			 * Derived from the GTWX5715 PCI boardfile.
 			 */
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0xf800 0 0 7>;
 			interrupt-map =
 			/* IDSEL 0 */
 			<0x0000 0 0 1 &gpio0 10 IRQ_TYPE_LEVEL_LOW>, /* INT A on slot 0 is irq 10 */
diff --git a/arch/arm/boot/dts/intel-ixp42x-netgear-wg302v2.dts b/arch/arm/boot/dts/intel-ixp42x-netgear-wg302v2.dts
index 04a0f7138967..a57009436ed8 100644
--- a/arch/arm/boot/dts/intel-ixp42x-netgear-wg302v2.dts
+++ b/arch/arm/boot/dts/intel-ixp42x-netgear-wg302v2.dts
@@ -62,6 +62,8 @@ pci@c0000000 {
 			 * We have slots (IDSEL) 1 and 2 with one assigned IRQ
 			 * each handling all IRQs.
 			 */
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0xf800 0 0 7>;
 			interrupt-map =
 			/* IDSEL 1 */
 			<0x0800 0 0 1 &gpio0 8 IRQ_TYPE_LEVEL_LOW>, /* INT A on slot 1 is irq 8 */
diff --git a/arch/arm/boot/dts/intel-ixp43x-gateworks-gw2358.dts b/arch/arm/boot/dts/intel-ixp43x-gateworks-gw2358.dts
index 84e6aec8e665..cf4010d60187 100644
--- a/arch/arm/boot/dts/intel-ixp43x-gateworks-gw2358.dts
+++ b/arch/arm/boot/dts/intel-ixp43x-gateworks-gw2358.dts
@@ -131,6 +131,8 @@ pci@c0000000 {
 			 * have instead assumed that they are rotated (swizzled) like
 			 * this with 11, 10, 9, 8 for the 4 pins on IDSEL 1 etc.
 			 */
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0xf800 0 0 7>;
 			interrupt-map =
 			/* IDSEL 1 */
 			<0x0800 0 0 1 &gpio0 11 IRQ_TYPE_LEVEL_LOW>, /* INT A on slot 1 is irq 11 */
diff --git a/arch/arm/boot/dts/intel-ixp4xx-reference-design.dtsi b/arch/arm/boot/dts/intel-ixp4xx-reference-design.dtsi
index c1d9c49982b3..146352ba848b 100644
--- a/arch/arm/boot/dts/intel-ixp4xx-reference-design.dtsi
+++ b/arch/arm/boot/dts/intel-ixp4xx-reference-design.dtsi
@@ -106,6 +106,8 @@ pci@c0000000 {
 			 * PCI slots on the BIXMB425BD base card.
 			 * We have up to 4 slots (IDSEL) with 4 swizzled IRQs.
 			 */
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0xf800 0 0 7>;
 			interrupt-map =
 			/* IDSEL 1 */
 			<0x0800 0 0 1 &gpio0 11 IRQ_TYPE_LEVEL_LOW>, /* INT A on slot 1 is irq 11 */
diff --git a/arch/arm/boot/dts/intel-ixp4xx.dtsi b/arch/arm/boot/dts/intel-ixp4xx.dtsi
index e5af2d463074..46fede021476 100644
--- a/arch/arm/boot/dts/intel-ixp4xx.dtsi
+++ b/arch/arm/boot/dts/intel-ixp4xx.dtsi
@@ -78,8 +78,6 @@ pci@c0000000 {
 			dma-ranges =
 			<0x02000000 0 0x00000000 0x00000000 0 0x04000000>;
 
-			#interrupt-cells = <1>;
-			interrupt-map-mask = <0xf800 0 0 7>;
 			/* Each unique DTS using PCI must specify the swizzling */
 		};
 
-- 
2.30.2

