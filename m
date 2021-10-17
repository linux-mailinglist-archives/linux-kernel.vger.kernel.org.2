Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B10AC430B9E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 20:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234071AbhJQTCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 15:02:01 -0400
Received: from ixit.cz ([94.230.151.217]:45746 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231517AbhJQTB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 15:01:59 -0400
Received: from localhost.localdomain (ip-89-176-96-70.net.upcbroadband.cz [89.176.96.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 978FB240AA;
        Sun, 17 Oct 2021 16:18:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1634480316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aOO0KgLZHFaeOh9tgpQWynMEY1a5pIhlAt4YsSaL1ws=;
        b=qQ/pgJsijDhlmgXBSAgyG78CWOIyjP5Pak4D/ws6lJD/ce79QL87nb4n266MPlGLc76Smm
        dPNiieu22jrgZ8HuDlvpdKNkrSTzvowWW1odDOVd+XXqTQWuMBU2V0vyC/4UXNmA0trcpQ
        aXRwp22JiHK9slQVL2YwQN63GZkg64o=
From:   David Heidelberg <david@ixit.cz>
To:     Rob Herring <robh+dt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~okias/devicetree@lists.sr.ht, David Heidelberg <david@ixit.cz>
Subject: [PATCH v3 4/4] dt-bindings: reserved-memory: ramoops: Convert txt bindings to yaml
Date:   Sun, 17 Oct 2021 16:17:00 +0200
Message-Id: <20211017141700.61201-4-david@ixit.cz>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211017141700.61201-1-david@ixit.cz>
References: <20211017141700.61201-1-david@ixit.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert ramoops driver to the YAML syntax.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
v2:
 - inherit reserved-memory properties
 - switch to unevaluatedProperties
v3:
 - add type references
 - enum -> oneOf
 - define maximum for max-reason
 - fixed max-reason node and remove accidentally created param: node
 - example: add root node

 .../bindings/reserved-memory/ramoops.txt      |  66 --------
 .../bindings/reserved-memory/ramoops.yaml     | 145 ++++++++++++++++++
 2 files changed, 145 insertions(+), 66 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/reserved-memory/ramoops.txt
 create mode 100644 Documentation/devicetree/bindings/reserved-memory/ramoops.yaml

diff --git a/Documentation/devicetree/bindings/reserved-memory/ramoops.txt b/Documentation/devicetree/bindings/reserved-memory/ramoops.txt
deleted file mode 100644
index b571ef6dab0f..000000000000
--- a/Documentation/devicetree/bindings/reserved-memory/ramoops.txt
+++ /dev/null
@@ -1,66 +0,0 @@
-Ramoops oops/panic logger
-=========================
-
-ramoops provides persistent RAM storage for oops and panics, so they can be
-recovered after a reboot. This is a child-node of "/reserved-memory", and
-is named "ramoops" after the backend, rather than "pstore" which is the
-subsystem.
-
-Parts of this storage may be set aside for other persistent log buffers, such
-as kernel log messages, or for optional ECC error-correction data.  The total
-size of these optional buffers must fit in the reserved region.
-
-Any remaining space will be used for a circular buffer of oops and panic
-records.  These records have a configurable size, with a size of 0 indicating
-that they should be disabled.
-
-At least one of "record-size", "console-size", "ftrace-size", or "pmsg-size"
-must be set non-zero, but are otherwise optional as listed below.
-
-
-Required properties:
-
-- compatible: must be "ramoops"
-
-- reg: region of memory that is preserved between reboots
-
-
-Optional properties:
-
-- ecc-size: enables ECC support and specifies ECC buffer size in bytes
-  (defaults to 0: no ECC)
-
-- record-size: maximum size in bytes of each kmsg dump.
-  (defaults to 0: disabled)
-
-- console-size: size in bytes of log buffer reserved for kernel messages
-  (defaults to 0: disabled)
-
-- ftrace-size: size in bytes of log buffer reserved for function tracing and
-  profiling (defaults to 0: disabled)
-
-- pmsg-size: size in bytes of log buffer reserved for userspace messages
-  (defaults to 0: disabled)
-
-- mem-type: if present, sets the type of mapping is to be used to map the
-  reserved region. mem-type: 0 = write-combined (default), 1 = unbuffered,
-  2 = cached.
-
-- unbuffered: deprecated, use mem_type instead. If present, and mem_type is
-  not specified, it is equivalent to mem_type = 1 and uses unbuffered mappings
-  to map the reserved region (defaults to buffered mappings mem_type = 0). If
-  both are specified -- "mem_type" overrides "unbuffered".
-
-- max-reason: if present, sets maximum type of kmsg dump reasons to store
-  (defaults to 2: log Oopses and Panics). This can be set to INT_MAX to
-  store all kmsg dumps. See include/linux/kmsg_dump.h KMSG_DUMP_* for other
-  kmsg dump reason values. Setting this to 0 (KMSG_DUMP_UNDEF), means the
-  reason filtering will be controlled by the printk.always_kmsg_dump boot
-  param: if unset, it will be KMSG_DUMP_OOPS, otherwise KMSG_DUMP_MAX.
-
-- no-dump-oops: deprecated, use max_reason instead. If present, and
-  max_reason is not specified, it is equivalent to max_reason = 1
-  (KMSG_DUMP_PANIC).
-
-- flags: if present, pass ramoops behavioral flags (defaults to 0,
-  see include/linux/pstore_ram.h RAMOOPS_FLAG_* for flag values).
diff --git a/Documentation/devicetree/bindings/reserved-memory/ramoops.yaml b/Documentation/devicetree/bindings/reserved-memory/ramoops.yaml
new file mode 100644
index 000000000000..f4c351a69542
--- /dev/null
+++ b/Documentation/devicetree/bindings/reserved-memory/ramoops.yaml
@@ -0,0 +1,145 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/reserved-memory/ramoops.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Ramoops oops/panic logger
+
+description: |
+  ramoops provides persistent RAM storage for oops and panics, so they can be
+  recovered after a reboot. This is a child-node of "/reserved-memory", and
+  is named "ramoops" after the backend, rather than "pstore" which is the
+  subsystem.
+
+  Parts of this storage may be set aside for other persistent log buffers, such
+  as kernel log messages, or for optional ECC error-correction data.  The total
+  size of these optional buffers must fit in the reserved region.
+
+  Any remaining space will be used for a circular buffer of oops and panic
+  records.  These records have a configurable size, with a size of 0 indicating
+  that they should be disabled.
+
+  At least one of "record-size", "console-size", "ftrace-size", or "pmsg-size"
+  must be set non-zero, but are otherwise optional as listed below.
+
+maintainers:
+  - Kees Cook <keescook@chromium.org>
+
+allOf:
+  - $ref: "reserved-memory.yaml"
+
+properties:
+  compatible:
+    const: ramoops
+
+  reg:
+    description: region of memory that is preserved between reboots
+
+  ecc-size:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: enables ECC support and specifies ECC buffer size in bytes
+    default: 0 # no ECC
+
+  record-size:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: maximum size in bytes of each kmsg dump
+    default: 0
+
+  console-size:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: size in bytes of log buffer reserved for kernel messages
+    default: 0
+
+  ftrace-size:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: size in bytes of log buffer reserved for function tracing and profiling
+    default: 0
+
+  pmsg-size:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: size in bytes of log buffer reserved for userspace messages
+    default: 0
+
+  mem-type:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: if present, sets the type of mapping is to be used to map the reserved region.
+    default: 0
+    oneOf:
+      - const: 0
+        description: write-combined
+      - const: 1
+        description: unbuffered
+      - const: 2
+        description: cached
+
+  max-reason:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 2 # log oopses and panics
+    maximum: 0x7fffffff
+    description: |
+      If present, sets maximum type of kmsg dump reasons to store.
+      This can be set to INT_MAX to store all kmsg dumps.
+      See include/linux/kmsg_dump.h KMSG_DUMP_* for other kmsg dump reason values.
+      Setting this to 0 (KMSG_DUMP_UNDEF), means the reason filtering will be
+      controlled by the printk.always_kmsg_dump boot param.
+      If unset, it will be 2 (KMSG_DUMP_OOPS), otherwise 5 (KMSG_DUMP_MAX).
+
+  flags:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 0
+    description: |
+      If present, pass ramoops behavioral flags
+      (see include/linux/pstore_ram.h RAMOOPS_FLAG_* for flag values).
+
+  no-dump-oops:
+    deprecated: true
+    type: boolean
+    description: |
+      Use max_reason instead. If present, and max_reason is not specified,
+      it is equivalent to max_reason = 1 (KMSG_DUMP_PANIC).
+
+  unbuffered:
+    deprecated: true
+    type: boolean
+    description: |
+      Use mem_type instead. If present, and mem_type is not specified,
+      it is equivalent to mem_type = 1 and uses unbuffered mappings to map
+      the reserved region (defaults to buffered mappings mem_type = 0).
+      If both are specified -- "mem_type" overrides "unbuffered".
+
+unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+
+anyOf:
+  - required: [record-size]
+  - required: [console-size]
+  - required: [ftrace-size]
+  - required: [pmsg-size]
+
+examples:
+  - |
+    / {
+        compatible = "foo";
+        model = "foo";
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        reserved-memory {
+            #address-cells = <1>;
+            #size-cells = <1>;
+            ranges;
+
+            ramoops@bfdf0000 {
+                compatible = "ramoops";
+                reg = <0xbfdf0000 0x10000>; /* 64kB */
+                console-size = <0x8000>;    /* 32kB */
+                record-size = <0x400>;      /*  1kB */
+                ecc-size = <16>;
+            };
+        };
+    };
+
-- 
2.33.0

