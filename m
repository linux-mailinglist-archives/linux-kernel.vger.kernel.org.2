Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77F19365DCE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 18:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbhDTQus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 12:50:48 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49837 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233341AbhDTQuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 12:50:40 -0400
Received: from mail-ej1-f71.google.com ([209.85.218.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lYtZg-0003Zd-72
        for linux-kernel@vger.kernel.org; Tue, 20 Apr 2021 16:50:08 +0000
Received: by mail-ej1-f71.google.com with SMTP id d16-20020a1709066410b0290373cd3ce7e6so5010811ejm.14
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 09:50:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qfjGBaYEFblHkd553VwSn0+2ZqklK3J6fJwIYGGKLB0=;
        b=q1xBr9e81w8aaHgVdsN0UN9hisxqHdYUgbosyx4XHe3DEA960Nis2XHSuwHnwGDM+1
         +04KXlvOle9p7JsAM94rutx5qmLxjDLglCuw6YGh3pVKwq5TzvIjxpqvmdD2Zmdo6iuP
         wwZvR1QAKE+wkdnyeXrKWRuoM2HZxjIPhX46eKxHr2cD9Ah+Ve2j9hjCqpsrWGg6Aluy
         nRm4bz5nSM34fMV4FaxABp9AI2efpBYTa2SsGj/cx9v/DYMHw7nYHxL1kvo/0leNEpdk
         JEOH7KHfci7p1cSiDjkWliEHMlFZhA7qWsiFmaPkIRJp6JVM87iPOIHSqI4KWdy0nHIc
         SQeA==
X-Gm-Message-State: AOAM530K7fbGCb1O8UNczY6GLQIwSnAexgpOcgtiBjZ+E/gmPtiDLYeG
        yd69NJxyRLYPf1g1OPWbEIwI2G8ZccY1On+P6xFI79tJOu5d8u3IgsokyFh7714AObMbzIogr/Y
        rP3QMmTu3qvyhTmRT2+CS18BbFqrPSfwQ1yFU5WwuRg==
X-Received: by 2002:a17:907:78d0:: with SMTP id kv16mr28383297ejc.174.1618937407835;
        Tue, 20 Apr 2021 09:50:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzt3lRVGoh8cst179jB4h9NfUTzzv+DW0UzRFLMekwlH45M2Ca2I32/cl7/sLnXBL+g1VBbqQ==
X-Received: by 2002:a17:907:78d0:: with SMTP id kv16mr28383289ejc.174.1618937407728;
        Tue, 20 Apr 2021 09:50:07 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-180-75.adslplus.ch. [188.155.180.75])
        by smtp.gmail.com with ESMTPSA id c12sm18252873edx.54.2021.04.20.09.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 09:50:06 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/11] ARM: dts: exynos: enable PMIC wakeup from suspend on SMDK5420
Date:   Tue, 20 Apr 2021 18:49:41 +0200
Message-Id: <20210420164943.11152-9-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210420164943.11152-1-krzysztof.kozlowski@canonical.com>
References: <20210420164943.11152-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RTC on S2MPS11 PMIC can wakeup the system from suspend to RAM.
Add a generic property for this.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm/boot/dts/exynos5420-smdk5420.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/exynos5420-smdk5420.dts b/arch/arm/boot/dts/exynos5420-smdk5420.dts
index d506da9fa661..a4f0e3ffedbd 100644
--- a/arch/arm/boot/dts/exynos5420-smdk5420.dts
+++ b/arch/arm/boot/dts/exynos5420-smdk5420.dts
@@ -132,6 +132,7 @@ &hsi2c_4 {
 	pmic@66 {
 		compatible = "samsung,s2mps11-pmic";
 		reg = <0x66>;
+		wakeup-source;
 
 		s2mps11_osc: clocks {
 			compatible = "samsung,s2mps11-clk";
-- 
2.25.1

