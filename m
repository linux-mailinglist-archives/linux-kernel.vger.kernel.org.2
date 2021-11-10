Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 035CE44BF72
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 12:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbhKJLC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 06:02:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbhKJLCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 06:02:53 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C38C06120D
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 03:00:01 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id y7so2797712plp.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 03:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=peaVpA9FhN/Vc52TS1nlumYAVj2G5wsFUHbVuVwYxEc=;
        b=I0pp1973B+/mL+qLzoqDH844dZuiimsjhHWNDXNEcoTwN9T+W7zx49z6sJYI0IeeiF
         CuHr2iFikkyiDMmJ0OOtZ/gWPoNAsCyW+gsQaBc2rCf7ml++GRVqQpGs0IjIPlr82OgQ
         0J3shYvFZmfP21m6qahrqEhEH7CkPTrJzrOtbC6l6zoLPmq40js7SPT83Qs7ZAw2rCgS
         wCdhnVYKtj+YoAspYSH/xwBc71ffwpaxz2+ExvCioElCOX5KJirOJLyf6kIx+kZosYIz
         5ELMkR/WJZOH7NZzpPkxjB61dhiPfgB3G92rNMNOhcR/23VIAkyZlDYnpifEd1WV61nA
         oBpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=peaVpA9FhN/Vc52TS1nlumYAVj2G5wsFUHbVuVwYxEc=;
        b=OhgziNU8qohu8JC52dTTtlGMqfvZtQfOyvGZCCKqp+9BNh3bEXE13fNfVwk51HCVyb
         R4dubcKuzGr5oQS4FmnAdzx/in3IGUwvTkhw1snZuVMZtnVIXrjh0UNrwgA2+ZCigIWp
         7nIVNkVaysjyuiL+wC3vGviNMLYiUNzJ4HI+Zkn0Tg6Ea7sNfz+n1oOqXpsu51Ty6L/F
         96YnbK0cQV2QAHvltatP7DrK18fn6FaaF9YNBE9GcEBYbrS0sbbYW/iQvz7KIbyzpmrH
         N4TyjzB44f0yCxmR5s/DKPE6OkrPkxJnqOYWZ13vjVcmlDvyWLSD/Io73t2QUpLDNt49
         qU8g==
X-Gm-Message-State: AOAM5301I3DZVgo1Id2e+DphMG6ylaPT+jFUDvjCE95it/qDINRBdOKo
        fXGpud0RhMe14tgvPEqHubY3NQ==
X-Google-Smtp-Source: ABdhPJww5ePwPiazLWacGwZAiQVioAsM/0bZxgb+wuEvmSOomy6uvG9/aOpiW/bTJfBNx0oAwBWbJQ==
X-Received: by 2002:a17:903:246:b0:13f:75bb:cabd with SMTP id j6-20020a170903024600b0013f75bbcabdmr15103212plh.30.1636542001334;
        Wed, 10 Nov 2021 03:00:01 -0800 (PST)
Received: from localhost.name ([122.161.52.143])
        by smtp.gmail.com with ESMTPSA id e11sm5585282pjl.20.2021.11.10.02.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 03:00:00 -0800 (PST)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, agross@kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, stephan@gerhold.net,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH v5 04/22] dt-bindings: qcom-bam: Add 'interconnects' & 'interconnect-names' to optional properties
Date:   Wed, 10 Nov 2021 16:29:04 +0530
Message-Id: <20211110105922.217895-5-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211110105922.217895-1-bhupesh.sharma@linaro.org>
References: <20211110105922.217895-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new optional properties - 'interconnects' and
'interconnect-names' to the device-tree binding documentation for
qcom-bam DMA IP.

These properties describe the interconnect path between bam and main
memory and the interconnect type respectively.

Cc: Thara Gopinath <thara.gopinath@linaro.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 Documentation/devicetree/bindings/dma/qcom_bam_dma.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/qcom_bam_dma.yaml b/Documentation/devicetree/bindings/dma/qcom_bam_dma.yaml
index 3ca222bd10bd..20e734448c1f 100644
--- a/Documentation/devicetree/bindings/dma/qcom_bam_dma.yaml
+++ b/Documentation/devicetree/bindings/dma/qcom_bam_dma.yaml
@@ -45,6 +45,14 @@ properties:
     const: 1
     description: The single cell represents the channel index.
 
+  interconnects:
+    maxItems: 1
+    description:
+      Interconnect path between bam and main memory.
+
+  interconnect-names:
+    const: memory
+
   qcom,ee:
     $ref: /schemas/types.yaml#/definitions/uint32
     minimum: 0
-- 
2.31.1

