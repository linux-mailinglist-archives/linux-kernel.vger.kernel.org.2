Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49856396FBD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 11:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233541AbhFAJDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 05:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233404AbhFAJDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 05:03:33 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1CBC061760
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 02:01:52 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id j14so13411055wrq.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 02:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M/EhBdL/mcwjthyCLjo7WM86qd4xvEeOPLsDx4c68dM=;
        b=brIgtgyXP5wH6/eJGW+yCKboXD+vUEy/oq8cVeFXz3/ICuFwChJgt1MD6QATwiWytj
         y8jK/aaF6VCfPE1jv8nN9X4CTB1cdDtehwv0Ug2TWFMfkY/ACJd4wunQNIw5DkrwlhHX
         8KXt2YOKyP6TWJyD+JdukwEOIawXI809cN21DeHtLQuIXPZC7JPQgrhHV58MzOy4mFvK
         B2tzlvTy1opf/ctFjWEBOwbSs+P/4YltrwwEWBJLJt1VcXaRkZtq8ZdCvVNJ1KbnsxTh
         HpqwXQDDGhQ1N6unhRwtPsMkiI8ZArx9kdFxzUFOsEmvvHjP+NkKD3uu6bnP21Pz22JW
         YRUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M/EhBdL/mcwjthyCLjo7WM86qd4xvEeOPLsDx4c68dM=;
        b=IfDOBUWBedaa7W/UqXe4hEs6iVAY21D9IK4t+masT1steCkD0rXjdExk82NsjnXEMW
         rK54xRYXeVa4nSXdnaMDkY6dG1mmpqDbmma8kGjk2MqD9Fkh7xLcoJez6aqUgyKWqFSG
         DPdUD4loprqn3VSpR/l5hVu6+NRmuoOjK/AbjEQS+JGB1jUykT/VB+bJr7s9q90c4i0C
         +9FZ3BSgjYubXeVZ9c6Zql1ntVe9aEZFAeHi0M8fFAxC0X+oOh2PrGmSQA4htMso5TcC
         I7yUECKRpan9KJE5rEcpHAYBwOLa1TQLt2c4uVHpOEUX/45BG1FpltWgix4gDt9K6hOY
         pnTw==
X-Gm-Message-State: AOAM5325vjgEcmdyGq/Tpfd6DrKtBusA7mdiB162y/CGG4pSp8IOInkx
        Z2M2SwHj1Z0h9e+ejeCXiK9hig==
X-Google-Smtp-Source: ABdhPJwXhg802s5xEq9kaawNtBg4wA52SPsR6PFx/qF0B/gQ89XcZZ4uasLjdOblWXv0UD7QUklXsg==
X-Received: by 2002:adf:fc11:: with SMTP id i17mr21836907wrr.374.1622538110933;
        Tue, 01 Jun 2021 02:01:50 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:90c:e290:a3a:d001:6a80:207a])
        by smtp.gmail.com with ESMTPSA id e17sm2668199wre.79.2021.06.01.02.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 02:01:50 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tobetter@gmail.com, Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 4/6] arm64: dts: meson-sm1-odroid-hc4: disable unused USB PHY0
Date:   Tue,  1 Jun 2021 11:01:38 +0200
Message-Id: <20210601090140.261768-5-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210601090140.261768-1-narmstrong@baylibre.com>
References: <20210601090140.261768-1-narmstrong@baylibre.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=856; h=from:subject; bh=wmaKsMmGNI6Mptjhlh3CWm/GG+i5sUZ0+LOTljh2gmk=; b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBgtfc7TiwJuBdWNWz+GFjbrmG1iwLtkpiDhF8p9NNz lkUlPM6JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCYLX3OwAKCRB33NvayMhJ0dGHD/ sF+s6vTMAe+c6LXAhuzTXJmf1LGY3Vxsw+/J1CaksxHDoIXmzLtGBikdOfMGRSZGgzv4xFI+ZPJJq3 0Mahhc3EYNa7mNMT9jofX0Y475dgX9YFavsnMfvswiiB50tcKTXqNbM9J6Lm0xiHps010mqRaNnD4s NaLRxqcolX1mFcN5sPCGJ62bzV69EgquwtaI9ot6ddfR6X0kqFx8uOMQ5rtfxgQ+AGgzMmxkigNbPI OWuZgB/jvX3p3/WXQYSbNP4aPTatkS0rmaQA0B9NrlqeFs6gVzGYN/kZrBNiOZP0V7HMWxWWD5+NI3 TJdhgWxIu850srjrzlvdP65mxA6mjmzZsjkUeDBCT4/Jz+5lAUGmtipd1cWrQJPrqoGjK+Sap03x/5 bOTegFIrWQxp8GjpNKNvJ9EkoxkR++xpUhAP9GlJYU//4aZHTit+jAKKU0hq5G7C7ipYeIX+FqcYfo qcsfllNI3Yd2hwoqSsoKhLs/zk1wvVLSHLqP/ONJLS12aJhfvCG0G5w9b0hWn0aJUuuYgFLauVqjZf PXgK8/3DU7RJMsNRToUqEv7Js6BviSY+oUm/co/AUZcaWHDsh8QGr9fjIcdY7nNwpz8V3yw/Mia/Y/ KFxg7EsMLn7LUHI3Lgy+kcxSuWdAaYnkz6pjAZV4A/Y7BoroMDcKfFomx2tg==
X-Developer-Key: i=narmstrong@baylibre.com; a=openpgp; fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As described in the HC4 schematics, only the USB port B is used,
port A is left unconnected. Thus disable PHY0 and remove it from PHYs list.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-sm1-odroid-hc4.dts | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-hc4.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-hc4.dts
index bf15700c4b15..0a34b658f994 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-hc4.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-hc4.dts
@@ -91,6 +91,10 @@ &sd_emmc_c {
 };
 
 &usb {
-	phys = <&usb2_phy0>, <&usb2_phy1>;
-	phy-names = "usb2-phy0", "usb2-phy1";
+	phys = <&usb2_phy1>;
+	phy-names = "usb2-phy1";
+};
+
+&usb2_phy0 {
+	status = "disabled";
 };
-- 
2.25.1

