Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89F89396FBF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 11:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233595AbhFAJDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 05:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233506AbhFAJDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 05:03:35 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7213CC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 02:01:53 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id l2so5950488wrw.6
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 02:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UHCQFBQhPzsG0CEaz0yeVlmPsGxszD+zPyDJnZSWUzU=;
        b=AqIMn9yHEuwVr2ZBVnbEs98mMuS9lRFi1IoNMU/OqM75U+SlAS1KDC1VuZBbAyaUVo
         sUdT2rJt1umJmcANWdjUkfevG0P43m91gzI3o+pwpf9n5MpAgZYkI1PUvI2Bh8V6V1VB
         g/ZuowGQmO110Wi7Sv43GFydJzWdk49VbTAsZabF1dPR0IKy4kts3ZGtHINhiZJFFK8j
         9QNsEYR5+DJxxy89ccxwFoRjcA5wAfIpjTfZbzn3nuxhOCYkjzUwfigfx/KwqgfrIkQB
         TkadOsbtF1jH3LAziq93w3gG9yhEqkvgh5d5kKE/ZnlVvaRlcs7A/8+XR+i0pA3H8/wA
         k0PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UHCQFBQhPzsG0CEaz0yeVlmPsGxszD+zPyDJnZSWUzU=;
        b=mONk8hCy5p6maZGwEiQr2utZNc37dBydPFnT7D28mIXG9niBqIsJwuF/Mww9pBM3bR
         w1OYHzsHd++21Uc2RAT9vYUqm2kk2opTUKzj7P7d+l5CR/SBvktvypK+oJ9VPBcUMeSF
         Zl+b6u/KoajkV7fHz/AIYvVnIQDB6au7QeomAVbTbHEG4G6UueJKZ9LRbHGHIrdWA8RE
         D5XMdx/yYnAlU2JKQ04Tts6lO/TsebNbj3dALqkoGZ/z8Cd0ebOpZTIzegse1toSAfaI
         Ttb/rDznND6aaEPM9swYUP/h1RssmVJkrTA5amK2gKP5o0SmuiTFUBduZtjS+FJGAn2E
         JWNg==
X-Gm-Message-State: AOAM532tR4RCCHLAfxceYrb1cVB3NuiF5tARlixtEsSfhZ+vMrzWQVNs
        e8h0lMoVnO4iDjiGPxUVpDkJ7w==
X-Google-Smtp-Source: ABdhPJzvIQebSNhoRt02RhludXujwexK7xW5RN0kUkeQ46rqmWXK+XEQICKQXdtppbGrD7k+CaDAUA==
X-Received: by 2002:adf:d1e3:: with SMTP id g3mr26324279wrd.21.1622538111949;
        Tue, 01 Jun 2021 02:01:51 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:90c:e290:a3a:d001:6a80:207a])
        by smtp.gmail.com with ESMTPSA id e17sm2668199wre.79.2021.06.01.02.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 02:01:51 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tobetter@gmail.com, Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 5/6] arm64: dts: meson-sm1-odroid-hc4: add regulators controlled by GPIOH_8
Date:   Tue,  1 Jun 2021 11:01:39 +0200
Message-Id: <20210601090140.261768-6-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210601090140.261768-1-narmstrong@baylibre.com>
References: <20210601090140.261768-1-narmstrong@baylibre.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1713; h=from:subject; bh=sSgXAcLCZAuhm54ZUZ6B4N280tFMWl0vaDNAR/nWRyw=; b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBgtfc8Vbr2sDac/s+JTxxGHeDjlM2n08Puv6+y7xTy 6jap8PiJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCYLX3PAAKCRB33NvayMhJ0UQtD/ wLbwAP0eI6j4rtkrOzyfsrLx8Vz1/+wP64GaK8WGSO2mUi9iFWwrzgj0+oBdViiIm2Yjo1jY+5U8r1 ylhvE83B8p9t/keDyYlF5xkganfVyLmkCXO+ppSqNEKnbdnw21+pzjr2KxXbRTDleHjJoUNTsmLrNZ aRXG4QpLQM2penC8CrOuqDwOSjWcyVenExlQyyXRndm/vUNo3jBUbwoZq+HLSXjbRwZX3tL83Af2hk wBssARI03BO2BBcfaMYj6pPcW3gjFAt7CaL4tkfk8YSqKJP7uC5jHXplVjaYYo77wdd5DFuaxr/zSM dT2AA9WnyPJbq3DSHXdNhK6Bxet4RnhnbVTVuLUgUcc7CMoC2s5HyvC7WN8YJGHRlT6v0Yvq+hJbJD Hi7qQJQhIDmm8Xsjy/Z7Rezmr5HWITaWojRE8iV89CBk+s6l3tVw/G8rzyclhk61qn/bAF2ZWzY0i1 yiunXR5I4w2o+jV0qcGgdiU/q5vHlvlHjOMlxwrbOodB6HVSxepCoTSf0NMqearMjCCc31fRJNvWRw r/6W6CeB/OE0ut4yu66x0AcpzRljfnvYjVMsWud8RON+577jUHOSKKMNfLFPGSYTcVTu5vC8C3DfYH TFRqpjIfEQsBFRK+B+NDoFWs3OgETo2b6fhzcXWqF4xP4AKZp7Feq1rK2E5A==
X-Developer-Key: i=narmstrong@baylibre.com; a=openpgp; fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As described in the HC4 schematics, GPIOH_8 controls the USB 5V and 12V
regulators used to power the SATA drives.

And is set as Open Drain since this GPIO doesn't support Push-Pull.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../boot/dts/amlogic/meson-sm1-odroid-hc4.dts | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-hc4.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-hc4.dts
index 0a34b658f994..d36c25b5b690 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-hc4.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-hc4.dts
@@ -44,6 +44,32 @@ led-red {
 		};
 	};
 
+	/* Powers the SATA Disk 0 regulator, which is enabled when a disk load is detected */
+	p12v_0: regulator-p12v_0 {
+		compatible = "regulator-fixed";
+		regulator-name = "P12V_0";
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+		vin-supply = <&main_12v>;
+
+		gpio = <&gpio GPIOH_8 GPIO_OPEN_DRAIN>;
+		enable-active-high;
+		regulator-always-on;
+	};
+
+	/* Powers the SATA Disk 1 regulator, which is enabled when a disk load is detected */
+	p12v_1: regulator-p12v_1 {
+		compatible = "regulator-fixed";
+		regulator-name = "P12V_1";
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+		vin-supply = <&main_12v>;
+
+		gpio = <&gpio GPIOH_8 GPIO_OPEN_DRAIN>;
+		enable-active-high;
+		regulator-always-on;
+	};
+
 	sound {
 		model = "ODROID-HC4";
 	};
@@ -98,3 +124,8 @@ &usb {
 &usb2_phy0 {
 	status = "disabled";
 };
+
+&vcc_5v {
+	gpio = <&gpio GPIOH_8 GPIO_OPEN_DRAIN>;
+	enable-active-high;
+};
-- 
2.25.1

