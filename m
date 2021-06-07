Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2370C39D571
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 08:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbhFGG5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 02:57:41 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:45692 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhFGG5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 02:57:40 -0400
Received: by mail-wr1-f52.google.com with SMTP id z8so16215208wrp.12
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jun 2021 23:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YnYvPcoGmh1x+bRXjFzR3j6yadbIjw2NQdavqi41Frw=;
        b=0ve2iPV/GEXdppG/8w2iFruZBCsCl5LkhTyocMD93Gm44seqkqnZUi3XqZTSw77HRL
         wzDKXDW61KXe6tsvOj6HlNj3+aWXPfqtIKS8aZPiz/DtRWf+zGTuJxN+h+dI4KXMQe1B
         LG+TDydwTkBD8QaHIEW3JOOT6t6R1gobcT4rrfJtIyWPlTHcUxy22ROPHRZzXgbAaxr5
         RWI+RVdd/OYZgkIjmBEamnnDjhYbnTsux3Pp+dItrhWwljuaLdw+h/KIEGh3aIdcRAh3
         Jcc2/da06Nx0XY9gMl096+6otGaXrRa1aIanQnw2LJFYG0dBIYvkj5VRcLchH5Y4qj+o
         vKjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YnYvPcoGmh1x+bRXjFzR3j6yadbIjw2NQdavqi41Frw=;
        b=Kxw074ZeEWG9sMAm4P50wDuZhjOJvKCDZ7dMRGziaqJPFRvaWTl+6lDkNZ6lhJ8Xd5
         jidJXV7GCCiAlzT97Jzp+M4LvEAuO7Vq58mhun+SsmxUNBUMM5kCjpWZEI9OPgFaaTt4
         DHGHUXjRWg1hczGlBdJ6MpAsuUsyjDe4/8Y3sZTypjAiMWTknSPG6VvxjnmYo+I49x5Q
         z1AvmVmtBRVE2e+R3rEW5WcJmyOTWjVMlVP5Fvo0D3a2ZO4jNDX1q4PomG1lEh8xsWEN
         UHVPLRNcdUMLY1YCSp1RG8n0SB/LAds4VQCczjt7e8UHxkLR1O+f/EvEs1WINFkZefiQ
         1uPA==
X-Gm-Message-State: AOAM530EfBdA2WiwbrXWJ/AsbpEiTAKovn92kxLou8JPd0oTi7wB9TYu
        Pf0SqUPV7QQtpBs0ljwqzcl6vA==
X-Google-Smtp-Source: ABdhPJxZ8GEWr9oR5HqAKmDh4IrHUjwqYcLbCYlZiWvVsE20rgffNmDmPCFLypSz7Faqz1C9gDcw6A==
X-Received: by 2002:a05:6000:1889:: with SMTP id a9mr3256505wri.288.1623048888828;
        Sun, 06 Jun 2021 23:54:48 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:90c:e290:7c1f:1c9f:555e:7398])
        by smtp.gmail.com with ESMTPSA id l5sm16145742wmi.46.2021.06.06.23.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jun 2021 23:54:48 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tobetter@gmail.com, Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 5/7] arm64: dts: meson-sm1-odroid-hc4: add regulators controlled by GPIOH_8
Date:   Mon,  7 Jun 2021 08:54:33 +0200
Message-Id: <20210607065435.577334-6-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210607065435.577334-1-narmstrong@baylibre.com>
References: <20210607065435.577334-1-narmstrong@baylibre.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1624; h=from:subject; bh=zKRtjcLOeeX9+hCk3h3mjBgv0kuOByy0JZuBpPeUfWw=; b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBgvcJAstNBuRgJ0A9ZYSycpVFUfXMLurRV3WRjfftU hls1Cl6JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCYL3CQAAKCRB33NvayMhJ0XfED/ 0ZA8MpWzNMpc1FTJJIORx9/fYkKAEUluxky5sfkNSsN/okqoQCyKj4ry5ZtZb5D91sP+lsClwUAYnL +/7GqJB2zHEmalLi/Gq96WcA6UKPHe9dbEdTBS/VoPnvGpYzvHeTd+X0tCJbSmBsgkGcKZW7AeJeYn hPZXsth5Wruxj04BoIkL38t8nOdtgYFsWhx8iNW+6YzaltCekCE4CniYEpj0ED+sZ3pPCRbBOm6FTt /dWBwH99B+X2FpVmmASmzK6HyKbREG1uSW3/XriIYI/776zzVDGblr4X0OAaaQCZ2myW/iGebl+1v8 Qzj0Ym1QvLCttFlTjEIru7eSwMDKDQj2xH0K5qFD1Drm/gAPAJmlvqfa4q6GGQH50STdm/GX77ZB24 4tERlcA59RowQB3NQW7Q9rM8pG+DOIWtGxp9niTlJXKZBmZH3nIyBFD2cmCJyuwtxjIWm5w7dIjBLz Y5QASl7nO3+W2uzkjStR9lVyj2MlY6bzJ22RgchQmIf6HaKfcfeNyn7ppe3f55eY3k2tnpEWJbPp5x gIC2MxpwDgnDvWQprbpcjW6/uBAbvV3Qjcus8NamdKw8eVKCHgcCtIW3UlxFGQEyzPPmzc1kt9FPTW xgvPw3mH4bpZnFixUW8KeHbkGQlWBts581Qx6K6uTwnesT1+Fzh6/kfD+qzw==
X-Developer-Key: i=narmstrong@baylibre.com; a=openpgp; fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As described in the HC4 schematics, GPIOH_8 controls the USB 5V and 12V
regulators used to power the SATA drives.

And is set as Open Drain since this GPIO doesn't support Push-Pull.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 .../boot/dts/amlogic/meson-sm1-odroid-hc4.dts | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-hc4.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-hc4.dts
index 0a34b658f994..fdad6b994c88 100644
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
-- 
2.25.1

