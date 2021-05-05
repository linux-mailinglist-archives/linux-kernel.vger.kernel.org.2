Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5AF6373CEE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 16:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233772AbhEEODZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 10:03:25 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54843 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233713AbhEEODN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 10:03:13 -0400
Received: from mail-qv1-f70.google.com ([209.85.219.70])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1leI6S-0008T7-8o
        for linux-kernel@vger.kernel.org; Wed, 05 May 2021 14:02:16 +0000
Received: by mail-qv1-f70.google.com with SMTP id h88-20020a0c82610000b02901b70a2884e8so1701261qva.20
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 07:02:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q9OdBSHulNH5gFLHkIOCDv8QntRXx2/eXhHIjzSoClg=;
        b=T3qhH78X+NTK5Z2o6LyXupq4i4ndAfE827tZYW3hIxgIp0ihtXN669vmPOjOumTqDu
         DHiCmGQtFnLOh1rom+KMdsp3jRHmlrqjFqXO7myAjTS0knqUBEVBG9JJxGWJ2pBPDoZf
         UTVDoeeLAcy7IsMsEkTsxC+EsoGFaqn1dGOusW2SNvu31SA9XwHS51No5XYVxtzqdLYP
         a5R+PspKZXro5YqLghO1OhIAdgB1DQRZZWGvqoLgLBfE6miKJBW5E5VZynKT5UGDn8ek
         rtYznr588aCGEa+9+sofBJuPiB2Zo3s6FVI6HcApHIxgr4DKARATXAGe1zKBvIPWe9Oc
         c/Pw==
X-Gm-Message-State: AOAM531AK4y5nLjdEbnJyDkoCjpdCf1DBWW6IOmCoeJ4d2hLUrEAMe9I
        SvOpJm0RTqSqbdNwvcbkeVegQl8eQXygEaALNMsMHtA6Ka0nqW42ULilgTMfbUqHl1xWgEo96Z6
        fRJcR3BibiFOYfQqHnY6iMFaRa2Tu6FmPKEBhsIb8yQ==
X-Received: by 2002:a05:620a:2081:: with SMTP id e1mr18232289qka.44.1620223335448;
        Wed, 05 May 2021 07:02:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwFRA7bKadLLvqEd32kd6vTBdINVWvP6c1I10p6p624rchszik9cN6XscoMa8hghI9bn7rsqQ==
X-Received: by 2002:a05:620a:2081:: with SMTP id e1mr18232273qka.44.1620223335283;
        Wed, 05 May 2021 07:02:15 -0700 (PDT)
Received: from localhost.localdomain ([45.237.49.2])
        by smtp.gmail.com with ESMTPSA id 97sm5016632qte.20.2021.05.05.07.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 07:02:14 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] ARM: dts: exynos: fix PWM LED max brightness on Odroid HC1
Date:   Wed,  5 May 2021 09:59:40 -0400
Message-Id: <20210505135941.59898-4-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210505135941.59898-1-krzysztof.kozlowski@canonical.com>
References: <20210505135941.59898-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no "max_brightness" property as pointed out by dtschema:

  arch/arm/boot/dts/exynos5422-odroidhc1.dt.yaml: led-controller: led-1: 'max-brightness' is a required property

Fixes: 1ac49427b566 ("ARM: dts: exynos: Add support for Hardkernel's Odroid HC1 board")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm/boot/dts/exynos5422-odroidhc1.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5422-odroidhc1.dts b/arch/arm/boot/dts/exynos5422-odroidhc1.dts
index 20c222b33f98..d91f7fa2cf80 100644
--- a/arch/arm/boot/dts/exynos5422-odroidhc1.dts
+++ b/arch/arm/boot/dts/exynos5422-odroidhc1.dts
@@ -22,7 +22,7 @@ led-1 {
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

