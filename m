Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B059533ADA9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 09:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbhCOIfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 04:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbhCOIfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 04:35:05 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B1FC061762
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 01:35:04 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id e9so5222696wrw.10
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 01:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9BPZS3vnao73K9jUsX/fpglGU+kHtpTMPEIGEWnyDz8=;
        b=J9uOWfrfMEKrcqh0mxGSAXwSVI+6IRtLA1Ee9SL2Yecz8KhM/QA7z4AG6nM2dd1b8s
         r8iSEl10nAm1w/8dGrFgSHg7wUYfnjQeQfagGirxlXqcfHWA3SLFA7jVaPUrvYWHwOSg
         6ZGSXcnKLDYIbnq0O92AdA5vGTqNH8J9Uj2+odsqoHvXc/PxBtSlG1BFqSVLe+mhSeHK
         KN7FeDUw2u0m/VDRT8dxah0TPqHBRGpH4ttZqpBp/w5EKYppPWKgURQr2ElSU3f8AdM3
         E7RCTGE/tN+CMx+ArF6vzrjdmIk6cYtEQyYoj5jU5iyfyrGL5tKwH3ucPi2F6nANiaKR
         rlxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9BPZS3vnao73K9jUsX/fpglGU+kHtpTMPEIGEWnyDz8=;
        b=nGxogOhUHnexdF8Fl2i6T1GJed9tChjxDbMxYH260MuAxIGC5A1suCYurUoKOGPdJ2
         NI8/McsqDWqf5PquZk44fQJWMew9j1H1C+KqwRVUHyI/yvewDhsDMXy4C+1EJQd/7mx/
         aN6an9OqtsXaXlMzA2NzYD7P44cSfosPAy9L+kVhH8icI34bKuJ+iQJEqjEr9kW5b/ZT
         l2WFuZyijL3N/iKzUvqajJDqistDU3Czig19xYBACpJdiMiowPVQBS7WLIGea8focqp4
         WSW5NQ4GwJpM5TcV2o6H6/tfKl9u5JaDO6VRuW5snGICb3UgZ9UTOrvQFoC7rsgEYAOH
         3nTA==
X-Gm-Message-State: AOAM533yhLs4mXo2xDUgcWejALJwsK0JfEx+HgTMzQ1oNvHCW8hal4nd
        HNuSUYGm0rBGAGO+Nb4G42rc9g==
X-Google-Smtp-Source: ABdhPJyQqwyuDSuV0WHwVd7Shb+AlqgYBqd5R3uq6WnrB0yfoRjomq0j8TJhFdUjMTF9iMgreMZTXg==
X-Received: by 2002:adf:f0c1:: with SMTP id x1mr25674841wro.7.1615797303277;
        Mon, 15 Mar 2021 01:35:03 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:90c:e290:708f:15aa:638c:22b7])
        by smtp.gmail.com with ESMTPSA id o2sm8372028wmc.23.2021.03.15.01.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 01:35:02 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     gregkh@linuxfoundation.org
Cc:     devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 3/3] arm64: dts: meson: set 128bytes FIFO size on uart A
Date:   Mon, 15 Mar 2021 09:34:59 +0100
Message-Id: <20210315083459.359773-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210315083459.359773-1-narmstrong@baylibre.com>
References: <20210315083459.359773-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first UART controller in "Everything-Else" power domain, usually used
for Bluetooth HCI has 128bytes FIFO depth.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi        | 1 +
 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi | 1 +
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi         | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index d945c84ab697..571383c12855 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -1872,6 +1872,7 @@ uart_A: serial@24000 {
 				status = "disabled";
 				clocks = <&xtal>, <&clkc CLKID_UART0>, <&xtal>;
 				clock-names = "xtal", "pclk", "baud";
+				amlogic,uart-fifosize = <128>;
 			};
 		};
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
index b858c5e43cc8..9e898479f118 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
@@ -2311,6 +2311,7 @@ uart_A: serial@24000 {
 				clocks = <&xtal>, <&clkc CLKID_UART0>, <&xtal>;
 				clock-names = "xtal", "pclk", "baud";
 				status = "disabled";
+				amlogic,uart-fifosize = <128>;
 			};
 		};
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index 0edd137151f8..bd0b049787fd 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -295,6 +295,7 @@ uart_A: serial@84c0 {
 				reg = <0x0 0x84c0 0x0 0x18>;
 				interrupts = <GIC_SPI 26 IRQ_TYPE_EDGE_RISING>;
 				status = "disabled";
+				amlogic,uart-fifosize = <128>;
 			};
 
 			uart_B: serial@84dc {
-- 
2.25.1

