Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52BD2338CA1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 13:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbhCLMXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 07:23:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbhCLMXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 07:23:03 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB35C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 04:23:03 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id y16so4709271wrw.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 04:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dw9cMYL3jtOlJaAZjl852OdyP+MrjSkhGMQF/GJ7398=;
        b=MnZg8BckWCKVKqWXv2LXDVn0bGKFv/UO5w0PAdja6Vo5FYRJNZnEt42SJoQzgoS/BL
         MMcs/kCElXSsbDwrcstRTWQfBR+SnPt7TA1xtCcKcJp3p/MmRp5t6KeG4SD9v7QV15qC
         JgvuBbdJ9v7nGrfE6GqM7dNbPiGwKnX2ivGC5XPlpljxamylHW6DIhwxU8MiM/E+F343
         TPLo/yzzUh31BRxcjodGt90M6el50sVwyGlHgLOC2wKdDpk/B7X0mUsLnNFj9LhnK5Vt
         h0Ssv6yTUgHqFalRhDJeK1fUaQAvFEtyEu/dj6tSzdePaY5xz83zK800LrfwsYEKiOpO
         ukhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dw9cMYL3jtOlJaAZjl852OdyP+MrjSkhGMQF/GJ7398=;
        b=nxsL937U+/6rxAfZ/7PYrpLbMIwDiE4ALH0f4u5OJfTw+DDyVv5deWz/U9Ny7cb842
         uqur8gmov6eqmMus9/IvKRVyNriIZ3whxYnurubtqitMIcW2e6jBCzAgrPT8Kcudbs4L
         1+fTed6pM8c9amBXM4IynjxDIKt05tdmqWP2U/KJOogVwIrm9IJxfVU6HBDiO2BYtItJ
         rLwbqTwmYIVwtRD/O44SMvFuJpdY9bzhCSAfetP8qlKtKPP0iq7WDGRYStfht9A+b7/d
         DD6AK1rh+/TFUqWoLipxlYJ1HK2fX7kKtG07yNBVmBOPBCqJI1O2W3TYEYsN1/SfD8RG
         tfWQ==
X-Gm-Message-State: AOAM5323F/Ynro7asiIj1wYTkKFVDsCo0RWUcnN4/osPf1zF57Qk0gft
        61KvY6hf6ND9AtRCzoWPvKEdgw==
X-Google-Smtp-Source: ABdhPJxelaUCaKUQZmHL7HJb4caHsVTShiD872wjtSGytEdC3VatTRVvj0MTTd5faY2TOorhScvwAw==
X-Received: by 2002:adf:a2d3:: with SMTP id t19mr13660099wra.299.1615551782223;
        Fri, 12 Mar 2021 04:23:02 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id 3sm8804329wry.72.2021.03.12.04.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 04:23:01 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, vkoul@kernel.org
Cc:     robh@kernel.org, devicetree@vger.kernel.org,
        yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RESEND PATCH v3 4/5] ASoC: dt-bindings: wsa881x: add bindings for port mapping
Date:   Fri, 12 Mar 2021 12:22:54 +0000
Message-Id: <20210312122255.3143-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210312122255.3143-1-srinivas.kandagatla@linaro.org>
References: <20210312122255.3143-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WSA881x SoundWire device ports are statically assigned to master ports
at design time. So add bindings required to specify these mappings!

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../devicetree/bindings/sound/qcom,wsa881x.yaml          | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/qcom,wsa881x.yaml b/Documentation/devicetree/bindings/sound/qcom,wsa881x.yaml
index ea44d03e58ca..491ce1270cb5 100644
--- a/Documentation/devicetree/bindings/sound/qcom,wsa881x.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,wsa881x.yaml
@@ -26,6 +26,13 @@ properties:
     description: GPIO spec for Powerdown/Shutdown line to use
     maxItems: 1
 
+  qcom,port-mapping:
+    description: |
+      Specifies static port mapping between slave and master ports.
+      In the order of slave port index.
+    maxItems: 4
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+
   '#thermal-sensor-cells':
     const: 0
 
@@ -54,6 +61,7 @@ examples:
             powerdown-gpios = <&wcdpinctrl 2 0>;
             #thermal-sensor-cells = <0>;
             #sound-dai-cells = <0>;
+            qcom,port-mapping = <1 2 3 7>;
         };
 
         speaker@0,2 {
@@ -62,6 +70,7 @@ examples:
             powerdown-gpios = <&wcdpinctrl 2 0>;
             #thermal-sensor-cells = <0>;
             #sound-dai-cells = <0>;
+            qcom,port-mapping = <4 5 6 8>;
         };
     };
 
-- 
2.21.0

