Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10E9D3A6F23
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 21:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235023AbhFNTfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 15:35:21 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35364 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234412AbhFNTfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 15:35:18 -0400
Received: from mail-ed1-f70.google.com ([209.85.208.70])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lssKg-00009b-Nv
        for linux-kernel@vger.kernel.org; Mon, 14 Jun 2021 19:33:14 +0000
Received: by mail-ed1-f70.google.com with SMTP id t11-20020a056402524bb029038ffacf1cafso11455123edd.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 12:33:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P0NAZ9mvHQKtho19Kodk6x42SkLdwGG//84ME/Va0gs=;
        b=YDeEKS90xTOnxY5uapomR6XAdBr5b08NAYJHZMrVXV3b+XNfYXlf9xA5WCpVNPXs77
         8/O5o0Agw2P8xotIUhvXycyt6lGkDybdEtEsQI7tMaLdVLqlQNAKiMBg9cg2tqNbPtPZ
         Lqdhk6zFzG/wL/PjR4gxXElQrOxaZ+Vqc1kBH16fY2fP3PvtuscHi/AL0P0YqkjK3BLp
         XIOAT0iIKbdQZWcDGgq4OIBMUpeZe9t0976asVs0MlK9UZ9MpoBQvx7MohmPw3hjF0Oh
         9E1gSf+7GOEwxY+emNW2Z3IQRgVxW1iW2zGPvH0geyHQ3J9Kx3guCh79JAeeNfxSECf7
         Z86Q==
X-Gm-Message-State: AOAM531Ouc/GrelE0nTJmyb/tSTYS7rDxr+eFoAFuoUEgUAQRNwl2vdI
        KGnPcJddeCFUF88gqOhGgV8Gy3AtvSJWrvMCpOiSYtfXBSG5P+g29D0VBEtvTHsGaY+aoOtENaH
        fyls7+CulGTAZoWhSifmiIMl8SMAN3G0150l55BMwhw==
X-Received: by 2002:a17:907:948c:: with SMTP id dm12mr16836650ejc.484.1623699194476;
        Mon, 14 Jun 2021 12:33:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyegN5ZDLDC6CBLPN9tGzm/ZZQeDNEXIQaiFCbsU2xFKTD2cPTtg93ymP/DXtEWH2egOhXeeA==
X-Received: by 2002:a17:907:948c:: with SMTP id dm12mr16836631ejc.484.1623699194295;
        Mon, 14 Jun 2021 12:33:14 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-177-222.adslplus.ch. [188.155.177.222])
        by smtp.gmail.com with ESMTPSA id gw7sm8029291ejb.5.2021.06.14.12.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 12:33:13 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL 1/2][PATCH] arm64: dts: exynos: enable PMIC wakeup from suspend on TM2
Date:   Mon, 14 Jun 2021 21:33:08 +0200
Message-Id: <20210614193309.20248-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210614193309.20248-1-krzysztof.kozlowski@canonical.com>
References: <20210614193309.20248-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RTC on S2MPS13 PMIC can wakeup the system from suspend to RAM.
Add a generic property for this.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Link: https://lore.kernel.org/r/20210420164943.11152-11-krzysztof.kozlowski@canonical.com
---
 arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
index 773d9abe3a44..cbcc01a66aab 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
@@ -391,6 +391,7 @@ pmic@66 {
 		interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
 		reg = <0x66>;
 		samsung,s2mps11-wrstbi-ground;
+		wakeup-source;
 
 		s2mps13_osc: clocks {
 			compatible = "samsung,s2mps13-clk";
-- 
2.27.0

