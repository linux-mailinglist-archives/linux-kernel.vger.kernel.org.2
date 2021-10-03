Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C778742037D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 20:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbhJCSyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 14:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbhJCSx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 14:53:59 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C57AC0613EC
        for <linux-kernel@vger.kernel.org>; Sun,  3 Oct 2021 11:52:12 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id n71so17869008iod.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Oct 2021 11:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dPbmPba/1JOH50dr2W7TP7ERKQ4tO7Im69cG4fYB8G4=;
        b=GbXTiWqzPfkjAuL0flIMhj94MRFoRo/T7W1k983RhkbqsKXqUqJA+RhbMrMKvzd7oK
         GlNpzR7ByjbEBVN5mMlGv0KoKbD1aYjpGk5r3yT5BOIQJx6V/ILsS8LorBSaF1dM164I
         QlwKKAkGi8nVDSldc1G7IjjAQN/sKgAJtaARg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dPbmPba/1JOH50dr2W7TP7ERKQ4tO7Im69cG4fYB8G4=;
        b=XUfwsfPvaQYG4QjVpHogkJcCcGfzZst7bbHjyXUOvNnPAcnkGhLLPxbTHg4wYQZZe4
         vjr0uKhfP4ElTu5gbTMS1LvDiosaomUTQRKMwmelNr5PCDfr1VeYYk3A9NtU/Fr0WtE4
         LLLD0LlDHvqDLlImIbLJPwbj0hjgiNUPu7Z9CKs6RjFAQmqEIKS3riAZvhFfoniIvTdV
         rSOTrIMvuDHFVY5EwQpHpSo8KIK2bajadS+yrQi5B7CQ3GiwLVlXRkF0tV5ED33HxB3A
         e1NsO54paxyTVKS/WWqsh2dmVTVwoGPUkRAB3xIbc/o1m+odTXZNm634gzq1v/FLdGvS
         rkjg==
X-Gm-Message-State: AOAM530T0MIsv0ZjWG3l40Xwn2F+lbG8260Qg+ReTkyPHRgGTfOSMeV5
        kHynXYkIu4HtWcO9tpgqdMTRLw==
X-Google-Smtp-Source: ABdhPJxP00cR30On5t+nCWKs6QtqxwLJYJXnmhZi/kyP49waZioGIdjCdk6yQhhYU9JFoEDB+itIvA==
X-Received: by 2002:a6b:6b08:: with SMTP id g8mr6522146ioc.199.1633287131505;
        Sun, 03 Oct 2021 11:52:11 -0700 (PDT)
Received: from kiwi.bld.corp.google.com (c-67-190-101-114.hsd1.co.comcast.net. [67.190.101.114])
        by smtp.gmail.com with ESMTPSA id j17sm7713795ile.20.2021.10.03.11.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 11:52:11 -0700 (PDT)
From:   Simon Glass <sjg@chromium.org>
To:     devicetree@vger.kernel.org
Cc:     Tom Rini <trini@konsulko.com>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Simon Glass <sjg@chromium.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: u-boot: Add an initial binding for config
Date:   Sun,  3 Oct 2021 12:51:53 -0600
Message-Id: <20211003125134.2.I7733f5a849476e908cc51f0c71b8a594337fbbdf@changeid>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U-Boot makes use of the devicetree for its driver model. Devices are bound
based on the hardware description in the devicetree.

Since U-Boot is not an operating system, it has no command line or user
space to provide configuration and policy information. This must be made
available in some other way.

Therefore U-Boot uses devicetree for configuration and run-time control
and has done for approximately 9 years. This works extremely well in the
project and is very flexible. However the bindings have never been
incorporated in the devicetree bindings in the Linux tree. This could be
a good time to start this work as we try to create standard bindings for
communicating between firmware components.

Add an initial binding for this node, covering just the config node, which
is the main requirement. It is similar in concept to the chosen node, but
used for passing information between firmware components, instead of from
firmware to operating system.

Signed-off-by: Simon Glass <sjg@chromium.org>
---
Please be kind in your review. Some words about why this is needed are
included in the description in config.yaml file.

The last attempt to add just one property needed by U-Boot went into the
weeds 6 years ago, with what I see as confusion about the role of the
chosen node in devicetree[1].

I am trying again in the hope of reaching resolution rather than just
going around in circles with the 'devicetree is a hardware description'
argument :-)

Quoting from the introduction to latest devicetree spec[2]:

>>>
To initialize and boot a computer system, various software components
interact. Firmware might perform low-level initialization of the system
hardware before passing control to software such as an operating system,
bootloader, or  hypervisor. Bootloaders and hypervisors can, in turn,
load and transfer control to operating systems. Standard, consistent
interfaces and conventions facilitate the interactions between these
software components. In this document the term boot program is used to
generically refer to a software component that initializes the system
state and executes another software component referred to as a client
program.
<<<

This clearly envisages multiple software components in the firmware
domain and in fact that is the case today. They need some way to
communicate configuration data such as memory setup, runtime-feature
selection and developer conveniences. Devicetree seems ideal, at least for
components where the performance / memory requirements of devicetree are
affordable.

I hope that the Linux community (which owns the devicetree bindings) finds
this initiative valuable and acceptable.

[1] https://lists.denx.de/pipermail/u-boot/2015-July/218585.html
[2] https://github.com/devicetree-org/devicetree-specification/releases/tag/v0.3

 .../devicetree/bindings/u-boot/config.yaml    | 137 ++++++++++++++++++
 1 file changed, 137 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/u-boot/config.yaml

diff --git a/Documentation/devicetree/bindings/u-boot/config.yaml b/Documentation/devicetree/bindings/u-boot/config.yaml
new file mode 100644
index 00000000000000..336577a17fdf5a
--- /dev/null
+++ b/Documentation/devicetree/bindings/u-boot/config.yaml
@@ -0,0 +1,137 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/u-boot/config.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: U-Boot configuration node
+
+maintainers:
+  - Simon Glass <sjg@chromium.org>
+
+description: |
+  The config node does not represent a real device, but serves as a place
+  for passing data between firmware elements, like memory maps. Data in the
+  config node does not represent the hardware. It is ignored by operating
+  systems.
+
+  Purpose of config node
+  ----------------------
+
+  A common problem with firmware is that many builds are needed to deal with the
+  slight variations between different, related models. For example, one model
+  may have a TPM and another may not. Devicetree provides an excellent solution
+  to this problem, in that the devicetree to actually use on a platform can be
+  injected in the factory based on which model is being manufactured at the time.
+
+  A related problem causing build proliferation is dealing with the differences
+  between development firmware, developer-friendly firmware (e.g. with all
+  security features present but with the ability to access the command line),
+  test firmware (which runs tests used in the factory), final production
+  firmware (before signing), signed firmware (where the signatures have been
+  inserted) and the like. Ideally all or most of these should use the same
+  U-Boot build, with just some options to determine the features available. For
+  example, being able to control whether the UART console or JTAG are available,
+  on any image, is a great debugging aid.
+
+  When the firmware consists of multiple parts (various U-Boot phases, TF-A,
+  OP-TEE), it is helpful that all operate the same way at runtime, regardless of
+  how they were built. This can be achieved by passing the runtime configuration
+  (e.g. 'enable UART console', 'here are your public keys') along the chain
+  through each firmware stage. It is frustrating to have to replicate a bug on
+  production firmware which does happen on developer firmware, because they are
+  completely different builds.
+
+  The config node provides useful functionality for this. It allows the different
+  controls to be 'factored out' of the U-Boot binary, so they can be controlled
+  separately from the initial source-code build. The node can be easily updated
+  by a build or factory tool and can control various features in U-Boot. It is
+  similar in concept to a Kconfig option, except that it can be changed after
+  U-Boot is built.
+
+  The config node is similar in concept to /chosen (see chosen.txt) except that
+  it is for passing information *into* and *between) firmware components,
+  instead of from firmware to the Operating System. Also, while operating
+  systems typically have a (sometimes extremely long) command line, U-Boot does
+  not support this, except with sandbox. The devicetree provides a more
+  structured approach in any case.
+
+properties:
+
+  compatible:
+    enum:
+      - "u-boot,config"
+
+  bootcmd:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: |
+      Allows overwriting of the boot command used by U-Boot on startup. If
+      present, U-Boot uses this command instead. Note that this feature can
+      work even if loading the environment is disabled, e.g. for security
+      reasons. See also bootsecure.
+
+  bootdelay:
+    $ref: /schemas/types.yaml#/definitions/int32
+    description: |
+      Allows selecting of the U-Boot bootdelay, to control whether U-Boot
+      waits on boot or for how long. This allows this option to be configured
+      by the build system or by a previous-stage binary. For example, if the
+      images is being packed for testing or a user holds down a button, it may
+      allow a delay, but disable it for production.
+
+      If this property is not present, a default value is used instead.
+
+      Values:
+
+      -1: no bootdelay and the user cannot interrupt boot
+      0: no bootdelay but use user can still interrupt boot by holding down a
+        key, if enabled
+      >= 1: delay for this many seconds
+
+
+  bootsecure:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Controls the execution of the boot command in U-Boot, e.g. selecting
+      between using a special function to run commands, or the normal CLI. This
+      can be used in production images, to restrict the amount of parsing done
+      or the options available, to cut back on the available surface for
+      security attacks.
+
+      Values:
+
+      0: normal boot using CLI (default if not present)
+      1: use secure boot mechanism instead to parse and run commands
+        other values are reserved for future use
+      2: use simplified command line (e.g. avoid hush)
+      3... reserved
+
+  silent-console:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      This allows the console to be silenced by default on boot. This can allow
+      easy disabling of console output on a production build, for example. When
+      suppressed, the console is still active. This feature only suppresses the
+      console output itself, on all output devices.
+
+      Values:
+
+      0: console output appears as normal (default)
+      1: console output is suppressed but console recording still operates (if
+        enabled)
+      2: console output is suppressed and not recorded
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    u-boot,config {
+      compatible = "u-boot,config";
+      bootcmd = "vboot go auto";
+      bootdelay = <(-1)>;
+      bootsecure = <1>;
+      silent-console = <1>;
+    };
-- 
2.33.0.800.g4c38ced690-goog

