Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17365349561
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 16:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbhCYPYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 11:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbhCYPYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 11:24:22 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A228C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 08:24:22 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id v11so2682419wro.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 08:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NsI7RWhSeaDJo4VSjykxLGXfOxolxJjq3ZnK3Jkyy1k=;
        b=wg48UBTKMFHtUsOUEBOoTrvtZYz6a3QXdnHmLSpUuHMydZTb3UBEpFcnTrMzTCb0bZ
         Cwu7hOdMFXIt+943OFA69HNpTugWpZ1cl+XH198G47qpAgPttKHALISWRAKLNGl5gr6h
         OmJx/BOsU4f+qB6o0MJwD1KvkFtRYgcuZG1MavtR2QMwf8XZaOpTNIkHFR2lcWMXawFl
         L2pnpn8j1yvUJuhRZmRvV4sGM+2gq3/snDOoTJPOL1VhBW6IFI8+SZgU/fSeA7AqALO3
         vE+nJmBAoqPtZ+vzmdl0kRkn1ZJcgL1lV+Y67Bry6lt209brXzVempIeHq1uzdk6Kmmp
         Y00Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NsI7RWhSeaDJo4VSjykxLGXfOxolxJjq3ZnK3Jkyy1k=;
        b=iiQy/xgP8sMfVNBvmrgdiqARxodj3MtQJvcl341ikt++m8abYlKju89RmchKJgZ6iP
         yY2W7UzHl9BnEyQjP3/pBlKJcFGME3PaWTIIe8QhVyUa6rtA/ItYXyqftVHsGG13/Fnt
         XPNdQXieIUhS8mYVgL60BwiSTsa3ZNhhCyoa8e5Y7P+fBVQicpYSLUsJwUgiiD8k1jhb
         5qGlK1uHJ0aUp3Quesp/Gimjcs7mn5fxuKDtdlPpzsjPXr6tMp/LjRUEtEshDUylxZiF
         En21kc5l1yuXMUIylg5TIsStCPIndxWVJIp1wKNsZY4rIue3MRHNk+IlWQ9rK+VYkWEQ
         PyfQ==
X-Gm-Message-State: AOAM532Hl4P5n6Wlg9pRWotoAPV8HEE+qOKBUJlGmTfKGokq1wlR+KxJ
        lertul3u1nyZXdJzPCgGE9q4DkAY3GflCwLj
X-Google-Smtp-Source: ABdhPJwubghLvEPh98CkBt+hC8/x7JIyFel31g5ZYSlGAhAgzRMes6kB7jwOtfcBrtlFpS6NQjHi2w==
X-Received: by 2002:a5d:538d:: with SMTP id d13mr9719471wrv.92.1616685860592;
        Thu, 25 Mar 2021 08:24:20 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:90c:e290:b105:9672:b0a:5820])
        by smtp.gmail.com with ESMTPSA id p18sm7395260wrs.68.2021.03.25.08.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 08:24:20 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     gregkh@linuxfoundation.org
Cc:     devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 3/3] arm64: dts: meson: set 128bytes FIFO size on uart A
Date:   Thu, 25 Mar 2021 16:24:10 +0100
Message-Id: <20210325152410.1795557-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210325152410.1795557-1-narmstrong@baylibre.com>
References: <20210325152410.1795557-1-narmstrong@baylibre.com>
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
index d945c84ab697..db3dae932a08 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -1872,6 +1872,7 @@ uart_A: serial@24000 {
 				status = "disabled";
 				clocks = <&xtal>, <&clkc CLKID_UART0>, <&xtal>;
 				clock-names = "xtal", "pclk", "baud";
+				fifo-size = <128>;
 			};
 		};
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
index b858c5e43cc8..4f5b85ad3120 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
@@ -2311,6 +2311,7 @@ uart_A: serial@24000 {
 				clocks = <&xtal>, <&clkc CLKID_UART0>, <&xtal>;
 				clock-names = "xtal", "pclk", "baud";
 				status = "disabled";
+				fifo-size = <128>;
 			};
 		};
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index 0edd137151f8..8eae0b7d1642 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -295,6 +295,7 @@ uart_A: serial@84c0 {
 				reg = <0x0 0x84c0 0x0 0x18>;
 				interrupts = <GIC_SPI 26 IRQ_TYPE_EDGE_RISING>;
 				status = "disabled";
+				fifo-size = <128>;
 			};
 
 			uart_B: serial@84dc {
-- 
2.25.1

