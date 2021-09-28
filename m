Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0A941A6BC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 06:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234377AbhI1Eq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 00:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232873AbhI1Eqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 00:46:53 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213FCC061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 21:45:15 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id a3so28512603oid.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 21:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=94MqB0gQILsi8/WKWtcPzu8DS559IzH+wAM9SzL16fk=;
        b=TMblAA0g17RHsOf3aJeueA3RmAn8jmOUyi0d9rz9rRTkk5+DfqLrOijbmPvuWkNQaW
         zcIsMXhwdfT2JM717r9FxDtowvTXCmm6Oy+UvjCAGrYtjVfDPyftnon68WQqTckm/Ehv
         cySYFRvsjeCmoHnmduSOtL/m737ojFbfpzIPmmvP9v2OqysI3xPyQLM2sTXg7xNnRhyU
         veZ7oOcn5GRF3sTBqWQD6LIPRzn0VBLs2iMEWN/SrjZgAcLnzHZm/cQpAtFwhlSVlwH0
         yJ2Ji/TvccsP37r8Qaky5tGNn06ngjmFQOYQZKzZyTzCT0YB7EoQKd0g30LM34dmzmFV
         XVpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=94MqB0gQILsi8/WKWtcPzu8DS559IzH+wAM9SzL16fk=;
        b=paUQfVnEOM0eSq7vMHEmByD2uvmS83xSsmL/fpLlEkU1oUxgSUmqAQiZ02ZKM3qbam
         4SbYkjlnACidXPRbc/XzTz/mwfzjMtvYMwCf8BsF1iCAN20tmmiAvDzsd8fJQbDtWYDW
         Zm3vHx3D3xP8u+arEthKZC5Lj9L+78RqakKJm9WA7yMl6kQ2qkZsrRFVblATesoRWlgK
         kYEQN9Wj7pIznWidkcP/PhMH3SO81YsTTZUyCpRXq09bRgp2XGrq7thjMzmUxdFW/8vb
         lQycASolrBd0lxmc9RgprcV34S/bMLx5+Vlx9QIobkPbJsafvgLjPVhik2iWxLfMtCd3
         Bb7g==
X-Gm-Message-State: AOAM532Fw59jKmNZ0lwRLq4QiXrPjGOLapBlHBla1bunkTpyyrLfyW5i
        Kuy/MbTrGM/cceycJFkOtg61UgV4OTno/Q==
X-Google-Smtp-Source: ABdhPJxDIRKDnylIaJQj/D+35NbZGygx61MRSo6BWHVerJFiEDgq/HfuU/wqnmiLgX9pCunJzKmmgg==
X-Received: by 2002:a05:6808:1141:: with SMTP id u1mr2135512oiu.123.1632804314458;
        Mon, 27 Sep 2021 21:45:14 -0700 (PDT)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id x29sm2553341oox.18.2021.09.27.21.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 21:45:14 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: soc: smem: Make indirection optional
Date:   Mon, 27 Sep 2021 21:45:44 -0700
Message-Id: <20210928044546.4111223-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
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

