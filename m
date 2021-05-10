Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97D513780EB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 12:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbhEJKN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 06:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbhEJKNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 06:13:20 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B6AC061760
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 03:12:15 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id z6so15992196wrm.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 03:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rij2/M/HKkSLFPHAJhhVJA6+zwbwek0D/b3cbL9vGJE=;
        b=MFuPgAt9Xb2qMiVljGJyA+uXnFVr3R2u4usj2DTx1SeqSvaF35dF3HGyWKb9gigUkw
         a1v6M35FgV96ayryWUJHvvX7NSFgxFgsdeBjtWuTawmAV8aDFaULq05l8n/3jbPopx3H
         iYnfThykEyMYPXiJJV/ml/JikXVPv5paHsZUaU7c3SuP4xOcVE6qCFjIJpjbfWkhS6sn
         EYsWSXZtVPQivsWDEaRs9IrYJHgKT1B9pEcgMHYdYJZliwUGC6hFAvVgetsztj9ng5bn
         wZ2etz0Hd7rxmXaRkhJ21tgZa0MJaolHqhI+gZp5rQbYXukQZipbhxz0fPRaGXyVdPMi
         IovA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rij2/M/HKkSLFPHAJhhVJA6+zwbwek0D/b3cbL9vGJE=;
        b=M7FGUYUry7b/KJgFZz75jHXZv2/MPxRFGbKPsLwt2RmCCTGW8Q+gGN7Dc7nTPvvDV4
         hV6mhCKh5qWjQoqZkMfAAzNwNiYCMsQvzjg0VPOvt3KxhckeMHrqP7FdvbkRekb8ZcPg
         Yi+M3da+fMQN+9GSWgajpguz+2vTHs/36PTdeswBwxB4RJdcmffMQy+VOXtaUuHD4Rbg
         DgXC/RXH3l07pS2l9CKTcObDNAgATJVCY7b8hzv6lP5RQq12wDqiG/SmzbhNgcguHGPh
         1R8UKYwoerYeEw0NUEVzwl3hfmMJYCkxmFZAd8IhOX6I1hKQUt5zmt1qs6oCSxZoMaVb
         N3Hw==
X-Gm-Message-State: AOAM533eVIYlnqih+i2xr+qU1lnRTTICLelnluyvEsTghajSxPi0xdX/
        UfQI0I1qcN7Bi7DCYybMYn4lSw==
X-Google-Smtp-Source: ABdhPJyR4qTOnILOTITMg3PbEL5bMtKXighTKxNJaEbAZmb5m3EwgEl6fTAu/xAjlo/IhBefwyqYvw==
X-Received: by 2002:adf:e44e:: with SMTP id t14mr30166177wrm.310.1620641534038;
        Mon, 10 May 2021 03:12:14 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id b7sm22072109wri.83.2021.05.10.03.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 03:12:13 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     robh@kernel.org, devicetree@vger.kernel.org, perex@perex.cz,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com, lee.jones@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/4] ASoC: dt-bindings: wcd934x: add bindings for Headset Button detection
Date:   Mon, 10 May 2021 11:11:58 +0100
Message-Id: <20210510101201.7281-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210510101201.7281-1-srinivas.kandagatla@linaro.org>
References: <20210510101201.7281-1-srinivas.kandagatla@linaro.org>
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
 .../bindings/sound/qcom,wcd934x.yaml          | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/qcom,wcd934x.yaml b/Documentation/devicetree/bindings/sound/qcom,wcd934x.yaml
index e8f716b5f875..b25c6ca4e97c 100644
--- a/Documentation/devicetree/bindings/sound/qcom,wcd934x.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,wcd934x.yaml
@@ -77,6 +77,64 @@ properties:
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
+  qcom,mbhc-button0-vthreshold-microvolt:
+    description: Voltage threshold value for headset button0
+    minimum: 0
+    maximum: 500000
+
+  qcom,mbhc-button1-vthreshold-microvolt:
+    description: Voltage threshold value for headset button1
+    minimum: 0
+    maximum: 500000
+
+  qcom,mbhc-button2-vthreshold-microvolt:
+    description: Voltage threshold value for headset button2
+    minimum: 0
+    maximum: 500000
+
+  qcom,mbhc-button3-vthreshold-microvolt:
+    description: Voltage threshold value for headset button3
+    minimum: 0
+    maximum: 500000
+
+  qcom,mbhc-button4-vthreshold-microvolt:
+    description: Voltage threshold value for headset button4
+    minimum: 0
+    maximum: 500000
+
+  qcom,mbhc-button5-vthreshold-microvolt:
+    description: Voltage threshold value for headset button5
+    minimum: 0
+    maximum: 500000
+
+  qcom,mbhc-button6-vthreshold-microvolt:
+    description: Voltage threshold value for headset button6
+    minimum: 0
+    maximum: 500000
+
+  qcom,mbhc-button7-vthreshold-microvolt:
+    description: Voltage threshold value headset button7
+    minimum: 0
+    maximum: 500000
+
   clock-output-names:
     const: mclk
 
@@ -159,6 +217,13 @@ examples:
         qcom,micbias2-microvolt = <1800000>;
         qcom,micbias3-microvolt = <1800000>;
         qcom,micbias4-microvolt = <1800000>;
+        qcom,hphl-jack-type-normally-closed;
+        qcom,ground-jack-type-normally-closed;
+        qcom,mbhc-button0-vthreshold-microvolt = <75000>;
+        qcom,mbhc-button1-vthreshold-microvolt = <150000>;
+        qcom,mbhc-button2-vthreshold-microvolt = <237000>;
+        qcom,mbhc-headset-vthreshold-microvolt = <1700000>;
+        qcom,mbhc-headphone-vthreshold-microvolt = <50000>;
         clock-names = "extclk";
         clocks = <&rpmhcc 2>;
 
-- 
2.21.0

