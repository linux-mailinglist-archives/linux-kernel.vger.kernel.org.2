Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 221C734E997
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 15:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbhC3NtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 09:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232164AbhC3Ns2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 09:48:28 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1AE7C061574;
        Tue, 30 Mar 2021 06:48:27 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id kt15so24899525ejb.12;
        Tue, 30 Mar 2021 06:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w25PhXv4L2UP3EkQ/RJPv5NSRmzp3Ufth6dz1A/da6E=;
        b=nmPmxCBmxi1ZkwFiHkJRo6oxkOn+0PVXMIbVGqFqGWUWAPEO5dO/ZXl8sT4oqQZdx4
         jeOmUmmFZyjV/GEJ+fvbW11LPsYDETOg/CIcJqOPGJQOyvklU0i8amlUQ23D0Sk0Yyfy
         C17vnD6pWUPCXeY7KMiDnsQLaxjN40pBXVwgESFgzfakGGJiGFaSWcw9EaxHM5vPzgzX
         tBYVGxuOJJYaaNrARzGzo3X3XsDcAyqBQbd8F6e4nL7F8u5aR56YMTcF8mleacVSdSiA
         gi7WVX9kBaT5q2vDwFDisjBB9PM/AoovwRaeDVGQ65DcgfJg/NwZTMW+Cw15ugz8jUCA
         JeOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w25PhXv4L2UP3EkQ/RJPv5NSRmzp3Ufth6dz1A/da6E=;
        b=qo3sbPie3hCsbyCEST1fijvUe3UetJEa7sUzly5XyDG51CnYxAeoCN4Usk8KJeABlx
         x53W0t2uJiFNknOkqft13S3ZSrz14McqtGT2GCvQZJx8IuFEdQH/QRT6/V1aEBEKC3s7
         i4nvkRi8ajjp35uDU+rQrxg5KmgvLWFwcY4ZFkP/Gl84jWHfsOnqlMyB/JMPBSThTqeI
         4uXv8OckdShufukCc2cE/GFcU3Srt+O7f0bmduyw8c9aWbs1ahlXFgRkOWqdRUrWWjVc
         Pko9mqt43tcTvEVE6ESFg1xbKKXBgVSgIcN14xMDCkHZvwj/ck08/OCXryEaLjrtUrw8
         dsQg==
X-Gm-Message-State: AOAM533T82jqF5KURmGNHTzTvUBpWDhx6q2Q2M2vego+7ommhadurCp6
        1P56nVXQ+SnILrRifVIHZorDrY5QPus=
X-Google-Smtp-Source: ABdhPJw/5pn1OWDyKa4Ye2Ri5EqfXdTOc2h8tqF/UYNJmcMZ/hcvRdVm0QT5D1qJZcNQ/PckqwALBg==
X-Received: by 2002:a17:906:fcb2:: with SMTP id qw18mr32290739ejb.434.1617112106712;
        Tue, 30 Mar 2021 06:48:26 -0700 (PDT)
Received: from localhost.localdomain ([188.24.140.160])
        by smtp.gmail.com with ESMTPSA id l12sm11114681edb.39.2021.03.30.06.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 06:48:26 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/6] dt-bindings: soc: actions: Add Actions Semi Owl socinfo binding
Date:   Tue, 30 Mar 2021 16:48:17 +0300
Message-Id: <15da0257b10aa62bfb7046437915d05a614c01ee.1617110420.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1617110420.git.cristian.ciocaltea@gmail.com>
References: <cover.1617110420.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding for the Actions Semi Owl socinfo driver.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
---
 .../bindings/soc/actions/owl-socinfo.yaml     | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/actions/owl-socinfo.yaml

diff --git a/Documentation/devicetree/bindings/soc/actions/owl-socinfo.yaml b/Documentation/devicetree/bindings/soc/actions/owl-socinfo.yaml
new file mode 100644
index 000000000000..01e4a8b4f5ac
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/actions/owl-socinfo.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/actions/owl-socinfo.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Actions Semi Owl SoC info module
+
+maintainers:
+  - Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
+
+description: |
+  Actions Semi Owl SoC info module provides access to various information
+  about the S500, S700 and S900 SoC variants, such as serial number or id.
+
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - actions,s500-soc
+          - actions,s700-soc
+          - actions,s900-soc
+  required:
+    - compatible
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - actions,s500-soc
+          - actions,s700-soc
+          - actions,s900-soc
+      - const: simple-bus
+
+required:
+  - compatible
+
+additionalProperties: true
+
+examples:
+  - |
+    / {
+        compatible = "roseapplepi,roseapplepi", "actions,s500";
+        model = "Roseapple Pi";
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        soc {
+            compatible = "actions,s500-soc", "simple-bus";
+            #address-cells = <1>;
+            #size-cells = <1>;
+            ranges;
+        };
+    };
+
+...
-- 
2.31.1

