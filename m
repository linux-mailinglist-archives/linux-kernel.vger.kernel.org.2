Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2A563E8FC0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 13:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237493AbhHKLtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 07:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237433AbhHKLtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 07:49:02 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C911C0617B9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 04:48:35 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id lo4so3601522ejb.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 04:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dVbMUoW3ODB/HqrQj9QMsvg4UcjoOQphLtGJOfXQLG4=;
        b=tLqQ1Q4ZmDF0GWwO+C3F55BzoRVX2dKIyhgtgjHKKcJn/PcEISO/vhg4T66jllGPyg
         TjL2SEOYBd7o3vq+4AF3hONbsZpQByl/Rk2hxzZOAGtutCcFzU52yl9J+ILf6urD6uWk
         3t5Jn8isV1aAB6i+H0GzYszNThuxbsDspjFZ3A/anNv1LF1M3h/KRpVJ3Xveg4LiBPXt
         7WP3eNNpcEqwwR0rFHbuaOYmivA4J05/89x6Bko10CbWApIzxD0+KQdxxTtG6Gab2uAA
         OCrlQrN1jcMFhV/PJcP27Mks2CN71g1Hoy/V/qTiQq+3EGsfugqpRtw2o9PGX9/IjGTl
         zzCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dVbMUoW3ODB/HqrQj9QMsvg4UcjoOQphLtGJOfXQLG4=;
        b=mNMQe9ykLNP/7mweRLK9exWJtim6MVTdGfdFV+Ko3rcVT5//S5oLivjwpM3M5/udGy
         L1zPxO8qgPaIu7jda3Hzep+SZTD0fg8iKx4h9ioDjw8ePgLvaAAb3AZx7RQgXDobvZwb
         BbNhumwD5088/MNzcqm/KeS3qyqkGZVQxh82EzpMGeIN+gxaEVhDQxA3GM5fDMj/Q5Ia
         d6o9wop+434edIUalcHxF7h2xQqNRT3oeGLtHfs3WkbQgpqORylxlIW/dV+oR09Kztv1
         51Z+TAEgEpUk9P+tK4JxFtCHlLLyfgDIdzx8bhqqogqUmWbU0Ds+rU+HS1shn+K4n/nV
         jbsg==
X-Gm-Message-State: AOAM530DIKBs+ndLBIqku/sI3svWKVtLzA6KkLj/VWwhTMxHGA67oK06
        rUSX4uh9nNY9VNuXO9veDjuBTQ==
X-Google-Smtp-Source: ABdhPJxJLRHsH9CfRsfHJsy6TvmFx2W6Ic3KvGkXHyeQaKob/XnyuXcDZvw12C575KwVBsfnb1InOA==
X-Received: by 2002:a17:906:5413:: with SMTP id q19mr3265627ejo.422.1628682513955;
        Wed, 11 Aug 2021 04:48:33 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id i10sm11096232edf.12.2021.08.11.04.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 04:48:33 -0700 (PDT)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
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
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH v3 3/7] dt-bindings: serial: samsung: Add Exynos850 doc
Date:   Wed, 11 Aug 2021 14:48:23 +0300
Message-Id: <20210811114827.27322-4-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210811114827.27322-1-semen.protsenko@linaro.org>
References: <20210811114827.27322-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible string for Exynos850 SoC.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v3:
  - None

Changes in v2:
  - None

 Documentation/devicetree/bindings/serial/samsung_uart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/samsung_uart.yaml b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
index f064e5b76cf1..2940afb874b3 100644
--- a/Documentation/devicetree/bindings/serial/samsung_uart.yaml
+++ b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
@@ -26,6 +26,7 @@ properties:
           - samsung,s3c6400-uart
           - samsung,s5pv210-uart
           - samsung,exynos4210-uart
+          - samsung,exynos850-uart
 
   reg:
     maxItems: 1
-- 
2.30.2

