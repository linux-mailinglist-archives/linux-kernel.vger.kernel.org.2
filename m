Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D602A3AAB12
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 07:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbhFQFgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 01:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbhFQFgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 01:36:53 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613CCC061768
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 22:34:46 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id u18so4049629pfk.11
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 22:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mXC2NA+CSEwSuQ2JUNooTVOMpQPHWlDfkI99DL5Kw+A=;
        b=uA6oN8l2LKCr6Dbrep/XAPRBGNqFDwLt1sC+AZBEqwdO9pR2ZhOlBwhUVKJl+lkhzx
         G0NGmpyzRfuCpKRK+KbTWt6YtAJofkCjUa891fj/oAZGFssUQP0QqjbdL59BVzHviGjj
         qK/RRLEocaVW1Y7eAqCvd50I4gbXZNW9LoSLgp2Pq29UDubF1dT6X6lUWUjtPVxQi998
         Au9igrArV5SnAYdoa3Hj4UMMjslnNwsn/XvHwxRWjGp+sK2DQ0af/L/xnCblQzQ1o4PS
         xAVGYPAuSmMRAmvMH09OZ6l1TMG7RI48jDVKNpPIx3drXuPsPfM4hEJaME7SK4jF2hjP
         4o8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mXC2NA+CSEwSuQ2JUNooTVOMpQPHWlDfkI99DL5Kw+A=;
        b=ocPSxATCcoQzjs4OeXZpBP914EcyFDQg3g/fMDhdt94jybmL3SGyoLCiMu+QjzuAHM
         kp8PoQfOI5sCAnMqOzWIPW8FAfYSLm7ToZ8kmA0YyqlO/J/oToV39PTWuBoc+sZ/z+Ug
         gZI7Xj+xhLeG5sFKw52ksCug1CMnrT1Vpc+KJfB21hQXqc/o20MvZJJJXAtfjf3Pl5CN
         PyOaTtvvaVDK0gvQ+ai9XTQKhxo9H7KRd64FFrkqpDWVRsL9CZ86x/sfWJkk97GX91x5
         i27tdd+rHcGPrkogYX16adcOGuGZYGp+1+6zfx9z6HeNgApa1jksMotIxE3L/LPrzLmg
         dRcQ==
X-Gm-Message-State: AOAM532xX4r8Cpd0LICnfB/NbEakUzgskb0ADM/UlIlGTY/Og3/zN+d1
        ULSIEDyhklxAm+dxWGbj7jGUCQ==
X-Google-Smtp-Source: ABdhPJyzbBuh2N9W618czQhIOGirFq73oAKVDmeTJy10jp/+3K4l8Ma+i7OTMPVLyuAjHPxk4tSxNw==
X-Received: by 2002:a63:5a5d:: with SMTP id k29mr3237914pgm.215.1623908085941;
        Wed, 16 Jun 2021 22:34:45 -0700 (PDT)
Received: from localhost.name ([122.177.46.2])
        by smtp.gmail.com with ESMTPSA id m126sm4056405pfb.15.2021.06.16.22.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 22:34:45 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, lgirdwood@gmail.com,
        Linus Walleij <linus.walleij@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH v3 1/4] dt-bindings: pinctrl: qcom,pmic-gpio: Arrange compatibles alphabetically
Date:   Thu, 17 Jun 2021 11:04:29 +0530
Message-Id: <20210617053432.350486-2-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210617053432.350486-1-bhupesh.sharma@linaro.org>
References: <20210617053432.350486-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arrange the compatibles inside qcom-pmic gpio device tree
bindings alphabetically.

While at it, also make some minor cosmetic changes to allow
future compatible addition to the bindings simpler.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 .../bindings/pinctrl/qcom,pmic-gpio.txt       | 58 +++++++++----------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt
index f6a9760558a6..10f049e21264 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt
@@ -7,10 +7,20 @@ PMIC's from Qualcomm.
 	Usage: required
 	Value type: <string>
 	Definition: must be one of:
+		    "qcom,pm660-gpio"
+		    "qcom,pm660l-gpio"
+		    "qcom,pm6150-gpio"
+		    "qcom,pm6150l-gpio"
 		    "qcom,pm8005-gpio"
+		    "qcom,pm8008-gpio"
 		    "qcom,pm8018-gpio"
 		    "qcom,pm8038-gpio"
 		    "qcom,pm8058-gpio"
+		    "qcom,pm8150-gpio"
+		    "qcom,pm8150b-gpio"
+		    "qcom,pm8350-gpio"
+		    "qcom,pm8350b-gpio"
+		    "qcom,pm8350c-gpio"
 		    "qcom,pm8916-gpio"
 		    "qcom,pm8917-gpio"
 		    "qcom,pm8921-gpio"
@@ -22,20 +32,10 @@ PMIC's from Qualcomm.
 		    "qcom,pmi8950-gpio"
 		    "qcom,pmi8994-gpio"
 		    "qcom,pmi8998-gpio"
-		    "qcom,pms405-gpio"
-		    "qcom,pm660-gpio"
-		    "qcom,pm660l-gpio"
-		    "qcom,pm8150-gpio"
-		    "qcom,pm8150b-gpio"
-		    "qcom,pm8350-gpio"
-		    "qcom,pm8350b-gpio"
-		    "qcom,pm8350c-gpio"
 		    "qcom,pmk8350-gpio"
 		    "qcom,pmr735a-gpio"
 		    "qcom,pmr735b-gpio"
-		    "qcom,pm6150-gpio"
-		    "qcom,pm6150l-gpio"
-		    "qcom,pm8008-gpio"
+		    "qcom,pms405-gpio"
 		    "qcom,pmx55-gpio"
 
 		    And must contain either "qcom,spmi-gpio" or "qcom,ssbi-gpio"
@@ -97,34 +97,34 @@ to specify in a pin configuration subnode:
 	Value type: <string-array>
 	Definition: List of gpio pins affected by the properties specified in
 		    this subnode.  Valid pins are:
-		    gpio1-gpio4 for pm8005
-		    gpio1-gpio6 for pm8018
+		    gpio1-gpio10 for pm6150
+		    gpio1-gpio12 for pm6150l
+		    gpio1-gpio4  for pm8005
+		    gpio1-gpio2  for pm8008
+		    gpio1-gpio6  for pm8018
 		    gpio1-gpio12 for pm8038
 		    gpio1-gpio40 for pm8058
-		    gpio1-gpio4 for pm8916
+		    gpio1-gpio10 for pm8150 (holes on gpio2, gpio5, gpio7
+					     and gpio8)
+		    gpio1-gpio12 for pm8150b (holes on gpio3, gpio4, gpio7)
+		    gpio1-gpio12 for pm8150l (hole on gpio7)
+		    gpio1-gpio10 for pm8350
+		    gpio1-gpio8  for pm8350b
+		    gpio1-gpio9  for pm8350c
+		    gpio1-gpio4  for pm8916
 		    gpio1-gpio38 for pm8917
 		    gpio1-gpio44 for pm8921
 		    gpio1-gpio36 for pm8941
-		    gpio1-gpio8 for pm8950 (hole on gpio3)
+		    gpio1-gpio8  for pm8950 (hole on gpio3)
 		    gpio1-gpio22 for pm8994
 		    gpio1-gpio26 for pm8998
 		    gpio1-gpio22 for pma8084
-		    gpio1-gpio2 for pmi8950
+		    gpio1-gpio2  for pmi8950
 		    gpio1-gpio10 for pmi8994
+		    gpio1-gpio4  for pmk8350
+		    gpio1-gpio4  for pmr735a
+		    gpio1-gpio4  for pmr735b
 		    gpio1-gpio12 for pms405 (holes on gpio1, gpio9 and gpio10)
-		    gpio1-gpio10 for pm8150 (holes on gpio2, gpio5, gpio7
-					     and gpio8)
-		    gpio1-gpio12 for pm8150b (holes on gpio3, gpio4, gpio7)
-		    gpio1-gpio12 for pm8150l (hole on gpio7)
-		    gpio1-gpio10 for pm8350
-		    gpio1-gpio8 for pm8350b
-		    gpio1-gpio9 for pm8350c
-		    gpio1-gpio4 for pmk8350
-		    gpio1-gpio4 for pmr735a
-		    gpio1-gpio4 for pmr735b
-		    gpio1-gpio10 for pm6150
-		    gpio1-gpio12 for pm6150l
-		    gpio1-gpio2 for pm8008
 		    gpio1-gpio11 for pmx55 (holes on gpio3, gpio7, gpio10
 					    and gpio11)
 
-- 
2.31.1

