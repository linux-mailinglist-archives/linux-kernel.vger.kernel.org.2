Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A69263A97B5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 12:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbhFPKjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 06:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232468AbhFPKjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 06:39:24 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FBFC061224
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 03:37:14 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id h4so3503830lfu.8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 03:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K9rTCswFDcSx/xadpaa8S03K2mvlJRdx5LDwjr8plho=;
        b=I5t43eIZCnjyPa+pKdyMqKnMr/EQajUpEvuogScKNI+ErMEJmin3AHBzvsqi3F7Ved
         49qQwy0hURavSmoJCaIwZ8dVmjdLqfsi2jRYXP+/C8l5fy09a/kHDWT7UE11u5sLMj8C
         h0GQzuVeB4zGiuGdGPjZHgvzy28JGggJE+s7yMliKSGCW/h09IjRdygF5eVc7n66S4xH
         Z9kbx6w+CsSJx2cbAL+nCv0c0V8djUMkZfwg4IdiHJoNQ4YW8Uz0dXDx5qE1p5n1tHCa
         66Oc3U2PfmFdFTGUVZdSzhc/W7suK+3/79px/ibN3lyI2Z5eo5mEdoU/d6O+U/z9FuIM
         O2Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K9rTCswFDcSx/xadpaa8S03K2mvlJRdx5LDwjr8plho=;
        b=j+sFT1hELaxuHGrr1+M5o8g7eMSliiIcIcuzMoRH8ln7VBcaPTP/ciiQ8JIYskUHcG
         YRL4h5jSo9ENQC1bJ05DZoqji9RFyOAXrFk96fyIlJr59zqHk4VbzQOBj3xHv+WGXxPO
         42eLTFzMHybCZiiDumldiY1bn0eLxs2xbbArOsNAwfyywPphQi23D5v+YDpuMKoDMP3C
         GTHlqyrSMRlUI1DvaNIJsgcF446bHyWOo9hQERRnrGUyLlZQvKfn066/tM3hJXuAwdnA
         13WtMYlLXsEzloiBAVwUwiqY+RrGggYrFh1mrXQJLoqc6po4S9Q/JOzEgb4wx5tn+lIA
         iGBg==
X-Gm-Message-State: AOAM5319KJDS0wFAU8ea5lG1bndkp3Xsma8b485vcR8u0R/ztaT1RtDm
        eHGdIJnJHcbn8Ys+38rQvAJqRx2dTZ0KMA==
X-Google-Smtp-Source: ABdhPJyRRh0Pb8kvyCXq/Lr9lQOLxI0JWINcPh9CvxE5rvjcyHijONeFGS2Ue+Juc03F1Wjspl6pIw==
X-Received: by 2002:ac2:4c0e:: with SMTP id t14mr3228126lfq.555.1623839832447;
        Wed, 16 Jun 2021 03:37:12 -0700 (PDT)
Received: from jade.urgonet (h-79-136-85-3.A175.priv.bahnhof.se. [79.136.85.3])
        by smtp.gmail.com with ESMTPSA id m17sm205621lfh.288.2021.06.16.03.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 03:37:12 -0700 (PDT)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     Jerome Forissier <jerome@forissier.org>,
        Etienne Carriere <etienne.carriere@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v2 3/7] dt-bindings: arm: optee: add interrupt property
Date:   Wed, 16 Jun 2021 12:36:45 +0200
Message-Id: <20210616103649.2662395-4-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210616103649.2662395-1-jens.wiklander@linaro.org>
References: <20210616103649.2662395-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds an optional interrupt property to the optee binding.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 .../devicetree/bindings/arm/firmware/linaro,optee-tz.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
index c931b030057f..3efbe11b637d 100644
--- a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
+++ b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
@@ -24,6 +24,9 @@ properties:
             for the reference implementation maintained by Linaro.
           const: linaro,optee-tz
 
+  interrupts:
+    maxItems: 1
+
   method:
     description: The method of calling the OP-TEE Trusted OS.
     $ref: /schemas/types.yaml#/definitions/string-array
@@ -37,6 +40,10 @@ properties:
           in drivers/tee/optee/optee_smc.h
         const: hvc
 
+required:
+  - compatible
+  - method
+
 additionalProperties: false
 
 examples:
@@ -45,5 +52,6 @@ examples:
       optee {
         compatible = "linaro,optee-tz";
         method = "smc";
+        interrupts = <0 187 4>;
       };
     };
-- 
2.31.1

