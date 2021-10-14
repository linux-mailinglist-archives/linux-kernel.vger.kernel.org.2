Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27F6742DA94
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 15:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbhJNNhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 09:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbhJNNhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 09:37:31 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E35AC061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 06:35:26 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id z11so26126776lfj.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 06:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N6W4v1n3kGpm51LGuWr4DOSZfvAmRLOc39RwJrVRkNE=;
        b=sS2XyoOmFym8VPzYBeiYdbCcFPoN35ePuF/iXKNNcFZkLI/kGvUrBWZpNgcso8yyW2
         IXjl/daA9ojrLYIEQQ/441lt96LQuEcY1+pRDtbYoPL1NiYAWF4C/ZNnbGD91VjvnDf1
         fkEF/WUkqTA7c/4ODLK/4VLEC/Kte7PPZ4+dEjnEdtLVvT2nqi9jnVZKpcBIEmqS305n
         xH8pyH7fOrgZxD/GX1/iSD5Vfb096zTCoRsN8urq76fUSoFgboTSB+GWDlJL9hVI6Ne8
         yQh0Ib0IVJjyOWqmJkFiVVa9exS8akUllhtdQnozqL2q/hV2v/QHcXWpv2kCrWrwGE8x
         Ku9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N6W4v1n3kGpm51LGuWr4DOSZfvAmRLOc39RwJrVRkNE=;
        b=rfTqmuSBaEeu7iV52rQAZOhHDAq5Dv9JukVJFb8idAFlQqRkhHGuryQ1Q7Wk4IS8TG
         9ULEf9rxg04c5DDoa2MGTsR5/0CkiOYa+2+XLgr3y/4we8xwlUWp8w6mcJBwheVpHrfs
         DwQeZ3+IWTWGKhMfqTyPzVxEYaI78MG0XEnEgqI2tQH4ZCcuE/Pl0WCW1GIb5F0Uh3ii
         Eakyz1SHcWL1sUs532Jp2FKHuMem48Gy7kldkFmYTjjSwpalRo5UKbDe4hwXkPTZOFx+
         Uk89zhv5hjc46Vbi2PiyIU+p3m2OgHcsSfGU+YINE9p5C9QsrU1nuHY2AxLyHkST8O4T
         eQaQ==
X-Gm-Message-State: AOAM5333M02vb2I9gPWE3c0Os98XwWGMaTve/6+c0cLunagsBnN6GTKj
        GN2bI3woCkia3uHqyE7NE82vKCupYCjWeTzM
X-Google-Smtp-Source: ABdhPJwIxRC1sPZ1H4aANAzK5JyQ6HDhWAzS3gCbdn7ctBbZRGf9O2k6f9aboGT5aOzaIRXbz1YFKg==
X-Received: by 2002:a2e:7f0f:: with SMTP id a15mr6384451ljd.251.1634218511471;
        Thu, 14 Oct 2021 06:35:11 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id y5sm264196ljy.38.2021.10.14.06.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 06:35:11 -0700 (PDT)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Sumit Semwal <sumit.semwal@linaro.org>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] dt-bindings: samsung: exynos-chipid: Document Exynos850 compatible
Date:   Thu, 14 Oct 2021 16:35:07 +0300
Message-Id: <20211014133508.1210-2-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211014133508.1210-1-semen.protsenko@linaro.org>
References: <20211014133508.1210-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible string for Exynos850 chip-id. While at it, use enum
instead of items/const, to reduce further cluttering of "compatible"
list.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v2:
  - (none)

Changes in v3:
  - Rebased on top of krzk/for-next

 .../devicetree/bindings/arm/samsung/exynos-chipid.yaml       | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/samsung/exynos-chipid.yaml b/Documentation/devicetree/bindings/arm/samsung/exynos-chipid.yaml
index f99c0c6df21b..bfc352a2fdd6 100644
--- a/Documentation/devicetree/bindings/arm/samsung/exynos-chipid.yaml
+++ b/Documentation/devicetree/bindings/arm/samsung/exynos-chipid.yaml
@@ -11,8 +11,9 @@ maintainers:
 
 properties:
   compatible:
-    items:
-      - const: samsung,exynos4210-chipid
+    enum:
+      - samsung,exynos4210-chipid
+      - samsung,exynos850-chipid
 
   reg:
     maxItems: 1
-- 
2.30.2

