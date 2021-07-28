Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE8563D94DD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 20:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbhG1SBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 14:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbhG1SBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 14:01:02 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDABC061757;
        Wed, 28 Jul 2021 11:00:59 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id w10so1989453qtj.3;
        Wed, 28 Jul 2021 11:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S56htb9vVkDrFmzApk71DTCJizGCv0+IZp82FWSdz/g=;
        b=owtO4XXjj6P6Rjd77xgdGJq/s1cIXPoVSiO7zCI14o5x9HuPAsV6xo+swVDwOS+ZjA
         ztTe4uNIBTc2IaR7dWUrUEv444EXFIJZy6s7fTrzROo+SKHeTIC/APTaUUNqsptqAjQ0
         JUJ7Ied3+YGJjFVtJZFOlQ2mF9N3Aj/vpGoCfzQNunvA4+Ik2Of+hjrHK/9J309xfIjj
         4UZiSMt+4qDj7ULdB+HUEI9y8pczBhA2zLfvQb3AC8H3OjvkXjxnAWA23bVWvT6eJVOv
         qRg+DZQmQ+QZPnN8KEAEs1Fn2ik2CCzzm48pRw9jXBkq0vSSIyR7vvtheY675Yq5MJUB
         OgVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S56htb9vVkDrFmzApk71DTCJizGCv0+IZp82FWSdz/g=;
        b=McJVfxLRBNOKlnU20/CqP2MJpM0U9qnnZNb5KqzK+1YAhG25a3xRQIRdss64vW5Ebs
         VRYSAchdks6wBqGxHZImPrE1/Eg9gERnZBq3NvVphCLq+NGT5JkGe5rncGOFjk4+ccNw
         wLUWtNkwGGODeUEGZ9e00t7Q2mdzzBckghsxvAeD5wb2c+FSxoB0QQJHxGRmZSAk5EGM
         ao7q+8gMtA/1NdJpM2X1B1PNau9ZMBgqmPhwOHKwMS8z7YkrY/yTcGa3yGWNsh0jSv5f
         ZoqwdxmiEPbfro4uTzj9oxb5QREs06TLZYv3qgLVc+uOA9I8bNmqj0HaztD8MusFZN8h
         wFCw==
X-Gm-Message-State: AOAM530VIOnS1738V1kPyGHpZxQMLmMu9eCSeDnByi2p2081ADUVFNfM
        +Rk32AenygrfQ5sD/6GySNQ=
X-Google-Smtp-Source: ABdhPJwXiOweFs0EgI4O/K88VOjku0nSLXkG/t0a1JDtXJczLMHrFHl2a0of4XrY2CunDR50P4P/hg==
X-Received: by 2002:ac8:4d9b:: with SMTP id a27mr688003qtw.351.1627495259053;
        Wed, 28 Jul 2021 11:00:59 -0700 (PDT)
Received: from master-laptop.sparksnet ([2601:153:980:85b1:b58:2ae8:d75f:660a])
        by smtp.gmail.com with ESMTPSA id r5sm223341qtm.75.2021.07.28.11.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 11:00:58 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     Peter Geis <pgwipeout@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/8] arm64: dts: rockchip: add rk356x gpio debounce clocks
Date:   Wed, 28 Jul 2021 14:00:29 -0400
Message-Id: <20210728180034.717953-4-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210728180034.717953-1-pgwipeout@gmail.com>
References: <20210728180034.717953-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rk356x added a debounce clock to the gpio devices. This clock is
necessary for the new v2 gpio driver to bind.
Add the clocks to the rk356x device tree.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk356x.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
index f7ecdfd66f86..c2aa7aeec58d 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
@@ -750,7 +750,7 @@ gpio0: gpio@fdd60000 {
 			compatible = "rockchip,gpio-bank";
 			reg = <0x0 0xfdd60000 0x0 0x100>;
 			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&pmucru PCLK_GPIO0>;
+			clocks = <&pmucru PCLK_GPIO0>, <&pmucru DBCLK_GPIO0>;
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
@@ -761,7 +761,7 @@ gpio1: gpio@fe740000 {
 			compatible = "rockchip,gpio-bank";
 			reg = <0x0 0xfe740000 0x0 0x100>;
 			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cru PCLK_GPIO1>;
+			clocks = <&cru PCLK_GPIO1>, <&cru DBCLK_GPIO1>;
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
@@ -772,7 +772,7 @@ gpio2: gpio@fe750000 {
 			compatible = "rockchip,gpio-bank";
 			reg = <0x0 0xfe750000 0x0 0x100>;
 			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cru PCLK_GPIO2>;
+			clocks = <&cru PCLK_GPIO2>, <&cru DBCLK_GPIO2>;
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
@@ -783,7 +783,7 @@ gpio3: gpio@fe760000 {
 			compatible = "rockchip,gpio-bank";
 			reg = <0x0 0xfe760000 0x0 0x100>;
 			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cru PCLK_GPIO3>;
+			clocks = <&cru PCLK_GPIO3>, <&cru DBCLK_GPIO3>;
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
@@ -794,7 +794,7 @@ gpio4: gpio@fe770000 {
 			compatible = "rockchip,gpio-bank";
 			reg = <0x0 0xfe770000 0x0 0x100>;
 			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cru PCLK_GPIO4>;
+			clocks = <&cru PCLK_GPIO4>, <&cru DBCLK_GPIO4>;
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
-- 
2.25.1

