Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 117F5365DBA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 18:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233227AbhDTQu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 12:50:29 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49796 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233212AbhDTQu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 12:50:26 -0400
Received: from mail-ed1-f71.google.com ([209.85.208.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lYtZR-0003VY-Rc
        for linux-kernel@vger.kernel.org; Tue, 20 Apr 2021 16:49:53 +0000
Received: by mail-ed1-f71.google.com with SMTP id y10-20020a50f1ca0000b0290382d654f75eso13446519edl.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 09:49:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3dMD592ElHi8nMETJZuVYSTLboZNsfqcXUmwdRPVf7o=;
        b=npvlL/5euj3XP+tu4/R5YOIJ5qxPyr/+I2maZz1mitDZIwsQayt/Vagtj2l49YM9FS
         1LqkzKkFzEpG0gSr7z2DNs1o2mkAsjWefimyJl4ga99MltBI/1gxLOm7c3HHhgA/SJ8b
         oEfU/DGYfxCapsKaJmFk4pCFvHThJ6LTnWbINlpoyH7IAbxvBk3Hswj+TQaFLH+S57ie
         Xp/U1hsBZyyO3zq5UJ29qsBObwTW5AB/Irsz+epAGbnq9AIcvimSJifLzLg6V7OMIysF
         2ca9BsqfJsdDLRnr5yr4IzOOs+Lq+0WnRr2udBThYXlxB8TiKI79KJ4Tcxuj6DMcolYk
         OtPw==
X-Gm-Message-State: AOAM530xjoWDb9asw3+FhSm88xSwss00Ek0PGs9DV4zs7FBgbJ9C/Bir
        eV7mmd5FvuLoaF0YUB6CMGqVyBKhWB8baSn8TPFsh7bYk08CmOSvg0BNSaItjN47rEIvjiRN9QT
        BxSeLNdBIPZcjee7Gp4fcx6prP5648hrjUJKYgFOPYg==
X-Received: by 2002:a17:906:3544:: with SMTP id s4mr29389524eja.73.1618937393512;
        Tue, 20 Apr 2021 09:49:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxml5h0MCp/k5aMeRiDFOFNo/wwzl9BNnecPMV2V8bC7mVCzWrVVPBCya4E8qd8HJd3A8nb9g==
X-Received: by 2002:a17:906:3544:: with SMTP id s4mr29389514eja.73.1618937393389;
        Tue, 20 Apr 2021 09:49:53 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-180-75.adslplus.ch. [188.155.180.75])
        by smtp.gmail.com with ESMTPSA id c12sm18252873edx.54.2021.04.20.09.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 09:49:52 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/11] ARM: dts: exynos: enable PMIC wakeup from suspend on Arndale
Date:   Tue, 20 Apr 2021 18:49:35 +0200
Message-Id: <20210420164943.11152-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210420164943.11152-1-krzysztof.kozlowski@canonical.com>
References: <20210420164943.11152-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RTC on S5M8767 PMIC can wakeup the system from suspend to RAM.
Add a generic property for this.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm/boot/dts/exynos5250-arndale.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts b/arch/arm/boot/dts/exynos5250-arndale.dts
index a161f6237c7f..a771542e28b8 100644
--- a/arch/arm/boot/dts/exynos5250-arndale.dts
+++ b/arch/arm/boot/dts/exynos5250-arndale.dts
@@ -218,6 +218,7 @@ pmic@66 {
 		interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&s5m8767_irq>;
+		wakeup-source;
 
 		vinb1-supply = <&main_dc_reg>;
 		vinb2-supply = <&main_dc_reg>;
-- 
2.25.1

