Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81BEC36DEA6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 19:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242789AbhD1Ruk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 13:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242971AbhD1RtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 13:49:25 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD4DC061574
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 10:48:37 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id k128so34302166wmk.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 10:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BfhAdhK/r3r1BKx7meKoyyIgz0VOdlbmjxJARvRxoxE=;
        b=RG+3PiXxka9dJ0Dd5hAAzjKtZxfAqghjfSsItaLbyZ2J1QvB4vqsVhR6dxzm1HuO5K
         fuXgtHlmcg6dSlEm+9NRJxTWWKd8DA+VALJP1b0VejK8NJ3RaG6xn8G2Ez7F55q1Z4ZP
         +UBMMheQryYpY0Rcdc9CW4zz+BiJKHSk+XUD7/v+v9LkjTUv5pY7zlkgNZsGqfymvdzV
         NaCmov5IaBWX0FAdI7gylDi/GThEI8EhteKXtaA7o1jtPwR0x2Z9nIBncwzaG+scDN+k
         6dRv+B5BzYj2lBtEWuQb1BCKtkqSA8aXb9AynD+Ec6M7aZ04NoK++fhPYBd24R4qnWKw
         g4AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BfhAdhK/r3r1BKx7meKoyyIgz0VOdlbmjxJARvRxoxE=;
        b=gHIbo7TWINO2poVt4E9IMXzET2gW0q462x27uc3TXzf9ND+N9D1DJPzmRMmTdb+jt7
         eezOZhh3nCZ09UjkQk8NDeT8hLk8FHjZNuguL0jU8aBBps9WQ/KMjy2WTmtWLsL3a/aA
         bblDQvbw0IFIKHlCs5JQxh4vmUAO99XYcbe0jJJofPaJJcXS9cvrkNi5h8p6jvmAPUO+
         xASLqDM8odhXHmZoZpBKKmuZYCNc/Q9UG77QXCM0GTq+0qFqPrrRbt+h7gnvnAJqI3rz
         m0F9+q89KMoqm6aEKyEXBTrfvI8wJJ+4SHz9FL4XJhZTwDdPoBxq1dx6ZjjvzJUJIrJk
         gCjg==
X-Gm-Message-State: AOAM532XhPsmDI0F3tASixIVkF9AmeH5uK+ZU8Pl50qyzxw0hjP5FjRx
        eMjBb6qFOF5OIdQAvpvOpfK1kQ==
X-Google-Smtp-Source: ABdhPJxr9azJjkaqN6JaVQ3hmflVUbCsm/I7tonHOcP5X9t0TTDBiAorDOluCAAX+DsBz0biXCKN5g==
X-Received: by 2002:a05:600c:ac2:: with SMTP id c2mr33620732wmr.23.1619632116588;
        Wed, 28 Apr 2021 10:48:36 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id c16sm616207wrt.83.2021.04.28.10.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 10:48:35 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     linus.walleij@linaro.org, robh+dt@kernel.org,
        ulli.kroll@googlemail.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] ARM: dts: gemini: rename mdio to the right name
Date:   Wed, 28 Apr 2021 17:48:30 +0000
Message-Id: <20210428174830.3691034-1-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ethernet-phy is not the right name for mdio, fix it.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 arch/arm/boot/dts/gemini-dlink-dns-313.dts | 2 +-
 arch/arm/boot/dts/gemini-nas4220b.dts      | 2 +-
 arch/arm/boot/dts/gemini-rut1xx.dts        | 2 +-
 arch/arm/boot/dts/gemini-wbd111.dts        | 2 +-
 arch/arm/boot/dts/gemini-wbd222.dts        | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/gemini-dlink-dns-313.dts b/arch/arm/boot/dts/gemini-dlink-dns-313.dts
index 1b2bb3beaccb..f5313f6be956 100644
--- a/arch/arm/boot/dts/gemini-dlink-dns-313.dts
+++ b/arch/arm/boot/dts/gemini-dlink-dns-313.dts
@@ -140,7 +140,7 @@ map1 {
 		};
 	};
 
-	mdio0: ethernet-phy {
+	mdio0: mdio {
 		compatible = "virtual,mdio-gpio";
 		/* Uses MDC and MDIO */
 		gpios = <&gpio0 22 GPIO_ACTIVE_HIGH>, /* MDC */
diff --git a/arch/arm/boot/dts/gemini-nas4220b.dts b/arch/arm/boot/dts/gemini-nas4220b.dts
index 77776c371ce0..da4ce90eec22 100644
--- a/arch/arm/boot/dts/gemini-nas4220b.dts
+++ b/arch/arm/boot/dts/gemini-nas4220b.dts
@@ -62,7 +62,7 @@ led-green-os {
 		};
 	};
 
-	mdio0: ethernet-phy {
+	mdio0: mdio {
 		compatible = "virtual,mdio-gpio";
 		gpios = <&gpio0 22 GPIO_ACTIVE_HIGH>, /* MDC */
 			<&gpio0 21 GPIO_ACTIVE_HIGH>; /* MDIO */
diff --git a/arch/arm/boot/dts/gemini-rut1xx.dts b/arch/arm/boot/dts/gemini-rut1xx.dts
index f8826a3b774f..6cea953150b5 100644
--- a/arch/arm/boot/dts/gemini-rut1xx.dts
+++ b/arch/arm/boot/dts/gemini-rut1xx.dts
@@ -56,7 +56,7 @@ led-power {
 		};
 	};
 
-	mdio0: ethernet-phy {
+	mdio0: mdio {
 		compatible = "virtual,mdio-gpio";
 		gpios = <&gpio0 22 GPIO_ACTIVE_HIGH>, /* MDC */
 			<&gpio0 21 GPIO_ACTIVE_HIGH>; /* MDIO */
diff --git a/arch/arm/boot/dts/gemini-wbd111.dts b/arch/arm/boot/dts/gemini-wbd111.dts
index 4f3e097d784b..00ea66f4788f 100644
--- a/arch/arm/boot/dts/gemini-wbd111.dts
+++ b/arch/arm/boot/dts/gemini-wbd111.dts
@@ -68,7 +68,7 @@ led-greeb-l3 {
 		};
 	};
 
-	mdio0: ethernet-phy {
+	mdio0: mdio {
 		compatible = "virtual,mdio-gpio";
 		gpios = <&gpio0 22 GPIO_ACTIVE_HIGH>, /* MDC */
 			<&gpio0 21 GPIO_ACTIVE_HIGH>; /* MDIO */
diff --git a/arch/arm/boot/dts/gemini-wbd222.dts b/arch/arm/boot/dts/gemini-wbd222.dts
index e6fe59ee65b6..6dfb61b8d133 100644
--- a/arch/arm/boot/dts/gemini-wbd222.dts
+++ b/arch/arm/boot/dts/gemini-wbd222.dts
@@ -67,7 +67,7 @@ led-green-l3 {
 		};
 	};
 
-	mdio0: ethernet-phy {
+	mdio0: mdio {
 		compatible = "virtual,mdio-gpio";
 		gpios = <&gpio0 22 GPIO_ACTIVE_HIGH>, /* MDC */
 			<&gpio0 21 GPIO_ACTIVE_HIGH>; /* MDIO */
-- 
2.26.3

