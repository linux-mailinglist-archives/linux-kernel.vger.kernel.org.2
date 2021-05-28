Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE7D393E7B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 10:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236061AbhE1IO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 04:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236029AbhE1IOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 04:14:54 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA72C061574;
        Fri, 28 May 2021 01:13:20 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id t193so1965845pgb.4;
        Fri, 28 May 2021 01:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1JuzSaJeX++ckGWb53wf2z0OIXSlH3HjOOCWZ8LzlB8=;
        b=uYycyqPXkgt61fbVNu81G9i5MhBxFqUmYRGVyeq/03jZutSsobb5tnCIVg19AQMAEW
         ACeh+OmaKpjqqG89Ho8Wtg85/Ujf9W5uJiyadZQKTRXVAH9YosiglbPEMMr2MYaqIncv
         0XDGNfQWGvNQGcVKqFNWpxcSqbqbd3djx9kmDq46UnQSRaQkrWUoGaB6f7py/huBfZzH
         63p2qCM8dYLfEzPpnYaDFPXglp5s0Sx8PRnCwubn3sueRcLnIVU0Zp3mMjOpDQsu3TzM
         lwootisMm/ISGiLEGyIq6G+QbFCqWyAyO2UKGxLYs4fBPECDcL3h5DKAmiRGr8mtmSom
         PpHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1JuzSaJeX++ckGWb53wf2z0OIXSlH3HjOOCWZ8LzlB8=;
        b=hyuAsaVmiLJ/qfQ+1iYc9t5TVClclxRIMs3uKve4xK/Cj/1Ze3OWyIERXh8TRi4fSi
         5T41EfTjdpb/gVrIPBVC49XqqPJ4IMiDiU4wQ8qzpME5JZS3WCnTXO1Fuoob4ti7IcGa
         70VI5zMYEgvuk8bMXSgI8r57/2uCvgjNvb6aOQE0Bbu7jr71vOqohzsnq5HdJVA0foPe
         v4+URS/cUPsAVLlH0X0D1thURUC2vP1ck5fVozEUfeCRtCoIIJbyHjpstnDzSSS+oNR2
         KZst1RFBxfJ7/t0PGzp0RAt1z+4K9GhJJyqn79zYi2RoRaGCH8q+v/51Ryh1Y+ffXwLv
         RSCg==
X-Gm-Message-State: AOAM5335UvMfSb722yECpOnLhSU0q5DW/MMCI9xmP5thBs2PKT4A3OWX
        964guOlshzXhaY79ZBqEPdU=
X-Google-Smtp-Source: ABdhPJz0lmodWUJUQCZwq7sQh1ltf7tdBdNSpySeirHXUURY9IlOJf+kA6KzHgr6aho3E0Zz8C+yZA==
X-Received: by 2002:a05:6a00:1992:b029:2df:b93b:49a with SMTP id d18-20020a056a001992b02902dfb93b049amr2749686pfl.11.1622189599844;
        Fri, 28 May 2021 01:13:19 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:46b:3194:b541:419e:4878:8a93])
        by smtp.gmail.com with ESMTPSA id z18sm3846594pfc.23.2021.05.28.01.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 01:13:19 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     sre@kernel.org, matthias.bgg@gmail.com,
        matti.vaittinen@fi.rohmeurope.com
Cc:     broonie@kernel.org, robh+dt@kernel.org, devicetree@vger.kernel.org,
        inux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org, gene_chen@richtek.com,
        Wilma.Wu@mediatek.com, shufan_lee@richtek.com,
        cy_huang@richtek.com, benjamin.chao@mediatek.com,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 2/3] dt-bindings: power: Add bindings document for Charger support on MT6360 PMIC
Date:   Fri, 28 May 2021 16:12:59 +0800
Message-Id: <20210528081300.64759-3-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210528081300.64759-1-gene.chen.richtek@gmail.com>
References: <20210528081300.64759-1-gene.chen.richtek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gene Chen <gene_chen@richtek.com>

Add bindings document for Charger support on MT6360 PMIC

Signed-off-by: Gene Chen <gene_chen@richtek.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/power/supply/mt6360_charger.yaml | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/mt6360_charger.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/mt6360_charger.yaml b/Documentation/devicetree/bindings/power/supply/mt6360_charger.yaml
new file mode 100644
index 000000000000..b89b15a5bfa4
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/mt6360_charger.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/mt6360_charger.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Battery charger driver for MT6360 PMIC from MediaTek Integrated.
+
+maintainers:
+  - Gene Chen <gene_chen@richtek.com>
+
+description: |
+  This module is part of the MT6360 MFD device.
+  Provides Battery Charger, Boost for OTG devices and BC1.2 detection.
+
+properties:
+  compatible:
+    const: mediatek,mt6360-chg
+
+  richtek,vinovp-microvolt:
+    description: Maximum CHGIN regulation voltage in uV.
+    enum: [ 5500000, 6500000, 11000000, 14500000 ]
+
+
+  usb-otg-vbus-regulator:
+    type: object
+    description: OTG boost regulator.
+    $ref: /schemas/regulator/regulator.yaml#
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    mt6360_charger: charger {
+      compatible = "mediatek,mt6360-chg";
+      richtek,vinovp-microvolt = <14500000>;
+
+      otg_vbus_regulator: usb-otg-vbus-regulator {
+        regulator-compatible = "usb-otg-vbus";
+        regulator-name = "usb-otg-vbus";
+        regulator-min-microvolt = <4425000>;
+        regulator-max-microvolt = <5825000>;
+      };
+    };
+...
-- 
2.25.1

