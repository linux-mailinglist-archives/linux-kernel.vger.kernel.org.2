Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B137B33B2FD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 13:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbhCOMnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 08:43:52 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:33270 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbhCOMnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 08:43:22 -0400
Received: from mail-wr1-f71.google.com ([209.85.221.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lLmZ7-0004i3-2O
        for linux-kernel@vger.kernel.org; Mon, 15 Mar 2021 12:43:21 +0000
Received: by mail-wr1-f71.google.com with SMTP id e29so15042345wra.12
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 05:43:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rxaIjR1J//5PkyRZXm0+xJCkI6bQEZtH1ohc21euivs=;
        b=Ms+j8J0WGPF96MN/ohaZRTK1yf9KetJ1nLIjE28ucklK5cQnHEYPUPOxPiJ2J8obcf
         P7ej+AkWleN1BkCDVDrwNk+1GsuOGDogwl10yEMaFTEANuH7I6HskuRtsnpaAAPyJjt8
         a1KwXsJCvopHj8jwUB3vCjtD6CEdmkCl0t6d32Y/JWeKQFzmZ/Rg63X9SpEKdAIR1a4U
         5Z1MFPBP4q82TGWl6SaEVxKJoa0eFr1WX2oew7jetjCGzcIsxuNyOoWhvijzRqtp/y6l
         feur03R0fDbjl4w5PlYLBN2QvaXYyrA4V1BtjTW/ecLbWLFMttnMKtoQWl4xXC8ANULq
         xr1w==
X-Gm-Message-State: AOAM533ikqtS18CO0Par5YPZ05SuwDCYhdv4U3WWt1JKTEQ8EgBcypTt
        f6ch9k4AfBYIahoNjZ+kdPMNYhRkr/nJ6O0Vcu7MRWe3ohHBUAGDsmIWHNRGF7AhKu2VBpt0ZoT
        qwKyBe9ngbysk4IOscgf564MSKdUeX2NJK67dgt7uhg==
X-Received: by 2002:a05:6000:1546:: with SMTP id 6mr27051363wry.398.1615812200828;
        Mon, 15 Mar 2021 05:43:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx19SoVoAAQrYf7moALON3Fv15zBfY8pJOsEEAAhFpyMpxvBF4bD3zbUHBRa65h38JIQJV97g==
X-Received: by 2002:a05:6000:1546:: with SMTP id 6mr27051353wry.398.1615812200719;
        Mon, 15 Mar 2021 05:43:20 -0700 (PDT)
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.gmail.com with ESMTPSA id r10sm14410094wmh.45.2021.03.15.05.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 05:43:20 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 3/3] arm64: dts: exynos: white-space cleanups
Date:   Mon, 15 Mar 2021 13:43:13 +0100
Message-Id: <20210315124313.114842-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210315124313.114842-1-krzysztof.kozlowski@canonical.com>
References: <20210315124313.114842-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixup white-space issue:

  WARNING: please, no spaces at the start of a line

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
index 413cac63a1cb..773d9abe3a44 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
@@ -1002,7 +1002,7 @@ events {
 		ppmu_event0_d1_general: ppmu-event0-d1-general {
 		       event-name = "ppmu-event0-d1-general";
 	       };
-       };
+	};
 };
 
 &pinctrl_alive {
-- 
2.25.1

