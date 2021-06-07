Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7BC39D572
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 08:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbhFGG5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 02:57:51 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:37496 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhFGG5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 02:57:50 -0400
Received: by mail-wr1-f42.google.com with SMTP id i94so11205132wri.4
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jun 2021 23:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fIlB5c20gqFSN8miPlr6OBIolKCtK/FrKxK6KrMtZFc=;
        b=QmbOSoRyMsOmc1piiQDmIiHZ0GJEGbCUbdA92vpZzVkJttm2mb8PYz8Paj/6sCxss/
         eICnwBab8T3ChcLAOwp/QaOCFE1jntMgWirHRcYmrfuBOhiP6yNpuceDxCAGtE7btQdM
         RshRdLdAkc8CAopV6V0cOTZtSn/YWwJzi2wvpMTH8gM/TzeTmCruSwoQRCioUHgk7TE1
         5fRX/sDcGF0mtaOI6/KsGEnrt8+xNwbJ9bpWBi1HRAG9UPTg7QKysyassn4VJWfFRXLJ
         zmGdmUHgjynzZU3X6W5SoDVgpVAx4t9I4kFKvoZ4YBq2hJ1YCKJCAmsO5mBgV9xxoYPn
         B7KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fIlB5c20gqFSN8miPlr6OBIolKCtK/FrKxK6KrMtZFc=;
        b=nRlSy5fH6zy9eaSzlXXudGlOJSpiYkYh6QNsnm5O8rR69/cnZJk3jOteNC0meS0fSA
         JlXarYjVr5tX1K8s8wBA4M2SvHnGMebuELgIWTF4G5W2eeep7QM6PMW7zScYcCIxg3vP
         vHHLNROb1XZlKJum2M5A8FLzqerlgfqsiB5kecX95bVI5/5mgebu8BVRyYpJKVCp5ouZ
         AHtdjgAseqqcNnTIbji3vly+xxaDC7Rs9YYbn19HAdDCFT8RZX/XoOJkgmzb95EBkxMn
         0WfGXu9cj3wlXxKM5Ucs4L++FgC+3z2OqBpbQ3kajQxNW8za9/TxDYBxgDi9aKC4uEkp
         E8oA==
X-Gm-Message-State: AOAM533DUcbvXUXWuiPFN4LLTlh07kWrv2pZ3s8s2d3X0tOdjMPROv6Z
        NfVQGGXTEEJQaMV39gcABZ5R9Q==
X-Google-Smtp-Source: ABdhPJw6Ffv5UPslCEk2it78Gaw0CLg46uUpxiJ0GayCQTgvvU9NMm5NWtVE/xQiV1YXXAZpoJaOlA==
X-Received: by 2002:a5d:4dc4:: with SMTP id f4mr15534235wru.181.1623048889928;
        Sun, 06 Jun 2021 23:54:49 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:90c:e290:7c1f:1c9f:555e:7398])
        by smtp.gmail.com with ESMTPSA id l5sm16145742wmi.46.2021.06.06.23.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jun 2021 23:54:49 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tobetter@gmail.com, Christian Hewitt <christianshewitt@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 6/7] arm64: dts: meson-sm1-odroid-hc4: add spifc node to ODROID-HC4
Date:   Mon,  7 Jun 2021 08:54:34 +0200
Message-Id: <20210607065435.577334-7-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210607065435.577334-1-narmstrong@baylibre.com>
References: <20210607065435.577334-1-narmstrong@baylibre.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1065; i=narmstrong@baylibre.com;
 h=from:subject; bh=McuXd6E6+YhsD8miQqNEtHLBIPy7689EyQJs3nQPN4Y=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBgvcJBhmciZpnVSN2b7nGLZuLfoM10SKSggv5DmO7Z
 eAP0dyaJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCYL3CQQAKCRB33NvayMhJ0WRqEA
 CeO/zWIwy0I4ft5zgjMmsR7wZybM7ImCtnoyt/GZhBG22pICfV0g2kP7nQ5D5aWAjKx6DJlmIQjPRp
 DYsVh+3/nGJZxouATOo4n1sD4niPZRQXzLtSe/PvMr+I6ea+XrHy91aEO8H94R56AI/BoG/o5su6aS
 wsJ61GMyf5ww062B6K+4ENbiy5ffywV9be3v/JRY9HB3dxIHa2GDyROMShABwVopbr55y9PNBS3SiX
 Z3fFn34JUT1w1euSoEzpHogemXRiUUZFm6/+Q9VDHwXBTs83k8aYVaa8QFVDH5tsKEDcZwKQQcXXNQ
 r4F/Nwz3VZ7BKnftxaR1FJHSVdSvbrJXanSXlfnWmPCMvsTV8isNZXJPY8wGtvz+4jxrB7SUxWEFLs
 5HLrqG3nzFZ8sm026TN6vXQEFNxREfJ3rXO3Qc16MaCSaDuXg93zRGKwa14qLL4p+ty2GvA8/PdcEE
 1SXOzJiBhkarbKJ6x8oi4lK8z55Qy+bbJDdbtaaiKUrfKS2dS49A+0540SK9FlTZDkDhwkJdGTDs5z
 dKFCGkBRRgjcTkmkN6PSzBeAPO5CSSbe81np6jxovBUgpLXQxUqBKpuMbeQDmymtmTag1yj1Od6qjX
 l8igKM/NMS5MGOH/Xt7x7z9DhNwleFMFlH8mFhXHiSb5Ntz1K3L3z0Y9r21Q==
X-Developer-Key: i=narmstrong@baylibre.com; a=openpgp; fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Hewitt <christianshewitt@gmail.com>

Add a node for the XT25F128B SPI-NOR flash to make it accessible
from Linux.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 .../boot/dts/amlogic/meson-sm1-odroid-hc4.dts      | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-hc4.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-hc4.dts
index fdad6b994c88..f3f953225bf5 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-hc4.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-hc4.dts
@@ -116,6 +116,20 @@ &sd_emmc_c {
 	status = "disabled";
 };
 
+&spifc {
+	status = "okay";
+	pinctrl-0 = <&nor_pins>;
+	pinctrl-names = "default";
+
+	spi-flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <104000000>;
+	};
+};
+
 &usb {
 	phys = <&usb2_phy1>;
 	phy-names = "usb2-phy1";
-- 
2.25.1

