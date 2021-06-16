Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49A273A97B7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 12:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbhFPKjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 06:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232433AbhFPKjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 06:39:24 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F705C06124A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 03:37:13 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id h4so3503733lfu.8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 03:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Umz7aYzmYhwqEEP8hnC/zZgdzJV3Msj9S6v5a9aoDDg=;
        b=VwI8KJq4r2miZYI4zo45kPqtcT9PQcZDZi7EgbrJ/dLYSxlekJGyMM3Oti5eB4RYqm
         ZHkdL8OBpSXPl+meGhQlfIMnqqcHTC7yVre4XK0+jTOmwGE/KtfDIgl7kl62+7B4whGc
         Gozv6cVsNkCcosBjkQinf1GZ6gacq4m5oZMs0IWWETLe1TonQXVhWz5yyAHMfW3hfmvD
         mEBFhdd6wX5G+dpX66LrSBBCjLIn+NxD8bmZB4zYM8YZd1n5rXzg+fbgOKRuTh2HehVz
         GnBbVrUoOm04x49Zk3S+rFgnps7nAsgsnzlXkCAcEBwRzSQsdEIJA9BIDfERUhaqiNMp
         J+EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Umz7aYzmYhwqEEP8hnC/zZgdzJV3Msj9S6v5a9aoDDg=;
        b=U6N6TjCzr51iD42aZ6xOE3zmWNiEZrDHY/mdtX0HXCP4ZJ3AdQHK2fy1TdpadFc9Tb
         KwNR4Io2Fkk/P2pIvqJCm9KfZliEWU0K45ym3Z979Ow+Mm9j8c+KhG90e0Ir2Uz6u6nV
         0RnxcZmGefLMr46gVHJYY/aaEKtRgij1BjdN76/dL02xLGZxhmpGNst4C0LpiwUlWu30
         LmGY9fTgD4YLuUBcXm5Uy0f1yJMDsrdbwDNlmWoN6qdWOjLhYTgNbirF3DDK0WWojA5X
         rKRU0M/AUVJNi42yyo9ceRuouf6JsfgtNrW0JD4X7LXTP+yCaZJ+cIdEUC9+aSWJFG4Y
         tIKg==
X-Gm-Message-State: AOAM531eCQtxjI51cuAE+fHXsoxpnMCAFiUQ7bnIgqzfuhZTSeHkGySR
        rULaEvdpyuGD4S2ynjqiLFyyhgE6m5SFbQ==
X-Google-Smtp-Source: ABdhPJwusF0Hwl0KFVC3f7/9aSUBQG2V+qpIxjgLKtQ37eXDUOU8OQTd23w0a+s/4F+jqEb90knm+g==
X-Received: by 2002:a05:6512:344e:: with SMTP id j14mr3261852lfr.468.1623839831236;
        Wed, 16 Jun 2021 03:37:11 -0700 (PDT)
Received: from jade.urgonet (h-79-136-85-3.A175.priv.bahnhof.se. [79.136.85.3])
        by smtp.gmail.com with ESMTPSA id m17sm205621lfh.288.2021.06.16.03.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 03:37:11 -0700 (PDT)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     Jerome Forissier <jerome@forissier.org>,
        Etienne Carriere <etienne.carriere@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v2 2/7] dt-bindings: arm: Convert optee binding to json-schema
Date:   Wed, 16 Jun 2021 12:36:44 +0200
Message-Id: <20210616103649.2662395-3-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210616103649.2662395-1-jens.wiklander@linaro.org>
References: <20210616103649.2662395-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Converts the optee binding to use DT schema format.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 .../bindings/arm/firmware/linaro,optee-tz.txt | 31 ------------
 .../arm/firmware/linaro,optee-tz.yaml         | 49 +++++++++++++++++++
 2 files changed, 49 insertions(+), 31 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.txt
 create mode 100644 Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml

diff --git a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.txt b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.txt
deleted file mode 100644
index d38834c67dff..000000000000
--- a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.txt
+++ /dev/null
@@ -1,31 +0,0 @@
-OP-TEE Device Tree Bindings
-
-OP-TEE is a piece of software using hardware features to provide a Trusted
-Execution Environment. The security can be provided with ARM TrustZone, but
-also by virtualization or a separate chip.
-
-We're using "linaro" as the first part of the compatible property for
-the reference implementation maintained by Linaro.
-
-* OP-TEE based on ARM TrustZone required properties:
-
-- compatible     : should contain "linaro,optee-tz"
-
-- method         : The method of calling the OP-TEE Trusted OS. Permitted
-                   values are:
-
-                   "smc" : SMC #0, with the register assignments specified
-		           in drivers/tee/optee/optee_smc.h
-
-                   "hvc" : HVC #0, with the register assignments specified
-		           in drivers/tee/optee/optee_smc.h
-
-
-
-Example:
-	firmware {
-		optee {
-			compatible = "linaro,optee-tz";
-			method = "smc";
-		};
-	};
diff --git a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
new file mode 100644
index 000000000000..c931b030057f
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/firmware/linaro,optee-tz.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: OP-TEE Device Tree Bindings
+
+maintainers:
+  - Jens Wiklander <jens.wiklander@linaro.org>
+
+description: |
+  OP-TEE is a piece of software using hardware features to provide a Trusted
+  Execution Environment. The security can be provided with ARM TrustZone, but
+  also by virtualization or a separate chip.
+
+properties:
+  $nodename:
+    const: optee
+  compatible:
+      oneOf:
+        - description:
+            We're using "linaro" as the first part of the compatible property
+            for the reference implementation maintained by Linaro.
+          const: linaro,optee-tz
+
+  method:
+    description: The method of calling the OP-TEE Trusted OS.
+    $ref: /schemas/types.yaml#/definitions/string-array
+    oneOf:
+      - description: |
+          SMC #0, with the register assignments specified in
+          in drivers/tee/optee/optee_smc.h
+        const: smc
+      - description: |
+          HVC #0, with the register assignments specified in
+          in drivers/tee/optee/optee_smc.h
+        const: hvc
+
+additionalProperties: false
+
+examples:
+  - |
+    firmware {
+      optee {
+        compatible = "linaro,optee-tz";
+        method = "smc";
+      };
+    };
-- 
2.31.1

