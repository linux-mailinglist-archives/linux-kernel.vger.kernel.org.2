Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FAC0389146
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 16:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354295AbhESOjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 10:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354264AbhESOjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 10:39:06 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA75CC06138C
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 07:37:44 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id h20-20020a17090aa894b029015db8f3969eso2901724pjq.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 07:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tfYY0SynHLUvKImA0WJS6vFoZYpwQQ4sgm9paKqwl54=;
        b=LMDyQ/zuyHaHFHZdUKNQlFAxMEqlWRr2VaQPfUkGnDJDmV1+yF8C00rnS4gCFd5v3o
         wmKj8D69QYlT2IY21LKAQ0umZwSOx99YlOm4ZSXhnsW99gHN8TXUbgLX0Eb8fK0zkumk
         FdBnnYmInjarV5Kb4JQQZNhGs7UyCgGhYZP2EaVOV5jar1VxohlN80/G1vglN9Fd8ggq
         Ob3cnQ5JAkQIJOWIEfUR8y8ZCpf5ftFAVaI1C3nk1Hiet1VVrGz47+vRcGsbpknC9fSF
         PVRMdV64UtNnZqwUmS3jKeDnvAOLOMsfnQ3rQ/EQkvoZS1dkgakaTpK7VDyUKEZGSSJC
         FClw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tfYY0SynHLUvKImA0WJS6vFoZYpwQQ4sgm9paKqwl54=;
        b=Ac7bOXTWGJew31lpQv12tTjr1f0nlVOO1vOOa37WWY2hopdVYY6r3moPKv6LS0xzw3
         nEA5LadaXqwivvPK26oxKX3az8AK/uECvumqqtXcd3u2mMjM7p3avuJhzOylEIEu6YPN
         mo4CA3EX6OB8mWL2ek4h/HYVPw2iYcv713s7/AqOBw3yRajphWoU0d0Z0RFBkl0wO7mk
         m5T/2qMMxl5c/zOMFQvNpYeA1vIY7i4rc83i1pRNMaEFMC+TDrF84QQvH4xHHnHo0SrS
         IVNsP4JX2iGIy5y9T5kYS7Azk5NsMCbgKG3z1jIowwSbgBqsVWiRc5Gp5ADIFW2SoSop
         mz1Q==
X-Gm-Message-State: AOAM5324AF3L0rxogtQat0QP4Z2qOXLQBwQYA0sPWKOBdmUWl/uCBiG1
        nsO4p6mWTfMm/C2/i73hTvcTZA==
X-Google-Smtp-Source: ABdhPJwy849Ca+hXXvP504HCbRthfcaqff/Mo+T2X7D7E2ExfjN7Ipe/+RyMBbaOmwnYSCCO9oSKDw==
X-Received: by 2002:a17:90b:4ac2:: with SMTP id mh2mr11697000pjb.33.1621435064459;
        Wed, 19 May 2021 07:37:44 -0700 (PDT)
Received: from localhost.localdomain.name ([122.177.135.250])
        by smtp.gmail.com with ESMTPSA id o24sm9239515pgl.55.2021.05.19.07.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 07:37:44 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhupesh.linux@gmail.com
Subject: [PATCH v3 03/17] dt-bindings: qcom-bam: Add 'iommus' to required properties
Date:   Wed, 19 May 2021 20:06:46 +0530
Message-Id: <20210519143700.27392-4-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210519143700.27392-1-bhupesh.sharma@linaro.org>
References: <20210519143700.27392-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing required property - 'iommus' to the
device-tree binding documentation for qcom-bam DMA IP.

This property describes the phandle(s) to apps_smmu node with sid mask.

Cc: Thara Gopinath <thara.gopinath@linaro.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Andy Gross <agross@kernel.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: David S. Miller <davem@davemloft.net>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org
Cc: linux-clk@vger.kernel.org
Cc: linux-crypto@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: bhupesh.linux@gmail.com
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 .../devicetree/bindings/dma/qcom_bam_dma.yaml         | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/qcom_bam_dma.yaml b/Documentation/devicetree/bindings/dma/qcom_bam_dma.yaml
index d2900616006c..2479862a3654 100644
--- a/Documentation/devicetree/bindings/dma/qcom_bam_dma.yaml
+++ b/Documentation/devicetree/bindings/dma/qcom_bam_dma.yaml
@@ -55,6 +55,12 @@ properties:
   interconnect-names:
     const: memory
 
+  iommus:
+    minItems: 1
+    maxItems: 8
+    description: |
+      phandle to apps_smmu node with sid mask.
+
   qcom,ee:
     $ref: /schemas/types.yaml#/definitions/uint8
     description:
@@ -81,6 +87,7 @@ required:
   - clocks
   - clock-names
   - "#dma-cells"
+  - iommus
   - qcom,ee
 
 additionalProperties: false
@@ -96,4 +103,8 @@ examples:
         clock-names = "bam_clk";
         #dma-cells = <1>;
         qcom,ee = /bits/ 8 <0>;
+        iommus = <&apps_smmu 0x584 0x0011>,
+                 <&apps_smmu 0x586 0x0011>,
+                 <&apps_smmu 0x594 0x0011>,
+                 <&apps_smmu 0x596 0x0011>;
     };
-- 
2.31.1

