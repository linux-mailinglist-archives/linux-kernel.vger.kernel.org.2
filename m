Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D05B365DBB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 18:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233262AbhDTQua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 12:50:30 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49804 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233237AbhDTQu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 12:50:28 -0400
Received: from mail-ed1-f71.google.com ([209.85.208.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lYtZU-0003W9-8x
        for linux-kernel@vger.kernel.org; Tue, 20 Apr 2021 16:49:56 +0000
Received: by mail-ed1-f71.google.com with SMTP id y10-20020a50f1ca0000b0290382d654f75eso13446551edl.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 09:49:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fj7Vif2aTzH3tZdsi6YgQzN1WxIkWtk37rnugc0OEF0=;
        b=YsBWwZdiKGWQdHMmzrlegRfe3il/V/Wnw8USXWxF5OKI00Gg127bDxfgyk9ZB/M4xu
         l/qzrI7hDjU9lbBf9LZegddzAidXedVgidxU2IbDVOjirnbbGPG0qMvKnGnGk4LmAtZV
         lnhBaPW5I0G7eHY27fmfGUVLNq0qTITeHgPFiUuFxIAMDh+6/XbgtHxKzNhyxqLnjW+r
         Nl7r5KADnZPV5Ms5ygJT+AYZs9QdUIS01uGKLSb6js/cpGuLgHo9x/ePxSEodDEcrSkp
         iW2wZ8AtDdcp1qfqFYWFsPzkgeWS5DaGe1EsisCGrwpJXIDBnZbiPPTGBfuplkOSxqI+
         Cc3w==
X-Gm-Message-State: AOAM531KRcXg9Czm7C38ZiTjUVrPo5TuLIEmXsPPk3+XnnbZDC60XU5v
        zZW+TbKw+y+HJujOeInjeXEZgZ2cBi3F1RFoAKUvxVbpvjv5tDy8LDqEnwWhzhiN6ZNosqfTaKd
        M1osqUf4jNZB8AhuXinr9rraBRqGSL5bif2OO+KhE3g==
X-Received: by 2002:a17:906:b6c5:: with SMTP id ec5mr28557656ejb.290.1618937395092;
        Tue, 20 Apr 2021 09:49:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwSRr6NSrHQp8U2jeiaffvf8WYW9iKm2uFgtdWnQa2quGs+NQghxGhwm2wVUg9G15AZRlNR6Q==
X-Received: by 2002:a17:906:b6c5:: with SMTP id ec5mr28557643ejb.290.1618937394964;
        Tue, 20 Apr 2021 09:49:54 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-180-75.adslplus.ch. [188.155.180.75])
        by smtp.gmail.com with ESMTPSA id c12sm18252873edx.54.2021.04.20.09.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 09:49:53 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/11] ARM: dts: exynos: enable PMIC wakeup from suspend on Odroid XU
Date:   Tue, 20 Apr 2021 18:49:36 +0200
Message-Id: <20210420164943.11152-4-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210420164943.11152-1-krzysztof.kozlowski@canonical.com>
References: <20210420164943.11152-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RTC on Maxim max77802 PMIC can wakeup the system from suspend to
RAM.  Add a generic property for this.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm/boot/dts/exynos5410-odroidxu.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/exynos5410-odroidxu.dts b/arch/arm/boot/dts/exynos5410-odroidxu.dts
index 949c0721cdb4..884fef55836c 100644
--- a/arch/arm/boot/dts/exynos5410-odroidxu.dts
+++ b/arch/arm/boot/dts/exynos5410-odroidxu.dts
@@ -190,6 +190,7 @@ max77802: pmic@9 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&max77802_irq>, <&pmic_dvs_1>, <&pmic_dvs_2>,
 			    <&pmic_dvs_3>;
+		wakeup-source;
 		#clock-cells = <1>;
 
 		inl1-supply = <&buck5_reg>;
-- 
2.25.1

