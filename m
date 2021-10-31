Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15ED0440E40
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Oct 2021 13:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbhJaMY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 08:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbhJaMYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 08:24:52 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297D9C061766
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 05:22:21 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id g8so55261212edb.2
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 05:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YrX17JLN3iZK9elmHvVA7fpxdjI/sdFhycMWQkjxxmg=;
        b=EoJorhiELL6i8YX9P+3PygS5UCUPug1ARREUj9jNmgGMuJ+8cio7Zc3HRIdeQEveTz
         swQRHS1aFNJ+72CRMI1zdgXUe2ds+ldsMQRUBhO3dlShrcmTWOG+3Gcjq3z0EC/zydGw
         VimMqtPezFOWur3Ysv6cc5+/m6TkT+Rqot13TMNA3oOsb51G7+myt48d3LoUZ+lvV1DI
         TmRJsrg9kWimfBRRvzzpSbSwBgF2+m8XdkQAcBRNjyAJIYjPo5Jbm5uwhHlRrjGeTS3o
         cZlOTCMUC2mCQTUxnN/q9DO8yqkaMaI/StRj7xwUC5EqLo2r3SxqGxcUjk+bgNlriJdo
         7RkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YrX17JLN3iZK9elmHvVA7fpxdjI/sdFhycMWQkjxxmg=;
        b=iEAWjgkX2dYcOxB5T4oBZ1r/5Dvz//e1Rkk9OE73Cyo3cWdlJjXg1pfasWMRkdNUx0
         D8o7XUTd5XE68acZRl6JrcHhese/2ajyXeedLmpvaCY6UBWSbtqZdUg7mwJ4mMy+nL1E
         FuqbNVDyJ0ODF/7ljO2uKxHXRaYgArqp/xGBqdDe+iMiinD3HPxK2q9quGY8VcDc77Li
         MzUYkpaa7tgcsvpzpstKw+sV3AGBbzdrXp5NS666enZ8MpU3kPeIcHqsmaAMQsfpdvwe
         qajx3AOVK2bHkDo1cJhVMNj2hwlCVziSExcD3p3gkx3AkMK/6HqnpJunhM9O+m7s2mu0
         O9jg==
X-Gm-Message-State: AOAM531yj4ig7AEKZ1lH7aqEf+J9INjMVabcEp8Dht7EPfhANZLq1DVj
        aiQz6n/9AAcd2ACPCA1PeIVUtg==
X-Google-Smtp-Source: ABdhPJxuGF6wQckRdjEtPpGPkF2sf452nvOubT7XXExNKWVcsdUQCtuxKqSxcFUKSExu8kZCUIhqSg==
X-Received: by 2002:a17:907:86a1:: with SMTP id qa33mr28216618ejc.270.1635682939671;
        Sun, 31 Oct 2021 05:22:19 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id ga1sm5738052ejc.40.2021.10.31.05.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Oct 2021 05:22:19 -0700 (PDT)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v2 01/12] dt-bindings: watchdog: Require samsung,syscon-phandle for Exynos7
Date:   Sun, 31 Oct 2021 14:22:05 +0200
Message-Id: <20211031122216.30212-2-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211031122216.30212-1-semen.protsenko@linaro.org>
References: <20211031122216.30212-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Exynos7 watchdog driver is clearly indicating that its dts node must
define syscon phandle property. That was probably forgotten, so add it.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
Fixes: 2b9366b66967 ("watchdog: s3c2410_wdt: Add support for Watchdog device on Exynos7")
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
Changes in v2:
  - Added R-b tag by Krzysztof Kozlowski
  - Added "Fixes" tag

 Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml b/Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml
index 76cb9586ee00..93cd77a6e92c 100644
--- a/Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml
@@ -39,8 +39,8 @@ properties:
   samsung,syscon-phandle:
     $ref: /schemas/types.yaml#/definitions/phandle
     description:
-      Phandle to the PMU system controller node (in case of Exynos5250
-      and Exynos5420).
+      Phandle to the PMU system controller node (in case of Exynos5250,
+      Exynos5420 and Exynos7).
 
 required:
   - compatible
@@ -58,6 +58,7 @@ allOf:
             enum:
               - samsung,exynos5250-wdt
               - samsung,exynos5420-wdt
+              - samsung,exynos7-wdt
     then:
       required:
         - samsung,syscon-phandle
-- 
2.30.2

