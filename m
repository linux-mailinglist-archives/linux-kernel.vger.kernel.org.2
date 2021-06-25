Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14FF33B3D12
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 09:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbhFYHQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 03:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbhFYHQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 03:16:14 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8504DC061756
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 00:13:54 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id e22so6830377pgv.10
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 00:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r2yTA2YyTTOHjnjnhewFrBRlVB9NzRAU33wz5Tl6BNM=;
        b=OdEef7pIh3zCgbOjoB508alu335Vkb4LaEgxaXjvjJxJbrdJoxPJXkw1qlsYPA+3tT
         8quzHjHhV0+Rt/XRVIZeHEQNv1wPc4XkG6g0/gdsrrs5mX1rdFawUBM/EKEbhS+K6Pc1
         wnQGWit51sPChvhC2fsvUlqRvsGqBoU4GcPwDhRBj9rN9lM812hKb4ORbUPdzL1EgB6r
         dd9Pdt/UTlHaHSWhDPMphnYxS3XmSvINrq03xVqHqeaPaqjJg5qiRkOo8PrkHbMMV2G3
         SuPYLA3lroGNYemybwu6Rwhw9H31TZl6AjjXrME9MxOhDdJrP30smlMGODHEbKXKxl0t
         iojQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r2yTA2YyTTOHjnjnhewFrBRlVB9NzRAU33wz5Tl6BNM=;
        b=Hm3sQtoGm3b7z6fZnq82jbgWEHsKjg7mc3hf5yJumMOEI7kaJ9QwwQ0ihTJntQ90XY
         XQ9IkFvuqfct7TPz+1uXqKqOjx76089E9rMTbEMajIvxdORAGuWAON2udQySkZAAkq4L
         NiHV34pazuX0A/i/yHanIwI8vlUANZh52qAZjiw5jdyKZQwh5vdbNjpjl9Dawc6b7pxQ
         89vzf0saQZTnGbRg5e6SFg+uRuMOJUphWeEvy7xD8PDTOH1KNHdZ+n51SwvB7xP2ZQKl
         vi1Bl27GZnyLQWBVNR6/T7xz+vHhIY3mM7D2URG5XGGrMEJ3RKz7Ykum950NVwvhYyUr
         OtTg==
X-Gm-Message-State: AOAM531QJOdlF2DYhLhb6wBMVifZWGdtVxkEhyITROjg0A9ql+CJnpTb
        Opij1DXMLd/oU+kJgKltTUQAJg==
X-Google-Smtp-Source: ABdhPJwC7NIRnInbJm+Qvh3Vo1RK5WO8HMU6QACBChKeI5zvThCLdYvwW+ePNQoEMJ/rCZiwNmX9Eg==
X-Received: by 2002:aa7:8390:0:b029:305:983b:42ad with SMTP id u16-20020aa783900000b0290305983b42admr9198864pfm.0.1624605234041;
        Fri, 25 Jun 2021 00:13:54 -0700 (PDT)
Received: from localhost.localdomain ([174.127.163.79])
        by smtp.gmail.com with ESMTPSA id i6sm10144961pjg.31.2021.06.25.00.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 00:13:53 -0700 (PDT)
From:   Drew Fustini <drew@beagleboard.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Michael Zhu <michael.zhu@starfivetech.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Fu Wei <tekkamanninja@gmail.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Drew Fustini <drew@beagleboard.org>
Subject: [PATCH v2] dt-bindings: riscv: add starfive jh7100 bindings
Date:   Fri, 25 Jun 2021 00:12:42 -0700
Message-Id: <20210625071240.577796-1-drew@beagleboard.org>
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
v2 changes:
- removed "items:" entry that only had "const: starfive,jh7100"
- correct typo in Description:

Results of running checks:

  $ make -j8 ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- dt_binding_check \
  DT_SCHEMA_FILES=Documentation/devicetree/bindings/riscv/starfive.yaml
  DTEX    Documentation/devicetree/bindings/riscv/starfive.example.dts
  DTC     Documentation/devicetree/bindings/riscv/starfive.example.dt.yaml
  CHECK   Documentation/devicetree/bindings/riscv/starfive.example.dt.yaml

  $ make -j8 ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- dtbs_check \
  DT_SCHEMA_FILES=Documentation/devicetree/bindings/riscv/starfive.yaml
  DTC     arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dt.yaml
  CHECK   arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dt.yaml

The dts file is from vendor repo and is being cleaned up right now in
preperation for submitting to the mailing list:
https://github.com/starfive-tech/linux/tree/beaglev/arch/riscv/boot/dts/starfive

 .../devicetree/bindings/riscv/starfive.yaml   | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/riscv/starfive.yaml

diff --git a/Documentation/devicetree/bindings/riscv/starfive.yaml b/Documentation/devicetree/bindings/riscv/starfive.yaml
new file mode 100644
index 000000000000..68954d0a7108
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
+          - const: beagle,beaglev-starlight-jh7100
+          - const: starfive,jh7100
+
+additionalProperties: true
+
+...
-- 
2.27.0

