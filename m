Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC173A785F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 09:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbhFOHvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 03:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbhFOHvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 03:51:37 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6656C0613A2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 00:49:33 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id x16so8413376pfa.13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 00:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eaKkXhgRq+hiBDUlSLJALn4pH2MiH2Q3FouMp4doJio=;
        b=pSd6Ecpyd9HPN8WV8GELBVQYSUBDKnoTZQgNadV2nL0eH4zsWgsLmnbTeRFTrYIXg8
         rOQztn1fYgf5lRzanVYtfvvYGCbqJn5nlpX1pIhb4xhtM3pFSLr3+PTZVyu9rZIRLQiM
         F1n6s4ZzY5f2oix1eOoLfA2eop9NuvDtylCQOCYuePxAbRgMjfr37NIZNrGIaRurnTI6
         uuerJgJOyeMAngHufeVqDB2zLSY66BvJGdUlme3zI3sgv88i4nuquclwXEEjAEl+++hK
         f+Fk/3cXCeNzcuy74SWc41GUYJ8jH9Yuo2Cvh0U497F0KGnMAEkWPkpcmiSLpuatvoy4
         l75g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eaKkXhgRq+hiBDUlSLJALn4pH2MiH2Q3FouMp4doJio=;
        b=VusO5s1wFrtAeLoea/+p/fuulVzlgxHc8OT9e/5I5hNhy+oPawZ3stEh+O3/9HO561
         E6E6WysedivS16vt7lkFUR05iffd8KuABwcKCJOlQGAahT0CO2nPVyRz/h0bP3AsLWq8
         ytVv5E+5261CWMda+v2Y/edKvDYosTEqW0kr2yH8fGNsRBFi6EtDxsfNJGimS+X5Dw3q
         Z0ypEEdM0e1K12CQSpYg8yHappZVgAjh3U00EeSgsPhZHYImNcqU4BzA4FMbsk4B5ugl
         LMCDl9AukmG2ZTCGUylWulK0PeltpWqlYwqMYlRBOmCqeoU1n47bYdjwBnzirL8oOuAf
         GPwg==
X-Gm-Message-State: AOAM5312UtkM4DOz1Q03PDuawJk0pdTfqoBtWIYtil7DHuS0v8JVc6MI
        hRV87BBhwYLTn+O3Rlow2TwFNw==
X-Google-Smtp-Source: ABdhPJxQW9CPUs3+T8hzaKmL/wLhXYBd5Pxacp0KFmx7ZwvnunAhGmzZoWmBwyf/bCR49m4l9bQqcg==
X-Received: by 2002:a05:6a00:a1e:b029:2e2:89d8:5c87 with SMTP id p30-20020a056a000a1eb02902e289d85c87mr3260866pfh.73.1623743373449;
        Tue, 15 Jun 2021 00:49:33 -0700 (PDT)
Received: from localhost.localdomain.name ([122.177.197.114])
        by smtp.gmail.com with ESMTPSA id c25sm14273097pfo.130.2021.06.15.00.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 00:49:33 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>
Subject: [PATCH v2 04/10] dt-bindings: arm: qcom: Add compatible for SA8155p-adp board
Date:   Tue, 15 Jun 2021 13:15:37 +0530
Message-Id: <20210615074543.26700-5-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210615074543.26700-1-bhupesh.sharma@linaro.org>
References: <20210615074543.26700-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SA8155p-adp board is based on Qualcomm Snapdragon sa8155p
SoC which is similar to the sm8150 SoC.

Add support for the same in dt-bindings.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Andy Gross <agross@kernel.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index d7bb90e5082c..b6dceca8b11f 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -36,6 +36,7 @@ description: |
         msm8992
         msm8994
         msm8996
+        sa8155p
         sc7180
         sc7280
         sdm630
@@ -48,6 +49,7 @@ description: |
 
   The 'board' element must be one of the following strings:
 
+        adp
         cdp
         cp01-c1
         dragonboard
@@ -199,6 +201,11 @@ properties:
               - qcom,ipq6018-cp01-c1
           - const: qcom,ipq6018
 
+      - items:
+          - enum:
+              - qcom,sa8155p-adp
+          - const: qcom,sa8155p
+
       - items:
           - enum:
               - qcom,sm8150-mtp
-- 
2.31.1

