Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04CC242BE2F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 12:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbhJMK7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 06:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232498AbhJMK6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 06:58:30 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FDCC061771
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 03:56:24 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id nn3-20020a17090b38c300b001a03bb6c4ebso1959343pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 03:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z2sBrvxA3Mihi2vqUGXbJq+xZIOpCjvkxgHKQyKWO9M=;
        b=dLxvEsOxnAJ/yiZvhLJAWdzUsjZx4F/hO8SG55sjqC0uoMeR5cKq8CRX6rctKV7T67
         Jnys6dAYsj5lAOLQp7uBRdoyWZsJvcC9PIimn/onluhCZRb2JuuEotwod62vfk2svJN0
         FYD3mJgXEgaXBT/qqliSdkQDC73Kr5MPVt02l+0OE1aVwSdKU80Nrd9auYlbcoMlWXPg
         dW+FpGdBF+SjX9kHvmUMPAfpOKCkKP41ROJmArpxZ/8LzolH0WeLVXrdQXVQ50Mhx311
         fCDBbsAvrNH63RX3hSSaPtxGTzzdqYWlskRYVOe+Pe3rxCTPoONuN/u0ax2AgjASAjCG
         5z9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z2sBrvxA3Mihi2vqUGXbJq+xZIOpCjvkxgHKQyKWO9M=;
        b=rKFw9JfNBQqC+G8ToFKwf0+CbT3V4xEu9lifn7IDoeTPoW4HCHNv57pmrPEisJ9ksI
         37zbgMWFraGLAcwJF6ru0lbP5gFIvw11OnXSvasenCG8nzSWctjADRsEpXJ2hlbh1Zhs
         bFgN1Be1gOobiqjUW5CINqtmKBw5XsdN/5WKKByVs1V1C8PhCbif3i6BadVurFyD04dC
         g+KWEY9GaUWQaMoIoUdCg7FiA2ofnQfvSWkxvHYv9Nh+XZ8y56vreVB8blbpViajlI/8
         vYi4gcH5OxlJaeR72hec6J46CjOLJHqkobM0CmlRZNf2+tTiRpTJ3HQluKxFHXIxPX4p
         uvSw==
X-Gm-Message-State: AOAM53314LA7N5K1j7AH1Qrfc/juZ7wyXt65VlmmLWV0sA2DWhWO806L
        BD8xxA38u0jOMJ5sfBYwaz9SRw==
X-Google-Smtp-Source: ABdhPJzS5MsQJ5G6pY/x5ilWe9j0Ca4cdetOxPcEMbiTwTVvfiYrezOs7OgcrbQRhYkzYJDvZNyTdw==
X-Received: by 2002:a17:90b:4d8e:: with SMTP id oj14mr12663660pjb.160.1634122583633;
        Wed, 13 Oct 2021 03:56:23 -0700 (PDT)
Received: from localhost.name ([122.161.48.68])
        by smtp.gmail.com with ESMTPSA id b13sm6155351pjl.15.2021.10.13.03.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 03:56:23 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, agross@kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, Thara Gopinath <thara.gopinath@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH v4 06/20] dt-bindings: qcom-bam: Add 'iommus' to optional properties
Date:   Wed, 13 Oct 2021 16:25:27 +0530
Message-Id: <20211013105541.68045-7-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211013105541.68045-1-bhupesh.sharma@linaro.org>
References: <20211013105541.68045-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add 'optional' property - 'iommus' to the
device-tree binding documentation for qcom-bam DMA IP.

This property describes the phandle(s) to apps_smmu node
with sid mask.

Cc: Thara Gopinath <thara.gopinath@linaro.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 .../devicetree/bindings/dma/qcom_bam_dma.yaml          | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/qcom_bam_dma.yaml b/Documentation/devicetree/bindings/dma/qcom_bam_dma.yaml
index 602e68df971f..7c046a281fcd 100644
--- a/Documentation/devicetree/bindings/dma/qcom_bam_dma.yaml
+++ b/Documentation/devicetree/bindings/dma/qcom_bam_dma.yaml
@@ -53,6 +53,12 @@ properties:
   interconnect-names:
     const: memory
 
+  iommus:
+    minItems: 1
+    maxItems: 8
+    description: |
+      phandle(s) to apps_smmu node with sid mask.
+
   qcom,ee:
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
@@ -94,4 +100,8 @@ examples:
         clock-names = "bam_clk";
         #dma-cells = <1>;
         qcom,ee = <0>;
+        iommus = <&apps_smmu 0x584 0x0011>,
+                 <&apps_smmu 0x586 0x0011>,
+                 <&apps_smmu 0x594 0x0011>,
+                 <&apps_smmu 0x596 0x0011>;
     };
-- 
2.31.1

