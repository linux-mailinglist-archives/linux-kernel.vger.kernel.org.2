Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC7323C6A9D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 08:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234014AbhGMGeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 02:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233310AbhGMGeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 02:34:07 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051D4C0613DD
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 23:31:18 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id o3-20020a17090a6783b0290173ce472b8aso791918pjj.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 23:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8q16xM0VATbsQIw9ZAgLMMaiBTBYT226BUgo9tEUHzo=;
        b=NowaPZ61D4lRhQ6XgEQ0JDdMKVSdlWxkprkpq7+bKySeVJQgMqMOsmUYMOLeh1I5Gb
         bdrmP72j2auo1MqavisF/kbi85hK1Y6yfli+BWmFcJ2+LqSvy+4MiVc4NuxzjnR23KcC
         6ngsDBy0qKS0oH2H3D2m+wO+DV7pTFT3paslf3S0Bptb9Trkk5R+GDaUGL9cCXaHg01O
         z6uU1o53B4/xsWuE0/Hlmp3lN5fwbXEXNcM/CdGy1RMWp/oyygL4vluidcsd4TfE5gNO
         TuMyWSMqTH0Jh/m7K6eh4h7vT3w6Lb+2S3v+G5FskgARUbAg9sslGzXnO9pYZhTBuonm
         nXzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8q16xM0VATbsQIw9ZAgLMMaiBTBYT226BUgo9tEUHzo=;
        b=N+WOVrJGTFQVUpcYY3B3iZK5a1+pBWHUN6W8+x98lg2u1nN7OXzuR3GCYUCpoiRWZY
         Ji4GL7+roopJmptwcG2mQUYdGEAeBpwUvFHJ0p0DfG2oyW6rGGwE/swEV32YMvESBmCH
         tSTWzGVPHjXdu/VvyhVuDHATOqsFYjlor0ATtq0UoXXOXNTzigYfq/55MFVY4iaKwpTt
         tTPzOui41rmHppYFqsAix0wv9mMi8ukSnbJGhL3SYVfkQtj+dBlZtUrKgnUDtTSTgG+4
         v/8UjPTPsmbCYATpLbRlBOwaH0LeDiwmH3KVyz5AJqT53lNxkabYhFgSxksaUSC2eAo4
         7GkA==
X-Gm-Message-State: AOAM532Q+ErsslliueMfgggUVWMVMxw88Qm4+mCgQd43ZFtUZDiDSJ7q
        +cKmA0C1MtmXpi2O5H9KTmLoyaf0usSy8A==
X-Google-Smtp-Source: ABdhPJwFUa2Qzo0NvquoV7uUpgYuK7y6PRmeZm5GHfrWJV99CHCkT2bfgPL8nMXgFoUfs+D+qZYBfA==
X-Received: by 2002:a17:90a:b63:: with SMTP id 90mr2836687pjq.58.1626157877430;
        Mon, 12 Jul 2021 23:31:17 -0700 (PDT)
Received: from localhost.localdomain ([174.127.163.79])
        by smtp.gmail.com with ESMTPSA id j13sm19614245pgp.29.2021.07.12.23.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 23:31:16 -0700 (PDT)
From:   Drew Fustini <drew@beagleboard.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Michael Zhu <michael.zhu@starfivetech.com>,
        Wei Fu <tekkamanninja@gmail.com>,
        Jack Zhu <jack.zhu@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Drew Fustini <drew@beagleboard.org>
Subject: [PATCH v4] dt-bindings: riscv: add starfive jh7100 bindings
Date:   Mon, 12 Jul 2021 23:30:18 -0700
Message-Id: <20210713063018.3000459-1-drew@beagleboard.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT binding documentation for the StarFive JH7100 Soc [1] and the
BeagleV Starlight JH7100 board [2].

[1] https://github.com/starfive-tech/beaglev_doc
[2] https://github.com/beagleboard/beaglev-starlight

Signed-off-by: Drew Fustini <drew@beagleboard.org>
---
v4 changes:
- removed JH7100 SoC revision number after discussion with Geert

v3 changes:
- added revision number for the board and soc after question from Palmer

v2 changes:
- removed "items:" entry that only had "const: starfive,jh7100"
- correct typo in Description:

Results of running checks:
  $ make -j8 ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- dt_binding_check \
    DT_SCHEMA_FILES=Documentation/devicetree/bindings/riscv/starfive.yaml
    CHKDT   Documentation/devicetree/bindings/processed-schema-examples.json
    DTEX    Documentation/devicetree/bindings/riscv/starfive.example.dts
    SCHEMA  Documentation/devicetree/bindings/processed-schema-examples.json
    DTC     Documentation/devicetree/bindings/riscv/starfive.example.dt.yaml
    CHECK   Documentation/devicetree/bindings/riscv/starfive.example.dt.yaml
  $ make -j8 ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- dtbs_check \
    DT_SCHEMA_FILES=Documentation/devicetree/bindings/riscv/starfive.yaml
    SYNC    include/config/auto.conf.cmd
    UPD     include/config/kernel.release
    SCHEMA  Documentation/devicetree/bindings/processed-schema.json
    DTC     arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dtb
    DTC     arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dt.yaml
    DTC     arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dt.yaml
    DTC     arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dt.yaml
    CHECK   arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dt.yaml
    CHECK   arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dt.yaml
    CHECK   arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dt.yaml

The dts file is from vendor repo and is being cleaned up right now in
preperation for submitting to the mailing list:
https://github.com/starfive-tech/linux/tree/beaglev/arch/riscv/boot/dts/starfive

 .../devicetree/bindings/riscv/starfive.yaml   | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/riscv/starfive.yaml

diff --git a/Documentation/devicetree/bindings/riscv/starfive.yaml b/Documentation/devicetree/bindings/riscv/starfive.yaml
new file mode 100644
index 000000000000..5b36243fd674
--- /dev/null
+++ b/Documentation/devicetree/bindings/riscv/starfive.yaml
@@ -0,0 +1,27 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/riscv/starfive.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive SoC-based boards
+
+maintainers:
+  - Michael Zhu <michael.zhu@starfivetech.com>
+  - Drew Fustini <drew@beagleboard.org>
+
+description:
+  StarFive SoC-based boards
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - items:
+          - const: beagle,beaglev-starlight-jh7100-r0
+          - const: starfive,jh7100
+
+additionalProperties: true
+
+...
-- 
2.27.0

