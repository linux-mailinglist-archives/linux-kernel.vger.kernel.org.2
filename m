Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D42B13CC14D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 06:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232396AbhGQFAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 01:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbhGQFAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 01:00:03 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8D6C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 21:57:06 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id b12so6312891plh.10
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 21:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iH5hOIug88dJD4ivQ2NqJKjZ3aauEwcovfQ35jFjeCY=;
        b=aXVtX2M6WCascZlHmLoPsu3liAWTk6yKEq2cnbAvh1AHSX5i+9MuCCI9Vz2B2axT2h
         WycmsN/R3vsh6zQgwhtmAZx8ce1Gno09qvSwNSjSuMfp2+3uiRF7MuwbN0M881Spt1tT
         5hDbMgDi/L07LfN0M0VcmsN6YxpgnQvhhENB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iH5hOIug88dJD4ivQ2NqJKjZ3aauEwcovfQ35jFjeCY=;
        b=R0Ty/WlOQcKCqgcpTuT40xPzMZ6mVHWrybF2vHqUKwvQtELd4C22BGkibT+vCC1PRD
         nhELojev6SBUAmnJXynJR2+us0wRAqU2MSDm5rqu66aQgpfMzOzXqRZN8Nb8TThUkVbq
         9KZ/NqKVOlh/ygEH9z7TXT/1dyyseStRv3B1JMef7F36gfTaUVstaMEPTnGEA8XSfIAO
         DcrFDH8pnGbbCFASRZwJuvzuht3hWST3ab5ZCE7kk+RORjH3Xd+1yo0tm6V5dFkLm/jF
         Ky5D9cXOalVuglYB4i7hgkVM208hoqTMMvdKKoPvwC+hk+jq76a3X34zFnL0LTSofphN
         zxlQ==
X-Gm-Message-State: AOAM533K/dmFig9Ep+y6ZEcZX6KCTzjmaz7jxd/aUHb31vZBEoskym9S
        L3BeDctbRpOqW5EUlKl9FX5uvQ==
X-Google-Smtp-Source: ABdhPJxdUypLTJ2BGFwx4JvhhuK6TYm5Fi8cmR+3/peM5Zh23rIIOV1c6rkmsHihycY3XP2/cRv5Gw==
X-Received: by 2002:a17:90a:cd01:: with SMTP id d1mr19035743pju.106.1626497825779;
        Fri, 16 Jul 2021 21:57:05 -0700 (PDT)
Received: from shiro.work (p866038-ipngn200510sizuokaden.shizuoka.ocn.ne.jp. [180.9.60.38])
        by smtp.googlemail.com with ESMTPSA id w2sm12522885pjf.2.2021.07.16.21.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 21:57:05 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
To:     devicetree@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linus.walleij@linaro.org, robh@kernel.org, romain.perier@gmail.com,
        Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH 10/10] ARM: dts: mstar: unitv2: Add wifi switch
Date:   Sat, 17 Jul 2021 13:56:27 +0900
Message-Id: <20210717045627.1739959-11-daniel@0x0f.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210717045627.1739959-1-daniel@0x0f.com>
References: <20210717045627.1739959-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a GPIO controlled fixed regulator for the Realtek WiFi
connected via USB.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 arch/arm/boot/dts/mstar-infinity2m-ssd202d-unitv2.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/mstar-infinity2m-ssd202d-unitv2.dts b/arch/arm/boot/dts/mstar-infinity2m-ssd202d-unitv2.dts
index 648751a1b27e..525305a3e3ac 100644
--- a/arch/arm/boot/dts/mstar-infinity2m-ssd202d-unitv2.dts
+++ b/arch/arm/boot/dts/mstar-infinity2m-ssd202d-unitv2.dts
@@ -56,6 +56,14 @@ vcc_dram: regulator@2 {
 		regulator-max-microvolt = <1500000>;
 		regulator-boot-on;
 	};
+
+	vcc_wifi: regulator@3 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_wifi";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpios = <&gpio SSD20XD_GPIO_GPIO14 0>;
+	};
 };
 
 &pm_uart {
-- 
2.32.0

