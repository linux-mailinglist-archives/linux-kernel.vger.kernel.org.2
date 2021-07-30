Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A18E33DBB23
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 16:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239513AbhG3Otl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 10:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239430AbhG3Otf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 10:49:35 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2EDC0617A2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 07:49:29 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id j2so13498076edp.11
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 07:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U9K2fCuQkFkuejqJypW0+59cAZpu5FWH3o4en7PCa/U=;
        b=xBHhd9zvnsIklZ1GYG2DllDAjGkCvzS1dG3aJNp2jJBUjGCODD25G5qxsc2ero+kap
         RpCdICsb5OUgHCuWG7tnZnMbM3MenMlhhh6Us32/VRdY3+PzBzn8R4/DOJeoRZZE5rQ8
         uzzVSVy/gCAn685CUUH8MSNnTu8iENv6JV7pC3EscmTCEj6NtZuXP58g8fwocXspBy1u
         MVIeizHdTl5IMp+ptpOLLfPsyg1TX0mDKnSatp61VSaOc1wiTWROa2J9DeGZvd/ygkHm
         X5duQR4eJDCRyu7okuNaMH+BeBYZyhWPWyAxgKidQsPo4pto1ZKIeHiRlfzVqJam76cc
         FA7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U9K2fCuQkFkuejqJypW0+59cAZpu5FWH3o4en7PCa/U=;
        b=Dy21Rv4LWMdeJRphA/obTbboMr3C+nGq5w/yycqg3GcQNdnUXfVNS9pfdpeU4yKzuc
         8YFbSCt8hmXsYjhVj3t/pXlQR0GiOBBReuC83F4v13fBOGROHYwSByKqxXR9m5YS9Xrm
         YuR6EAztWw+eqTPjN9+jd28ZHoVw8ReKc6Tcsc4saysaMEn45IfM7xasoRrkhPahiwH9
         eHil2iVr3qReErXiJ2PICLi5B5Vu+0zhwfHD1omRwlhawJQNIsaUWDKI9lxcNhnRSjzJ
         As/M4bz8jan5Dex0YYDSqpFT22sZpwgaGrlHEXIduJUzgVAxYRiAsZs7jBOdzkZPgDew
         vtLg==
X-Gm-Message-State: AOAM533TQPQvtPR0akyvPLHhM+8P4Vrhh/RKwCvDfprr5Z3uqLRHi6lb
        s4u0FmUxpB1dVe3iV811/qcjJg==
X-Google-Smtp-Source: ABdhPJxvInSByeFK70X/NowaXTvQWPUys9gilEqsi8KsW2g7rqMqdK8b8pF3hHKfCXSK9nyni6+Zqg==
X-Received: by 2002:a05:6402:411:: with SMTP id q17mr3370148edv.29.1627656568574;
        Fri, 30 Jul 2021 07:49:28 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id b15sm622945ejv.15.2021.07.30.07.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 07:49:28 -0700 (PDT)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tomasz Figa <tomasz.figa@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Charles Keepax <ckeepax@opensource.wolfsonmicro.com>,
        Ryu Euiyoul <ryu.real@samsung.com>,
        Tom Gall <tom.gall@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: [PATCH 03/12] dt-bindings: pinctrl: samsung: Add Exynos850 doc
Date:   Fri, 30 Jul 2021 17:49:13 +0300
Message-Id: <20210730144922.29111-4-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210730144922.29111-1-semen.protsenko@linaro.org>
References: <20210730144922.29111-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document compatible string for Exynos850 SoC. Nothing else is changed,
as Exynos850 SoC uses already existing samsung pinctrl driver.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
index 38a1416fd2cd..e7a1b1880375 100644
--- a/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
@@ -22,6 +22,7 @@ Required Properties:
   - "samsung,exynos5420-pinctrl": for Exynos5420 compatible pin-controller.
   - "samsung,exynos5433-pinctrl": for Exynos5433 compatible pin-controller.
   - "samsung,exynos7-pinctrl": for Exynos7 compatible pin-controller.
+  - "samsung,exynos850-pinctrl": for Exynos850 compatible pin-controller.
 
 - reg: Base address of the pin controller hardware module and length of
   the address space it occupies.
-- 
2.30.2

