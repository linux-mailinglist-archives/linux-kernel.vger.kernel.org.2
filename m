Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 255303E4CE3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 21:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236139AbhHITQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 15:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236051AbhHITQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 15:16:37 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87969C0617B0
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 12:16:13 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id z24so13418230qtn.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 12:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gv+OB+zM5345b30boI1Lb87AMcz6Zm625J86U+m0DDQ=;
        b=u66mof9UZWfzozysTRhTFMa9uWwaPMPgEfMLgNOAo7IkTgPRCA5TW77iQaHcCBhAat
         AEbjRBTLS46wv7WROSGETRDxspeu4zVZY5Ehjd7Ne+/K01BlLWqrvVoBbAociBeOcIuK
         GRsA0F0AcacQm38xfXATCKlu/IQaxs735+fdkRzVQuJOpUC1Xs5x9MYqPKRCHcGesFGm
         6MXrGM7JfT2fTXZtjI4YbPuDwU/tgaxO9tLa3ReOsQuQUjqKxOTgFrBLi3pweFUPpAkX
         7f6TALay4zXZF85OAQbS47wbTNRGlGMVO93HP+RYybUpWTrkMwNnmaogXYYU083Y0uDc
         1Hvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gv+OB+zM5345b30boI1Lb87AMcz6Zm625J86U+m0DDQ=;
        b=NCRIMfmk6N3jMvg45QHlpWh2PFy9lIpYLxcSV8QDzKlbnqGbNchUXNPT1gufiUve9a
         XLpRLn3waAJniJ+qEMWLvEIuj9dm2NLen++2C/O+zDCQOblf7GEmRAi7wXFcALGEyacJ
         VDgrzTRqlO7tKDhC03+lhIbWp/vetp/kEsIjFfWm04LZ3vi5oQRJPLWiMeQ5H02SaVWl
         V6xDRBXoYX1UIDa4m2hREj5kU0gVLwkbz9kJ4ujgvvXkinoFhtVikvAIbG4zV+CRhMz9
         DoIPCDtgwV7FIzuhqYiT1L4CjrkxZi2woBV8T9rW2O9n9Fr/EpyIlyJec3tF7hWUjthp
         KAVw==
X-Gm-Message-State: AOAM5335OvAOqfynMlR5PL4iqzQ+j7LrTqFWttGUHWz5BZEquXiXQYbD
        ZkTDjXjTFF6hSoI3fMNVB4mUqw==
X-Google-Smtp-Source: ABdhPJw5/xxDaedKxpjvJ6yLlI9xIoe/03yr2dJSVYEpzYIHPS8T9azPUbXY6puHqWC3RXKBjJlQFA==
X-Received: by 2002:ac8:5a91:: with SMTP id c17mr9079858qtc.42.1628536572691;
        Mon, 09 Aug 2021 12:16:12 -0700 (PDT)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id n14sm7303398qti.47.2021.08.09.12.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 12:16:12 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        rjw@rjwysocki.net, robh+dt@kernel.org
Cc:     steev@kali.org, tdas@codeaurora.org, mka@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [Patch v5 6/6] dt-bindings: thermal: Add dt binding for QCOM LMh
Date:   Mon,  9 Aug 2021 15:16:04 -0400
Message-Id: <20210809191605.3742979-7-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210809191605.3742979-1-thara.gopinath@linaro.org>
References: <20210809191605.3742979-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt binding documentation to describe Qualcomm
Limits Management Hardware node.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---

v4->v5:
	- Renamed dt binding property qcom,lmh-cpu to cpus as per
	  Rob Herring's review comments.
	- Fixed examples and consolidated to just one example.
	- Other minor fixes as pointed out by Rob Herring.

v3->v4:
	- Changed dt property qcom,lmh-cpu-id to qcom,lmh-cpu and made it
	  a phandle pointing to the cpu node instead of a number as per
	  Rob Herring's review comments.
	- Added suffix -millicelsius to all temperature properties as per
	  Rob Herring's review comments.
	- Dropped unnecessary #includes in the example as pointed out by Bjorn.
	- Other minor fixes.

 .../devicetree/bindings/thermal/qcom-lmh.yaml | 82 +++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/qcom-lmh.yaml

diff --git a/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml b/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml
new file mode 100644
index 000000000000..289e9a845600
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml
@@ -0,0 +1,82 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright 2021 Linaro Ltd.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/qcom-lmh.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Limits Management Hardware(LMh)
+
+maintainers:
+  - Thara Gopinath <thara.gopinath@linaro.org>
+
+description:
+  Limits Management Hardware(LMh) is a hardware infrastructure on some
+  Qualcomm SoCs that can enforce temperature and current limits as
+  programmed by software for certain IPs like CPU.
+
+properties:
+  compatible:
+    enum:
+      - qcom,sdm845-lmh
+
+  reg:
+    items:
+      - description: core registers
+
+  interrupts:
+    maxItems: 1
+
+  '#interrupt-cells':
+    const: 1
+
+  interrupt-controller: true
+
+  cpus:
+    description:
+      phandle of the first cpu in the LMh cluster
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  qcom,lmh-temp-arm-millicelsius:
+    description:
+      An integer expressing temperature threshold at which the LMh thermal
+      FSM is engaged.
+
+  qcom,lmh-temp-low-millicelsius:
+    description:
+      An integer expressing temperature threshold at which the state machine
+      will attempt to remove frequency throttling.
+
+  qcom,lmh-temp-high-millicelsius:
+    description:
+      An integer expressing temperature threshold at which the state machine
+      will attempt to throttle the frequency.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - '#interrupt-cells'
+  - interrupt-controller
+  - cpus
+  - qcom,lmh-temp-arm-millicelsius
+  - qcom,lmh-temp-low-millicelsius
+  - qcom,lmh-temp-high-millicelsius
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    lmh@17d70800 {
+      compatible = "qcom,sdm845-lmh";
+      reg = <0x17d70800 0x400>;
+      interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
+      cpus = <&CPU4>;
+      qcom,lmh-temp-arm-millicelsius = <65000>;
+      qcom,lmh-temp-low-millicelsius = <94500>;
+      qcom,lmh-temp-high-millicelsius = <95000>;
+      interrupt-controller;
+      #interrupt-cells = <1>;
+    };
-- 
2.25.1

