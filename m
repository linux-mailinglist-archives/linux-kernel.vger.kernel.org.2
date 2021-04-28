Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7570C36DD4C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 18:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241204AbhD1Qn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 12:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241147AbhD1QnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 12:43:19 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB565C061574
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 09:42:33 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 26-20020a05600c22dab029013efd7879b8so7777420wmg.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 09:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rEhU8Um5f0JiN5UeHBJI5GyHDmhvUyYTxNlEBkR3UOo=;
        b=VANfQzQ0qON+/3vbMLMeo4ASaKFeXcGWMD6nIW0LD8DjR1bqi4cUiu4gKKeaLke52p
         qIEKuNpnOiXnFStis487cvxwy75vIEhnZF79j6c+Q5ahIwL+kzfAT7nTBXd5/HxTSdZi
         QqgCB138YLKciSWvIYZjC7A0qhuIk30UR5sjlYySEmRH1PrnbMdP9YSkE+V9amPfgN7R
         AXkAk5vkO9Ium1n1CU3J6s8MQTXDVaaN7pxpwVAZJnt8+UfamsBUWFB/DswEgxNwaSHV
         aQtt21fZi05Tu0+0dIIOpug4QInjppHkAZ7KtIueLir5KFpei5pMLKyBuRUKPElfOmzU
         +U0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rEhU8Um5f0JiN5UeHBJI5GyHDmhvUyYTxNlEBkR3UOo=;
        b=HA+WmAyEGF1TY3mywkOzPRlgl4VhXCUt2gDZdvGl1KmHCTZMhEdyTMCkTKKlH+pbIW
         O0VnEIyGJstd1sqZb+k6JQCDpq/2OMf2zavbR/avcjps0GGCO77b/DBzgvzoCX88iMdJ
         9YRp1w1OQb6r7boH2I1yPGXx8c57tzSlyN6bLXk/EdL7W5xHIYCCKcR4GcYAyDXp3DkA
         bRp6KoKDTKk/LsQf7WaqHaQ1BQ7h7zRk1AEGzUshG2P1w56SmIZRlvzFWwl9kBTvC6kj
         MkpJGoD8MiWzTgDvJW3RdbNok6DULY0RRSiX1SA8Gw0ZB7D6mj1rS6QNYzC52xwvHfOT
         9/Fw==
X-Gm-Message-State: AOAM530hpwP41ZW+ANs+AhtWlpEsEIasIxX4OWOqeLGz26Ly+C24EJtF
        ZzVus89kcCM3gEDQoOqH6aKt3Q==
X-Google-Smtp-Source: ABdhPJxng5RPhsw/McvY8XrJYzLmH7UXgx8AS7ZgIpJmZ5h8u3Ww/Ds6Rad8TOErgiFInrsHrO7P3g==
X-Received: by 2002:a05:600c:2cd6:: with SMTP id l22mr25791567wmc.160.1619628152274;
        Wed, 28 Apr 2021 09:42:32 -0700 (PDT)
Received: from groot.home ([2a01:cb19:826e:8e00:5864:ddd1:d623:f912])
        by smtp.gmail.com with ESMTPSA id o10sm351299wrx.35.2021.04.28.09.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 09:42:31 -0700 (PDT)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     fparent@baylibre.com,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] arm64: dts: mt6358: add mt6358-keys node
Date:   Wed, 28 Apr 2021 18:42:19 +0200
Message-Id: <20210428164219.1115537-8-mkorpershoek@baylibre.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210428164219.1115537-1-mkorpershoek@baylibre.com>
References: <20210428164219.1115537-1-mkorpershoek@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enables the power,home keys on MediaTek boards with a mt6358 pmic.

Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt6358.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt6358.dtsi b/arch/arm64/boot/dts/mediatek/mt6358.dtsi
index fa159b20379e..a1b017a6a751 100644
--- a/arch/arm64/boot/dts/mediatek/mt6358.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt6358.dtsi
@@ -2,6 +2,7 @@
 /*
  * Copyright (c) 2020 MediaTek Inc.
  */
+#include <dt-bindings/input/input.h>
 
 &pwrap {
 	pmic: mt6358 {
@@ -356,5 +357,16 @@ mt6358_vsim2_reg: ldo_vsim2 {
 		mt6358rtc: mt6358rtc {
 			compatible = "mediatek,mt6358-rtc";
 		};
+
+		mt6358keys: mt6358keys {
+			compatible = "mediatek,mt6358-keys";
+			power {
+				linux,keycodes = <KEY_POWER>;
+				wakeup-source;
+			};
+			home {
+				linux,keycodes = <KEY_HOME>;
+			};
+		};
 	};
 };
-- 
2.27.0

