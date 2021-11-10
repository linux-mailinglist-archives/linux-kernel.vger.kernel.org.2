Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13B8944C8F3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 20:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbhKJT1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 14:27:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232718AbhKJT10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 14:27:26 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9057FC061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 11:24:38 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id o29so3167228wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 11:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hGC5vbTP7eVhWvQa6obMxUPyW7fE6TkeuAmRY62poPc=;
        b=o8YgN3Yr2RJVNTOVw0QWOGogKTBQMT4+qFJOEYABx2bj6SGGv63pxe/SJ4WVcCC3jn
         S05I4wPHD8+z79WW8vHnLfVOVCRrvtfEbM0/n3C7vWEAhsPrY0b4qbqwJixF8XZ6zP5U
         t9iCkujPvC/hTFn2vw7e85oBE8a126iesSSEPM7b21YMhn2y7EXSS5A7k/Lm4H6EI3VQ
         D9NTMrB8kCHJgzWX/9+4BDtAepVPqgHEJBSpZGf6y6io+5o3D1ucoHi3oeUB8Ko8aXpy
         AMIRhMvdNEHXMpDoABTqi5nFy1ORDwR4ZjebDc2S0fEpdHIvzVLWIaQEBZb8sdP2GT1u
         eSEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hGC5vbTP7eVhWvQa6obMxUPyW7fE6TkeuAmRY62poPc=;
        b=2JzSdjq5p/SJ3IvVL4DyI2yy/6pa8/iSxOoo4vG6RQXGjCbqwkQMWJlR6Wldq9blUb
         vF2Qo5qBuV7dShOPxv9j1ya75Ksh8MNmOMkIW8DubB8ydZW5q5T5G+1NaLVJWM59xq6h
         q14clxLC2OteWadOPt3s1Kx9TI550p7PEGhkF4r/464/Lm/QkXD0P4n/S1xzw5N9nfE4
         LqKszKvd9n914BCC7IrzD6ro9cocdokaazX2E2Pcr1CXHoHXy9b3gGGL087eMaUUTiRm
         zbZg6TJlBQDucqMgZkYtKqyj3b59Hym41ZxTp/TFqDf0KxwnoGnbghZ5331NbZ4xQI/6
         uGrg==
X-Gm-Message-State: AOAM530Qbza3G6cAjC6u6txdr8h0EmjssvThA1syfvBGOHf8tiWVu3X3
        FzTz6UwA6D2PmBHFUeSVR8M1MA==
X-Google-Smtp-Source: ABdhPJwaqqXQvPtpGCJMftdZKiPsBPV2gDWdi4b770EA4FIRU+mVpBnIMR/wI0wlnRlRhRDKVUbAUw==
X-Received: by 2002:a1c:3546:: with SMTP id c67mr1721206wma.43.1636572277143;
        Wed, 10 Nov 2021 11:24:37 -0800 (PST)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id d16sm6250113wmb.37.2021.11.10.11.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 11:24:36 -0800 (PST)
From:   Fabien Parent <fparent@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Fabien Parent <fparent@baylibre.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: mediatek: mt8183-pumpkin: add USB host support
Date:   Wed, 10 Nov 2021 20:24:17 +0100
Message-Id: <20211110192417.4177741-3-fparent@baylibre.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211110192417.4177741-1-fparent@baylibre.com>
References: <20211110192417.4177741-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MT8183 Pumpkin board provides USB host support through 2 type-A
ports. In addition the board provides Ethernet support
with the LAN9512 IP connected on the USB bus.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 .../boot/dts/mediatek/mt8183-pumpkin.dts      | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts b/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
index d5a6628e9c5b..541b382c0e81 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
@@ -434,6 +434,18 @@ pins_gpio {
 				 <PINMUX_GPIO28__FUNC_GPIO28>;
 		};
 	};
+
+	usb_pins: usb-pins {
+		pins_usb {
+			pinmux = <PINMUX_GPIO42__FUNC_GPIO42>;
+			output-low;
+		};
+
+		pins_hub_rst {
+			pinmux = <PINMUX_GPIO9__FUNC_GPIO9>;
+			output-low;
+		};
+	};
 };
 
 &mfg {
@@ -496,3 +508,17 @@ dpi_out: endpoint {
 		};
 	};
 };
+
+&ssusb {
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb_pins>;
+	maximum-speed = "high-speed";
+	dr_mode = "host";
+	vusb33-supply = <&mt6358_vusb_reg>;
+	status = "okay";
+};
+
+&usb_host {
+	vusb33-supply = <&mt6358_vusb_reg>;
+	status = "okay";
+};
-- 
2.33.1

