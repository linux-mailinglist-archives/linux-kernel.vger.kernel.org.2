Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C450E365DC4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 18:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233255AbhDTQuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 12:50:37 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49823 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233288AbhDTQud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 12:50:33 -0400
Received: from mail-ej1-f70.google.com ([209.85.218.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lYtZZ-0003Y5-Ii
        for linux-kernel@vger.kernel.org; Tue, 20 Apr 2021 16:50:01 +0000
Received: by mail-ej1-f70.google.com with SMTP id d16-20020a1709066410b0290373cd3ce7e6so5010700ejm.14
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 09:50:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SZDfcyCZwVylLX5TsAAAA/wUyySKv8eKHfB4MShW5ZM=;
        b=QIMtMxG3IfVp8qaRCJmfjz3zlsC+mjcTy6yqlnxyiKWABFo+hLp49lajzQtIjuvJgj
         F+EzpUSwEY3m4Uxz+o3ibiVoBykENbthcFmykgh2OHMKvG7Y30gIJ+kcUOhd3bZKc6P1
         SKwyV0P1QjXF5Z3Y+azZE0uyakc/fVauavSkU3sr7rmZQXlvPA+EDzzNK5xHPpRC032D
         x3YAMbtx0u+7R2iSarETDtPxX9beLs5fJO7+RGwR0p7WgNMPAImTABDhEcXkztcbdCKy
         YWLBZ1etD/uRFTUmysYrYyF8Pz5m0MeOhyDg9rqT83uNDDK7cbOZKodJEjdUEqXemZGK
         NGhg==
X-Gm-Message-State: AOAM533A9AGDYeNM/p5ldd6x2Tjk/L7wlE1dBkFXIMJlySDA5iZJhJLI
        o18GFjJdR6tt2MaQxN95haAcDnOYm0FdLsEnsn1HuCvCZ/tlvbsRkOdVEF3aC10frnezTGcmnzM
        Ljbu2ED8FLuijwLMEhzQUIqkUhuADn+8T+io7U6aNrw==
X-Received: by 2002:aa7:c7da:: with SMTP id o26mr33442344eds.244.1618937399814;
        Tue, 20 Apr 2021 09:49:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxvd13jGax0cMnNAZv3uD8tJgdViFUxJlK5G4XxKdlgdYp76PfhEquTOjft8MVprNuWSmmdKw==
X-Received: by 2002:aa7:c7da:: with SMTP id o26mr33442335eds.244.1618937399717;
        Tue, 20 Apr 2021 09:49:59 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-180-75.adslplus.ch. [188.155.180.75])
        by smtp.gmail.com with ESMTPSA id c12sm18252873edx.54.2021.04.20.09.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 09:49:57 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/11] ARM: dts: exynos: enable PMIC wakeup from suspend on Odroid X/U3
Date:   Tue, 20 Apr 2021 18:49:38 +0200
Message-Id: <20210420164943.11152-6-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210420164943.11152-1-krzysztof.kozlowski@canonical.com>
References: <20210420164943.11152-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RTC on Maxim max77686 PMIC can wakeup the system from suspend to
RAM.  Add a generic property for this.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
index 5bd05866d7a3..5b1d4591b35c 100644
--- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
+++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
@@ -282,6 +282,7 @@ max77686: pmic@9 {
 		interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&max77686_irq>;
+		wakeup-source;
 		reg = <0x09>;
 		#clock-cells = <1>;
 
-- 
2.25.1

