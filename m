Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1C934E637
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 13:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbhC3LOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 07:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbhC3LNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 07:13:48 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55509C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 04:13:48 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id jy13so24256393ejc.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 04:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tI19V/9+bzVX/HQD/pyeZOq0qTNflgRJC75eI3UYzVY=;
        b=vlybpNL+x7uzqKeDp1IRagMCgeBH9N2dSzWs8sqYqc1I5CgSzJgtmJNA/S+t0/0kBD
         KFfF/2wNo0FYcbAPFciI5HRCtVFvNc7b+cCy+kRouvxVU1jzFdaZgTACCTQU6GatSRxq
         WZqGoaZrhNftkhn3KdMv8Bdmn0xt2VgvKEpvGpb51kP80P0jbiaFzHQSl1/b2AbM3giv
         1TAEqUJTxEDXgsZh1hvcDJIHSw9WNzC+ADmFDfeBEtoxIwb05fi3BCcQ6XKpG1pn4xIK
         Zy3xrjbSjKvPfw5s+TSUl8FpG5fTq97ACR9h46EID0u+Cqd9xVBWL+p/tG8bcdbGBD3i
         HZ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tI19V/9+bzVX/HQD/pyeZOq0qTNflgRJC75eI3UYzVY=;
        b=UppqZ3Iz59Fn8IUNFDA1i/QZeIL3ya6jcY+rc8gxc5JG/waldJhn4DOynpYCjxxoKX
         qDS4dbqBSdW+MIjwYiMRu4+8pwJUPFHSSZOOMeB4OxXE7Wj/+qSpm0I/YW6dAS7eIQpq
         YJ3QVMSoZXemY8Tpa3U8T6gEDO5hfA2Yr3ENsEBvvv7IaVNBA2m+rMeNP4YePRFYmi4u
         PzJ5SIl0+l3oCpboIglSsbTUchGA76seM03fsKi86T6OYD7yIpWEFnolWNIgtx5KfYKl
         ObfHwHz1GpK7cHzjtILEYa6u+Dc8xNGwPm8u7PhE26rIiQMNa9bFMnHxJPgrnKbL6WtT
         0jgg==
X-Gm-Message-State: AOAM530kMQLVC/n95wmthR3bTYNjuRTrvlLYTSStTiKsOM813UtO2o50
        w4q4AMfBjauRPDf4EOrTrPV5TA==
X-Google-Smtp-Source: ABdhPJwU0JpWW7QV83frZxNLu1WkNVzjEO38DFmzMvMQIyfk1V1CQACPOGBeC38i+eMypypykeMAXw==
X-Received: by 2002:a17:906:f9db:: with SMTP id lj27mr33023316ejb.399.1617102827093;
        Tue, 30 Mar 2021 04:13:47 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id r19sm10961308edp.52.2021.03.30.04.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 04:13:46 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Rob Herring <robh@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 09/10] dt-bindings: nvmem: Add SoC compatible for sc7280
Date:   Tue, 30 Mar 2021 12:12:40 +0100
Message-Id: <20210330111241.19401-10-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210330111241.19401-1-srinivas.kandagatla@linaro.org>
References: <20210330111241.19401-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajendra Nayak <rnayak@codeaurora.org>

Document SoC compatible for sc7280

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
index 992777c90a0b..861b205016b1 100644
--- a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
+++ b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
@@ -24,6 +24,7 @@ properties:
           - qcom,msm8998-qfprom
           - qcom,qcs404-qfprom
           - qcom,sc7180-qfprom
+          - qcom,sc7280-qfprom
           - qcom,sdm845-qfprom
       - const: qcom,qfprom
 
-- 
2.21.0

