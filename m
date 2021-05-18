Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74B8F387C45
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 17:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350150AbhERPSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 11:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350098AbhERPSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 11:18:34 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65FBC061763
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 08:17:10 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id z130so5643727wmg.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 08:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lsVhBJHSfM3t7nEcMYoG9OqldUiNNdLX6U7vkUGlUnk=;
        b=Z0WsPHLoM+Zmujcbc0B0PA+0U+Fq0gACHg9fclZ7v5C6CKTwDGxSYKS1JZh2GkUkT3
         8utkEWQ40qoIVovor8RHE2fxeh9bIzaxZggi351iYcg5fznxZ+D5y1jDRoMIX4ML5Zyr
         b4dSLrwKBFy9VQNghpQG3UeQ7uQT7CKZlXLv8eaSBf2h0FVoEcTnZEDIYvti7AHm8kbg
         yS32qGxsgaoqSiX0CBnknzFEpsyYUPywXTu7/elw00+hr5nD/Ig/EJWaBEy+aZMkkOpf
         sn3W+VMLIp9XK8t9xGgmBiLWYTftn9P2Q3KgdENI2EQr59g2nqrr2f7JCM2qiqPBUVh5
         +Qow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lsVhBJHSfM3t7nEcMYoG9OqldUiNNdLX6U7vkUGlUnk=;
        b=hjLAn9RUEhwYart06YUIvD//cxDXUtjxDNBUqRo97FFdmLMj5+xpb7Kt2EGDkZ0C+z
         T04hl6llsLtEM10BU4lopTOzUO5uNywlozQr4xc71mo/L2G8iINAEA5IiiWEbEg0xBGP
         noz+TWuHo/T4ldk8rNodB/7sMUcJVJnWlsEaVDldm9mXft/NvZUUDkIinAH4xShPY4bn
         DnoCdCsUII0mfDOwC4rB+/Ucv+NT7zLTkf1qgxpiAKIIsY0I71aJFh1ybXJ4y+I+fOV3
         PgSyz8pVkg2njwTCdpyZ3sRUv2Xv+ZIHXHVrUpATCl2Up5X8GEGY6JTq0D9dxjb1wEoh
         aUWQ==
X-Gm-Message-State: AOAM532SdDLo8t/KUAuV71Jlw3AwumEFif6YygNkGnF4XxLYAdtaLiE0
        E+iuLjChPdCK8FnzCxlTwfIEmg==
X-Google-Smtp-Source: ABdhPJyx8poY/JBy9Z3+f4eGLwN7ifEtmzpqeUGxvFn3FQWDoaZ0FXogJh8DOeukLQyf9pic97megw==
X-Received: by 2002:a1c:3184:: with SMTP id x126mr5535649wmx.52.1621351029580;
        Tue, 18 May 2021 08:17:09 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id z9sm18005808wmi.17.2021.05.18.08.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 08:17:09 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        linus.walleij@linaro.org, linux@armlinux.org.uk,
        robh+dt@kernel.org, ulli.kroll@googlemail.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 3/5] ARM: dts: gemini: add crypto node
Date:   Tue, 18 May 2021 15:16:53 +0000
Message-Id: <20210518151655.125153-4-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210518151655.125153-1-clabbe@baylibre.com>
References: <20210518151655.125153-1-clabbe@baylibre.com>
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
2.26.3

