Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D04D2308B49
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 18:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbhA2RRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 12:17:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232323AbhA2RP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 12:15:28 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5BDC0613ED
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 09:14:48 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id 6so9596251wri.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 09:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SzuhsXrzyw/79H75opKAwsU2pvLm/2jprqqwvj/UmC8=;
        b=FFxogIS+jsV3f+xekAAajAfMXnFxPtdYy/H4+dUR3bz1rOIXdli44NkHTujgRcGsWP
         tZxObvgUXUTjWJKSzPAHMPSBJPg+hGr02UBw4hZoalle5+NYMvJ38sWW+NQXRYmy6dhl
         JsFYBC3JAzUjgplgDFAzAZ0P2qPqdlGwXbuMu0c/qdZlXC38XSvwzb2eol2OJzmEm2xx
         1TcC8ENNzdR6txaV4XEyDT1IEl+vnQFg7fzGMFbMWoVPEn1XYck1Otisq7KKUTy9ITk8
         UFHabjWb1LeUJJJVyTxRDiiym/Uxdaq+6hPTcGVaALSqJXPYS/QC/hEFKTHnG9i9qFZN
         V9SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SzuhsXrzyw/79H75opKAwsU2pvLm/2jprqqwvj/UmC8=;
        b=Zg9UrWgZohOXIKyMszP5xD/d09Ihgi1YNmV40pN9xFtoaHg+05B4hCEVGEhp+7Coyj
         hC2q67/emGHkomaMli/r7JWWSgr1qyd2UFtYgdvpx9hnzTwYarcPmfPFCDqxOepwSNxd
         rf1mQBWbPh3xtXH5VVsumXoO1+GII7BtY3qF+lr62AWBZKid6WX68h7eocu0ljsIOjhu
         vJfPzR0EKjdZWhFwYwZjdMuG04buApanrNGHz60DLKFdFl+w7kFppTSbk2lb0k+PHT2T
         EkwZu0v8q37RGXiREECC0pN2gEM0D3YbCyLyrrD21hXJytHHHkqqFSJytkuVzSrNLqwT
         45Xg==
X-Gm-Message-State: AOAM530aFgMZVTCYTGzxTx1qQiFAdiBZKIDxcwWBN1ybrmbQ+ivKYtiu
        KAXr9BMyVRgCfiaRsOTEZBy85A==
X-Google-Smtp-Source: ABdhPJwS7WJOPLsJlz4aEFMO7OFn6esYVTJ9sEaRiaOeBoIsKb3R9mf3EABrti+HTq65Is82doqeaQ==
X-Received: by 2002:a5d:470f:: with SMTP id y15mr5632318wrq.187.1611940486648;
        Fri, 29 Jan 2021 09:14:46 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id n15sm12952487wrx.2.2021.01.29.09.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 09:14:46 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Rob Herring <robh@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 3/5] dt-bindings: nvmem: Add bindings for rmem driver
Date:   Fri, 29 Jan 2021 17:14:28 +0000
Message-Id: <20210129171430.11328-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210129171430.11328-1-srinivas.kandagatla@linaro.org>
References: <20210129171430.11328-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Firmware/co-processors might use reserved memory areas in order to pass
data stemming from an nvmem device otherwise non accessible to Linux.
For example an EEPROM memory only physically accessible to firmware, or
data only accessible early at boot time.

Introduce the dt-bindings to nvmem's rmem.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../devicetree/bindings/nvmem/rmem.yaml       | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/rmem.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/rmem.yaml b/Documentation/devicetree/bindings/nvmem/rmem.yaml
new file mode 100644
index 000000000000..1d85a0a30846
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/rmem.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/rmem.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Reserved Memory Based nvmem Device
+
+maintainers:
+  - Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
+
+allOf:
+  - $ref: "nvmem.yaml#"
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - raspberrypi,bootloader-config
+      - const: nvmem-rmem
+
+  no-map:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Avoid creating a virtual mapping of the region as part of the OS'
+      standard mapping of system memory.
+
+required:
+  - compatible
+  - no-map
+
+unevaluatedProperties: false
+
+examples:
+  - |
+        reserved-memory {
+                #address-cells = <1>;
+                #size-cells = <1>;
+
+                blconfig: nvram@10000000 {
+                        compatible = "raspberrypi,bootloader-config", "nvmem-rmem";
+                        #address-cells = <1>;
+                        #size-cells = <1>;
+                        reg = <0x10000000 0x1000>;
+                        no-map;
+                };
+        };
+
+...
-- 
2.21.0

