Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB55938AE23
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbhETMZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232858AbhETMZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:25:17 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F70C0AF783
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 04:21:14 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id z130so8948240wmg.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 04:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I1s2g7mZiKD+3vqbYSRNmdSX/CMtcVBGAGHbX0P5N+Y=;
        b=dQXS0Q9+oZRSBGRK9IhEcny+g10qxP56m7wQL+S2aq4svKPeRJkuV1BHZlLHSQNs1B
         woNjvZXc2ckEW/Kl8q78BIRa6upPdqxeGocCHpS5/JL53eYZErgAtR6zBZar3EdqH6NN
         xVOlHbRmDlUXGA8OK5xXHyFW0p/B68RYExjov+c0N9uX9Jn/ZhoFGf2UZ7KhmceSQofR
         mUdNAG992HfUBXokhiuWG/b0q5QIpRtAcKir4Dtrigr6OuWcm5VQ8IdB/EodtZwe5FOU
         5zDqO3qxJBRWkX/8OUMSffv6if7yrcPbxGjzY6vJ8axrb4YjVBpe3HFM4YEnxqVeLccs
         BO6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I1s2g7mZiKD+3vqbYSRNmdSX/CMtcVBGAGHbX0P5N+Y=;
        b=c/1Y2maOil9aOTyydJAEXUXQWM4HH9wjJR0YiSzhX035C4XobqBl2j3h+vovxKb1V1
         06UVzlihRA4FnNKvndVWAbv/2j5HhQuWqurT6fRUmytCTKa6g+KB5u1VX82afMGK7Dp0
         F8HY1e/6LamsG0FBKkJmXoeCbOUbHgZwKX8u5Jc8puG6DzZPSzBpy+tEJvyuFcw9Ew2l
         1yJdIVBbxoSYNExBzyTUKCnOC1EVsd2h5ZqEQ44M8JMU1IRLtFYArHN9VHIDZ5EZDDIZ
         vu7VxFANiU6z4knvQBXJkvNy2Zsfd6DCP5f0Z8S1CMKbgZPQpuOREYM4vu16Azx+36eH
         H9zQ==
X-Gm-Message-State: AOAM531r3lPf6oQ0mGGpyG0YlZhdoO1nlY6i/15F+7Xpo5WTXtDA7jYa
        uGGU1RZZcDm1Z9L+aOeCokaZ8g==
X-Google-Smtp-Source: ABdhPJwgZ2Uy9gIUoGlppdjJs1r6s6YTR4PaEUrIYWth4zddJArej2XDwuX9NSmnvHi6LOsm7bcw/Q==
X-Received: by 2002:a05:600c:2301:: with SMTP id 1mr3600762wmo.180.1621509672880;
        Thu, 20 May 2021 04:21:12 -0700 (PDT)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id o11sm2756646wrq.93.2021.05.20.04.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 04:21:12 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     mkorpershoek@baylibre.com, Fabien Parent <fparent@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] arm64: dts: mediatek: mt8192: fix i2c node names
Date:   Thu, 20 May 2021 13:21:05 +0200
Message-Id: <20210520112106.77190-4-fparent@baylibre.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520112106.77190-1-fparent@baylibre.com>
References: <20210520112106.77190-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the i2c node names to be compliant to the YAML schema. The
I2C node name should match the following pattern: "^i2c@[0-9a-f]+$".

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---

v2: New patch

 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
index 9757138a8bbd..684e8e32af16 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
@@ -436,7 +436,7 @@ nor_flash: spi@11234000 {
 			status = "disable";
 		};
 
-		i2c3: i2c3@11cb0000 {
+		i2c3: i2c@11cb0000 {
 			compatible = "mediatek,mt8192-i2c";
 			reg = <0 0x11cb0000 0 0x1000>,
 			      <0 0x10217300 0 0x80>;
@@ -449,7 +449,7 @@ i2c3: i2c3@11cb0000 {
 			status = "disabled";
 		};
 
-		i2c7: i2c7@11d00000 {
+		i2c7: i2c@11d00000 {
 			compatible = "mediatek,mt8192-i2c";
 			reg = <0 0x11d00000 0 0x1000>,
 			      <0 0x10217600 0 0x180>;
@@ -462,7 +462,7 @@ i2c7: i2c7@11d00000 {
 			status = "disabled";
 		};
 
-		i2c8: i2c8@11d01000 {
+		i2c8: i2c@11d01000 {
 			compatible = "mediatek,mt8192-i2c";
 			reg = <0 0x11d01000 0 0x1000>,
 			      <0 0x10217780 0 0x180>;
@@ -475,7 +475,7 @@ i2c8: i2c8@11d01000 {
 			status = "disabled";
 		};
 
-		i2c9: i2c9@11d02000 {
+		i2c9: i2c@11d02000 {
 			compatible = "mediatek,mt8192-i2c";
 			reg = <0 0x11d02000 0 0x1000>,
 			      <0 0x10217900 0 0x180>;
@@ -488,7 +488,7 @@ i2c9: i2c9@11d02000 {
 			status = "disabled";
 		};
 
-		i2c1: i2c1@11d20000 {
+		i2c1: i2c@11d20000 {
 			compatible = "mediatek,mt8192-i2c";
 			reg = <0 0x11d20000 0 0x1000>,
 			      <0 0x10217100 0 0x80>;
@@ -501,7 +501,7 @@ i2c1: i2c1@11d20000 {
 			status = "disabled";
 		};
 
-		i2c2: i2c2@11d21000 {
+		i2c2: i2c@11d21000 {
 			compatible = "mediatek,mt8192-i2c";
 			reg = <0 0x11d21000 0 0x1000>,
 			      <0 0x10217180 0 0x180>;
@@ -514,7 +514,7 @@ i2c2: i2c2@11d21000 {
 			status = "disabled";
 		};
 
-		i2c4: i2c4@11d22000 {
+		i2c4: i2c@11d22000 {
 			compatible = "mediatek,mt8192-i2c";
 			reg = <0 0x11d22000 0 0x1000>,
 			      <0 0x10217380 0 0x180>;
@@ -527,7 +527,7 @@ i2c4: i2c4@11d22000 {
 			status = "disabled";
 		};
 
-		i2c5: i2c5@11e00000 {
+		i2c5: i2c@11e00000 {
 			compatible = "mediatek,mt8192-i2c";
 			reg = <0 0x11e00000 0 0x1000>,
 			      <0 0x10217500 0 0x80>;
@@ -540,7 +540,7 @@ i2c5: i2c5@11e00000 {
 			status = "disabled";
 		};
 
-		i2c0: i2c0@11f00000 {
+		i2c0: i2c@11f00000 {
 			compatible = "mediatek,mt8192-i2c";
 			reg = <0 0x11f00000 0 0x1000>,
 			      <0 0x10217080 0 0x80>;
@@ -553,7 +553,7 @@ i2c0: i2c0@11f00000 {
 			status = "disabled";
 		};
 
-		i2c6: i2c6@11f01000 {
+		i2c6: i2c@11f01000 {
 			compatible = "mediatek,mt8192-i2c";
 			reg = <0 0x11f01000 0 0x1000>,
 			      <0 0x10217580 0 0x80>;
-- 
2.31.1

