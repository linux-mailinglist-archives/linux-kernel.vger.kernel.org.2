Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79CD639D573
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 08:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbhFGG5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 02:57:52 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]:54177 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbhFGG5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 02:57:50 -0400
Received: by mail-wm1-f43.google.com with SMTP id h3so9278917wmq.3
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jun 2021 23:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cRBSOx180b/8yVnDTJgXllPZieNx41tmIQu1Fr+M/y0=;
        b=fsRDhwznO0x5xyw455Mz/u9rpjsQk+roBybCUodlgB79qyjxwSPOIOWhCdOwOovxzb
         jUQ49quTUCJYZFKlckYneez5sj1A7GQA1DT1TBpUTFWpmCkrswqjp2FsK4CaAOg+43Jp
         Ax1HAG17raxgZW5CHToxCTxgQSheBCqgwnxNCKs1Kei/8oBHP37ivsN86/eBMZ6YJR1n
         8tirequ1SrWpLM1zAFHg0gzeugfeDUdbKGFo1cWX7YzttoFqRzzrtwm+RR3HBW/2jl4q
         djj3BjxZWeKxwdCv3Q1pytTUVQywfFjLvpY3vPR32yyINBb6DaLoonm632PcnIoX64oK
         8aaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cRBSOx180b/8yVnDTJgXllPZieNx41tmIQu1Fr+M/y0=;
        b=PDZRft1nPAne9ZiVLnBWrHWwcxzO8SXoyCeBoHsR8IhZzxK4pTKrdcsjXG7Xhh2UbJ
         Yn3QAt+zY5tOgV53GgHWCYN1EDL9cEnCrOpn5aRSRb1PjBEmmOXTH4VTZdTt//klY0pS
         bqTwovsn9BZJyGKuUlhGAmaYpL/9ravEpNKEpJQSyVAU+PxbmRvRM8WOpqs1O9AHSb86
         /Ae4NsJw1m463uYcFOyUzZQqr63D+cjHZ1SRfZOh9w6Xtel/Xe6onxP+QFcZhpCBM61x
         Ab0WA0wsujjKUmT2T6lpUPlqAj0uJ/eMsqDE2pEScQkjFzsuTpKr3WymbFDqpkmMg3lG
         fKoA==
X-Gm-Message-State: AOAM533m38KaraCE9LGtNxxE2Vn67WTwuQTuEnXWULeLkLLtJYb2rUBZ
        6HTWIQVr7m6mMp0Oy0CbGNCgbA==
X-Google-Smtp-Source: ABdhPJyDGxyR9IzsEaiyY0U+isINphgNDkB6KtHKRrnbNjwJ9w+o/v2PB/imHNlCNV3+IFKvhTVhiA==
X-Received: by 2002:a05:600c:4ba1:: with SMTP id e33mr9597480wmp.39.1623048886601;
        Sun, 06 Jun 2021 23:54:46 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:90c:e290:7c1f:1c9f:555e:7398])
        by smtp.gmail.com with ESMTPSA id l5sm16145742wmi.46.2021.06.06.23.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jun 2021 23:54:46 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tobetter@gmail.com, Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 3/7] arm64: dts: meson-sm1-odroid: add 5v regulator gpio
Date:   Mon,  7 Jun 2021 08:54:31 +0200
Message-Id: <20210607065435.577334-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210607065435.577334-1-narmstrong@baylibre.com>
References: <20210607065435.577334-1-narmstrong@baylibre.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=854; h=from:subject; bh=e5HwpRzORbnYCuuj9Al0sdpop+blxy0nlslXu8zzo9s=; b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBgvcJArOTRfLm5KMYAm4Gk49/w4dTCgkXImCBFEesY MA5e84SJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCYL3CQAAKCRB33NvayMhJ0fEdD/ 91Sbp+cA72Pa1nKQjFl4lIyHt/uAm83qdGLx0WpyJ6guR2phAa8I79ISM41G8ccSTWjUXTvnoIwWq5 zAear9Ja5GXreXstcysapZEqjCuMKgiLQzfXHN1Qq9IifFbv86GoS/VmSCS2BQ8wMR9ke3UFK3QlGj 25F3U2NI2/cNsWJVLlfg51VD02zHTLidIWw/GHVQK+ePs5XSeKjxXtS36qt0f4PvzGICHAQekeYim1 MvbP+wfiC9z/BC59AVvvIAJn3tkRMddaNmVybsAJNN1pUhcM8A9Vx0/KPAg9n/+2gbjy7J4oKWaJVA t1ve+pHW80lsp357Bwg/Rt4MYC7MRQZmNS5PKMGlXGph0/mqJxpKFv0Ed36+4WIofFO19khQMEiv49 m8cQZtaMD25pCgB6zz2t/u2Duw4/gi5w67lrUbGFZ7c8VPE+FI7QNkGmyHYna+Szv8/pko6O9dYQI8 dOUci15YFBMLN+6HQ20nvbowldNlL53X9ROTiCHN9MU7dpYcZY4aSQ40eYaIwVYDiaw4u34yK/M3u8 v5W8kaZcFXfPQAhnyOhs2Vgj+NU9KsZUiYXk96Xq2bxgwJJ0evWDY5aPdGVio5TUwo/vD2IuWJNAIr sKoJkK/AYneNZkZj7CXBZkoCMrXzwyXKtrIK/0jwRArZ9WxHKiMcBMDnuDHg==
X-Developer-Key: i=narmstrong@baylibre.com; a=openpgp; fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As described in the Odroid-C4 & Odroid-HC4 schematics, the 5V regulator is controlled
by GPIOH_8 and in Open Drain since this GPIO doesn't support Push-Pull.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi
index e64359163331..fd0ad85c165b 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi
@@ -83,6 +83,8 @@ vcc_5v: regulator-vcc_5v {
 		regulator-max-microvolt = <5000000>;
 		regulator-always-on;
 		vin-supply = <&main_12v>;
+		gpio = <&gpio GPIOH_8 GPIO_OPEN_DRAIN>;
+		enable-active-high;
 	};
 
 	vcc_1v8: regulator-vcc_1v8 {
-- 
2.25.1

