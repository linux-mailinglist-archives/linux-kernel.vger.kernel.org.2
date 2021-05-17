Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7FE382C1B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 14:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237042AbhEQMa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 08:30:56 -0400
Received: from mga04.intel.com ([192.55.52.120]:16516 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237012AbhEQMap (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 08:30:45 -0400
IronPort-SDR: qG7d700sUpARSCe8FJJjv9x05IDyVaP1VrKFg0seU9wCfOyykpAm2zsP5x1u+8G5TI6i95v3Zk
 L6y6cDm4P46Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9986"; a="198499870"
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="198499870"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 05:29:29 -0700
IronPort-SDR: CvEQXuRsYSD3VkuaUiPfnJiMvvPtNRK3LbY1TlaLqNHFxVLJb8AzQIQZIBaBXm5Uy5Jlxaqr5l
 rjdtGWa98xGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="393498741"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 17 May 2021 05:29:27 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 50669752; Mon, 17 May 2021 15:29:48 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v4 4/4] devres: Enable trace events
Date:   Mon, 17 May 2021 15:29:46 +0300
Message-Id: <20210517122946.53161-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210517122946.53161-1-andriy.shevchenko@linux.intel.com>
References: <20210517122946.53161-1-andriy.shevchenko@linux.intel.com>
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
v4: rebased on top of v5.13-rc2

 drivers/base/Makefile  |  3 +++
 drivers/base/devres.c  | 47 +++++++++++++++--------------------
 drivers/base/trace.c   | 10 ++++++++
 drivers/base/trace.h   | 56 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/device.h |  9 -------
 5 files changed, 89 insertions(+), 36 deletions(-)
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
index dee48858663f..eaa9a5cd1db9 100644
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
@@ -134,26 +139,13 @@ static void replace_dr(struct device *dev,
 	list_replace(&old->entry, &new->entry);
 }
 
-#ifdef CONFIG_DEBUG_DEVRES
-void * __devres_alloc_node(dr_release_t release, size_t size, gfp_t gfp, int nid,
-		      const char *name)
-{
-	struct devres *dr;
-
-	dr = alloc_dr(release, size, gfp | __GFP_ZERO, nid);
-	if (unlikely(!dr))
-		return NULL;
-	set_node_dbginfo(&dr->node, name, size);
-	return dr->data;
-}
-EXPORT_SYMBOL_GPL(__devres_alloc_node);
-#else
 /**
- * devres_alloc_node - Allocate device resource data
+ * __devres_alloc_node - Allocate device resource data
  * @release: Release function devres will be associated with
  * @size: Allocation size
  * @gfp: Allocation flags
  * @nid: NUMA node
+ * @name: Name of the resource
  *
  * Allocate devres of @size bytes.  The allocated area is zeroed, then
  * associated with @release.  The returned pointer can be passed to
@@ -162,17 +154,18 @@ EXPORT_SYMBOL_GPL(__devres_alloc_node);
  * RETURNS:
  * Pointer to allocated devres on success, NULL on failure.
  */
-void * devres_alloc_node(dr_release_t release, size_t size, gfp_t gfp, int nid)
+void *__devres_alloc_node(dr_release_t release, size_t size, gfp_t gfp, int nid,
+			  const char *name)
 {
 	struct devres *dr;
 
 	dr = alloc_dr(release, size, gfp | __GFP_ZERO, nid);
 	if (unlikely(!dr))
 		return NULL;
+	set_node_dbginfo(&dr->node, name, size);
 	return dr->data;
 }
-EXPORT_SYMBOL_GPL(devres_alloc_node);
-#endif
+EXPORT_SYMBOL_GPL(__devres_alloc_node);
 
 /**
  * devres_for_each_res - Resource iterator
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
diff --git a/include/linux/device.h b/include/linux/device.h
index 38a2071cf776..3769cce77e2c 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -165,21 +165,12 @@ void device_remove_bin_file(struct device *dev,
 typedef void (*dr_release_t)(struct device *dev, void *res);
 typedef int (*dr_match_t)(struct device *dev, void *res, void *match_data);
 
-#ifdef CONFIG_DEBUG_DEVRES
 void *__devres_alloc_node(dr_release_t release, size_t size, gfp_t gfp,
 			  int nid, const char *name) __malloc;
 #define devres_alloc(release, size, gfp) \
 	__devres_alloc_node(release, size, gfp, NUMA_NO_NODE, #release)
 #define devres_alloc_node(release, size, gfp, nid) \
 	__devres_alloc_node(release, size, gfp, nid, #release)
-#else
-void *devres_alloc_node(dr_release_t release, size_t size,
-			gfp_t gfp, int nid) __malloc;
-static inline void *devres_alloc(dr_release_t release, size_t size, gfp_t gfp)
-{
-	return devres_alloc_node(release, size, gfp, NUMA_NO_NODE);
-}
-#endif
 
 void devres_for_each_res(struct device *dev, dr_release_t release,
 			 dr_match_t match, void *match_data,
-- 
2.30.2

