Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E727439D574
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 08:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbhFGG5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 02:57:55 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:34494 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbhFGG5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 02:57:50 -0400
Received: by mail-wm1-f42.google.com with SMTP id u5-20020a7bc0450000b02901480e40338bso6628395wmc.1
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jun 2021 23:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PRBWRym/hnnglzSwgB/BY82h6cifk9/yMhYsGBnagus=;
        b=hs7bqy59BYacx9nbeHjKBSMvHxv8/SkWzpVZrXwj3QCXqH0PvZ+h8WMZRSKQfXXE6g
         Dy7dyqK/NZMZc7tImJfCoHKDHiyX7tm39M4+FqvQ9xfsS/aZIhkHOsCIIIMT07bRWlIV
         tMPYTXX5PAjQhi/AWmZkvKunGjGoDpSjT6vAtmNSW9r7iBi6lqqTjUS5fD5aTifoyyLn
         KhFPby3Unm5QWDS+t0IWmbd4AMMEPBFEPmdR3uXpvOv95zp+KkyLLUeanmnEmdxidHst
         rpAVNxGontxQCXwiAnPev5d4TueHP11uNMmwfQITORIZz/r8XDQAwImanVtS2FldYhPP
         IbYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PRBWRym/hnnglzSwgB/BY82h6cifk9/yMhYsGBnagus=;
        b=YaD6nAybwQ8MOPlThN1oYV39R04Mwr9ywV2GNCJ2DW7sYpnWFH4wZ7izyPfhehISNx
         k5dR2QT91rheLSj+g1uOdD0HWmkxY6R5PkjnHIPMQM+K2fKSeylHOjSAsT7Nn7t1OBYv
         LX0+G3KqZexRwwdpYWDOEZKzpUxA3ogbj3VdEdt8tnL5drYQiI+Rx0TypAHTzMjXTkMV
         pB+QNfQwW/qvmH9fkCQSkHk37GDRlf/SXrDEjx91+f3tiPaCa4mvcQsx3HxtZy6zOwtC
         n6AWwrkEJ8HdOPEchr8t6SpZtVBP96dIzF5xdQYpsjbJ/1v65QOeGAGEru57HFRTP8hl
         pjAw==
X-Gm-Message-State: AOAM532nx9n24TYopCjHrDAzkiNsXUi6BUEH2ykLA6elyfqiu8NpZ10+
        g1Y19KzWK8Q/z8877wOp7lj5Hw==
X-Google-Smtp-Source: ABdhPJxH6gW7D5mGRHcZh6BVwLXgDOSyEe7VCtVkOl8jjX49ILsWUUjyQX5+rEEVFmMgz4tscVVXzw==
X-Received: by 2002:a05:600c:4fd0:: with SMTP id o16mr2121303wmq.50.1623048884506;
        Sun, 06 Jun 2021 23:54:44 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:90c:e290:7c1f:1c9f:555e:7398])
        by smtp.gmail.com with ESMTPSA id l5sm16145742wmi.46.2021.06.06.23.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jun 2021 23:54:44 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tobetter@gmail.com, Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 1/7] arm64: dts: meson-sm1-odroid: add missing enable gpio and supply for tf_io regulator
Date:   Mon,  7 Jun 2021 08:54:29 +0200
Message-Id: <20210607065435.577334-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210607065435.577334-1-narmstrong@baylibre.com>
References: <20210607065435.577334-1-narmstrong@baylibre.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1032; h=from:subject; bh=HiHya1PPCqlF98u6DQ39DcCvPVr0hE5hqFtXe3ngrAo=; b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBgvcJADW2KZD2C0vOutSfwcLNkDcCPiu3DweerRVTC YLhrV7KJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCYL3CQAAKCRB33NvayMhJ0ZKVEA CMpY5iWv4CxZ1dxMX5O8/iqjJCb1dAY1pbcFvWsasIZAedO5esJs2o7rk423+axPRzqAvwR/CmBiqW UiQMkkVodypV9fQtLtF078w2LkEj8XZgHl5UY5lnPEeNwU64CliI7Umdt68LmnvmLzz52aM0spIE5o +IJEFtA8MY4zFr869qL09a6kLVZxwyxd56JHk5lDknBq8dXnzAi70tK0UjYzXCxeGVIHrJmx04c04q +IqMpY70+jaaV6op5SQbP5xWA6s7L9p3Me5rAbLfMNRCX5uw0douYISgT/xR4l0IrA8zEbCvdmnS0z C6bEI/9XYcwhF7dkSaEa61m+Cd3Hw9MzbEOelSeUJMeRtzIEy/6VLdu6IAqMbkXvfx8K+xi5YhRIWc texbeYQgPv3omrLnTnsRRzGTKOma7f7R0hyJnv/83HvJEEgOWa1sBU8kGk4fvJGQJmMPkNohvNpXsP p+hfTUmN1BEvWaC3wgUurUJlM7gHtHxubpD5wU2+MvxFp+e8wwuwdVWW0bGW3G56jCoiH9xdi5/tdO qqiTL4Ki1Y8yoasIphY7BXuAJCBhYPUjhjCANrDvc2WNDM37PTGiIBywbz4V+mo+OhdubjLa613vPk WNCYaH23w4MCV70JPYDkT6mVZMH2B6SJJp3WY/FA2vdgfLWM11pbaIdUKHmg==
X-Developer-Key: i=narmstrong@baylibre.com; a=openpgp; fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As described in the schematics of Odroid-C4 and Odroid-HC4, the TF_IO regulator
is enabled by the GPIOE_2 GPIO and gets it's supply from VCC_5V.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi
index d14716b3d0f1..af40ba461074 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi
@@ -46,6 +46,11 @@ tf_io: gpio-regulator-tf_io {
 		regulator-name = "TF_IO";
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc_5v>;
+
+		enable-gpio = <&gpio GPIOE_2 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-always-on;
 
 		gpios = <&gpio_ao GPIOAO_6 GPIO_ACTIVE_HIGH>;
 		gpios-states = <0>;
-- 
2.25.1

