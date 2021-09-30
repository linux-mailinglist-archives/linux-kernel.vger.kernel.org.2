Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8EC541E0F5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 20:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353403AbhI3SVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 14:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350651AbhI3SVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 14:21:09 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4D0C06176D
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 11:19:26 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id v17-20020a4ae051000000b002b5a56e3da3so2138433oos.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 11:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I3QEbxt5uEHrOmXC8KCrrnLxWzCqzAmWjkibzCAclE4=;
        b=MXtkO4ZL2hg6pJxEcl6h3nK1ZPFXDIpp3fzznUJXpyc3ZujmcrZh9AxCkxfMYVXJ+c
         wfczBlkCOikmsURoZoCQZpla2ICy8zT4o0AFWkS+SoSyZzbRTkcNDqxgr3ynXI0BZzj1
         ED9YKCwiHYk1xmc6D810dKtLLrGKLDOdn0mB/A6+G24k/QOPkCIpPrxugQX+JfDWM//X
         nKGuQUFjBZOgJ1FweOAidBb/O7jIe1eKODkxTaD+x/CQ4Yf09nHOdHdwjRIuMhhpR8Vn
         egZ0Z3GnVYR9+qJ9DZxDoxYy8XEUBzzzUuzlNychc9Y1328x8++UVKx6lUKwKfMvTzVy
         GogA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I3QEbxt5uEHrOmXC8KCrrnLxWzCqzAmWjkibzCAclE4=;
        b=li+wx4SUAnAPa00SYLxm8G5faasoURAOrs4uyN+fhvTgt0rHliIf1EvQOhBqsHf+Gm
         vj2IVKw+jga0mPJgu4sOmwNvw9izpQSlb63K4DfguPC21D0yv5OD0v+W+/y3YI7Q808u
         xY3OfOKkTwY8gEE62PM1qJejHcyK6/r4dMqIKx8vEa3A5EOlYPFor8Y3w6iyHiJQoFdT
         P8USLJ55fuQRxAJ/F1JvX/AonJNYP4o+ol45xbSgLZJjkEAK+JfpVSyKn400dVa+hfL3
         ez1GdoblWEkj2cL7FIKN7ozl11p2zTfSB6mv0/CVRu68J+WqPvXBhFmj+9GJigfinNkD
         +ocg==
X-Gm-Message-State: AOAM531LIG+BZSu6uB26pigsuJKcDv6Wx/O0Ar00CHLtD/eCSH18jyRR
        xsZwczvOg9W8qeqOpAK1sZ3q9Q==
X-Google-Smtp-Source: ABdhPJyJ0gLxYo5g3S61yQhJ3Qd1BV0yhEyePn5x/zs2PClR9zQgPLraSzO91ZyDUITuSMtDXcWmYg==
X-Received: by 2002:a4a:d9c6:: with SMTP id l6mr6134204oou.0.1633025965420;
        Thu, 30 Sep 2021 11:19:25 -0700 (PDT)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id k6sm727416otf.80.2021.09.30.11.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 11:19:25 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chris Lew <clew@codeaurora.org>,
        Deepak Kumar Singh <deesin@codeaurora.org>
Subject: [PATCH v2 2/4] dt-bindings: soc: smem: Make indirection optional
Date:   Thu, 30 Sep 2021 11:21:09 -0700
Message-Id: <20210930182111.57353-3-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210930182111.57353-1-bjorn.andersson@linaro.org>
References: <20210930182111.57353-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the olden days the Qualcomm shared memory (SMEM) region consisted of
multiple chunks of memory, so SMEM was described as a standalone node
with references to its various memory regions.

But practically all modern Qualcomm platforms has a single reserved memory
region used for SMEM. So rather than having to use two nodes to describe
the one SMEM region, update the binding to allow the reserved-memory
region alone to describe SMEM.

The olden format is preserved as valid, as this is widely used already.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- None

 .../bindings/soc/qcom/qcom,smem.yaml          | 34 ++++++++++++++++---
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,smem.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,smem.yaml
index f7e17713b3d8..4149cf2b66be 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,smem.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,smem.yaml
@@ -10,14 +10,18 @@ maintainers:
   - Andy Gross <agross@kernel.org>
   - Bjorn Andersson <bjorn.andersson@linaro.org>
 
-description: |
-  This binding describes the Qualcomm Shared Memory Manager, used to share data
-  between various subsystems and OSes in Qualcomm platforms.
+description:
+  This binding describes the Qualcomm Shared Memory Manager, a region of
+  reserved-memory used to share data between various subsystems and OSes in
+  Qualcomm platforms.
 
 properties:
   compatible:
     const: qcom,smem
 
+  reg:
+    maxItems: 1
+
   memory-region:
     maxItems: 1
     description: handle to memory reservation for main SMEM memory region.
@@ -29,11 +33,19 @@ properties:
     $ref: /schemas/types.yaml#/definitions/phandle
     description: handle to RPM message memory resource
 
+  no-map: true
+
 required:
   - compatible
-  - memory-region
   - hwlocks
 
+oneOf:
+  - required:
+      - reg
+      - no-map
+  - required:
+      - memory-region
+
 additionalProperties: false
 
 examples:
@@ -43,6 +55,20 @@ examples:
         #size-cells = <1>;
         ranges;
 
+        smem@fa00000 {
+            compatible = "qcom,smem";
+            reg = <0xfa00000 0x200000>;
+            no-map;
+
+            hwlocks = <&tcsr_mutex 3>;
+        };
+    };
+  - |
+    reserved-memory {
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges;
+
         smem_region: smem@fa00000 {
             reg = <0xfa00000 0x200000>;
             no-map;
-- 
2.29.2

