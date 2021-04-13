Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D30335DDE2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 13:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244569AbhDMLiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 07:38:17 -0400
Received: from mga06.intel.com ([134.134.136.31]:45394 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238148AbhDMLiL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 07:38:11 -0400
IronPort-SDR: Lsvs5WTbYXNAhKYi1pcFmfuJWD8j+wuerZr9dhPL09XEg67ud0LN61u/IKK5SqI7vmjkj0hp/A
 ltXh5skctJyA==
X-IronPort-AV: E=McAfee;i="6200,9189,9952"; a="255715414"
X-IronPort-AV: E=Sophos;i="5.82,219,1613462400"; 
   d="scan'208";a="255715414"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2021 04:37:48 -0700
IronPort-SDR: WUDXVAjnYm+B1ecFGtpppaNKuzcV2biJo1yIFWrUrFVOFZFEWLIGHEyQZbZIByl6UKbMfHXUqM
 BJUS6XU+Z4ZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,219,1613462400"; 
   d="scan'208";a="420768039"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 13 Apr 2021 04:37:46 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 855B417E; Tue, 13 Apr 2021 14:38:03 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v2 1/1] devres: Enable trace events
Date:   Tue, 13 Apr 2021 14:38:01 +0300
Message-Id: <20210413113801.18245-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some cases the printf() mechanism is too heavy and can't be used.
For example, when debugging a race condition involving devres API.
When CONFIG_DEBUG_DEVRES is enabled I can't reproduce an issue, and
otherwise it's quite visible with a useful information being collected.

Enable trace events for devres part of the driver core.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: fixed compilation error (lkp), elaborate commit message (Greg)
 drivers/base/Makefile |  3 +++
 drivers/base/devres.c | 23 +++++++++++-------
 drivers/base/trace.c  | 10 ++++++++
 drivers/base/trace.h  | 56 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 83 insertions(+), 9 deletions(-)
 create mode 100644 drivers/base/trace.c
 create mode 100644 drivers/base/trace.h

diff --git a/drivers/base/Makefile b/drivers/base/Makefile
index 8b93a7f291ec..ef8e44a7d288 100644
--- a/drivers/base/Makefile
+++ b/drivers/base/Makefile
@@ -30,3 +30,6 @@ obj-y			+= test/
 
 ccflags-$(CONFIG_DEBUG_DRIVER) := -DDEBUG
 
+# define_trace.h needs to know how to find our header
+CFLAGS_trace.o		:= -I$(src)
+obj-$(CONFIG_TRACING)	+= trace.o
diff --git a/drivers/base/devres.c b/drivers/base/devres.c
index db1f3137fc81..a0850bd1eab7 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -14,14 +14,13 @@
 #include <asm/sections.h>
 
 #include "base.h"
+#include "trace.h"
 
 struct devres_node {
 	struct list_head		entry;
 	dr_release_t			release;
-#ifdef CONFIG_DEBUG_DEVRES
 	const char			*name;
 	size_t				size;
-#endif
 };
 
 struct devres {
@@ -43,10 +42,6 @@ struct devres_group {
 	/* -- 8 pointers */
 };
 
-#ifdef CONFIG_DEBUG_DEVRES
-static int log_devres = 0;
-module_param_named(log, log_devres, int, S_IRUGO | S_IWUSR);
-
 static void set_node_dbginfo(struct devres_node *node, const char *name,
 			     size_t size)
 {
@@ -54,7 +49,11 @@ static void set_node_dbginfo(struct devres_node *node, const char *name,
 	node->size = size;
 }
 
-static void devres_log(struct device *dev, struct devres_node *node,
+#ifdef CONFIG_DEBUG_DEVRES
+static int log_devres = 0;
+module_param_named(log, log_devres, int, S_IRUGO | S_IWUSR);
+
+static void devres_dbg(struct device *dev, struct devres_node *node,
 		       const char *op)
 {
 	if (unlikely(log_devres))
@@ -62,10 +61,16 @@ static void devres_log(struct device *dev, struct devres_node *node,
 			op, node, node->name, node->size);
 }
 #else /* CONFIG_DEBUG_DEVRES */
-#define set_node_dbginfo(node, n, s)	do {} while (0)
-#define devres_log(dev, node, op)	do {} while (0)
+#define devres_dbg(dev, node, op)	do {} while (0)
 #endif /* CONFIG_DEBUG_DEVRES */
 
+static void devres_log(struct device *dev, struct devres_node *node,
+		       const char *op)
+{
+	trace_devres_log(dev, op, node, node->name, node->size);
+	devres_dbg(dev, node, op);
+}
+
 /*
  * Release functions for devres group.  These callbacks are used only
  * for identification.
diff --git a/drivers/base/trace.c b/drivers/base/trace.c
new file mode 100644
index 000000000000..b24b0a309c4a
--- /dev/null
+++ b/drivers/base/trace.c
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Device core Trace Support
+ * Copyright (C) 2021, Intel Corporation
+ *
+ * Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
+ */
+
+#define CREATE_TRACE_POINTS
+#include "trace.h"
diff --git a/drivers/base/trace.h b/drivers/base/trace.h
new file mode 100644
index 000000000000..3192e18f877e
--- /dev/null
+++ b/drivers/base/trace.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Device core Trace Support
+ * Copyright (C) 2021, Intel Corporation
+ *
+ * Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
+ */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM dev
+
+#if !defined(__DEV_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
+#define __DEV_TRACE_H
+
+#include <linux/device.h>
+#include <linux/tracepoint.h>
+#include <linux/types.h>
+
+DECLARE_EVENT_CLASS(devres,
+	TP_PROTO(struct device *dev, const char *op, void *node, const char *name, size_t size),
+	TP_ARGS(dev, op, node, name, size),
+	TP_STRUCT__entry(
+		__string(devname, dev_name(dev))
+		__field(struct device *, dev)
+		__field(const char *, op)
+		__field(void *, node)
+		__field(const char *, name)
+		__field(size_t, size)
+	),
+	TP_fast_assign(
+		__assign_str(devname, dev_name(dev));
+		__entry->op = op;
+		__entry->node = node;
+		__entry->name = name;
+		__entry->size = size;
+	),
+	TP_printk("%s %3s %p %s (%zu bytes)", __get_str(devname),
+		  __entry->op, __entry->node, __entry->name, __entry->size)
+);
+
+DEFINE_EVENT(devres, devres_log,
+	TP_PROTO(struct device *dev, const char *op, void *node, const char *name, size_t size),
+	TP_ARGS(dev, op, node, name, size)
+);
+
+#endif /* __DEV_TRACE_H */
+
+/* this part has to be here */
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE trace
+
+#include <trace/define_trace.h>
-- 
2.30.2

