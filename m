Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE1F45826D
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 08:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbhKUHGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 02:06:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbhKUHGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 02:06:32 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8EAC061574;
        Sat, 20 Nov 2021 23:03:27 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id i8-20020a7bc948000000b0030db7b70b6bso13970902wml.1;
        Sat, 20 Nov 2021 23:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5wISGq2t2SDmY1fBi1n88KuPv1Mb+rVK+4uwhokCpSE=;
        b=cUn0+vQeVAB6Up16OIJRP5NyDruX7H2Yk/ZJ/kn9X0V8SxWGSGWmBRRcmJNF7cDZ4N
         rnGE/btBqG82tezCe3l1x/nVtOwCI8mH2jtbnYDwKQocVroae5Ncbh2Co2hdv+KEaD9C
         UakkMvh4pX/tG7CyL2GUqi6s01OnXTb8yQ5BNxOrHw0fZosXfrBLPJwcYxmzX43fEcbN
         NzrDuvFlRQ9Cy8gBf/I7xJWdBny4XmrgBtVz7Rb1xU6j9x1rCptI5GJMLij9D1wCSc4u
         sS5hA15CKV/aduifqxcneKJZzyMs9tzCw3iBQ5xGi79TKxvfz8wLeZEZzV9hEhuQGOOo
         3JjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5wISGq2t2SDmY1fBi1n88KuPv1Mb+rVK+4uwhokCpSE=;
        b=IuQPZDPI+22oY3qUezyIqH9Rppb9+JWGXeLWa8ZGNGbcO9z5rhu5LG9lmnkjvP7Io0
         DQhSYwqK+GX3YnSkJPhJQnLA+Ctk4P7Kw+jPvU1fOwnu4wBuSVzEKo4UWGu/ER33r2XK
         dnUoUJOiXjysT7WgIMsOZ6B0jg3W633VTde4MChVZcwXtVkXlGVhHrSswc8YKfOvJ4GL
         /goK2eszQjAJH4lNdOzK5uDEu3HXBl2RagjLMpYqroFJF8mR4lBjoDzXGGjKf3A29S3S
         6r0qm0w99JSw/wB0yG0ed8ZrHEOXyJC0PByOZPpfb6erfGckIYEEDcGFzLsY2qgr+FaI
         TdvQ==
X-Gm-Message-State: AOAM531akx0Nj79QhXr+CPTCQ94dHYD9X7ZtERI8yGHeJrv4uusk2UK8
        7KTp2AekwWXW2cdCocWwdIA=
X-Google-Smtp-Source: ABdhPJzLvfJDsRut5KiPWWiiRTblRiQR4SJ5SdmjWPKji8bryNV+1aYeFMsm5cenajTowWn9FuY8ow==
X-Received: by 2002:a7b:c084:: with SMTP id r4mr17706610wmh.117.1637478205554;
        Sat, 20 Nov 2021 23:03:25 -0800 (PST)
Received: from kista.localdomain (cpe-86-58-29-253.static.triera.net. [86.58.29.253])
        by smtp.gmail.com with ESMTPSA id d6sm4886620wrx.60.2021.11.20.23.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Nov 2021 23:03:24 -0800 (PST)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, wens@csie.org
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH] ARM: dts: sun8i: h3: beelink-x2: Sort nodes
Date:   Sun, 21 Nov 2021 08:03:21 +0100
Message-Id: <20211121070321.601659-1-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nodes are not sorted alphabetically. Do it.

There is no functional change.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 arch/arm/boot/dts/sun8i-h3-beelink-x2.dts | 28 +++++++++++------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts b/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
index 4ab4bbf001ba..cd9f655e4f92 100644
--- a/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
+++ b/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
@@ -93,11 +93,15 @@ led-1 {
 		};
 	};
 
-	wifi_pwrseq: wifi_pwrseq {
-		compatible = "mmc-pwrseq-simple";
-		reset-gpios = <&r_pio 0 7 GPIO_ACTIVE_LOW>; /* PL7 */
-		clocks = <&rtc 1>;
-		clock-names = "ext_clock";
+	r-gpio-keys {
+		compatible = "gpio-keys";
+
+		power {
+			label = "power";
+			linux,code = <KEY_POWER>;
+			gpios = <&r_pio 0 3 GPIO_ACTIVE_LOW>;
+			wakeup-source;
+		};
 	};
 
 	sound_spdif {
@@ -118,15 +122,11 @@ spdif_out: spdif-out {
 		compatible = "linux,spdif-dit";
 	};
 
-	r-gpio-keys {
-		compatible = "gpio-keys";
-
-		power {
-			label = "power";
-			linux,code = <KEY_POWER>;
-			gpios = <&r_pio 0 3 GPIO_ACTIVE_LOW>;
-			wakeup-source;
-		};
+	wifi_pwrseq: wifi_pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&r_pio 0 7 GPIO_ACTIVE_LOW>; /* PL7 */
+		clocks = <&rtc 1>;
+		clock-names = "ext_clock";
 	};
 };
 
-- 
2.34.0

