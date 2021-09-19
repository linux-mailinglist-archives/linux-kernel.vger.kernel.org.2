Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE082410D7F
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Sep 2021 23:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbhISVdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 17:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbhISVdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 17:33:16 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3764C061574;
        Sun, 19 Sep 2021 14:31:50 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id v19so10590317pjh.2;
        Sun, 19 Sep 2021 14:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S5wcLSMUUek1zUXBGHTi9rruAn4oSmVgDe1fOAA1Xkg=;
        b=Y/N3J24yLgRRME487s1w+trnRf3GM3/ZCj+Rz0s4m3s5uVhn1oKBO4wnKRmwVf2M+Y
         ofxcScY2nKHlydUwPMx4fL3DH4W14o8mAL43MB2rmcJkE0gMakXGyW3+8CJ4OZUeK3Vw
         aUZS4plpLVwhl0dOlAsTMQfmF3ptb6dnDti2Gigp4awhgnvwVM+1hyiM4s7r1WQcSirD
         8CCBnBdkuCIF+4sCpLQk7nY8fABo4jJz8NjuxXBqq6o8XbrEnoT7Xc7qCCi346YFJEbC
         yYKL629szenYQULrk3mL1t665kaNh/77sedCQIce/Z87Q+RxcKAARLDY1JEfTgaFzWLM
         dVUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S5wcLSMUUek1zUXBGHTi9rruAn4oSmVgDe1fOAA1Xkg=;
        b=Km2kEMOkfAdjx7svU/V46+dY1LAyNg6ffbe8tiPeuZqrEAMqe2ikdd65/3XmVoKGY6
         RN4QcOyZLGidH5aA/vUPYwNtNn08uRMjXXis0h6laL9dpO+hLEJRg4R25jxWyqnzCHRZ
         6OSRq8CRj0dMm+1VDM5CCpKLvBzV/10pjhzIbRoyFTY5VInNPEN7xoG/KKwTDjCwNLLd
         74D1cOTiYbPDeRSSqe2xqAj+pGJ8lYfU+DIKUUpXt84pPhgjV/o7EMNqnNH+krpi2IP9
         mnLj7vO5UJEcwDtVTty3QVzPZ2Kvid+nw5setvSWBLqnECpTCGBVynvmHUVs+L80UTJF
         Ymyg==
X-Gm-Message-State: AOAM533Jzi9t/30MB2MM7utxJ5ioCu2VQBOc6MEPY9GpghafjI0c8i9g
        9fLpLMX6D6G7Ahf87wJ+6aU=
X-Google-Smtp-Source: ABdhPJwJdFeXtYKqEAT69skINXiw+B63LnASvCir2sKFfBwsrp57j29JzZL2xt/mcCWwRHR8uXQQIg==
X-Received: by 2002:a17:903:22ce:b0:13b:9a00:f090 with SMTP id y14-20020a17090322ce00b0013b9a00f090mr19799864plg.11.1632087110550;
        Sun, 19 Sep 2021 14:31:50 -0700 (PDT)
Received: from archl-c2lm.. ([103.51.72.29])
        by smtp.gmail.com with ESMTPSA id m9sm11973459pfo.44.2021.09.19.14.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Sep 2021 14:31:50 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Anand Moon <linux.amoon@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org
Subject: [PATCH] arm64: dts: meson-g12b-odroid-n2: add 5v regulator gpio
Date:   Sun, 19 Sep 2021 21:31:34 +0000
Message-Id: <20210919213135.4928-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As described in the Odroid-n2 & Odroid-n2-plus schematics,
the 5V regulator is controlled by GPIOH_8 and in Open Drain
since this GPIO doesn't support Push-Pull.

Cc: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
index 4f33820aba1f..e8a00a2f8812 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
@@ -99,6 +99,8 @@ vcc_5v: regulator-vcc_5v {
 		regulator-max-microvolt = <5000000>;
 		regulator-always-on;
 		vin-supply = <&main_12v>;
+		gpio = <&gpio GPIOH_8 GPIO_OPEN_DRAIN>;
+		enable-active-high;
 	};
 
 	vcc_1v8: regulator-vcc_1v8 {
-- 
2.33.0

