Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDDF239763A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 17:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234549AbhFAPNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 11:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234256AbhFAPNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 11:13:24 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A16C061761
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 08:11:42 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id v23so12396013wrd.10
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 08:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AAkZStHUHr+LanZ27s/ZUoFUcbytaKBTOQXLG7XH/4I=;
        b=RWncbEcmn3mqcF6u5yjSus3WxbbyJ6khmAPMX6Al6kb3ECT5TXhC/X7YF8FPnq8auL
         ctTEcvmULvuDe5mqoars2IBLKgNUJNxHdbM8UDvmOecYLKcvqv+iLa3t31R+0bmAKiFC
         eAfqLMAGGDsmzF6nHQRJnzof7X6u5dseMXI21rx1oYyazPZXBmdF7g1gY7Ni3mabCJEG
         cPq5815amKDKV3j6i2/DaZH3oN90phBCQk6CYp7skuWuTrByR+R8rVh8hTorQX1o+4oz
         A586OgQW61mX0GXaq6StD7VuQGHr0TIvkKcLvFJWk4swFvzH69Hs8nKYU9m3vfHq4VUH
         Kx8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AAkZStHUHr+LanZ27s/ZUoFUcbytaKBTOQXLG7XH/4I=;
        b=f0TI/gbfQtzo1CSjZ0IV5It7CU7kkBCxvjgsmTewMRTiqu2GjUDW0Metdez/Rqzsag
         zSrcUjKPCJeIzzbwirhB9TQ2+FxQHugQO6qQ0ZD+dY0YRDad6Yl+rfUYyjfHysJ++uKB
         zBgiCy3+3vd4DvZJlSQqLHHU6N6BDFc2A7a2dI5ohnGfalOiOYdEl+7CR0Px3cA4+oq0
         YKLR4/eAEnJEc1UpGF5qsx/XkX52F4mwDyIKdr0EL1IaZBFKdtpYLO6gXA64GAkHcyYZ
         zXkpKXEhcRoKWbiccTPaMYB4jW5pMGJShi9VQT9lAU22o/kW8l1JE5XgEAe0Pf4KjPRj
         g4wA==
X-Gm-Message-State: AOAM533D8krRA2OvM3jo9NJvDRZxjyEwp9P4JksMgAglAIq67qqTzKFJ
        ibcSp3ZpBwd1wYWmnSa9JZtiMNRM1ps9NQ==
X-Google-Smtp-Source: ABdhPJzMheEFiKxpaEA/PNjLhjQDNi9mDAKEwFl57f+/HGrLbrvNtbQa3BkO+LBrTJNrYseVueRQqg==
X-Received: by 2002:adf:e7d0:: with SMTP id e16mr12477968wrn.202.1622560301169;
        Tue, 01 Jun 2021 08:11:41 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id f20sm22344163wmh.41.2021.06.01.08.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 08:11:40 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        linus.walleij@linaro.org, linux@armlinux.org.uk,
        robh+dt@kernel.org, ulli.kroll@googlemail.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2 3/5] ARM: dts: gemini: add crypto node
Date:   Tue,  1 Jun 2021 15:11:30 +0000
Message-Id: <20210601151132.1893443-4-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210601151132.1893443-1-clabbe@baylibre.com>
References: <20210601151132.1893443-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SL3516 SoC has a crypto offloader IP.
This patch adds it on the gemini SoC Device-tree.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 arch/arm/boot/dts/gemini.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/gemini.dtsi b/arch/arm/boot/dts/gemini.dtsi
index 6e043869d495..cf4b081c13d9 100644
--- a/arch/arm/boot/dts/gemini.dtsi
+++ b/arch/arm/boot/dts/gemini.dtsi
@@ -356,6 +356,14 @@ gmac1: ethernet-port@1 {
 			};
 		};
 
+		crypto: crypto@62000000 {
+			compatible = "cortina,sl3516-crypto";
+			reg = <0x62000000 0x10000>;
+			interrupts = <7 IRQ_TYPE_EDGE_RISING>;
+			resets = <&syscon GEMINI_RESET_SECURITY>;
+			clocks = <&syscon GEMINI_CLK_GATE_SECURITY>;
+		};
+
 		ide0: ide@63000000 {
 			compatible = "cortina,gemini-pata", "faraday,ftide010";
 			reg = <0x63000000 0x1000>;
-- 
2.31.1

