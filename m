Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEBC739BA34
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 15:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbhFDNu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 09:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbhFDNuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 09:50:25 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF1CC061768;
        Fri,  4 Jun 2021 06:48:22 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id t4-20020a1c77040000b029019d22d84ebdso7946723wmi.3;
        Fri, 04 Jun 2021 06:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3A9nKUhXlAsdzVYpKKxMoJNv7x9Ic1OvtPp5GTZtTZs=;
        b=mrOIzFFmzNq7FMb0jxVLbPxGs4E7IrQQmzeOpxE81vnXEd1ijt96WrZ2szBs0GXUJz
         pkpsH7lOmgcuHf9z2Eo9UBnjpRT7Lg6eQIpGyXxbcM+Itc3pPppYAorrCe6ComhBf0sb
         ogMEZrEvO7K8BbRV1qz0u9E4+Ub82EffMH+Hp3v3nKYF+psifucZwkQNDNvgMCbDcKKH
         Jf6N0nyCqC6ZOq/8UTHK6bR9JNSZs5HrkORCe/2BsOl5y+CbdIKrqGQvQwIePn77pYQd
         JJhcUqg056mn8FbISNpc2ufeUixalc/TC2ZZ/LGpP/89GpeB9UbhKzh3fY23frkd+3c5
         5Ubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3A9nKUhXlAsdzVYpKKxMoJNv7x9Ic1OvtPp5GTZtTZs=;
        b=KZOOaGW067jbheUVsSDLOJfoJzqNYDODlnrhDDURK68qLttziVVlkKJhJBAan7oeU1
         DFhrYCZYKNtnAa/kgXAjvTJxRGlDwyfXgutT/0FkshVfmN4CU6SEZm/jfFki7EpHPxq9
         4mSwRsZ3XQa1YgCioXLFthQsCWLJlUmHAy9gSRmpEMT3P2pmwyK40TH8B+SHi1eKZfSO
         K/Fuo/JF7FxHrbZeBqSH6BVoAvkQhAL6nqCkyE+afWoq/saAQtnLh4UnJl7m0kaC3/OM
         GYm7zWw8lIlM9nVD3NVPuHg/qJ+rC9jpUnOW2hFRUsIRY8YP36o0poO6eLZHyFV/4Zij
         XcHQ==
X-Gm-Message-State: AOAM533aUGhRS+SVx1CIqG+A5RHiyHJ3LuVrWapy2kakxpO+u3BlWYBY
        JXEDWrBUrOZRWyb7t0I5lns=
X-Google-Smtp-Source: ABdhPJz0KF6jEq9va9+BKn/LaYpliICcPlL5KovstNd5GzbAb5ZBdzIjkYVOjPrbsgzeaVBC2NYt5A==
X-Received: by 2002:a1c:bad6:: with SMTP id k205mr3904228wmf.171.1622814501257;
        Fri, 04 Jun 2021 06:48:21 -0700 (PDT)
Received: from xws.localdomain (pd9e5aba0.dip0.t-ipconnect.de. [217.229.171.160])
        by smtp.gmail.com with ESMTPSA id u16sm7403167wru.56.2021.06.04.06.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 06:48:20 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/7] platform/surface: aggregator: Update copyright
Date:   Fri,  4 Jun 2021 15:47:51 +0200
Message-Id: <20210604134755.535590-4-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210604134755.535590-1-luzmaximilian@gmail.com>
References: <20210604134755.535590-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's 2021, update the copyright accordingly.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---

Changes in v2:
 - None

---
 drivers/platform/surface/aggregator/Kconfig             | 2 +-
 drivers/platform/surface/aggregator/Makefile            | 2 +-
 drivers/platform/surface/aggregator/bus.c               | 2 +-
 drivers/platform/surface/aggregator/bus.h               | 2 +-
 drivers/platform/surface/aggregator/controller.c        | 2 +-
 drivers/platform/surface/aggregator/controller.h        | 2 +-
 drivers/platform/surface/aggregator/core.c              | 2 +-
 drivers/platform/surface/aggregator/ssh_msgb.h          | 2 +-
 drivers/platform/surface/aggregator/ssh_packet_layer.c  | 2 +-
 drivers/platform/surface/aggregator/ssh_packet_layer.h  | 2 +-
 drivers/platform/surface/aggregator/ssh_parser.c        | 2 +-
 drivers/platform/surface/aggregator/ssh_parser.h        | 2 +-
 drivers/platform/surface/aggregator/ssh_request_layer.c | 2 +-
 drivers/platform/surface/aggregator/ssh_request_layer.h | 2 +-
 drivers/platform/surface/aggregator/trace.h             | 2 +-
 include/linux/surface_aggregator/controller.h           | 2 +-
 include/linux/surface_aggregator/device.h               | 2 +-
 include/linux/surface_aggregator/serial_hub.h           | 2 +-
 18 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/platform/surface/aggregator/Kconfig b/drivers/platform/surface/aggregator/Kconfig
index 3aaeea9f0433..fd6dc452f3e8 100644
--- a/drivers/platform/surface/aggregator/Kconfig
+++ b/drivers/platform/surface/aggregator/Kconfig
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0+
-# Copyright (C) 2019-2020 Maximilian Luz <luzmaximilian@gmail.com>
+# Copyright (C) 2019-2021 Maximilian Luz <luzmaximilian@gmail.com>
 
 menuconfig SURFACE_AGGREGATOR
 	tristate "Microsoft Surface System Aggregator Module Subsystem and Drivers"
diff --git a/drivers/platform/surface/aggregator/Makefile b/drivers/platform/surface/aggregator/Makefile
index c112e2c7112b..c8498c41e758 100644
--- a/drivers/platform/surface/aggregator/Makefile
+++ b/drivers/platform/surface/aggregator/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0+
-# Copyright (C) 2019-2020 Maximilian Luz <luzmaximilian@gmail.com>
+# Copyright (C) 2019-2021 Maximilian Luz <luzmaximilian@gmail.com>
 
 # For include/trace/define_trace.h to include trace.h
 CFLAGS_core.o = -I$(src)
diff --git a/drivers/platform/surface/aggregator/bus.c b/drivers/platform/surface/aggregator/bus.c
index a9b660af0917..0169677c243e 100644
--- a/drivers/platform/surface/aggregator/bus.c
+++ b/drivers/platform/surface/aggregator/bus.c
@@ -2,7 +2,7 @@
 /*
  * Surface System Aggregator Module bus and device integration.
  *
- * Copyright (C) 2019-2020 Maximilian Luz <luzmaximilian@gmail.com>
+ * Copyright (C) 2019-2021 Maximilian Luz <luzmaximilian@gmail.com>
  */
 
 #include <linux/device.h>
diff --git a/drivers/platform/surface/aggregator/bus.h b/drivers/platform/surface/aggregator/bus.h
index 7712baaed6a5..ed032c2cbdb2 100644
--- a/drivers/platform/surface/aggregator/bus.h
+++ b/drivers/platform/surface/aggregator/bus.h
@@ -2,7 +2,7 @@
 /*
  * Surface System Aggregator Module bus and device integration.
  *
- * Copyright (C) 2019-2020 Maximilian Luz <luzmaximilian@gmail.com>
+ * Copyright (C) 2019-2021 Maximilian Luz <luzmaximilian@gmail.com>
  */
 
 #ifndef _SURFACE_AGGREGATOR_BUS_H
diff --git a/drivers/platform/surface/aggregator/controller.c b/drivers/platform/surface/aggregator/controller.c
index c673aa8309c8..14cd7b31ccc1 100644
--- a/drivers/platform/surface/aggregator/controller.c
+++ b/drivers/platform/surface/aggregator/controller.c
@@ -2,7 +2,7 @@
 /*
  * Main SSAM/SSH controller structure and functionality.
  *
- * Copyright (C) 2019-2020 Maximilian Luz <luzmaximilian@gmail.com>
+ * Copyright (C) 2019-2021 Maximilian Luz <luzmaximilian@gmail.com>
  */
 
 #include <linux/acpi.h>
diff --git a/drivers/platform/surface/aggregator/controller.h b/drivers/platform/surface/aggregator/controller.h
index 8297d34e7489..a0963c3562ff 100644
--- a/drivers/platform/surface/aggregator/controller.h
+++ b/drivers/platform/surface/aggregator/controller.h
@@ -2,7 +2,7 @@
 /*
  * Main SSAM/SSH controller structure and functionality.
  *
- * Copyright (C) 2019-2020 Maximilian Luz <luzmaximilian@gmail.com>
+ * Copyright (C) 2019-2021 Maximilian Luz <luzmaximilian@gmail.com>
  */
 
 #ifndef _SURFACE_AGGREGATOR_CONTROLLER_H
diff --git a/drivers/platform/surface/aggregator/core.c b/drivers/platform/surface/aggregator/core.c
index 8dc2c267bcd6..5d780e55f4a1 100644
--- a/drivers/platform/surface/aggregator/core.c
+++ b/drivers/platform/surface/aggregator/core.c
@@ -7,7 +7,7 @@
  * Handles communication via requests as well as enabling, disabling, and
  * relaying of events.
  *
- * Copyright (C) 2019-2020 Maximilian Luz <luzmaximilian@gmail.com>
+ * Copyright (C) 2019-2021 Maximilian Luz <luzmaximilian@gmail.com>
  */
 
 #include <linux/acpi.h>
diff --git a/drivers/platform/surface/aggregator/ssh_msgb.h b/drivers/platform/surface/aggregator/ssh_msgb.h
index 1221f642dda1..e562958ffdf0 100644
--- a/drivers/platform/surface/aggregator/ssh_msgb.h
+++ b/drivers/platform/surface/aggregator/ssh_msgb.h
@@ -2,7 +2,7 @@
 /*
  * SSH message builder functions.
  *
- * Copyright (C) 2019-2020 Maximilian Luz <luzmaximilian@gmail.com>
+ * Copyright (C) 2019-2021 Maximilian Luz <luzmaximilian@gmail.com>
  */
 
 #ifndef _SURFACE_AGGREGATOR_SSH_MSGB_H
diff --git a/drivers/platform/surface/aggregator/ssh_packet_layer.c b/drivers/platform/surface/aggregator/ssh_packet_layer.c
index 15d96eac6811..5e08049fc3ac 100644
--- a/drivers/platform/surface/aggregator/ssh_packet_layer.c
+++ b/drivers/platform/surface/aggregator/ssh_packet_layer.c
@@ -2,7 +2,7 @@
 /*
  * SSH packet transport layer.
  *
- * Copyright (C) 2019-2020 Maximilian Luz <luzmaximilian@gmail.com>
+ * Copyright (C) 2019-2021 Maximilian Luz <luzmaximilian@gmail.com>
  */
 
 #include <asm/unaligned.h>
diff --git a/drivers/platform/surface/aggregator/ssh_packet_layer.h b/drivers/platform/surface/aggregator/ssh_packet_layer.h
index e8757d03f279..2eb329f0b91a 100644
--- a/drivers/platform/surface/aggregator/ssh_packet_layer.h
+++ b/drivers/platform/surface/aggregator/ssh_packet_layer.h
@@ -2,7 +2,7 @@
 /*
  * SSH packet transport layer.
  *
- * Copyright (C) 2019-2020 Maximilian Luz <luzmaximilian@gmail.com>
+ * Copyright (C) 2019-2021 Maximilian Luz <luzmaximilian@gmail.com>
  */
 
 #ifndef _SURFACE_AGGREGATOR_SSH_PACKET_LAYER_H
diff --git a/drivers/platform/surface/aggregator/ssh_parser.c b/drivers/platform/surface/aggregator/ssh_parser.c
index e2dead8de94a..b77912f8f13b 100644
--- a/drivers/platform/surface/aggregator/ssh_parser.c
+++ b/drivers/platform/surface/aggregator/ssh_parser.c
@@ -2,7 +2,7 @@
 /*
  * SSH message parser.
  *
- * Copyright (C) 2019-2020 Maximilian Luz <luzmaximilian@gmail.com>
+ * Copyright (C) 2019-2021 Maximilian Luz <luzmaximilian@gmail.com>
  */
 
 #include <asm/unaligned.h>
diff --git a/drivers/platform/surface/aggregator/ssh_parser.h b/drivers/platform/surface/aggregator/ssh_parser.h
index 63c38d350988..3bd6e180fd16 100644
--- a/drivers/platform/surface/aggregator/ssh_parser.h
+++ b/drivers/platform/surface/aggregator/ssh_parser.h
@@ -2,7 +2,7 @@
 /*
  * SSH message parser.
  *
- * Copyright (C) 2019-2020 Maximilian Luz <luzmaximilian@gmail.com>
+ * Copyright (C) 2019-2021 Maximilian Luz <luzmaximilian@gmail.com>
  */
 
 #ifndef _SURFACE_AGGREGATOR_SSH_PARSER_H
diff --git a/drivers/platform/surface/aggregator/ssh_request_layer.c b/drivers/platform/surface/aggregator/ssh_request_layer.c
index 52a83a8fcf82..bfe1aaf38065 100644
--- a/drivers/platform/surface/aggregator/ssh_request_layer.c
+++ b/drivers/platform/surface/aggregator/ssh_request_layer.c
@@ -2,7 +2,7 @@
 /*
  * SSH request transport layer.
  *
- * Copyright (C) 2019-2020 Maximilian Luz <luzmaximilian@gmail.com>
+ * Copyright (C) 2019-2021 Maximilian Luz <luzmaximilian@gmail.com>
  */
 
 #include <asm/unaligned.h>
diff --git a/drivers/platform/surface/aggregator/ssh_request_layer.h b/drivers/platform/surface/aggregator/ssh_request_layer.h
index cb35815858d1..9c3cbae2d4bd 100644
--- a/drivers/platform/surface/aggregator/ssh_request_layer.h
+++ b/drivers/platform/surface/aggregator/ssh_request_layer.h
@@ -2,7 +2,7 @@
 /*
  * SSH request transport layer.
  *
- * Copyright (C) 2019-2020 Maximilian Luz <luzmaximilian@gmail.com>
+ * Copyright (C) 2019-2021 Maximilian Luz <luzmaximilian@gmail.com>
  */
 
 #ifndef _SURFACE_AGGREGATOR_SSH_REQUEST_LAYER_H
diff --git a/drivers/platform/surface/aggregator/trace.h b/drivers/platform/surface/aggregator/trace.h
index eb332bb53ae4..de64cf169060 100644
--- a/drivers/platform/surface/aggregator/trace.h
+++ b/drivers/platform/surface/aggregator/trace.h
@@ -2,7 +2,7 @@
 /*
  * Trace points for SSAM/SSH.
  *
- * Copyright (C) 2020 Maximilian Luz <luzmaximilian@gmail.com>
+ * Copyright (C) 2020-2021 Maximilian Luz <luzmaximilian@gmail.com>
  */
 
 #undef TRACE_SYSTEM
diff --git a/include/linux/surface_aggregator/controller.h b/include/linux/surface_aggregator/controller.h
index 7965bdc669c5..068e1982ad37 100644
--- a/include/linux/surface_aggregator/controller.h
+++ b/include/linux/surface_aggregator/controller.h
@@ -6,7 +6,7 @@
  * managing access and communication to and from the SSAM EC, as well as main
  * communication structures and definitions.
  *
- * Copyright (C) 2019-2020 Maximilian Luz <luzmaximilian@gmail.com>
+ * Copyright (C) 2019-2021 Maximilian Luz <luzmaximilian@gmail.com>
  */
 
 #ifndef _LINUX_SURFACE_AGGREGATOR_CONTROLLER_H
diff --git a/include/linux/surface_aggregator/device.h b/include/linux/surface_aggregator/device.h
index 6ff9c58b3e17..f636c5310321 100644
--- a/include/linux/surface_aggregator/device.h
+++ b/include/linux/surface_aggregator/device.h
@@ -7,7 +7,7 @@
  * Provides support for non-platform/non-ACPI SSAM clients via dedicated
  * subsystem.
  *
- * Copyright (C) 2019-2020 Maximilian Luz <luzmaximilian@gmail.com>
+ * Copyright (C) 2019-2021 Maximilian Luz <luzmaximilian@gmail.com>
  */
 
 #ifndef _LINUX_SURFACE_AGGREGATOR_DEVICE_H
diff --git a/include/linux/surface_aggregator/serial_hub.h b/include/linux/surface_aggregator/serial_hub.h
index 64276fbfa1d5..c3de43edcffa 100644
--- a/include/linux/surface_aggregator/serial_hub.h
+++ b/include/linux/surface_aggregator/serial_hub.h
@@ -6,7 +6,7 @@
  * Surface System Aggregator Module (SSAM). Provides the interface for basic
  * packet- and request-based communication with the SSAM EC via SSH.
  *
- * Copyright (C) 2019-2020 Maximilian Luz <luzmaximilian@gmail.com>
+ * Copyright (C) 2019-2021 Maximilian Luz <luzmaximilian@gmail.com>
  */
 
 #ifndef _LINUX_SURFACE_AGGREGATOR_SERIAL_HUB_H
-- 
2.31.1

