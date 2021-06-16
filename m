Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69F113AA5EC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 23:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233872AbhFPVIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 17:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233836AbhFPVIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 17:08:54 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69D6C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 14:06:46 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id p21so3038705qtw.6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 14:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RzCkdN6tX+XXHrDMHqqK2lwdNxaG8bekFdU3KiKb3g8=;
        b=fEjHUWuUuxhXnKnLWoNLL8+HboKzbXkB6JoS9lUjPwp6gWmzwBeL56hn2Or+BJKYjP
         sCu7V8xb98zpioJiXd6PNWWrIzycWoMvpZaAdUxH8dlcRlqSKiDn8eUpC5vBgKFYmyzd
         bT6wa0WYUdU3JXNcY6o63T7YbD5QXc1iKrbH2HqTY4rKG80rT1SW/0NdBuMeOQyFgaRG
         /UkKfn9TSEdyGMf5AesLE5MazV719VvSqxMP5pKJ9/sbOe2s9wYnWLOD27JDam3nBNiV
         QLOPubykOvl4nZkgmjITZQk4TSFGQu61crI/N9mC3E3XhjAtTIeY3El/L2N8t/dm8l39
         d/Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RzCkdN6tX+XXHrDMHqqK2lwdNxaG8bekFdU3KiKb3g8=;
        b=JnLZLeYQK1ol0IW/dlb9VSzp8S8D3v0Jg2L9l1/sShoghq4knV9KRrgbi/ACYaZYFD
         wTdG1jXP8WnIx60qK2CorthX+PkpSDxl5KUzWXt5Vd4NKePsftIuWoZa5/GaRqgTnW0O
         VuEh2yocouoxIU90yDlJvn2mRvw0nL51ZBH0bI0ZrB1K+LK282+kyT1/VJpYlBqDuYh0
         WVTSAFGC7qFFYsqT11/SEeEQtwm7NyoINQLaGi632TioU18Ds/cMcSukkGwscRAxXOc4
         0ptCEKKFPP6i0bEwaseZT++KPu+9RsiDxQwLETo7HREK/80VI+g0OLbAWkiOTNqdUwHK
         hROw==
X-Gm-Message-State: AOAM532ZDTcUrJS6CyO8Oi0+ByGB4exPDTPttVO+lBAJfPY9QCWMb9HO
        HsVhMHLxSpu0PbIOipTGSZqW5A==
X-Google-Smtp-Source: ABdhPJzLx7sY5g0vFN6W0143lePOO4l12P8xpneWC77bY6jV6jIC13p4/yF3O1aIeaUkW0UI07LxXg==
X-Received: by 2002:ac8:7301:: with SMTP id x1mr1789285qto.56.1623877605948;
        Wed, 16 Jun 2021 14:06:45 -0700 (PDT)
Received: from localhost.localdomain ([172.58.43.164])
        by smtp.gmail.com with ESMTPSA id j7sm348075qkd.21.2021.06.16.14.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 14:06:45 -0700 (PDT)
From:   Drew Fustini <drew@beagleboard.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Michael Zhu <michael.zhu@starfivetech.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Fu Wei <tekkamanninja@gmail.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Drew Fustini <drew@beagleboard.org>
Subject: [PATCH] dt-bindings: riscv: add starfive jh7100 compatibles
Date:   Wed, 16 Jun 2021 13:27:00 -0700
Message-Id: <20210616202654.578870-1-drew@beagleboard.org>
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
Note: my patch to add 'starfive' to vendor-prefixes.yaml was applied by
Rob back on June 2:
https://lore.kernel.org/linux-devicetree/20210602163200.GA3513985@robh.at.kernel.org/

I ran dt_binding_check and dtbs_check: 

  $ make -j8 ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- dt_binding_check \
  DT_SCHEMA_FILES=Documentation/devicetree/bindings/riscv/starfive.yaml 
  CHKDT   Documentation/devicetree/bindings/processed-schema-examples.json
  SCHEMA  Documentation/devicetree/bindings/processed-schema-examples.json
  DTC     Documentation/devicetree/bindings/riscv/starfive.example.dt.yaml
  CHECK   Documentation/devicetree/bindings/riscv/starfive.example.dt.yaml

  $ make -j8 ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- dtbs_check \
  DT_SCHEMA_FILES=Documentation/devicetree/bindings/riscv/starfive.yaml
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
  DTC     arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dt.yaml
  CHECK   arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dt.yaml

The files jh7100.dtsi and jh7100-beaglev-starlight.dts are in the
process of being cleaned up for submission. The current downstream is:
https://github.com/starfive-tech/linux/tree/beaglev/arch/riscv/boot/dts/starfive

 .../devicetree/bindings/riscv/starfive.yaml   | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/riscv/starfive.yaml

diff --git a/Documentation/devicetree/bindings/riscv/starfive.yaml b/Documentation/devicetree/bindings/riscv/starfive.yaml
new file mode 100644
index 000000000000..4deae9f5c60d
--- /dev/null
+++ b/Documentation/devicetree/bindings/riscv/starfive.yaml
@@ -0,0 +1,30 @@
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
+  SiFive SoC-based boards
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - items:
+          - const: beagle,beaglev-starlight-jh7100
+          - const: starfive,jh7100
+
+      - items:
+          - const: starfive,jh7100
+
+additionalProperties: true
+
+...
-- 
2.27.0

