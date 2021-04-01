Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 440AE35218C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 23:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234866AbhDAVVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 17:21:25 -0400
Received: from mga04.intel.com ([192.55.52.120]:4650 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233926AbhDAVVV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 17:21:21 -0400
IronPort-SDR: tOijUrDe5POjMlUy2TmoCpk5vOgNeQBEmG7vB3AqgOsxbqnItGe2AXH1PA57oZnSMNqLQXv1sD
 rpasmVZbOpVA==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="190102843"
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="190102843"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 14:21:20 -0700
IronPort-SDR: sQXdprg3X7qjinhzSntC8tcbXQhcEZwAv+GtYDXLwydxFSNt8wrqXlX8aILXFwIHTB3MniuKbh
 P6QtICD2PIZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="377848732"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 01 Apr 2021 14:21:18 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1DB42A1; Fri,  2 Apr 2021 00:21:33 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v1 1/1] driver core: enable trace events (devres)
Date:   Fri,  2 Apr 2021 00:21:29 +0300
Message-Id: <20210401212129.82552-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable trace events for driver core. For now only devres is supported.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/Makefile |  3 +++
 drivers/base/devres.c | 12 ++++++++--
 drivers/base/trace.c  | 10 ++++++++
 drivers/base/trace.h  | 56 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 79 insertions(+), 2 deletions(-)
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
index 8746f2212781..b8af6eddd13b 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -14,6 +14,7 @@
 #include <asm/sections.h>
 
 #include "base.h"
+#include "trace.h"
 
 struct devres_node {
 	struct list_head		entry;
@@ -54,7 +55,7 @@ static void set_node_dbginfo(struct devres_node *node, const char *name,
 	node->size = size;
 }
 
-static void devres_log(struct device *dev, struct devres_node *node,
+static void devres_dbg(struct device *dev, struct devres_node *node,
 		       const char *op)
 {
 	if (unlikely(log_devres))
@@ -63,9 +64,16 @@ static void devres_log(struct device *dev, struct devres_node *node,
 }
 #else /* CONFIG_DEBUG_DEVRES */
 #define set_node_dbginfo(node, n, s)	do {} while (0)
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

