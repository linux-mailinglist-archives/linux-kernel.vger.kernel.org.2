Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E787F4545CE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 12:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236891AbhKQLlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 06:41:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236837AbhKQLlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 06:41:08 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5BAC061204
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 03:38:08 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id k37-20020a05600c1ca500b00330cb84834fso4508825wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 03:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=IdJJhrRpftq1m7Kk3EVMrUIrSaR2a6rKnBgshEFLV04=;
        b=AorhigbMRmR7TtkdU9V6oaaA0Ye0DX6Dv8KPxUZA3c0wAOFPN2UaR4xV2dNES+WeVs
         7iBwuPze3kROm13PhuPhIw5wmo9wCa+6pmbofqe7fSQDyljkrS+ZvZrs4OGCiGU9tq/x
         kQtYS8phMERh2D0Nx/IYhUmiKXdwPhb9ItycWe4jykVwfjuq1lXdlU6bs8EAYiHkN/5E
         hB1tcsIprWU/rGP6MBES4kIlsW2NyIgwlwOPVRdyUgLPeOab9uh5X6blrBCsQqZtqKkb
         0ddQ/Onuu8QuInTdNFGeX0eCIMCvhrTKCTFb5CsdDGZTJYA0SQu5BiQYyJY6jhwpUay/
         B31w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IdJJhrRpftq1m7Kk3EVMrUIrSaR2a6rKnBgshEFLV04=;
        b=2/6mgTpz6fbl7qcDd4jugTsrBWsJoOQjTVfxeezhyUi5xUkl6cRmya8kksIyx0iXv+
         ++n6r+xSS9LUNRaIf+OgDRw1QB0iECh9mXd6LFvX/EUSez44JhxwoNHOVfRGUzuDnT7A
         fx7H5456PlOh1S5T7r7Gg9EJxr1QMoDvcMxvAwMc/IsuFYtsWPZEMcwZHK0BixXvwYIX
         DeScbM/IEYNOJ1R9I242pIa05ZQuYPP8PrprSDcLHJLKYTfXE+DRWt9bVXH2tdP5AYQd
         JMgQB8V3ytRfFKKgUIfqyLDvlOKhHUW/mHO+zc5e5ZUUJsvDCf7q2IjqlBI+cZLr6Z9q
         Af8Q==
X-Gm-Message-State: AOAM532kjcvXwPY1Zah2GDXuAqPswtb0gh/dWWM6dmcN/iQqrInuUbNP
        CDFgLvOjKDRV9CaKO6x7i2ei/w==
X-Google-Smtp-Source: ABdhPJz4pRR8W9YbDyuyDeE6HM9OOblvz8hpS/Zw1g41mngXTRvYFkAcwvQxgfgX30bxz8XdfMDiFQ==
X-Received: by 2002:a05:600c:4982:: with SMTP id h2mr17126291wmp.4.1637149087464;
        Wed, 17 Nov 2021 03:38:07 -0800 (PST)
Received: from xps7590.. (freifunk-gw.bsa1-cpe1.syseleven.net. [176.74.57.43])
        by smtp.gmail.com with ESMTPSA id t8sm6560453wmq.32.2021.11.17.03.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 03:38:06 -0800 (PST)
From:   Robert Foss <robert.foss@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        robert.foss@linaro.org, todor.too@gmail.com, mchehab@kernel.org,
        robh+dt@kernel.org, angelogioacchino.delregno@somainline.org,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andrey Konovalov <andrey.konovalov@linaro.org>
Subject: [PATCH v2 2/4] media: dt-bindings: media: camss: Remove clock-lane property
Date:   Wed, 17 Nov 2021 12:37:58 +0100
Message-Id: <20211117113800.260741-3-robert.foss@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211117113800.260741-1-robert.foss@linaro.org>
References: <20211117113800.260741-1-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clock-lanes property is not programmable by the hardware,
and as such it should not be exposed in the dt-binding.

Signed-off-by: Robert Foss <robert.foss@linaro.org>
---
 .../bindings/media/qcom,msm8916-camss.yaml    | 10 ----------
 .../bindings/media/qcom,msm8996-camss.yaml    | 20 -------------------
 .../bindings/media/qcom,sdm660-camss.yaml     | 20 -------------------
 .../bindings/media/qcom,sdm845-camss.yaml     | 17 ----------------
 4 files changed, 67 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/qcom,msm8916-camss.yaml b/Documentation/devicetree/bindings/media/qcom,msm8916-camss.yaml
index 304908072d72..12ec3e1ea869 100644
--- a/Documentation/devicetree/bindings/media/qcom,msm8916-camss.yaml
+++ b/Documentation/devicetree/bindings/media/qcom,msm8916-camss.yaml
@@ -83,10 +83,6 @@ properties:
             unevaluatedProperties: false
 
             properties:
-              clock-lanes:
-                items:
-                  - const: 1
-
               data-lanes:
                 description:
                   An array of physical data lanes indexes.
@@ -99,7 +95,6 @@ properties:
                 maxItems: 4
 
             required:
-              - clock-lanes
               - data-lanes
 
       port@1:
@@ -114,16 +109,11 @@ properties:
             unevaluatedProperties: false
 
             properties:
-              clock-lanes:
-                items:
-                  - const: 1
-
               data-lanes:
                 minItems: 1
                 maxItems: 4
 
             required:
-              - clock-lanes
               - data-lanes
 
   reg:
diff --git a/Documentation/devicetree/bindings/media/qcom,msm8996-camss.yaml b/Documentation/devicetree/bindings/media/qcom,msm8996-camss.yaml
index 38be41e932f0..6aeb3d6d02d5 100644
--- a/Documentation/devicetree/bindings/media/qcom,msm8996-camss.yaml
+++ b/Documentation/devicetree/bindings/media/qcom,msm8996-camss.yaml
@@ -105,10 +105,6 @@ properties:
             unevaluatedProperties: false
 
             properties:
-              clock-lanes:
-                items:
-                  - const: 7
-
               data-lanes:
                 description:
                   An array of physical data lanes indexes.
@@ -121,7 +117,6 @@ properties:
                 maxItems: 4
 
             required:
-              - clock-lanes
               - data-lanes
 
       port@1:
@@ -136,16 +131,11 @@ properties:
             unevaluatedProperties: false
 
             properties:
-              clock-lanes:
-                items:
-                  - const: 7
-
               data-lanes:
                 minItems: 1
                 maxItems: 4
 
             required:
-              - clock-lanes
               - data-lanes
 
       port@2:
@@ -160,16 +150,11 @@ properties:
             unevaluatedProperties: false
 
             properties:
-              clock-lanes:
-                items:
-                  - const: 7
-
               data-lanes:
                 minItems: 1
                 maxItems: 4
 
             required:
-              - clock-lanes
               - data-lanes
 
       port@3:
@@ -184,16 +169,11 @@ properties:
             unevaluatedProperties: false
 
             properties:
-              clock-lanes:
-                items:
-                  - const: 7
-
               data-lanes:
                 minItems: 1
                 maxItems: 4
 
             required:
-              - clock-lanes
               - data-lanes
 
   reg:
diff --git a/Documentation/devicetree/bindings/media/qcom,sdm660-camss.yaml b/Documentation/devicetree/bindings/media/qcom,sdm660-camss.yaml
index 841a1aafdd13..338ab28d5f3b 100644
--- a/Documentation/devicetree/bindings/media/qcom,sdm660-camss.yaml
+++ b/Documentation/devicetree/bindings/media/qcom,sdm660-camss.yaml
@@ -111,16 +111,11 @@ properties:
             unevaluatedProperties: false
 
             properties:
-              clock-lanes:
-                items:
-                  - const: 7
-
               data-lanes:
                 minItems: 1
                 maxItems: 4
 
             required:
-              - clock-lanes
               - data-lanes
 
       port@1:
@@ -135,16 +130,11 @@ properties:
             unevaluatedProperties: false
 
             properties:
-              clock-lanes:
-                items:
-                  - const: 7
-
               data-lanes:
                 minItems: 1
                 maxItems: 4
 
             required:
-              - clock-lanes
               - data-lanes
 
       port@2:
@@ -159,16 +149,11 @@ properties:
             unevaluatedProperties: false
 
             properties:
-              clock-lanes:
-                items:
-                  - const: 7
-
               data-lanes:
                 minItems: 1
                 maxItems: 4
 
             required:
-              - clock-lanes
               - data-lanes
 
       port@3:
@@ -183,16 +168,11 @@ properties:
             unevaluatedProperties: false
 
             properties:
-              clock-lanes:
-                items:
-                  - const: 7
-
               data-lanes:
                 minItems: 1
                 maxItems: 4
 
             required:
-              - clock-lanes
               - data-lanes
 
   reg:
diff --git a/Documentation/devicetree/bindings/media/qcom,sdm845-camss.yaml b/Documentation/devicetree/bindings/media/qcom,sdm845-camss.yaml
index 9ca5dfa7f226..9404d6b9db54 100644
--- a/Documentation/devicetree/bindings/media/qcom,sdm845-camss.yaml
+++ b/Documentation/devicetree/bindings/media/qcom,sdm845-camss.yaml
@@ -105,15 +105,11 @@ properties:
             unevaluatedProperties: false
 
             properties:
-              clock-lanes:
-                maxItems: 1
-
               data-lanes:
                 minItems: 1
                 maxItems: 4
 
             required:
-              - clock-lanes
               - data-lanes
 
       port@1:
@@ -128,16 +124,11 @@ properties:
             unevaluatedProperties: false
 
             properties:
-              clock-lanes:
-                items:
-                  - const: 7
-
               data-lanes:
                 minItems: 1
                 maxItems: 4
 
             required:
-              - clock-lanes
               - data-lanes
 
       port@2:
@@ -152,15 +143,11 @@ properties:
             unevaluatedProperties: false
 
             properties:
-              clock-lanes:
-                maxItems: 1
-
               data-lanes:
                 minItems: 1
                 maxItems: 4
 
             required:
-              - clock-lanes
               - data-lanes
 
       port@3:
@@ -175,15 +162,11 @@ properties:
             unevaluatedProperties: false
 
             properties:
-              clock-lanes:
-                maxItems: 1
-
               data-lanes:
                 minItems: 1
                 maxItems: 4
 
             required:
-              - clock-lanes
               - data-lanes
 
   reg:
-- 
2.32.0

