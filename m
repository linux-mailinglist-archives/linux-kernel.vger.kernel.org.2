Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25E77337D89
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 20:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbhCKTUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 14:20:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbhCKTUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 14:20:02 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E98C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 11:20:01 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id lr13so48611151ejb.8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 11:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BUYFIrTGJMKusXcgJwvfovMKgwYSZMXx3AEN+yMz7Qk=;
        b=WcnqMPzK+XTGfUGsUjlnD9OQybghAURdqf/frSvwBWLHpGOdMF4XjnpLtz/4ULwJGd
         lOfSQhBYQ94VMDfarRZRt960BHkfKykj9WBR2/RcxdA1mU3cF+Qehe3+fXia7hxwvH4V
         TbrBcdTCIdX1QoiLWTCQGOtKVmYfB64tBpKwd8wcTScwqRZYYJSpB/qBy4osawSGfhoL
         tnmfag7feQ7mLHa0lX7eAplXjEpttNA6oCIf0ynnb4epjSNIBgpU6gfLeVVRi1g8V8ea
         0WdM/+kSdfXRXBWv5C+iK9K8WOflbMRJTIDcQgWrIPa1wPA73o/89k0SlN6vAqKAcX1h
         B0DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BUYFIrTGJMKusXcgJwvfovMKgwYSZMXx3AEN+yMz7Qk=;
        b=Ub9+eYXxGvHRpxEeSmGaS3cGrDSrH/Nkg2Bmg/5k4lJopDF1S8nGMG582H6ZBoR3gN
         vwRW1JUrlMMNBtciKU8xvbuBayTYBhbZyYkLXcTbBAudC3CPuHUFL4ozIDEucb+9qeJ0
         D1+sqe8ZML6GpcaST4xlJvjI+5vy3nsraOlBPMsnHu8x4jcRypbgofaNlD/ougzbaaLk
         EON8JXbzGWyslQdBEYGUqJfJ7BO/UPgOpUbcrt19H2EtdMM1ZJio/8t0PEHDgK+fd3XM
         IDpQxGvS4IAb8W7xeoL/8BeiNjSTS3OSeWdBn/Jci1milY2N9oTo1z6vObXmPxvouTUt
         FSiw==
X-Gm-Message-State: AOAM530sp6QAbvaa6wpYIwcLny0PG/+pdXrLipUJOEkoIAmXwOl6mK1L
        PuZg4RvvZd4HZikEtWrtbjs=
X-Google-Smtp-Source: ABdhPJznKWGxhZhUv9aP47OwDsK9S7A5/tKm/oZ2WFq4Y54/WUpXeMkLgD2rNX303oG22Dx3WwfHaQ==
X-Received: by 2002:a17:906:1386:: with SMTP id f6mr4540790ejc.45.1615490400651;
        Thu, 11 Mar 2021 11:20:00 -0800 (PST)
Received: from localhost.localdomain ([81.18.95.223])
        by smtp.gmail.com with ESMTPSA id u59sm1944143edc.73.2021.03.11.11.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 11:20:00 -0800 (PST)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] ARM: owl: Add Actions Semi Owl S500 SoC machine
Date:   Thu, 11 Mar 2021 21:19:58 +0200
Message-Id: <c560f4c188e39c4100e330ed4bc2d277c5ad6905.1615490186.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add machine entry for the S500 variant of the Actions Semi Owl SoCs
family.

For the moment the only purpose is to provide the system serial
information which will be used by the Owl Ethernet MAC driver to
generate a stable MAC address.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
---
 arch/arm/mach-actions/Makefile  |  1 +
 arch/arm/mach-actions/actions.c | 44 +++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)
 create mode 100644 arch/arm/mach-actions/actions.c

diff --git a/arch/arm/mach-actions/Makefile b/arch/arm/mach-actions/Makefile
index 8eae9587fe82..31865c958d92 100644
--- a/arch/arm/mach-actions/Makefile
+++ b/arch/arm/mach-actions/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
+obj-${CONFIG_ARCH_ACTIONS} += actions.o
 obj-${CONFIG_SMP} += platsmp.o
diff --git a/arch/arm/mach-actions/actions.c b/arch/arm/mach-actions/actions.c
new file mode 100644
index 000000000000..306c6bb178fe
--- /dev/null
+++ b/arch/arm/mach-actions/actions.c
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Actions Semi Owl SoCs
+ *
+ * Copyright (c) 2012 Actions Semi Inc.
+ * Copyright (c) 2021 Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
+ */
+
+#include <linux/highmem.h>
+#include <linux/of_platform.h>
+
+#include <asm/mach/arch.h>
+#include <asm/system_info.h>
+
+#define OWL_S500_SERIAL_LOW_PAGE_OFF		0x800
+#define OWL_S500_SERIAL_HIGH_PAGE_OFF		0x804
+
+static const char *const owl_s500_dt_compat[] __initconst = {
+	"actions,s500",
+	NULL,
+};
+
+static void __init owl_s500_get_system_serial(void)
+{
+	char *vddr = kmap_local_page(pfn_to_page(PFN_DOWN(0)));
+
+	memcpy(&system_serial_low, vddr + OWL_S500_SERIAL_LOW_PAGE_OFF,
+	       sizeof(system_serial_low));
+	memcpy(&system_serial_high, vddr + OWL_S500_SERIAL_HIGH_PAGE_OFF,
+	       sizeof(system_serial_high));
+
+	kunmap_local(vddr);
+}
+
+static void __init owl_s500_init_early(void)
+
+{
+	owl_s500_get_system_serial();
+}
+
+DT_MACHINE_START(ACTIONS, "Actions Semi Owl S500 SoC")
+	.dt_compat	= owl_s500_dt_compat,
+	.init_early	= owl_s500_init_early,
+MACHINE_END
-- 
2.30.2

