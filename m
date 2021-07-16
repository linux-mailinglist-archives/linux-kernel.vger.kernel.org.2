Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F87F3CB62D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 12:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239230AbhGPKk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 06:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237344AbhGPKk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 06:40:57 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F5CC06175F;
        Fri, 16 Jul 2021 03:38:03 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id c1so4753089pfc.13;
        Fri, 16 Jul 2021 03:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VmmdmkhCXO7AkJW07YrDSJja8AB+CMGTjyDZ72pZ3SM=;
        b=XLSE0l9iqM0FUsdbXgwyYeUrxZueBS2H6c7hqHRL9yloc2KjuRPsCFY3K0pJgN92Jl
         I9S81ExFA/RPQv40q29hoSSelFqrR9ivp1lUaAz/6Stwhu6zR8137DTnjOpD6NalZNyi
         tNm1WWPQbRBc7D6YJMSnmh8zapD4oxafFu7J2Bq2kMnAU8Ofu+WjuhZD+U8vs9Pv4ELL
         LaLf79ZEbZ5A/kLT0Jppqmff93zKY4Ku32+2+IZ0XR3Mpg9T7xqtH+0buG0S2xibGBaa
         zGQ+f0bd9lIJ5JmAcZpotR+I+V6rUUJKdn35klF80vjgtPpiDymMNs9A9u6abhyRMZLw
         Jz9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VmmdmkhCXO7AkJW07YrDSJja8AB+CMGTjyDZ72pZ3SM=;
        b=ChMCLmEqv7r2YEkgNqKob8KUaT/hH4VpeufHaxijpujwTQXlzk70LtA5T4JzApMHVs
         zcsWGrV45etcaPF2vuWMUjVtze1zEWIw5z0hSsQQ/ow7DSK+y4letRpRszu4zu0PLYxz
         XjYwzdGe6wb2Gs6SAtQADyXD7xXW2jFcGgqwvXEYvW494iMJZjT52gmrs7hxMtl91wIT
         7E4sTSQH56ywolwc7FpZNspYEB6kkutiFiytkkrcCC1uWexkKNHPUD4fsZ7juCgFCkhW
         I6uWIZatqRfAH35Rq93sRuI0SMSDNp1TfDgwas+fFxnOhX1dZFUZDW6hNeVhFX/bcfnU
         r42g==
X-Gm-Message-State: AOAM530lmsXOBF/vZZu+SBiz8aZbwybCqtYaINOXrh3We2+bBQ6IlaeG
        lgpOo1mAsDt3Hc4/Vxz5xn4=
X-Google-Smtp-Source: ABdhPJwcfKzs6LufNBOvTwQDhzOMXdnw2fdKAY5SkFQfRpvVwVTYBM5CiUo9KwmAaTJF9L0qBS4k9Q==
X-Received: by 2002:a05:6a00:2:b029:32e:3ef0:770a with SMTP id h2-20020a056a000002b029032e3ef0770amr9954297pfk.8.1626431882813;
        Fri, 16 Jul 2021 03:38:02 -0700 (PDT)
Received: from archl-c2lm.. ([103.51.72.31])
        by smtp.gmail.com with ESMTPSA id d29sm10070111pfq.193.2021.07.16.03.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 03:38:02 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Anand Moon <linux.amoon@gmail.com>,
        Matt Corallo <oc2udbzfd@mattcorallo.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Emiliano Ingrassia <ingrassia@epigenesys.com>,
        Brian Kim <brian.kim@hardkernel.com>,
        devicetree@vger.kernel.org
Subject: [PATCHv2 2/4] arm64: dts: amlogic: odroidc2: Fix the chip enable signal for usb power
Date:   Fri, 16 Jul 2021 10:36:34 +0000
Message-Id: <20210716103651.1455-3-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210716103651.1455-1-linux.amoon@gmail.com>
References: <20210716103651.1455-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the chip enable signal changing from Active High to Active Low
to enable input power to USB power. Also updated signal name as per
the shematics.

Fixes: 5a0803bd5ae2 ("ARM64: dts: meson-gxbb-odroidc2: Enable USB Nodes")

Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
New patch in this series
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index 201596247fd9..3f4f16a5dedd 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -38,12 +38,11 @@ usb_otg_pwr: regulator-usb-pwrs {
 		regulator-max-microvolt = <5000000>;
 
 		/*
-		 * signal name from schematics: PWREN
+		 * signal name from schematics: PWREN - GPIOAO.BIT5
 		 */
-		gpio = <&gpio_ao GPIOAO_5 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
+		gpios = <&gpio_ao GPIOAO_5 GPIO_ACTIVE_LOW>;
 		/*
-		 * signal name from schematics: USB_POWER
+		 * signal name from schematics: USB_POWER - P5V0
 		 */
 		vin-supply = <&p5v0>;
 	};
-- 
2.32.0

