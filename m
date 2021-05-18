Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1485B3873AF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 09:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347401AbhERIAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 04:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347366AbhERIAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 04:00:07 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614BCC061760
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 00:58:47 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id i17so9062804wrq.11
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 00:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UVZto4g6Wsxu+4WPtlJ/ny9aJEsfvT/s2hR41/jSqcM=;
        b=q/zVbBc8de/ZHaVlbkXtflSU9Y6r05ipflZJPEJMidMnL6VU4nk75xdR8qzzIyGvIk
         GPRztw2VRKTfvAPTWNBbUVxz1eZOAoPnhwthMU19UODq2two5XpYbaJoyRUJzDpfGyMo
         7b4DtMErwdRVN7HkifwHY8Lqg6dKGQdlZcQBkftjfCsY8Xqr1dSLa11uFelUy6eU1ew0
         g6yEy/U5syvHBNsLdJWV6gf06ICAqDUCtsrPbYouVwj9PuW5nrtabchPnhZxIx6Sq/Kh
         Gyw9T1lkBzA3/IDFB3lFrXiFqajKwsuq/HwsAf30PeGHdKvFg/s2BGDN51IT6D+QI2YP
         c3Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UVZto4g6Wsxu+4WPtlJ/ny9aJEsfvT/s2hR41/jSqcM=;
        b=GsLR1p0BODTgUrKTXoQaw4SgCqb3Y084RVR+7bVYq+4A8W+97PXZ3S9pzAC0aTaE3c
         Obbn7vnIxnUkGD0ddmZX3YwVEQFrIX/yalGCxU6unweEWy7AhU3U8ZYq27x/eEKLGQ+W
         pr/wE1lWa3NVuulDRib3SEFeyDx5rO2UgrSVQs7KOZJST2fOls5dLWchiBs1r83Dcvlt
         HBkED24oj0zoCPKuZmDbOGmjOBOHAHwNWUg7w6ZFrI5Ob+Oho+bIa89EJHG6cEp60Oyf
         9hvq4WZLZe8CF3hFszo2Pr4f+Vfdo1Il+5Rd/PCL6Oii7pNPBLLb+20ydjPe2H+8lfZH
         cWHg==
X-Gm-Message-State: AOAM53234VXwFA23/AXOkzeIWH/LvffO3cyqzQyQ174zgRkdJFBvITV4
        D72Q/JveuIDU+4mdKK90Maj24g==
X-Google-Smtp-Source: ABdhPJwIn4TUckWjyOGKmOz5dzsQpoXw/XnPgmeXj7aq688o9TKoq0ZTOggr/wiZltQtLTx5ttg/GQ==
X-Received: by 2002:a5d:40cd:: with SMTP id b13mr5180323wrq.356.1621324726026;
        Tue, 18 May 2021 00:58:46 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:90c:e290:842:2d82:a1ae:1a91])
        by smtp.gmail.com with ESMTPSA id v16sm735448wml.6.2021.05.18.00.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 00:58:45 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 3/3] arm64: dts: meson: set 128bytes FIFO size on uart A
Date:   Tue, 18 May 2021 09:58:33 +0200
Message-Id: <20210518075833.3736038-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210518075833.3736038-1-narmstrong@baylibre.com>
References: <20210518075833.3736038-1-narmstrong@baylibre.com>
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
index 895c43c7af9f..3f5254eeb47b 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -1871,6 +1871,7 @@ uart_A: serial@24000 {
 				status = "disabled";
 				clocks = <&xtal>, <&clkc CLKID_UART0>, <&xtal>;
 				clock-names = "xtal", "pclk", "baud";
+				fifo-size = <128>;
 			};
 		};
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
index 793d48f72390..00c6f53290d4 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
@@ -2317,6 +2317,7 @@ uart_A: serial@24000 {
 				clocks = <&xtal>, <&clkc CLKID_UART0>, <&xtal>;
 				clock-names = "xtal", "pclk", "baud";
 				status = "disabled";
+				fifo-size = <128>;
 			};
 		};
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index 3d00404aae0f..6b457b2c30a4 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -301,6 +301,7 @@ uart_A: serial@84c0 {
 				reg = <0x0 0x84c0 0x0 0x18>;
 				interrupts = <GIC_SPI 26 IRQ_TYPE_EDGE_RISING>;
 				status = "disabled";
+				fifo-size = <128>;
 			};
 
 			uart_B: serial@84dc {
-- 
2.25.1

