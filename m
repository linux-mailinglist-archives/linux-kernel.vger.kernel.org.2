Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69E9C373CF9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 16:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233739AbhEEOEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 10:04:14 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54886 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233728AbhEEOEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 10:04:12 -0400
Received: from mail-qv1-f69.google.com ([209.85.219.69])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1leI7P-000087-Ge
        for linux-kernel@vger.kernel.org; Wed, 05 May 2021 14:03:15 +0000
Received: by mail-qv1-f69.google.com with SMTP id f20-20020a0caa940000b02901c5058e5813so1696260qvb.23
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 07:03:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gHlNQxBMJJJPApy8J9ScRibX6GAiaOm1NP7zfEL0aKw=;
        b=ae9fbJP+BM4nmIkpptP4iIHJniYh9MZM4ZC8XMdLVev8giniqT61t1POlESWqfRsJK
         YflzvcffT1wKC+5Zrtta37skQhgQslnMhYmQSDrfWBX4cwsXpBzT4MyvRWNeI4tdu56D
         OSx/zMGowoAGmuKm55S6dV6WZUG8s9YbpD1lw64ZpEthNQjhflPqrHoZPZ54q5teoBNC
         tpsKMNrkq3UYulqWwMGxy655T8Xr18AaHWKwios3R+J/8wWHXr+PnqvGv+pEk+XMWRNh
         7wR/H3oIAZnYCCP656frJdElQ7jy5gTtIIKfgWqLSvZOfPA/hSbcpHYPT8kUX1wj3scS
         3AXw==
X-Gm-Message-State: AOAM532UGBl5RpWRjC6+j62H1smkrSd6P/0ORYMlj3ySZVnQpdGoI53l
        ZHE5AjnR4e5VXldfKiYpyYDiSjZbWbuvaXeCIROVU6kFsF2tgw2E2KF/Y9yKOWGowlqEuRJBbts
        wULmjPbi8ADe3HeDm0gKzC19YbxobOXMhRZ8UI3g4GQ==
X-Received: by 2002:ac8:118d:: with SMTP id d13mr26914119qtj.294.1620223394012;
        Wed, 05 May 2021 07:03:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxx77jKyRL1IlHqhDJ4GD0HwdRxVnhzwQKiw5Ri5Ut4bvfEkDj1ezNgIO6TQsyv10c+hqq6OQ==
X-Received: by 2002:ac8:118d:: with SMTP id d13mr26914106qtj.294.1620223393830;
        Wed, 05 May 2021 07:03:13 -0700 (PDT)
Received: from localhost.localdomain ([45.237.49.2])
        by smtp.gmail.com with ESMTPSA id l8sm4956754qtv.18.2021.05.05.07.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 07:03:13 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH] ARM: dts: am5729-beagleboneai: drop unused Broadcom WiFi properties
Date:   Wed,  5 May 2021 10:00:15 -0400
Message-Id: <20210505140015.60013-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The brcm,sd-head-align, brcm,sd_head_align and brcm,sd_sgentry_align are
not used by the driver and not present in dtschema:

  arch/arm/boot/dts/am5729-beagleboneai.dt.yaml: wifi@1:
    'brcm,sd-head-align', 'brcm,sd_head_align', 'brcm,sd_sgentry_align' do not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm/boot/dts/am5729-beagleboneai.dts | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/am5729-beagleboneai.dts b/arch/arm/boot/dts/am5729-beagleboneai.dts
index 149cfafb90bf..d3b2e87a6266 100644
--- a/arch/arm/boot/dts/am5729-beagleboneai.dts
+++ b/arch/arm/boot/dts/am5729-beagleboneai.dts
@@ -582,10 +582,6 @@ brcmf: wifi@1 {
 		reg = <1>;
 		compatible = "brcm,bcm4329-fmac";
 
-		brcm,sd-head-align = <4>;
-		brcm,sd_head_align = <4>;
-		brcm,sd_sgentry_align = <512>;
-
 		interrupt-parent = <&gpio3>;
 		interrupts = <23 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-names = "host-wake";
-- 
2.25.1

