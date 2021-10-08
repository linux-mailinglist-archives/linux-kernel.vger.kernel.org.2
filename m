Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFE0426A0B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 13:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242363AbhJHLpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 07:45:45 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:47766
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243317AbhJHLnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 07:43:42 -0400
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id F32264000A
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 11:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633693263;
        bh=YenCxJtlGV3PQlymT33h0MoUTyi5idKH+CvjTblUKV8=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=lLD7w6GdEGww4V7eRiiVKTAFutW+nBav+I9Y3XBEizooFC0aj7Xdt8YWJOE9oWCYF
         2QoBHIOlPSMapPeVE2njX3Wcx9XwBwPPkpDjuUxDAgkTiOu8TdSmnb+PAOJdV4IpXO
         zTFcMDh3mSbnyoPrwTtneeJCY79it/BniEhiUGr5BAEPybPm2SgCrLcMjCq97M4/4R
         hauNrYhZsw9Bihn/Orc3bpaibjfzl8NL+spcV39REHySWuHTSsQty/jK1EBEPCa4s8
         7XiVpKCG0RLX39M/rDdfBkNsIs/z3uEDUuFxghD79f/LNVSCUME+zOEHvx62AXs75U
         5URC+bpqXMYBg==
Received: by mail-ed1-f71.google.com with SMTP id v9-20020a50d849000000b003db459aa3f5so6336545edj.15
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 04:41:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YenCxJtlGV3PQlymT33h0MoUTyi5idKH+CvjTblUKV8=;
        b=pc7qyUBtSubcFvRz5PH2w4dbS8Q7i3c8yQykC7ColkFFvQ2hHgdd+jVJFlJDclvzEq
         IxyXeT2gD9AQ6X4cHRzjc0g3uRzm8SP34HlrpORzXCC2sfYw5Fzx/yAPsT/aqzilfJeA
         eJsZnNHB3PVB8IpYj/x9AT5FC3tEJe8lC332MEKQo7keANuqslIt1jn2ytbizNPpBVQ4
         1kHTokiwOVcQgniH9ImmOSRXLpjBNjiGXxFdF1BOkIupwSHrE33O7ohhcWu/WM7uJS2f
         Cw73pDOGiiT1aqYlcJzWqJu1RWDHNguT1CUKx+OeUwpv+Js9nddFQnuBSv5rqO667vyR
         vX0Q==
X-Gm-Message-State: AOAM533iWKxgnBVGXxkmUgbA0mRvBvU5E4F3Zmyker9UtcKLyx2NgJrE
        VRw4oHGFGw0641zZ0b1CmNp+JCxeYgAM81koEXbvSXplF62QZNhDnyERMvYtwdwkzhZIkYsrraG
        JrCCEv7sJdDlR+daOnlzfi4N8g8T2/3+FdxSSH8jN1Q==
X-Received: by 2002:a17:907:1c0e:: with SMTP id nc14mr3610942ejc.103.1633693259159;
        Fri, 08 Oct 2021 04:40:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxomzDMpxmD/kRXVctv2bbCqa67VNyIA5xEzK0LWLUsGmubPwb/clohBcAxG5qJ4i+p3jGu3g==
X-Received: by 2002:a17:907:1c0e:: with SMTP id nc14mr3610907ejc.103.1633693258920;
        Fri, 08 Oct 2021 04:40:58 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-186-13.adslplus.ch. [188.155.186.13])
        by smtp.gmail.com with ESMTPSA id kw5sm10121ejc.110.2021.10.08.04.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 04:40:58 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Sam Protsenko <semen.protsenko@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 10/10] dt-bindings: mfd: samsung,s5m8767: document buck and LDO supplies
Date:   Fri,  8 Oct 2021 13:40:24 +0200
Message-Id: <20211008114024.135335-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211008113723.134648-1-krzysztof.kozlowski@canonical.com>
References: <20211008113723.134648-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the properties with regulator supplies for bucks and LDOs.  At
least one board uses it (Exynos5250 Arndale).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/mfd/samsung,s5m8767.yaml         | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/samsung,s5m8767.yaml b/Documentation/devicetree/bindings/mfd/samsung,s5m8767.yaml
index b2529a48c890..5531718abdf0 100644
--- a/Documentation/devicetree/bindings/mfd/samsung,s5m8767.yaml
+++ b/Documentation/devicetree/bindings/mfd/samsung,s5m8767.yaml
@@ -96,6 +96,44 @@ properties:
     description: |
       GPIO specifiers for three host gpio's used for dvs.
 
+  vinb1-supply:
+    description: Power supply for buck1
+  vinb2-supply:
+    description: Power supply for buck2
+  vinb3-supply:
+    description: Power supply for buck3
+  vinb4-supply:
+    description: Power supply for buck4
+  vinb5-supply:
+    description: Power supply for buck5
+  vinb6-supply:
+    description: Power supply for buck6
+  vinb7-supply:
+    description: Power supply for buck7
+  vinb8-supply:
+    description: Power supply for buck8
+  vinb9-supply:
+    description: Power supply for buck9
+
+  vinl1-supply:
+    description: Power supply for LDO3, LDO10, LDO26, LDO27
+  vinl2-supply:
+    description: Power supply for LDO13, LDO16, LDO25, LDO28
+  vinl3-supply:
+    description: Power supply for LDO11, LDO14
+  vinl4-supply:
+    description: Power supply for LDO4, LDO9
+  vinl5-supply:
+    description: Power supply for LDO12, LDO17, LDO19, LDO23
+  vinl6-supply:
+    description: Power supply for LDO18, LDO20, LDO21, LDO24
+  vinl7-supply:
+    description: Power supply for LDO5, LDO22
+  vinl8-supply:
+    description: Power supply for LDO1, LDO6, LDO7, LDO8, LDO15
+  vinl9-supply:
+    description: Power supply for LDO2
+
   wakeup-source: true
 
 required:
-- 
2.30.2

