Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE9A37FADE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 17:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234954AbhEMPh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 11:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234921AbhEMPh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 11:37:28 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F3AC061761
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 08:36:17 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id gx5so40438721ejb.11
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 08:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snejp.pl; s=gmail;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=RckDkE4qxGZvjN5zfkyL3EzM+dPcbREpj6loS+q+SAE=;
        b=Z1bjBN1rPw1kra+FSpbyjHXyc/0KOwdODLr6/25TeA63e6qPQRiBsIcjGYjuI9AGKO
         QhH+Hu+0DFv9H5gPzunFiRj9W/u9yie/W2h5WbfYoug7FUip8MTzI27vMTGgUvutGORe
         KSheWdpGjrVbODw/a9Llf8RmCLWrc6ZF22TRUpeALRmD9351hZMe/TJjZ9EivmIEVGUL
         fTxoc/A7sRoGhuzChAb8BgkbZs2KeEvZf/hvL5Y9dWLQSiV6hltgEL+VX9Tyt/keM8pC
         cXofJK5Ytoce6gw3qbw7l1x7jEfUyb9PUGgDainNHb1T0GnSLJ1McLDdERv3QBG2B1AN
         LEKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RckDkE4qxGZvjN5zfkyL3EzM+dPcbREpj6loS+q+SAE=;
        b=GhdSl9wMsJT3sqaydrZizFoVfKrBHOJXjtcpjJxFlAvV802JVtz+ZTSmetX+dZNxJC
         DUJfYko6paeqHEFjsYkUFXBPa4hG/IjHoladNVa3ojm/aGspD0BkNwDPz4NJPvEORS47
         0rc9+XMhnK9WnNymUh6l+tYmMvtczmYYqAvzUEDSZ/rN50oCaG1E5PPOidgxNHnT+v+D
         NOFKJm6yAHXLwZsmDJ9eGX9dYPjk+GgPA9Hxa6MhjDtgwjTo2RNRNkU5WZ9XvVwMXM+n
         raQ9iml2G927PjOJYIN1WQFt5VuLRiOH6D9vmOx1HCSXuOUMVdaU1+sOIlEv+BMmk00p
         2EFA==
X-Gm-Message-State: AOAM532bYCQkwJBLhJADIHKHlMS2HzAKDRZSf87ukKYO3ZlRj/e8pOh4
        xSOI4772pQIYaGmUE7rndjOE/w==
X-Google-Smtp-Source: ABdhPJyKtgSTJRy3WlO2USF9K2vb/hRxtEk/WS3n7MnW/wxd6N5U3N3Iska23ccWXSgspmzDb3lKhg==
X-Received: by 2002:a17:906:b191:: with SMTP id w17mr44527233ejy.200.1620920176435;
        Thu, 13 May 2021 08:36:16 -0700 (PDT)
Received: from PackardBell (192038133011.mbb.telenor.dk. [192.38.133.11])
        by smtp.googlemail.com with ESMTPSA id gb26sm2217950ejc.25.2021.05.13.08.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 08:36:16 -0700 (PDT)
Received: from localhost (PackardBell [local])
        by PackardBell (OpenSMTPD) with ESMTPA id fb9dc804;
        Thu, 13 May 2021 15:35:48 +0000 (UTC)
From:   Bartosz Dudziak <bartosz.dudziak@snejp.pl>
To:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        David Sterba <dsterba@suse.com>, Jens Axboe <axboe@kernel.dk>,
        Bartosz Dudziak <bartosz.dudziak@snejp.pl>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/2] dt-bindings: arm: Document qcom,cpss-acc
Date:   Thu, 13 May 2021 17:34:41 +0200
Message-Id: <20210513153442.52941-2-bartosz.dudziak@snejp.pl>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210513153442.52941-1-bartosz.dudziak@snejp.pl>
References: <20210513153442.52941-1-bartosz.dudziak@snejp.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CPSS ACC binding describes the clock, reset, and power domain
controller for a Cortex-A7 CPU.

Signed-off-by: Bartosz Dudziak <bartosz.dudziak@snejp.pl>
---
 .../devicetree/bindings/arm/cpus.yaml         |  7 ++--
 .../bindings/arm/msm/qcom,cpss-acc.yaml       | 41 +++++++++++++++++++
 2 files changed, 45 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,cpss-acc.yaml

diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
index 26b886b20b..f391e15184 100644
--- a/Documentation/devicetree/bindings/arm/cpus.yaml
+++ b/Documentation/devicetree/bindings/arm/cpus.yaml
@@ -204,6 +204,7 @@ properties:
           - marvell,mmp3-smp
           - mediatek,mt6589-smp
           - mediatek,mt81xx-tz-smp
+          - qcom,cpss-acc
           - qcom,gcc-msm8660
           - qcom,kpss-acc-v1
           - qcom,kpss-acc-v2
@@ -276,7 +277,7 @@ properties:
       Specifies the SAW* node associated with this CPU.
 
       Required for systems that have an "enable-method" property
-      value of "qcom,kpss-acc-v1" or "qcom,kpss-acc-v2"
+      value of "qcom,kpss-acc-v1", "qcom,kpss-acc-v2" or "qcom,cpss-acc"
 
       * arm/msm/qcom,saw2.txt
 
@@ -286,9 +287,9 @@ properties:
       Specifies the ACC* node associated with this CPU.
 
       Required for systems that have an "enable-method" property
-      value of "qcom,kpss-acc-v1" or "qcom,kpss-acc-v2"
+      value of "qcom,kpss-acc-v1", "qcom,kpss-acc-v2" or "qcom,cpss-acc"
 
-      * arm/msm/qcom,kpss-acc.txt
+      * arm/msm/qcom,kpss-acc.txt or arm/msm/qcom,cpss-acc.yaml
 
   rockchip,pmu:
     $ref: '/schemas/types.yaml#/definitions/phandle'
diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,cpss-acc.yaml b/Documentation/devicetree/bindings/arm/msm/qcom,cpss-acc.yaml
new file mode 100644
index 0000000000..54efbc5e3d
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/msm/qcom,cpss-acc.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/msm/qcom,cpss-acc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cortex-A7 Processor Sub-system (CPSS) Application Clock Controller (ACC)
+
+maintainers:
+  - Kumar Gala <galak@codeaurora.org>
+
+description: |
+  The CPSS ACC provides clock, power domain, and reset control to a Cortex-A7
+  processor. There is one ACC register region per CPU within the PSS remapped
+  region as well as an alias register region that remaps accesses to the ACC
+  associated with the CPU accessing the region.
+
+properties:
+  compatible:
+    enum:
+      - qcom,cpss-acc
+
+  reg:
+    minItems: 1
+    maxItems: 2
+    items:
+      - description: ACC base register region
+      - description: optional ACC alias register region
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    clock-controller@f9088000 {
+      compatible = "qcom,cpss-acc";
+      reg = <0xf9088000 0x1000>, <0xf9008000 0x1000>;
+    };
-- 
2.25.1

