Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58144365DD2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 18:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233405AbhDTQuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 12:50:54 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49846 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233362AbhDTQuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 12:50:46 -0400
Received: from mail-ed1-f72.google.com ([209.85.208.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lYtZl-0003aO-D3
        for linux-kernel@vger.kernel.org; Tue, 20 Apr 2021 16:50:13 +0000
Received: by mail-ed1-f72.google.com with SMTP id c15-20020a056402100fb029038518e5afc5so5911928edu.18
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 09:50:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TqJ62+H3p8lMBv0o+qNlrq3mJGwE89Butuxlq5byZWw=;
        b=PUJOoqwORUfJtm9frdSejKcFPzcPptNmLExUmfCt1QGGduwRaSE9QhY5sizKG0tgJv
         q4VfidHkYzok+lUY4bPlSOd9jIiFNKfoVr+ZNt9sqltBDhJuEx82SiL/vhdS93lTT/Zw
         W4rzbFROZ7PrkLBXN/i/tk9nsLFpWj6T/f0+bX8UDfNWegaarS+wC528K62aA9V43DEd
         7pH0AVuqUzHu+O0fPqR2Njgt7/St5J901MNveOtzLuv2F8voNDQoC3neloD6qFJK6c1a
         g646ekXVEXC9fM/nGN9nobs776L1bLJrwZSHchj63IAQLeGedQxpT6Cfxer8YBGnImVJ
         F/tQ==
X-Gm-Message-State: AOAM53235zvO12j1+jYDLYdmuoXLAczuqHeFO/EjBen9T4boIHYBiPv4
        GKFMP+JqNLRkA+ykGN8uxLV8XNCQZ8Wh23rnhIP9lValIGwL1Uo76FqkGdD8YWL0VODShFsBAkI
        jiZrd/6+04HiUuY9spnrNN3xiB+RyNH6qfzQc25s+NQ==
X-Received: by 2002:aa7:cd8b:: with SMTP id x11mr4729066edv.87.1618937413135;
        Tue, 20 Apr 2021 09:50:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxDDo9ukF3fqdtjY4XRoahPeCfemNkf0eD5yfTKHEHt5tiIkyXvhXPIhPPUxhSQBt2RR4Vnrg==
X-Received: by 2002:aa7:cd8b:: with SMTP id x11mr4729052edv.87.1618937412975;
        Tue, 20 Apr 2021 09:50:12 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-180-75.adslplus.ch. [188.155.180.75])
        by smtp.gmail.com with ESMTPSA id c12sm18252873edx.54.2021.04.20.09.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 09:50:12 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/11] arm64: dts: exynos: enable PMIC wakeup from suspend on TM2
Date:   Tue, 20 Apr 2021 18:49:43 +0200
Message-Id: <20210420164943.11152-11-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210420164943.11152-1-krzysztof.kozlowski@canonical.com>
References: <20210420164943.11152-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RTC on S2MPS13 PMIC can wakeup the system from suspend to RAM.
Add a generic property for this.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
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
2.25.1

