Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1DA388D11
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 13:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351977AbhESLkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 07:40:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47316 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351899AbhESLkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 07:40:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621424366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WmrQjIcCVjIj8nO5clucOj0FIO/GBUt6vzt+TVQx+5E=;
        b=frY++B7tm+NAcA6w8ps7OExun6+LrP+1IMbuVGJqF2EZyZV4PBnzx4V6gjEsczZ5cciS7j
        /F0BT54rfPj8XTPURG8EPJQlLnxiKI0t2ElHCuo75OzviC72sJ1IJX2X3xPvtV6eMMgHex
        gAiWhd1KoJC01eaS6nYppycvaaHUgVU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-537-DABQaQfPNRip5EjMVEKOrg-1; Wed, 19 May 2021 07:39:24 -0400
X-MC-Unique: DABQaQfPNRip5EjMVEKOrg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D53A6D586;
        Wed, 19 May 2021 11:39:21 +0000 (UTC)
Received: from x1.com (ovpn-112-250.rdu2.redhat.com [10.10.112.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D0FAA687E1;
        Wed, 19 May 2021 11:39:14 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
To:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Cc:     Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Kate Carcia <kcarcia@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Gabriele Paoloni <gabriele.paoloni@intel.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>, linux-doc@vger.kernel.org
Subject: [RFC PATCH 13/16] rv/reactors: Add the panic reactor
Date:   Wed, 19 May 2021 13:36:34 +0200
Message-Id: <a5d7735537fce69022448d1ee000774e12170fb3.1621414942.git.bristot@redhat.com>
In-Reply-To: <cover.1621414942.git.bristot@redhat.com>
References: <cover.1621414942.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sample reactor that panics the system when an exception is found. This
is useful both to capture a vmcore, or to fail-safe a critical system.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Gabriele Paoloni <gabriele.paoloni@intel.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
---
 kernel/trace/rv/Kconfig          |  8 ++++++
 kernel/trace/rv/Makefile         |  1 +
 kernel/trace/rv/reactors/panic.c | 44 ++++++++++++++++++++++++++++++++
 3 files changed, 53 insertions(+)
 create mode 100644 kernel/trace/rv/reactors/panic.c

diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index 6cbfb0f9cf76..32de3e7702ec 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -46,4 +46,12 @@ config RV_REACT_PRINTK
 	  Enables the printk reactor. The printk reactor emmits a printk()
 	  message if an exception is found.
 
+config RV_REACT_PANIC
+	tristate "Panic reactor"
+	depends on RV_REACTORS
+	default y if RV_REACTORS
+	help
+	  Enables the panic reactor. The panic reactor emmits a printk()
+	  message if an exception is found and panic()s the system.
+
 endif # RV
diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
index a57cb3c3d410..995f199d0348 100644
--- a/kernel/trace/rv/Makefile
+++ b/kernel/trace/rv/Makefile
@@ -5,3 +5,4 @@ obj-$(CONFIG_RV_MON_WIP) += monitors/wip/wip.o
 obj-$(CONFIG_RV_MON_WWNR) += monitors/wwnr/wwnr.o
 obj-$(CONFIG_RV_REACTORS) += rv_reactors.o
 obj-$(CONFIG_RV_REACT_PRINTK) += reactors/printk.o
+obj-$(CONFIG_RV_REACT_PANIC) += reactors/panic.o
diff --git a/kernel/trace/rv/reactors/panic.c b/kernel/trace/rv/reactors/panic.c
new file mode 100644
index 000000000000..2605d77f8802
--- /dev/null
+++ b/kernel/trace/rv/reactors/panic.c
@@ -0,0 +1,44 @@
+/*
+ * Panic RV reactor:
+ *   Prints the exception msg to the kernel message log and panic().
+ *
+ * Copyright (C) 2019-2021 Daniel Bristot de Oliveira <bristot@redhat.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0
+ */
+
+#include <linux/ftrace.h>
+#include <linux/tracepoint.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/rv.h>
+
+static void rv_panic_reaction(char *msg)
+{
+	panic(msg);
+}
+
+struct rv_reactor rv_panic = {
+	.name = "panic",
+	.description = "panic the system if an exception is found.",
+	.react = rv_panic_reaction
+};
+
+int register_react_panic(void)
+{
+	rv_register_reactor(&rv_panic);
+	return 0;
+}
+
+void unregister_react_panic(void)
+{
+	rv_unregister_reactor(&rv_panic);
+}
+
+module_init(register_react_panic);
+module_exit(unregister_react_panic);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Daniel Bristot de Oliveira");
+MODULE_DESCRIPTION("panic rv reactor: panic if an exception is found");
-- 
2.26.2

