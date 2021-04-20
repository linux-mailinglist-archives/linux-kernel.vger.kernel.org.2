Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95298365DCA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 18:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233340AbhDTQuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 12:50:44 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49833 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233324AbhDTQui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 12:50:38 -0400
Received: from mail-ed1-f70.google.com ([209.85.208.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lYtZe-0003Yt-9P
        for linux-kernel@vger.kernel.org; Tue, 20 Apr 2021 16:50:06 +0000
Received: by mail-ed1-f70.google.com with SMTP id f1-20020a0564021941b02903850806bb32so7515651edz.9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 09:50:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bj1M9QiCdlb898I0Pyior9VNVYymfqUZCE25Z1A8C8I=;
        b=HWTkAsH05tF9ktEN2nLeF+E9Fr33cqUnSlmkMMBYuZUVtH77rMnqAHR0jf+BmBOtiZ
         +e9nHYqTMluyE7vHgdTqecmwbhWLu3o24e4p/8hzo1ENd4CKuCXS0G6zV9ta4RyiQJri
         GrPi8Avb5+e43uYG0ZTMz5PZ4Ba2R9INT4+1NWcx88aOi9jHN/7UGoiq2CVofijVWqga
         OI07MqQQZQCVPwUkMkCyjQrJCEU/m/MrdKSBYjnApiI8MN15rh9yb6ysamAfayyOzHoO
         ewC+qyy6Uva2OEKRpVfQurZoOse7EB/9Qifu2Ppln/k/IL3zD8HD3o/3DdtK4C3IVO+e
         BMyA==
X-Gm-Message-State: AOAM531PWGBVbrhIHIHPfF5o06GNeFQmJjA8TpuwxPJrh5PZ6/gdn/hn
        9OvRT1Vxv6GAzHBkRHKYgCCzWifEVOXdCZMCgZshjkTrVUue9xiPm6e1RPg4uZKOA1tKX4Gxqqy
        xMykb6pL2ke5Ub/7OOr3ZVGJayfg6Etwwefq1J3lHRg==
X-Received: by 2002:aa7:c40b:: with SMTP id j11mr33821642edq.219.1618937406069;
        Tue, 20 Apr 2021 09:50:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwOX41yAZ5d2I/3hC672/0TlhE2JqeKmJHyH8IhJtZIpVrL1kp4tD55KzYPmGl8DVxg0Ztc4Q==
X-Received: by 2002:aa7:c40b:: with SMTP id j11mr33821630edq.219.1618937405920;
        Tue, 20 Apr 2021 09:50:05 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-180-75.adslplus.ch. [188.155.180.75])
        by smtp.gmail.com with ESMTPSA id c12sm18252873edx.54.2021.04.20.09.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 09:50:04 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/11] ARM: dts: exynos: enable PMIC wakeup from suspend on Arndale Octa
Date:   Tue, 20 Apr 2021 18:49:40 +0200
Message-Id: <20210420164943.11152-8-krzysztof.kozlowski@canonical.com>
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
 arch/arm/boot/dts/exynos5420-arndale-octa.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/exynos5420-arndale-octa.dts b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
index 1aad4859c5f1..dfc7f14f5772 100644
--- a/arch/arm/boot/dts/exynos5420-arndale-octa.dts
+++ b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
@@ -352,6 +352,7 @@ pmic@66 {
 		interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&s2mps11_irq>;
+		wakeup-source;
 
 		s2mps11_osc: clocks {
 			compatible = "samsung,s2mps11-clk";
-- 
2.25.1

