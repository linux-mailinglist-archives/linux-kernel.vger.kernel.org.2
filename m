Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1B6396FBE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 11:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233586AbhFAJDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 05:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233360AbhFAJDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 05:03:34 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C37C061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 02:01:49 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id l18-20020a1c79120000b0290181c444b2d0so1425055wme.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 02:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EDi2mw6WIsOG9a2qhW6Yl1ooRjSzYn5fhSnlTxTnEKk=;
        b=L1bePSihMHTzgesRU+wOrg4LnzZm+Y8hnaNfY37fI2E8QemwtowmMVZQHaH3NBa8hd
         ZfpDirz7yNc4eJJ+Fi6Thw2q00k4xizx7nQS4OETwvntWQ2Bt1fUT7m2Zq8UCIR52V3O
         IymmuT0bvj2PQfAVmii/pphvrHdbV+zq/ADfu5unvwpNGLF3X0APCWAtJ2fHH7w1F2B4
         1X4Q1Pvs8oFPfXjlnUkN39SO32F4ZSJv2BWBEy1mfPPh00Fo82WddJj3XiKglcjLFNQK
         +8W+ejmPWtWaQFdx12jeIMPlj0Ja+H3qAfAylb2DmlfvZ3twgWJjWEI+if7vEwBGOJ2P
         rxsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EDi2mw6WIsOG9a2qhW6Yl1ooRjSzYn5fhSnlTxTnEKk=;
        b=WXBxAfR2nPSdKbLfW+GIJjVe6UlOEpf+qgBIv2Aj2I1jMAZqE5IYwyyMcTw0bUM/Qj
         TIubWs1PaWB2HTnIwX/4Eb4TgN/H47XtxXgB/TbN0vleXimXtBn9yc/8DcjBnYWHLgKt
         Sc9vZgJlY4ICs1zXTIzgVU+AW9aSv3Lcj2g//ygWsiiIf2RSaZ2DoeSqXWhOrYxY8Mg6
         DV7fJ4efn1YteCvCljwv9w9QSti+6rREIaRJFX+KTY/Uhw6KUw1CT5aVLOG8y9A+opjh
         ptH97hVokRPJKeMZLVSAJMl150Z/CgDNYfMkaUBJtClEdR/xbEvY+sjVZBJlMIZCE5Yf
         3+/g==
X-Gm-Message-State: AOAM533dVq1fpsPq9sOlUohQJMbxWuLXD2G70girsOTb+6Q2BRgncpQx
        Pj/7+5kBpQKQpPVfpNZPevuL3A==
X-Google-Smtp-Source: ABdhPJx4wmLMtfAJcffUQTp7OFN7GQ7uCm4sseVIhGjWnrFYutod890o3lGcfZLNDgyJJASw/yIjKw==
X-Received: by 2002:a05:600c:4f8b:: with SMTP id n11mr25617158wmq.180.1622538107692;
        Tue, 01 Jun 2021 02:01:47 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:90c:e290:a3a:d001:6a80:207a])
        by smtp.gmail.com with ESMTPSA id e17sm2668199wre.79.2021.06.01.02.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 02:01:47 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tobetter@gmail.com, Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 1/6] arm64: dts: meson-sm1-odroid: add missing enable gpio and supply for tf_io regulator
Date:   Tue,  1 Jun 2021 11:01:35 +0200
Message-Id: <20210601090140.261768-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210601090140.261768-1-narmstrong@baylibre.com>
References: <20210601090140.261768-1-narmstrong@baylibre.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1044; h=from:subject; bh=RVG2YgfB1rqHQ1RBvlzfyjp6vgCQYnivHRfs0+IydqI=; b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBgtfc7TAEbzF4Q36frgpZgT0AJbdPxo50OtIppfKwp waTgzUeJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCYLX3OwAKCRB33NvayMhJ0RAGEA DE4xDEZfXa8r3NcvgA66pyh/SHC+2iK+5ZDsBmC+YLj1JTQHZD6IdR15P2tp82uD3PWZ6S0Mwq1ObR 3ro/yvYlZliQH53njyVzo5lOE6VRZdroEYcjY1kGqpRUk+Oh0vKBgcy3IQPH+kRYjsQVVwKyQAaHjX ZC4dVSi+g9Opk2TbJEd/5Xsao8uYZQL2NDr5GH/zvsCOxuHyXAkulzOTD1dcDnwc0cT6dPQvYSUKed O0kNvWKc9e4dHo4qj4ylobG/VKR9Y3KngHeHSEApXzQX4t+VhkCSSjcQEwxgjQ0gHlHrNXBxu/JDNK BNZgIOcG9ZAbQwp3OeG9bk5WqhRXHFYXnH74nKG0dLt3qafp7ZW3yK5J0MrqyN8ygLGR7YaSmYfA22 QnmASvCyqySiyEej+Iba0GgZgmqTGpZWhC9PqEdquM1Q/RGtp/oZNIx5FTvHtXoCITisVvuVcf/yGQ RWNRutSSxvlOxIcWR1gRdNot/rWACVhYXOmjcvzCxbYvSujTFuNVidICtNVZhcVSy3MKE1CI3BvdZ9 jScU4AFirjl0DytHS/ieO1oP3R8QPSryXMaeArTuf9lp851vFJ4o4VgzEe040B0oV9I0psAA+APz// /ghEmndZiq3zV/rdiVi7AYRvOIaM95sGme9246el5n9+u0lO8kRZS4+DQk2Q==
X-Developer-Key: i=narmstrong@baylibre.com; a=openpgp; fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As described in the schematics of Odroid-C4 and Odroid-HC4, the TF_IO regulator
is enabled by the GPIOE_2 GPIO and gets it's supply from VCC_5V.

Fixes: 88d537bc92ca ("arm64: dts: meson: convert meson-sm1-odroid-c4 to dtsi")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
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

