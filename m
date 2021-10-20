Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD979435223
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 19:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbhJTSAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 14:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbhJTSAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 14:00:11 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACFBFC061749
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 10:57:56 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id r7so48662281wrc.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 10:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=RepuXJUEELKyiobJIR91lnWFO15T/GloUqVYiY/VwD8=;
        b=YO50rxD7BRuFgC6p7ZQpT6gqttx2Lzctu4y6MIR+041UCEhyjU77KDREOmgSIODJm/
         +n9rv0iqWnDRkgf0goi5eY19yaoibEVoQ5CV4oXkRTIwCdx70hmbSs4bJszkCEV8i7S0
         pz7z1YiiCUL76YcIq+JvU3ER/l1XMpob5XAuOg3GnI3eGFzoQ30PU9bviiskcxuYnjxI
         2iBkUwtfND6lC6f9yV6kOHKukBrwejMZ287lSu5cs0I/95ReVITXhPIzGNxCpuIjJzcc
         mGgq2SJER8sAk99HDExQ27pWoseoccKqoQwz8OKdOV0O3TDt0cKy/FzZ/03jGr/XkkyV
         HYZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RepuXJUEELKyiobJIR91lnWFO15T/GloUqVYiY/VwD8=;
        b=qPUrlVblqY3u25bNI24ZxqJrFZJ9kCQUnjJZqo497+mYw1jXIgdEeQo1HuYSCr20TW
         8M+qZFrtkQqHWOD4dKjmwYJdVGRnMSLlzI0KGiray9vZusaN3659b23M0OtFWAWPOxKE
         Wr1MplM+Qp34UMtbH5NfvMX1SI3jW3cHVTMz5j8Wd8gD9Ts5a9ShTHerjopbN2DSwrms
         xK1dcnb0xGQdKqk5j7SWC76SQ7YZetmlPFF1v+VUJ/pL7r67b2HwMpIca3MPVXzYz34x
         07bgtJlshTHv8A685AqGDAZ8n5wLTe4oOtljDTpaN/S3HN6KIEabkzS2HJUaS4YVSga1
         DK4A==
X-Gm-Message-State: AOAM5301BN+716cl85iq1Y6pCKhw6fTa88VozNi+uHCJqt854+UY9L6t
        wxNpovWbqpMgLGrDv8n+dSZkZrHnJ3DnDg==
X-Google-Smtp-Source: ABdhPJw0yUpaz/Nhl52S8E7Iu+FHtzj2JtL811eNLwT/O8TEeznni3rrwEwVUDvpuwbKqNBH0k/j+A==
X-Received: by 2002:adf:fe45:: with SMTP id m5mr830887wrs.197.1634752674931;
        Wed, 20 Oct 2021 10:57:54 -0700 (PDT)
Received: from lmecxl0524.home (2a01cb058b850800f8bd7b81c8669456.ipv6.abo.wanadoo.fr. [2a01:cb05:8b85:800:f8bd:7b81:c866:9456])
        by smtp.gmail.com with ESMTPSA id s3sm2609227wrm.40.2021.10.20.10.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 10:57:53 -0700 (PDT)
From:   Etienne Carriere <etienne.carriere@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Etienne Carriere <etienne.carriere@linaro.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v4 1/2] dt-bindings: arm: Add OP-TEE transport for SCMI
Date:   Wed, 20 Oct 2021 19:57:46 +0200
Message-Id: <20211020175747.28449-1-etienne.carriere@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce compatible "linaro,scmi-optee" for SCMI transport channel
based on an OP-TEE service invocation. The compatible mandates a
channel ID defined with property "linaro,optee-channel-id".

Cc: devicetree@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
---
Changes since v3:
 - Add description for linaro,optee-channel-id in patternProperties
   specifying protocol can optionaly define a dedicated channel id.
 - Fix DTS example (duplicated phandles issue, subnodes ordering)
 - Fix typo in DTS example and description comments.

Changes since v2:
 - Define mandatory property linaro,optee-channel-id
 - Rebased on yaml description file

Changes since v1:
 - Removed modification regarding mboxes property description.
---
 .../bindings/firmware/arm,scmi.yaml           | 66 +++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
index 5c4c6782e052..997e5f15c735 100644
--- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
+++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
@@ -38,6 +38,9 @@ properties:
                      The virtio transport only supports a single device.
         items:
           - const: arm,scmi-virtio
+      - description: SCMI compliant firmware with OP-TEE transport
+        items:
+          - const: linaro,scmi-optee
 
   interrupts:
     description:
@@ -83,6 +86,11 @@ properties:
     description:
       SMC id required when using smc or hvc transports
 
+  linaro,optee-channel-id:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Channel specifier required when using OP-TEE transport.
+
   protocol@11:
     type: object
     properties:
@@ -195,6 +203,13 @@ patternProperties:
         minItems: 1
         maxItems: 2
 
+      linaro,optee-channel-id:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          Channel specifier required when using OP-TEE transport and
+          protocol has a dedicated communication channel.
+        maxItems: 1
+
     required:
       - reg
 
@@ -226,6 +241,16 @@ else:
       - arm,smc-id
       - shmem
 
+  else:
+    if:
+      properties:
+        compatible:
+          contains:
+            const: linaro,scmi-optee
+    then:
+      required:
+        - linaro,optee-channel-id
+
 examples:
   - |
     firmware {
@@ -340,7 +365,48 @@ examples:
                 reg = <0x11>;
                 #power-domain-cells = <1>;
             };
+        };
+    };
 
+  - |
+    firmware {
+        scmi {
+            compatible = "linaro,scmi-optee";
+            linaro,optee-channel-id = <0>;
+
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            scmi_dvfs1: protocol@13 {
+                reg = <0x13>;
+                linaro,optee-channel-id = <1>;
+                shmem = <&cpu_optee_lpri0>;
+                #clock-cells = <1>;
+            };
+
+            scmi_clk0: protocol@14 {
+                reg = <0x14>;
+                #clock-cells = <1>;
+            };
+        };
+    };
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        sram@51000000 {
+            compatible = "mmio-sram";
+            reg = <0x0 0x51000000 0x0 0x10000>;
+
+            #address-cells = <1>;
+            #size-cells = <1>;
+            ranges = <0 0x0 0x51000000 0x10000>;
+
+            cpu_optee_lpri0: optee-shm-section@0 {
+                compatible = "arm,scmi-shmem";
+                reg = <0x0 0x80>;
+            };
         };
     };
 
-- 
2.17.1

