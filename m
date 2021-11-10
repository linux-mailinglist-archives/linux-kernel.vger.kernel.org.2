Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F013844BF82
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 12:00:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbhKJLDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 06:03:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbhKJLDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 06:03:14 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B85BC061767
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 03:00:22 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id gf14-20020a17090ac7ce00b001a7a2a0b5c3so1322468pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 03:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KAyZqAMlAmUiHf1dIx2+pecIBOy9N3N7dPQhBsif/R8=;
        b=f0pHnEifAzmDAArN/HwII5bNPgjK419EZhSz1sjI9mvSbAYTen9l0dp90oBGPBk/BO
         7hoBIr5HLj4UOUQTzY6OYvKe2h73SGzJRouL12bxGEh9hhRKRVtPnXkyGpUrnebx09GO
         7/vjTmNDN7CVMWWMGKnE27lLVMbH/m03d3O7fAXSEXrCOzK31BvKSctLyFpwYAdqu8Pj
         dE+M6PKFKQiElWR8iCd4eEpBqg5wOexQu+zv4s3CU+JtcKrVWqxElYCT4MDaGAJlSWXg
         GXw5f4OMUcbCwsSAZ44b2EatbGDGDHaPff7r/Clf/gFFD94o7qosT1lNasckiZPvafil
         j6LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KAyZqAMlAmUiHf1dIx2+pecIBOy9N3N7dPQhBsif/R8=;
        b=H821INByQLL5Ai3sTEUyxDsKNVAPC/NjC0PyCN5ZHw+W9FZumVzpsKgub+38HthYDc
         dwS3OTXtXEQLVaT/9iSg9fLh+2s8mijA0XLBpDRTGFB0dB72YaawusOdqUmqnziCqyrZ
         MNnQcaAn8CD9yU+oHmEXW9FXrnFYFllEOGOJ52Yu0ZDJCevJeer7ZBhGXqSnb6tDECf9
         /LVVKbiG9i3HgDreBtZMOnBlY8cj1tVBuSGNbWSHCqAAitg1XwK6/UE2FXxbGOcSJ9va
         RhtRJMOFBlIa9tEyMy3rW7Bzf2e9sJDy92zREkyFB3nIuczj/qq5zLpGes/iwwsuC9hD
         WaOA==
X-Gm-Message-State: AOAM531Ax6jgUv5/t1maKHth0+RlqU+4aHq9fB7XrBY1kVHdUQ/uaPtR
        CXmnRab/HSlnF1Tc3DOoEX1U/g==
X-Google-Smtp-Source: ABdhPJwHqUeKDR5q61yigu2TuQjbamu1gW52Bf126KWU3sYBRESwbfSmA++ahBXu3lZKz6URwfYh3g==
X-Received: by 2002:a17:90a:df01:: with SMTP id gp1mr15736659pjb.28.1636542021917;
        Wed, 10 Nov 2021 03:00:21 -0800 (PST)
Received: from localhost.name ([122.161.52.143])
        by smtp.gmail.com with ESMTPSA id e11sm5585282pjl.20.2021.11.10.03.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 03:00:21 -0800 (PST)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, agross@kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, stephan@gerhold.net,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH v5 08/22] dt-bindings: qcom-qce: Add 'interconnects' and 'interconnect-names'
Date:   Wed, 10 Nov 2021 16:29:08 +0530
Message-Id: <20211110105922.217895-9-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211110105922.217895-1-bhupesh.sharma@linaro.org>
References: <20211110105922.217895-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add 'interconnects' and 'interconnect-names' as optional properties
to the device-tree binding documentation for qcom crypto IP.

These properties describe the interconnect path between crypto and main
memory and the interconnect type respectively.

Cc: Thara Gopinath <thara.gopinath@linaro.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 Documentation/devicetree/bindings/crypto/qcom-qce.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/crypto/qcom-qce.yaml b/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
index 3a839c159d92..30deaa0fa93d 100644
--- a/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
+++ b/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
@@ -32,6 +32,14 @@ properties:
       - const: bus
       - const: core
 
+  interconnects:
+    maxItems: 1
+    description:
+      Interconnect path between qce crypto and main memory.
+
+  interconnect-names:
+    const: memory
+
   dmas:
     items:
       - description: DMA specifiers for rx dma channel.
-- 
2.31.1

