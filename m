Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3BC9363539
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Apr 2021 14:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236835AbhDRMak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 08:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233723AbhDRMa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 08:30:27 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC79CC061761
        for <linux-kernel@vger.kernel.org>; Sun, 18 Apr 2021 05:29:57 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id z5so940818edr.11
        for <linux-kernel@vger.kernel.org>; Sun, 18 Apr 2021 05:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snejp.pl; s=gmail;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=poG+00NR3A/mJvY0huIpYA8eZO34WbE2BkLHQjye9Xo=;
        b=jxI71f4L5r2PHuL6P8eTxXCWATovgLqV9ms1eVcUgKCwi+hTiX9pD5PAYCGLrRRnsD
         bTVo7NJqPzuGTkPrW8xxSnUsIjNiQbftvHPsiMa/bBPqfkNPz534XcXYhyT61l0Ptlpj
         YpxMpuPdlKrNNP06vxg3z5/NfNpJS80Wbsvfj1Epu87eC/WOYvC59jPJI7ov+UmvgaWR
         nGpHz5GefQAuBh+n8idLvg7XXnYau2iV8Zp+3u6R+gbAMAyhdoJ5egOlHtymAixP9a8G
         I0qok4jXFSNgvQMMszsNHW5usoljDr96S8uANTNpjBCy8tbKx6/+qfpotCWlV48TcSOF
         OztA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=poG+00NR3A/mJvY0huIpYA8eZO34WbE2BkLHQjye9Xo=;
        b=dYpxLOkLiZAdbvDkizS7pHRemm/+VMbxht6l4z/mR61U/805n4mYdCQ8xCUrSrbPHv
         Y9R3IlqDoe+VzNxCQ3mRARyqYw/8IvANKljsmsWdTaf7t8M6ImJeT/7+hnAo0cuCqJTq
         EMX6gGQWNQmyaoNoYwR90lSZy48tOfIe9jPeXVU3tKc9PBUavkp3UAMJO27V7IzXutee
         JVVk7/N/YuwcAg46PqlQqzKaV1VognGa9wQp1RNjhSV73PVg8s31b2fHrNtFQPuNaquB
         +eL0cbMAHGy/1bt3mpVcqbpkr/rSD2t5/Ly99mjaI5sTzOq4SXAdKMHhKq47IoajR030
         vMmw==
X-Gm-Message-State: AOAM533UalkyC79U+SQj66TCfYcjnSXeYIQLt7tPDTty20crnH+kHE9T
        a1KeC+mv5tRRetzlJy+uJZAQFw==
X-Google-Smtp-Source: ABdhPJyGX/ftdays69q5ndkss6svGGpAWjC4/CJqNRxdNiBRdj2hPflxZYvnlGj4VBPrnuejAMbtxQ==
X-Received: by 2002:a05:6402:1157:: with SMTP id g23mr20062254edw.303.1618748996620;
        Sun, 18 Apr 2021 05:29:56 -0700 (PDT)
Received: from PackardBell (87-49-44-144-mobile.dk.customer.tdc.net. [87.49.44.144])
        by smtp.googlemail.com with ESMTPSA id k26sm8483371ejk.29.2021.04.18.05.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Apr 2021 05:29:56 -0700 (PDT)
Received: from localhost (PackardBell [local])
        by PackardBell (OpenSMTPD) with ESMTPA id f2c73f30;
        Sun, 18 Apr 2021 12:29:50 +0000 (UTC)
From:   Bartosz Dudziak <bartosz.dudziak@snejp.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Bartosz Dudziak <bartosz.dudziak@snejp.pl>
Subject: [PATCH v2 4/5] dt-bindings: arm: qcom: Document MSM8226 SoC binding
Date:   Sun, 18 Apr 2021 14:29:08 +0200
Message-Id: <20210418122909.71434-5-bartosz.dudziak@snejp.pl>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210418122909.71434-1-bartosz.dudziak@snejp.pl>
References: <20210418122909.71434-1-bartosz.dudziak@snejp.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the MSM8226 SoC device-tree binding.

Signed-off-by: Bartosz Dudziak <bartosz.dudziak@snejp.pl>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 11ec349d56..73902ce46f 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -31,6 +31,7 @@ description: |
         ipq6018
         ipq8074
         mdm9615
+        msm8226
         msm8916
         msm8974
         msm8992
@@ -111,6 +112,11 @@ properties:
               - qcom,apq8084-sbc
           - const: qcom,apq8084
 
+      - items:
+          - enum:
+              - samsung,s3ve3g
+          - const: qcom,msm8226
+
       - items:
           - enum:
               - qcom,msm8960-cdp
-- 
2.25.1

