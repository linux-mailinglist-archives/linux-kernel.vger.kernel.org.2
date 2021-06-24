Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09D373B3747
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 21:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232837AbhFXTu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 15:50:59 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:37659 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232806AbhFXTu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 15:50:58 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1624564118; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=YrIYc5RHw9lI1hfapLw2nYs17T/vihvpK3WWcZ6MUyQ=; b=NQG//UbG7p7VTzlBhDzJMESYjLYLqTeqOUG31wp47ok++sN6UOknzMEd+EUWb7Ku1od/wMq4
 5ZEjbmFfX1yePp/sR3P89kfsVTp1X2QAi+uB3BV2EtP1La1qZqgQNDx248l2Z2tJlTtca4ox
 mHeAgwCMqAPuNJAP0/lwVEf3rsc=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 60d4e1877e5ba0fdc0a0a989 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 24 Jun 2021 19:48:23
 GMT
Sender: sibis=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A5A93C4338A; Thu, 24 Jun 2021 19:48:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D5294C43217;
        Thu, 24 Jun 2021 19:48:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D5294C43217
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org, robh+dt@kernel.org, will@kernel.org,
        saiprakash.ranjan@codeaurora.org
Cc:     ohad@wizery.com, agross@kernel.org, mathieu.poirier@linaro.org,
        robin.murphy@arm.com, joro@8bytes.org, p.zabel@pengutronix.de,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, evgreen@chromium.org,
        dianders@chromium.org, swboyd@chromium.org,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH 1/9] dt-bindings: remoteproc: qcom: pas: Add SC7280 MPSS support
Date:   Fri, 25 Jun 2021 01:17:30 +0530
Message-Id: <1624564058-24095-2-git-send-email-sibis@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1624564058-24095-1-git-send-email-sibis@codeaurora.org>
References: <1624564058-24095-1-git-send-email-sibis@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MPSS PAS support for SC7280 SoCs.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
index ad85617b43fa..28e41cef701c 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
@@ -25,6 +25,7 @@ properties:
       - qcom,qcs404-cdsp-pas
       - qcom,qcs404-wcss-pas
       - qcom,sc7180-mpss-pas
+      - qcom,sc7280-mpss-pas
       - qcom,sdm845-adsp-pas
       - qcom,sdm845-cdsp-pas
       - qcom,sdx55-mpss-pas
@@ -147,6 +148,7 @@ allOf:
               - qcom,msm8998-adsp-pas
               - qcom,qcs404-adsp-pas
               - qcom,qcs404-wcss-pas
+              - qcom,sc7280-mpss-pas
               - qcom,sdm845-adsp-pas
               - qcom,sdm845-cdsp-pas
               - qcom,sm8150-adsp-pas
@@ -287,6 +289,7 @@ allOf:
           contains:
             enum:
               - qcom,sc7180-mpss-pas
+              - qcom,sc7280-mpss-pas
               - qcom,sdx55-mpss-pas
               - qcom,sm8150-mpss-pas
               - qcom,sm8350-mpss-pas
@@ -390,6 +393,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,sc7280-mpss-pas
               - qcom,sdx55-mpss-pas
               - qcom,sm8150-mpss-pas
               - qcom,sm8350-mpss-pas
@@ -463,6 +467,7 @@ allOf:
           contains:
             enum:
               - qcom,sc7180-mpss-pas
+              - qcom,sc7280-mpss-pas
     then:
       properties:
         resets:
@@ -480,6 +485,7 @@ allOf:
           contains:
             enum:
               - qcom,sc7180-mpss-pas
+              - qcom,sc7280-mpss-pas
               - qcom,sm8150-adsp-pas
               - qcom,sm8150-cdsp-pas
               - qcom,sm8150-mpss-pas
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

