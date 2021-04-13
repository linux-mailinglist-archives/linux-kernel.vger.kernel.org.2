Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7102535E8EB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 00:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237505AbhDMWNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 18:13:49 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:40893 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbhDMWNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 18:13:47 -0400
Received: by mail-ot1-f44.google.com with SMTP id w31-20020a9d36220000b02901f2cbfc9743so17550525otb.7;
        Tue, 13 Apr 2021 15:13:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ObKLeSKO6Zm9QWJCV869w3D4LCNzoFN7I9J2YYe/dTY=;
        b=jMLLHVsUsyybdiQVhvTIy2RiNC8ks+4wyQWMJCWsm6/krrkzs3U2kae8h/VqB6E8j5
         srBEbA7Ql96IfuB+D3bT0gFnhCEP4DvfaGFsDkHswdL/wfXI+pa0sxe5FbGxg/16Q2UH
         YN4hjuEYLgeKC6dtrIxjIEFMeZLtQD6BsOJW048aZU2uBa9Qpr3JM2OkgykXSsy2HAff
         lx+a1q63/D9y3yikZizlAPDamfehJxpv9Ah7VKDUoIdAvyU4nhgYKn8/S/ScRzYZVu2D
         BZLcKkYLwH01ba/jcbzFnrmYJl79fIx2JgyVVhCnpj+qTfQeA5+nXrdlwoHTlEJhW70v
         G6xw==
X-Gm-Message-State: AOAM533lUzOgAP/2vtsN++nS/MR7+oN2IDDRjdFa4N43o2svh6feBg0m
        OKIGoBHOZqTuzUbmS6t10mkwKEjWXw==
X-Google-Smtp-Source: ABdhPJydY9xjxM1VYJYAn9Zr5/PhEY81wtD6Lzl5gOvvgiHq8tiLqog4Pjrj0uKl6Adq01RPzmLJhg==
X-Received: by 2002:a05:6830:1af4:: with SMTP id c20mr11039833otd.136.1618352006179;
        Tue, 13 Apr 2021 15:13:26 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id u1sm3875456otj.43.2021.04.13.15.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 15:13:25 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] dt-bindings: Add schema for known '/aliases' property names
Date:   Tue, 13 Apr 2021 17:13:24 -0500
Message-Id: <20210413221324.2261097-1-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'/aliases' node property names haven't ever been documented. There's
some names such as 'serial' which are pretty much standard. Then there
are other (mostly) platform specific names which sneak in as a way to
have indices for devices. Let's add a schema so that any new alias names
can be reviewed.

The list of property names consists of common aliases which are widely
used and ones which are used by the kernel, but are marked deprecated.
New users of deprecated names are allowed, but discouraged. There's
still more names which are present in DT files, but not used in the
kernel or u-boot (it's not trivial to check u-boot usage though). These
will generate warnings.

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/aliases.yaml          | 101 ++++++++++++++++++
 1 file changed, 101 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/aliases.yaml

diff --git a/Documentation/devicetree/bindings/aliases.yaml b/Documentation/devicetree/bindings/aliases.yaml
new file mode 100644
index 000000000000..223adbe4a2e9
--- /dev/null
+++ b/Documentation/devicetree/bindings/aliases.yaml
@@ -0,0 +1,101 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/aliases.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: '/aliases' node properties
+
+maintainers:
+  - Rob Herring <robh@kernel.org>
+
+description: |
+  This schema defines the list of known alias names.
+
+properties:
+  $nodename:
+    const: aliases
+
+patternProperties:
+  '^ethernet[0-9]+$': true
+  '^i2c[0-9]+$': true
+  '^mmc[0-9]+$': true
+  '^serial[0-9]+$': true
+  '^spi[0-9]+$': true
+  '^rtc[0-9]+$': true
+  '^watchdog[0-9]+$': true
+  '^usb[0-9]+$': true
+
+  # Deprecated aliases in use. Don't add to this list.
+  '^display[0-9]+$':
+    deprecated: true
+
+  '^dmc[0-9]+$':
+    deprecated: true
+
+  '^fimc[0-9]+$':
+    deprecated: true
+
+  '^fimc-lite[0-9]+$':
+    deprecated: true
+
+  '^fiu[0-9]+$':
+    deprecated: true
+
+  '^gpio[0-9]+$':
+    deprecated: true
+
+  '^gsc[0-9]+$':
+    deprecated: true
+
+  '^hsuart[0-9]+$':
+    deprecated: true
+
+  '^ipu[0-9]+$':
+    deprecated: true
+
+  '^mdio-gpio[0-9]+$':
+    deprecated: true
+
+  '^mshc[0-9]+$':
+    deprecated: true
+
+  '^mu[0-9]+$':
+    deprecated: true
+
+  '^phy[0-9]+$':
+    deprecated: true
+
+  '^pinctrl[0-9]+$':
+    deprecated: true
+
+  '^rproc[0-9]+$':
+    deprecated: true
+
+  '^sai[0-9]+$':
+    deprecated: true
+
+  '^saif[0-9]+$':
+    deprecated: true
+
+  '^ssc[0-9]+$':
+    deprecated: true
+
+  '^stmpe-i2c[0-9]+$':
+    deprecated: true
+
+  '^timer[0-9]+$':
+    deprecated: true
+
+  '^tmuctrl[0-9]+$':
+    deprecated: true
+
+  '^usbdrdphy[0-9]+$':
+    deprecated: true
+
+  '^usbphy[0-9]+$':
+    deprecated: true
+
+additionalProperties: false
+
+...
-- 
2.27.0

