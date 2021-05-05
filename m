Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9B52373CF3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 16:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233806AbhEEODf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 10:03:35 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54853 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233707AbhEEODU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 10:03:20 -0400
Received: from mail-qk1-f197.google.com ([209.85.222.197])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1leI6Y-0008Un-BN
        for linux-kernel@vger.kernel.org; Wed, 05 May 2021 14:02:22 +0000
Received: by mail-qk1-f197.google.com with SMTP id o14-20020a05620a130eb02902ea53a6ef80so1084400qkj.6
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 07:02:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aFybNoYvXXuMhUMueJoFGIOzsnT8VCCuO9x/0O6WW3Q=;
        b=FXMZg5otUz8Wg8OayctkKzvm93tJFwlaa+CZ0ZrvwI1OjJ6BxNqW+8ZhFOup8nEAPO
         SINWaifmdeDRg2dyfYYEL5jriWu7u6Um5mcmi3ZMCdanRfksUuLw5Ts9ESJq/vKKamLV
         Nqknuyj2Zg+i3srARBy9pwmlittC3PzI2itKIIOHzZAXI91eAPvapb0fkdawceVMLQpO
         KEllQy3X/guJDgOHyMiC+nCAT6jFo1sHXnQJnVy60GxeiAToJVD2kJFdVc+vT56EhX9H
         GNa/pHVDpAURrrcTAF8vTL6x2VZ2G9LKaoG99jxGJyTFpKJexoIZaCVAOmUXE2IArTW/
         k1vw==
X-Gm-Message-State: AOAM532CdkGouIUmwTROdBY2sEm26ZdoytbbiFncqeOsaOVIpY+gfwKO
        lRAcluRB2RLaTLiNbVB9nip2CdrQfw8w5Kuts9BforABZpltW1gzWJquTY+R0V4BjoJzlAMk9Pa
        h87EZGkepblrHOFeQELkVLzqpZuCk0gFZCrd65TTAtA==
X-Received: by 2002:a05:620a:4008:: with SMTP id h8mr30402466qko.366.1620223339201;
        Wed, 05 May 2021 07:02:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxIh64S24rt8pIj4QLk85n1rPZ1rAb4wDfcLPTkMNb4AjA8b8DYcHICmN8fDtMnm0CAKo0PHQ==
X-Received: by 2002:a05:620a:4008:: with SMTP id h8mr30402338qko.366.1620223337602;
        Wed, 05 May 2021 07:02:17 -0700 (PDT)
Received: from localhost.localdomain ([45.237.49.2])
        by smtp.gmail.com with ESMTPSA id 97sm5016632qte.20.2021.05.05.07.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 07:02:16 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] ARM: dts: exynos: fix PWM LED max brightness on Odroid XU4
Date:   Wed,  5 May 2021 09:59:41 -0400
Message-Id: <20210505135941.59898-5-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210505135941.59898-1-krzysztof.kozlowski@canonical.com>
References: <20210505135941.59898-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no "max_brightness" property as pointed out by dtschema:

  arch/arm/boot/dts/exynos5422-odroidxu4.dt.yaml: led-controller: led-1: 'max-brightness' is a required property

Fixes: 6658356014cb ("ARM: dts: Add support Odroid XU4 board for exynos5422-odroidxu4")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm/boot/dts/exynos5422-odroidxu4.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5422-odroidxu4.dts b/arch/arm/boot/dts/exynos5422-odroidxu4.dts
index ede782257643..1c24f9b35973 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu4.dts
+++ b/arch/arm/boot/dts/exynos5422-odroidxu4.dts
@@ -24,7 +24,7 @@ led-1 {
 			label = "blue:heartbeat";
 			pwms = <&pwm 2 2000000 0>;
 			pwm-names = "pwm2";
-			max_brightness = <255>;
+			max-brightness = <255>;
 			linux,default-trigger = "heartbeat";
 		};
 	};
-- 
2.25.1

