Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46600358ADA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 19:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbhDHRGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 13:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232666AbhDHRGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 13:06:00 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03AC7C0613DF
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 10:05:46 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id y2so1377900plg.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 10:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LzLBZRgN0IZwJ8UaEh0p4IsQJQazWZVEGqH9AmkhtxE=;
        b=vv2n6wOYHTJNH5UU+vCyyGnCqglN8T5TdqA3DRUyFcLlhErTWf+Sqgno1/KFQ3wwr1
         9Td+67x6yzrHf5C18Z3L5xEKsfxMcgg/z6KguJqQyaPB14cIgCpPHLjI3ACw823TIHZq
         8vNluvSZjOSt6u4NEjSEUi/6qcg9JRMNPJH9TRtQMTQAtsOFawSTlN1Wl9DxAGf1evtv
         dfZYCD5gQf7hav0PivVvVtkS1BdwOgPVHIi0R52tuH7uFxtQ/aKvszMfxorYv3EdN6va
         Sk2oH9ksygCVgwdU6gIkGyFb4uKpsFI9h0rn/OPwWqAf2IJcevxS60+hoGGBphfEdNiS
         oFIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LzLBZRgN0IZwJ8UaEh0p4IsQJQazWZVEGqH9AmkhtxE=;
        b=l8vkGaHGyie/efY+9VUdukagVGFKquCCUmqtdIXRICSAMz313cFMV8BB7VA3POJBnA
         HpsG1rgwlkhME5tmw6w7eD7oaySPYnwiIX+W8bDWtdjxiYUwfWASuuHEMqSjgzkFAMmB
         H2CgI/LCyoSqwa6NB59HUx2KUkH6rsi5H/E8QzFC9pCgFZnwXRUWQTT77kC7+xx8t3nM
         pDOrdRDnIRI293usUCLP2Q4T2p1LvXjB0Aafg/enG5T5NwiDfUKvYjUywcs6wXkchA5L
         aSN8tAiF6i+x7duEPt55SJTdF1e0tev6ta0Qkn8j1L3rBydTR63KRQcYMFtRR8vUt30D
         l+GQ==
X-Gm-Message-State: AOAM53125XONZVjaK0toeEChv+82WJq9+mIUhtIbaaXi6Xh4kRJZHhlJ
        fJAvLTafUZ9ejBDjirpkbbEV
X-Google-Smtp-Source: ABdhPJyO/SrVOS15NhVdODREzZpYzltCR8qnlcu6IAZRa2Aw/DowyLFdWPX5ZEECXC1z9vnL6Wyx9Q==
X-Received: by 2002:a17:902:7896:b029:e8:fa73:ad22 with SMTP id q22-20020a1709027896b02900e8fa73ad22mr8629497pll.66.1617901545494;
        Thu, 08 Apr 2021 10:05:45 -0700 (PDT)
Received: from localhost.localdomain ([103.77.37.191])
        by smtp.gmail.com with ESMTPSA id y194sm65183pfb.21.2021.04.08.10.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 10:05:45 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH 14/15] dt-bindings: remoteproc: qcom: pas: Add binding for SDX55
Date:   Thu,  8 Apr 2021 22:34:56 +0530
Message-Id: <20210408170457.91409-15-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210408170457.91409-1-manivannan.sadhasivam@linaro.org>
References: <20210408170457.91409-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding for SDX55 remoteproc.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/remoteproc/qcom,adsp.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.txt b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.txt
index 1c330a8941f9..229f908fd831 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.txt
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.txt
@@ -18,6 +18,7 @@ on the Qualcomm ADSP Hexagon core.
 		    "qcom,sc7180-mpss-pas"
 		    "qcom,sdm845-adsp-pas"
 		    "qcom,sdm845-cdsp-pas"
+                    "qcom,sdx55-mpss-pas"
 		    "qcom,sm8150-adsp-pas"
 		    "qcom,sm8150-cdsp-pas"
 		    "qcom,sm8150-mpss-pas"
@@ -61,6 +62,7 @@ on the Qualcomm ADSP Hexagon core.
 		    must be "wdog", "fatal", "ready", "handover", "stop-ack"
 	qcom,qcs404-wcss-pas:
 	qcom,sc7180-mpss-pas:
+        qcom,sdx55-mpss-pas:
 	qcom,sm8150-mpss-pas:
 	qcom,sm8350-mpss-pas:
 		    must be "wdog", "fatal", "ready", "handover", "stop-ack",
@@ -128,6 +130,8 @@ on the Qualcomm ADSP Hexagon core.
 	qcom,sm8150-mpss-pas:
 	qcom,sm8350-mpss-pas:
 		    must be "cx", "load_state", "mss"
+        qcom,sdx55-mpss-pas:
+                    must be "cx", "mss"
 	qcom,sm8250-adsp-pas:
 	qcom,sm8350-adsp-pas:
 	qcom,sm8150-slpi-pas:
-- 
2.25.1

