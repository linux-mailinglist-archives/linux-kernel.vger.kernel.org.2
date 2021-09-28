Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D87E141B762
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 21:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242475AbhI1TTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 15:19:42 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:36852 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242253AbhI1TTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 15:19:41 -0400
Received: by mail-ot1-f41.google.com with SMTP id 5-20020a9d0685000000b0054706d7b8e5so30317522otx.3;
        Tue, 28 Sep 2021 12:18:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FGfb3wNIfOCvmVvUEtza99Pxtm2G7AAUDFzuVFG1vBY=;
        b=teMUyRBbjm6biy5OolopaigsRtSO1NXkFIpsikkdj3Ik45b1K36SYwGiWrBNqHNQvC
         96dkZ34TR5O0GKQ9GPNDIl9CQkiFaNrz2Rb+C0h7RrwW1X2cytLClXrY5JrMMcrnEpnN
         VgrvDPoCwakcAaB7fkVlHpqiCVCGJ1EJVg+Rk+O2Z0dLL+k3DsHJhi2ljUjnA+6U+YKt
         5L2stbAw2C/EDn/ZeWUof82Lz46qA5j6lxyA4cjSF6fEMeGoVtStBwpuf1p9LccQNCc2
         /+ptirztuKRZlduXb5c4d1tqXCdDK2hVYwswZOwZAw3hfRyzpRDwSPwESl20DETs0uMV
         bRAg==
X-Gm-Message-State: AOAM5333wJN9sxtoWdYsLy4rqEEXUSo0kMm/QeiRpMRVDjzgfELxMHqg
        uTHctsFqQ29WdC2zGJj3hQ==
X-Google-Smtp-Source: ABdhPJwZ2qdHFmb9xziUfmKxbd0kH8eT14FkHX3cqv8C02YFKKr5DDEzH5oC2S++RPwV5NbkgX7Mjg==
X-Received: by 2002:a9d:3e09:: with SMTP id a9mr6709268otd.22.1632856681405;
        Tue, 28 Sep 2021 12:18:01 -0700 (PDT)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id e2sm4980582ooh.40.2021.09.28.12.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 12:18:00 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: gemini: Consolidate PCI interrupt-map properties
Date:   Tue, 28 Sep 2021 14:17:59 -0500
Message-Id: <20210928191759.1835325-1-robh@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Gemini PCI 'interrupt-map' does not vary by board, so let's move
the definition to a common location. This avoids having incomplete
interrupt properties (i.e. #interrupt-cells without interrupt-map).

Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/boot/dts/gemini-dlink-dir-685.dts | 18 ------------------
 arch/arm/boot/dts/gemini-sl93512r.dts      | 18 ------------------
 arch/arm/boot/dts/gemini-sq201.dts         | 18 ------------------
 arch/arm/boot/dts/gemini-wbd111.dts        | 18 ------------------
 arch/arm/boot/dts/gemini-wbd222.dts        | 18 ------------------
 arch/arm/boot/dts/gemini.dtsi              | 21 ++++++++++++++++++++-
 6 files changed, 20 insertions(+), 91 deletions(-)

diff --git a/arch/arm/boot/dts/gemini-dlink-dir-685.dts b/arch/arm/boot/dts/gemini-dlink-dir-685.dts
index c79a2a02dd6b..396149664297 100644
--- a/arch/arm/boot/dts/gemini-dlink-dir-685.dts
+++ b/arch/arm/boot/dts/gemini-dlink-dir-685.dts
@@ -439,24 +439,6 @@ gpio1: gpio@4e000000 {
 
 		pci@50000000 {
 			status = "okay";
-			interrupt-map-mask = <0xf800 0 0 7>;
-			interrupt-map =
-				<0x4800 0 0 1 &pci_intc 0>, /* Slot 9 */
-				<0x4800 0 0 2 &pci_intc 1>,
-				<0x4800 0 0 3 &pci_intc 2>,
-				<0x4800 0 0 4 &pci_intc 3>,
-				<0x5000 0 0 1 &pci_intc 1>, /* Slot 10 */
-				<0x5000 0 0 2 &pci_intc 2>,
-				<0x5000 0 0 3 &pci_intc 3>,
-				<0x5000 0 0 4 &pci_intc 0>,
-				<0x5800 0 0 1 &pci_intc 2>, /* Slot 11 */
-				<0x5800 0 0 2 &pci_intc 3>,
-				<0x5800 0 0 3 &pci_intc 0>,
-				<0x5800 0 0 4 &pci_intc 1>,
-				<0x6000 0 0 1 &pci_intc 3>, /* Slot 12 */
-				<0x6000 0 0 2 &pci_intc 0>,
-				<0x6000 0 0 3 &pci_intc 1>,
-				<0x6000 0 0 4 &pci_intc 2>;
 		};
 
 		ethernet@60000000 {
diff --git a/arch/arm/boot/dts/gemini-sl93512r.dts b/arch/arm/boot/dts/gemini-sl93512r.dts
index c78e55fd2562..91c19e8ebfe8 100644
--- a/arch/arm/boot/dts/gemini-sl93512r.dts
+++ b/arch/arm/boot/dts/gemini-sl93512r.dts
@@ -256,24 +256,6 @@ gpio1: gpio@4e000000 {
 
 		pci@50000000 {
 			status = "okay";
-			interrupt-map-mask = <0xf800 0 0 7>;
-			interrupt-map =
-				<0x4800 0 0 1 &pci_intc 0>, /* Slot 9 */
-				<0x4800 0 0 2 &pci_intc 1>,
-				<0x4800 0 0 3 &pci_intc 2>,
-				<0x4800 0 0 4 &pci_intc 3>,
-				<0x5000 0 0 1 &pci_intc 1>, /* Slot 10 */
-				<0x5000 0 0 2 &pci_intc 2>,
-				<0x5000 0 0 3 &pci_intc 3>,
-				<0x5000 0 0 4 &pci_intc 0>,
-				<0x5800 0 0 1 &pci_intc 2>, /* Slot 11 */
-				<0x5800 0 0 2 &pci_intc 3>,
-				<0x5800 0 0 3 &pci_intc 0>,
-				<0x5800 0 0 4 &pci_intc 1>,
-				<0x6000 0 0 1 &pci_intc 3>, /* Slot 12 */
-				<0x6000 0 0 2 &pci_intc 0>,
-				<0x6000 0 0 3 &pci_intc 1>,
-				<0x6000 0 0 4 &pci_intc 2>;
 		};
 
 		ethernet@60000000 {
diff --git a/arch/arm/boot/dts/gemini-sq201.dts b/arch/arm/boot/dts/gemini-sq201.dts
index 1b64cc80b55a..d0efd76695da 100644
--- a/arch/arm/boot/dts/gemini-sq201.dts
+++ b/arch/arm/boot/dts/gemini-sq201.dts
@@ -252,24 +252,6 @@ gpio1: gpio@4e000000 {
 
 		pci@50000000 {
 			status = "okay";
-			interrupt-map-mask = <0xf800 0 0 7>;
-			interrupt-map =
-				<0x4800 0 0 1 &pci_intc 0>, /* Slot 9 */
-				<0x4800 0 0 2 &pci_intc 1>,
-				<0x4800 0 0 3 &pci_intc 2>,
-				<0x4800 0 0 4 &pci_intc 3>,
-				<0x5000 0 0 1 &pci_intc 1>, /* Slot 10 */
-				<0x5000 0 0 2 &pci_intc 2>,
-				<0x5000 0 0 3 &pci_intc 3>,
-				<0x5000 0 0 4 &pci_intc 0>,
-				<0x5800 0 0 1 &pci_intc 2>, /* Slot 11 */
-				<0x5800 0 0 2 &pci_intc 3>,
-				<0x5800 0 0 3 &pci_intc 0>,
-				<0x5800 0 0 4 &pci_intc 1>,
-				<0x6000 0 0 1 &pci_intc 3>, /* Slot 12 */
-				<0x6000 0 0 2 &pci_intc 0>,
-				<0x6000 0 0 3 &pci_intc 1>,
-				<0x6000 0 0 4 &pci_intc 2>;
 		};
 
 		ethernet@60000000 {
diff --git a/arch/arm/boot/dts/gemini-wbd111.dts b/arch/arm/boot/dts/gemini-wbd111.dts
index 5602ba8f30f2..de3c4416b0fb 100644
--- a/arch/arm/boot/dts/gemini-wbd111.dts
+++ b/arch/arm/boot/dts/gemini-wbd111.dts
@@ -140,24 +140,6 @@ gpio0: gpio@4d000000 {
 
 		pci@50000000 {
 			status = "okay";
-			interrupt-map-mask = <0xf800 0 0 7>;
-			interrupt-map =
-				<0x4800 0 0 1 &pci_intc 0>, /* Slot 9 */
-				<0x4800 0 0 2 &pci_intc 1>,
-				<0x4800 0 0 3 &pci_intc 2>,
-				<0x4800 0 0 4 &pci_intc 3>,
-				<0x5000 0 0 1 &pci_intc 1>, /* Slot 10 */
-				<0x5000 0 0 2 &pci_intc 2>,
-				<0x5000 0 0 3 &pci_intc 3>,
-				<0x5000 0 0 4 &pci_intc 0>,
-				<0x5800 0 0 1 &pci_intc 2>, /* Slot 11 */
-				<0x5800 0 0 2 &pci_intc 3>,
-				<0x5800 0 0 3 &pci_intc 0>,
-				<0x5800 0 0 4 &pci_intc 1>,
-				<0x6000 0 0 1 &pci_intc 3>, /* Slot 12 */
-				<0x6000 0 0 2 &pci_intc 0>,
-				<0x6000 0 0 3 &pci_intc 1>,
-				<0x6000 0 0 4 &pci_intc 2>;
 		};
 
 		ethernet@60000000 {
diff --git a/arch/arm/boot/dts/gemini-wbd222.dts b/arch/arm/boot/dts/gemini-wbd222.dts
index a4a260c36d75..e5ceaadbcc1a 100644
--- a/arch/arm/boot/dts/gemini-wbd222.dts
+++ b/arch/arm/boot/dts/gemini-wbd222.dts
@@ -151,24 +151,6 @@ gpio0: gpio@4d000000 {
 
 		pci@50000000 {
 			status = "okay";
-			interrupt-map-mask = <0xf800 0 0 7>;
-			interrupt-map =
-				<0x4800 0 0 1 &pci_intc 0>, /* Slot 9 */
-				<0x4800 0 0 2 &pci_intc 1>,
-				<0x4800 0 0 3 &pci_intc 2>,
-				<0x4800 0 0 4 &pci_intc 3>,
-				<0x5000 0 0 1 &pci_intc 1>, /* Slot 10 */
-				<0x5000 0 0 2 &pci_intc 2>,
-				<0x5000 0 0 3 &pci_intc 3>,
-				<0x5000 0 0 4 &pci_intc 0>,
-				<0x5800 0 0 1 &pci_intc 2>, /* Slot 11 */
-				<0x5800 0 0 2 &pci_intc 3>,
-				<0x5800 0 0 3 &pci_intc 0>,
-				<0x5800 0 0 4 &pci_intc 1>,
-				<0x6000 0 0 1 &pci_intc 3>, /* Slot 12 */
-				<0x6000 0 0 2 &pci_intc 0>,
-				<0x6000 0 0 3 &pci_intc 1>,
-				<0x6000 0 0 4 &pci_intc 2>;
 		};
 
 		ethernet@60000000 {
diff --git a/arch/arm/boot/dts/gemini.dtsi b/arch/arm/boot/dts/gemini.dtsi
index cc053af3c347..03623ef6474e 100644
--- a/arch/arm/boot/dts/gemini.dtsi
+++ b/arch/arm/boot/dts/gemini.dtsi
@@ -289,9 +289,28 @@ pci@50000000 {
 			device_type = "pci";
 			#address-cells = <3>;
 			#size-cells = <2>;
-			#interrupt-cells = <1>;
 			status = "disabled";
 
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0xf800 0 0 7>;
+			interrupt-map =
+				<0x4800 0 0 1 &pci_intc 0>, /* Slot 9 */
+				<0x4800 0 0 2 &pci_intc 1>,
+				<0x4800 0 0 3 &pci_intc 2>,
+				<0x4800 0 0 4 &pci_intc 3>,
+				<0x5000 0 0 1 &pci_intc 1>, /* Slot 10 */
+				<0x5000 0 0 2 &pci_intc 2>,
+				<0x5000 0 0 3 &pci_intc 3>,
+				<0x5000 0 0 4 &pci_intc 0>,
+				<0x5800 0 0 1 &pci_intc 2>, /* Slot 11 */
+				<0x5800 0 0 2 &pci_intc 3>,
+				<0x5800 0 0 3 &pci_intc 0>,
+				<0x5800 0 0 4 &pci_intc 1>,
+				<0x6000 0 0 1 &pci_intc 3>, /* Slot 12 */
+				<0x6000 0 0 2 &pci_intc 0>,
+				<0x6000 0 0 3 &pci_intc 1>,
+				<0x6000 0 0 4 &pci_intc 2>;
+
 			bus-range = <0x00 0xff>;
 			/* PCI ranges mappings */
 			ranges =
-- 
2.30.2

