Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34E1639B878
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 13:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbhFDLzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 07:55:38 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:44022 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbhFDLzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 07:55:37 -0400
Received: by mail-ed1-f54.google.com with SMTP id s6so10778440edu.10
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 04:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5j5rgBC9lX13jha0n88LekB5zZqgucGPLSnMQ3bIh4o=;
        b=J1Ee5tPz44E+NWe276Ludx6VS/UmQV+jX0PZA9EUalZ6leSqTpMNFdLfYH9tfl15pp
         zdoC6/GY9VwOqLvYk2fbrleNvXwVcMrzaJJ2JQP9r8Bl+dcHCz33d2kROHkJ9mkXhGpA
         Y7y5EV+iQYVkLiJMkJ/VWVI+20eUK0TWgF0ZWLNhswi8EF4U+wlrJMtzNyZ+k03lvtXq
         3N+Asj0K0AEefwndf0XskBVsKKGICxKl5cg3FjqyaYSwfb5HbdeDR4qtfVft5ixUBx8y
         Tow9s+mChO5ORadFP6ZpE1vAvLmziJR4ZaMOGlcHh4oIqoYv9TOxJdkG8F5nkoBMtgrm
         1CZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5j5rgBC9lX13jha0n88LekB5zZqgucGPLSnMQ3bIh4o=;
        b=uUVluHwlqFUJVg6ZzNVoYg53Bq8bG1Ye6bN++HRXf0O1yIJQX03MBJLaiRD3m5tLlC
         i9CNCd9BEbLoyn9cmCd0ZNh96L3e88ivm2GrZCh6WmHgwGkqg63gbvfZ5yHxdo+OJLCe
         baGNGuvz+8CU2jSQf/B7o1xuTst87H+1+qOGDaQdYn9Ssx4CXdHnQQVS3QUfTsG3cvR9
         vN8Nx4DT4BgWOmPuehaGnB1vqOsEdDVHjtRa8Y7zLymZ4pnaLc7VpoI3Isl/tXiRkjHe
         FHbRE0o/IQJicMwF5pDODPOPMB3rfTtvcLHQ2Uif/RZv6wO5x9B5wqfp1aMdCHqV81kn
         28hw==
X-Gm-Message-State: AOAM532qw2+QvohZNmZlBQ4bYCcp6MI4FjpxKs3ugcTXo46Yz+mmEJ6/
        VKRAXElpWHeTLCwTPOWYLkAnTQ==
X-Google-Smtp-Source: ABdhPJwVY3yFv1D6F4g4S+Uhs6HitOYun/5vjW0DqJ3yxHeUU6wMQTm8aRFnuO0cLCFwbbW7S6daPw==
X-Received: by 2002:a05:6402:424c:: with SMTP id g12mr4224119edb.145.1622807557673;
        Fri, 04 Jun 2021 04:52:37 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id x9sm2805527eje.64.2021.06.04.04.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 04:52:37 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     robh@kernel.org, devicetree@vger.kernel.org, perex@perex.cz,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 1/4] ASoC: dt-bindings: wcd934x: add bindings for Headset Button detection
Date:   Fri,  4 Jun 2021 12:52:27 +0100
Message-Id: <20210604115230.23259-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210604115230.23259-1-srinivas.kandagatla@linaro.org>
References: <20210604115230.23259-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings required for Multi Button Headset detection.
WCD934x support Headsets with upto 8 buttons including, impedance measurement
on both L/R Headset speakers and cross connection detection.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/sound/qcom,wcd934x.yaml          | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/qcom,wcd934x.yaml b/Documentation/devicetree/bindings/sound/qcom,wcd934x.yaml
index e8f716b5f875..9b225dbf8b79 100644
--- a/Documentation/devicetree/bindings/sound/qcom,wcd934x.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,wcd934x.yaml
@@ -77,6 +77,31 @@ properties:
     minimum: 1800000
     maximum: 2850000
 
+  qcom,hphl-jack-type-normally-closed:
+    description: Indicates that HPHL jack switch type is normally closed
+    type: boolean
+
+  qcom,ground-jack-type-normally-closed:
+    description: Indicates that Headset Ground switch type is normally closed
+    type: boolean
+
+  qcom,mbhc-headset-vthreshold-microvolt:
+    description: Voltage threshold value for headset detection
+    minimum: 0
+    maximum: 2850000
+
+  qcom,mbhc-headphone-vthreshold-microvolt:
+    description: Voltage threshold value for headphone detection
+    minimum: 0
+    maximum: 2850000
+
+  qcom,mbhc-buttons-vthreshold-microvolt:
+    description:
+      Array of 8 Voltage threshold values corresponding to headset
+      button0 - button7
+    minItems: 8
+    maxItems: 8
+
   clock-output-names:
     const: mclk
 
@@ -159,6 +184,11 @@ examples:
         qcom,micbias2-microvolt = <1800000>;
         qcom,micbias3-microvolt = <1800000>;
         qcom,micbias4-microvolt = <1800000>;
+        qcom,hphl-jack-type-normally-closed;
+        qcom,ground-jack-type-normally-closed;
+        qcom,mbhc-buttons-vthreshold-microvolt = <75000 150000 237000 500000 500000 500000 500000 500000>;
+        qcom,mbhc-headset-vthreshold-microvolt = <1700000>;
+        qcom,mbhc-headphone-vthreshold-microvolt = <50000>;
         clock-names = "extclk";
         clocks = <&rpmhcc 2>;
 
-- 
2.21.0

