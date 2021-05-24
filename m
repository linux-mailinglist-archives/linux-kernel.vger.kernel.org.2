Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E94D038E4D2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 13:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbhEXLIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 07:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232609AbhEXLIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 07:08:43 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50AFBC06138A
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 04:07:15 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id n17-20020a7bc5d10000b0290169edfadac9so1384183wmk.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 04:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c8u1uKiF4cwNsy2YewN8Mgn0CBiEVyeAerYkNkO3g7c=;
        b=tKvdQ/FR4p6VLgPqIWJrvCMpOywStOt1QnT/nHDbjnQBQXqYdOglN7uVbeLK5mvL2I
         OlhFjD22TsWDv5ISaoct0RTAfOGVMxb1RSuxwEueoZSN2269MPtiXU85EZ5AFYTAQ0K6
         j2FULpjZ5tdwU427vCvOqAvRuob7dD4XPtu8HqZQGfhk7XY5VNkyao4AnRC+O9qZl9T9
         7SeOs6uHd+979UGzhfCq3Kkt2XErJuTsHfEwmCXUjC5aFH4EXuL/53CBOj6trqIqxein
         6EpzSgkMebSQN51fhyD9+qb+sMBGnlhaE0APPpMSTqzYGF4PBtnOhsLHZVOfCVbSxi6T
         UX1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c8u1uKiF4cwNsy2YewN8Mgn0CBiEVyeAerYkNkO3g7c=;
        b=ewEeanOnQVvOhiTNlqiweTeKTq1exWHXB9sTKaBWdn3sbqyXmKTXhEziBnACcYHTtJ
         wc8aiaDSuer8qfidj8T4EZJQKbZrScg6YSdpPdDgRKGmL9u2rtaIZ0y/wkOwwwwIvg+I
         dJXWI5JqO4xuRKVdnPEANwid+25YwfYCelMTu55rhq3XuIteqNWvQ4ZFDV8UqGjq1ZRl
         gBpZCPejknMlCoec9blh1qPISAmzjzMric82qgMnRSQQ2+vuuWVzY2+Tqe6iPR+6MaMj
         ob2WQVQthkthHYD3hdHTVCAv1SQGA0dtIB0fHBuxBxn2tcQ+XSw2Vp+WJtboyg9grXSz
         xQPw==
X-Gm-Message-State: AOAM530VqjucBn6vT2DoL4RlGjVncs81+dMlU08clHw9l8UUryq9TSnh
        P/tkOkE2a1Jlblr9MdFoHH4KjA==
X-Google-Smtp-Source: ABdhPJxONpq3vILFH55Qst67QptNQS+miFFkQcuJIrCsQwnMmLgBvTSo9iPfbxxsfqJax9KGx591Wg==
X-Received: by 2002:a05:600c:b58:: with SMTP id k24mr19331110wmr.155.1621854433853;
        Mon, 24 May 2021 04:07:13 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id x4sm7590978wmj.17.2021.05.24.04.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 04:07:13 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     robh@kernel.org, devicetree@vger.kernel.org, perex@perex.cz,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 1/4] ASoC: dt-bindings: wcd934x: add bindings for Headset Button detection
Date:   Mon, 24 May 2021 12:06:57 +0100
Message-Id: <20210524110700.27077-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210524110700.27077-1-srinivas.kandagatla@linaro.org>
References: <20210524110700.27077-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings required for Multi Button Headset detection.
WCD934x support Headsets with upto 8 buttons including, impedance measurement
on both L/R Headset speakers and cross connection detection.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
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

