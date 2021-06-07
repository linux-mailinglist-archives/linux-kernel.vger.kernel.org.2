Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F198239DB84
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 13:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbhFGLlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 07:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbhFGLlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 07:41:15 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340D5C061789
        for <linux-kernel@vger.kernel.org>; Mon,  7 Jun 2021 04:39:24 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id z26so12854487pfj.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 04:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zrsK6owk2kow8C6W/boob0YZ4Vh4KO+fRL2h89xnMCE=;
        b=T38jYMX0/r08xRHtkOEQEWpqqyuOrGZVGvLLYOC8bTeEGhl+qTAnZ9LFslh+Lj1xlD
         xuF+XnWRuPq9britTriAt1f2i3otpZhJZGaxlTikG4DpxoaKMfMajbKiVtKSXOp9YDgI
         RkqVz3vqzKNKrVCqT4/4sEbTLIgJeNow2a3iMmTdv7HPTX6nsU1AUnHkmYp55eYTX+it
         OowSRXxl7f03e+o0WboWhPyWLlMeC2sib1ijeAdm6UKUqDh3hvsd65/DOOtFs4AjnVNp
         0u3JZmXisKNpNBTQdfbKg7QFTnpni7onbvCPNK9+lNws3WmeMK57RWIHZWGWvBbllIMp
         +Xdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zrsK6owk2kow8C6W/boob0YZ4Vh4KO+fRL2h89xnMCE=;
        b=EeMJNagc3ioqAdfNc1JtyXi8R1/rYLb9RPjNp9eabW6GJUhUyPBwUMHvwHNc8IIpBa
         1d9e7FVcRVEteOskv1ckn/DlP87q1mZFpKiD6FiBMe3L8Xr5qBapZkC8cnB1pB1K4WKL
         uU/XFuA3XQMSp9kFwrwrG4e+2rKo4ymiaTEWDuav+hMyuYNNodRQa9VaJYoPxlexAWKU
         mgfYXPiyaYLxlfTJiroLBwUlMEbQKoXnOaWWrVI1N3pnc6K3IAEFO0HLyQepxsTCGqcE
         FD88YvfggynQJyJ4AS1XfcV+nHhVC0a76VFDKSZ/loAXOty0vKg8YHJ63eiYMfGR7yjS
         H8eg==
X-Gm-Message-State: AOAM5338ULEQKc4/Zvo5F9/q9q9n1de5w82WzTPtALU5L/wSmwse+5fd
        bktt8VcXxhxfJqtfKOFsJnOT3A==
X-Google-Smtp-Source: ABdhPJzRjBjRbRZst+j3DIMIPLbY3+2Q3WsXW5lJA9uzDhbKzEXk5GILCKC0rffIR0xKhhiDnwpqKQ==
X-Received: by 2002:aa7:8114:0:b029:2e9:c437:1121 with SMTP id b20-20020aa781140000b02902e9c4371121mr16492936pfi.7.1623065963772;
        Mon, 07 Jun 2021 04:39:23 -0700 (PDT)
Received: from localhost.localdomain.name ([122.177.177.211])
        by smtp.gmail.com with ESMTPSA id j7sm7223939pjf.0.2021.06.07.04.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 04:39:23 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        bhupesh.linux@gmail.com
Subject: [PATCH 3/8] dt-bindings: arm: qcom: Add compatible for SA8155p-adp board
Date:   Mon,  7 Jun 2021 17:08:35 +0530
Message-Id: <20210607113840.15435-4-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210607113840.15435-1-bhupesh.sharma@linaro.org>
References: <20210607113840.15435-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SA8155p-adp board is based on Qualcomm Snapdragon sm8150
SoC.

Add support for the same.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Andy Gross <agross@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-gpio@vger.kernel.org
Cc: bhupesh.linux@gmail.com
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 9b27e991bddc..b5897f1f9695 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -42,11 +42,13 @@ description: |
         sdm660
         sdm845
         sdx55
+        sm8150
         sm8250
         sm8350
 
   The 'board' element must be one of the following strings:
 
+        adp
         cdp
         cp01-c1
         dragonboard
@@ -198,6 +200,12 @@ properties:
               - qcom,ipq6018-cp01-c1
           - const: qcom,ipq6018
 
+      - items:
+          - enum:
+              - qcom,sa8155p-adp
+              - qcom,sm8150-mtp
+          - const: qcom,sm8150
+
       - items:
           - enum:
               - qcom,qrb5165-rb5
-- 
2.31.1

