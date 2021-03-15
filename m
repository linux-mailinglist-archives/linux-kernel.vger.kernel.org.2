Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46E3F33C2B8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 17:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234555AbhCOQ5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 12:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234355AbhCOQ47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 12:56:59 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36885C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 09:56:59 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id l19so8536560wmh.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 09:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dw9cMYL3jtOlJaAZjl852OdyP+MrjSkhGMQF/GJ7398=;
        b=hgOmJNEgjoKRZJFLsQvmXzKGK0x6KpA7ts+E75YZSi7QZn+qZOS507y4wZdiB+K3yg
         qFF1KpqSP0gXwhKwQN8Bcd/gkNIkpaaRM92zi50lqMRsFVUxQTA0BgSZOapRo76i7GOe
         vlF9+LLtakDwOMZdFtlrxrdwoBnGLV3zdCF6TTyth2SEfCJZa6/JpAnHBR0n02NhLbdd
         MIBEXh5gV/lIxkZOdATeu8l2jsaZ0kTAFDaQyZCAF5LHrdvFkHMFo4DcsCNyCc0Dp5n7
         kxlaFq9kX3YOzm2tjYEwdDfzPNKIs/8fYgLJRwUwXM9gyflouEMti7ucdkQrRVRKO1DO
         NTNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dw9cMYL3jtOlJaAZjl852OdyP+MrjSkhGMQF/GJ7398=;
        b=tM7c9ZVK7Mmvre+Dq1qLgv3qs+SoPntsAYFb+8G0Ux1PdsEiswtWw4UXJeP6y31Nia
         gJ96KosU4Isg7QeiW3gyx4FFSplb940hn+a+W3Q02ZI/UMMgoWnFlTCrkCLwJTf0/Va1
         ZoVdmxaDnzY5vvWkRY2qmnc30qENUdPXGXZKIJ/1/fIcUrcVP+xdDqVJP/SQD2V1iw25
         MhhyaJ6+0UPz5PXPW5uWs9DJjofOn+jST53MZceNcrJF2bOsJ3xrNZ1pWRR6rU+FGOCF
         VTywBhQaDBPs1yHyQ15aELUB3NjirJi/wCnd2JYZnA6izp0/J+f+BwRZp98bOiRlJt6G
         pdGQ==
X-Gm-Message-State: AOAM530HkQbvva/dCLfJtAqWqEud077wzy2glx29KDOIOs600+9fiUmF
        2eskAu7okC9GUgRya2lPFGg7hw==
X-Google-Smtp-Source: ABdhPJzMBv0pTbvIZlo/UdYjOAw45gYOiv83AQPqWmAq4/LN3KCPnChY4V557WPxobTeEkMKedyQfQ==
X-Received: by 2002:a1c:e389:: with SMTP id a131mr630946wmh.78.1615827417971;
        Mon, 15 Mar 2021 09:56:57 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id o2sm227656wmc.23.2021.03.15.09.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 09:56:57 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, vkoul@kernel.org
Cc:     robh@kernel.org, devicetree@vger.kernel.org,
        yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v4 4/5] ASoC: dt-bindings: wsa881x: add bindings for port mapping
Date:   Mon, 15 Mar 2021 16:56:49 +0000
Message-Id: <20210315165650.13392-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210315165650.13392-1-srinivas.kandagatla@linaro.org>
References: <20210315165650.13392-1-srinivas.kandagatla@linaro.org>
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

