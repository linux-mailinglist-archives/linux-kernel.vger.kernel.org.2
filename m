Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8DF8338BA5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 12:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233728AbhCLLj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 06:39:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbhCLLjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 06:39:39 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BBEC061761
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 03:39:39 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id f22-20020a7bc8d60000b029010c024a1407so15612730wml.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 03:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dw9cMYL3jtOlJaAZjl852OdyP+MrjSkhGMQF/GJ7398=;
        b=JO/SQnNAgL9e4Z+uuEOW9BgtfgUkesqGXsKQKZNiJhNp5d8P7mjIxUzYGSA0yGeLLT
         twuuywut+oNvZBEizrkkcNbeapEkpRs9C9W7naMzL0dQFHabuL3mKucVmVeWk1tYGHRl
         i6u6KjqFrER9VHlvx582HE5VLOeY2N5n0e7wdK+BOhecBIB+AgykWzUq9HiNMFkbhe4n
         EsDNe7tPZWCCkquzG/d0lapo2v1e5Dp2yQO5ZECx7He7u4GdWtKiTCEIZL0t3ewt4GFw
         ObvGJMp/Xuxy1aubyfcwM4obb1Y4LvCqdiq68AitA3oXULty0UXMy5+eys0qipqDfDLf
         6dMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dw9cMYL3jtOlJaAZjl852OdyP+MrjSkhGMQF/GJ7398=;
        b=FFOe/UbWqwYJf6MceHgfJe0u68q2EyMOzRlzNE2TvwMUogkymZD5hMih5ExUqYoEdz
         MMYPm5ld7dqi4qaW8w302hZ7ytvGpNXyuvbyehzGcAapTB9pHXYaNw9YqRquXyZqy2BL
         DvxZLs4klLjO8t8vJ7hf2f+ztZHx8Y/PQypqVrAHgWeQbEAdAUTvJXBbRJ9tSzLgCVkH
         o+WEMFEwbA9H684f6W7WBWr/wRVPuP7wP8Hk6MKYswH/BfeiutXtQoZLvAHbhssSRnhK
         mIzCIVktFm7M6UI2/K6k3BiVebyNmrqB61n1BlWf4bp1+fWYqZsJ/7KOugrmv5sUcc/h
         XHlw==
X-Gm-Message-State: AOAM532040fH3PoTADV40Bpn/OByN6t0CfRX6Xx/MCgydZY+RduG5724
        wLkjBCaXSHZh1w+d9SPsIgDP4w==
X-Google-Smtp-Source: ABdhPJxHH2KwibL8YYRtor2RZ4P+cFxPGZfR3X963HmMM7BYP1z8q3cJ5K/mo2keqnZkIaWJ22Yu9w==
X-Received: by 2002:a1c:7714:: with SMTP id t20mr12411840wmi.107.1615549177792;
        Fri, 12 Mar 2021 03:39:37 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id z1sm7412458wru.95.2021.03.12.03.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 03:39:37 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, vkoul@kernel.org
Cc:     robh@kernel.org, devicetree@vger.kernel.org,
        yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 4/5] ASoC: dt-bindings: wsa881x: add bindings for port mapping
Date:   Fri, 12 Mar 2021 11:39:28 +0000
Message-Id: <20210312113929.17512-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210312113929.17512-1-srinivas.kandagatla@linaro.org>
References: <20210312113929.17512-1-srinivas.kandagatla@linaro.org>
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

