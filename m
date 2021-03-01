Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1BE3281DC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 16:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236918AbhCAPJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 10:09:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236844AbhCAPIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 10:08:05 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C51CC06178A
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 07:07:24 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lGk8j-00AJOK-MX; Mon, 01 Mar 2021 16:07:17 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-um@lists.infradead.org
Cc:     Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 2/8] lib: add iomem emulation (logic_iomem)
Date:   Mon,  1 Mar 2021 16:07:02 +0100
Message-Id: <20210301160501.39f783537872.I01b0589b5b625d4fb3bdc31b84dd4d4cedca399a@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210301150708.244970-1-johannes@sipsolutions.net>
References: <20210301150708.244970-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Add IO memory emulation that uses callbacks for read/write to
the allocated regions. The callbacks can be registered by the
users using logic_iomem_alloc().

To use, an architecture must 'select LOGIC_IOMEM' in Kconfig
and then include <asm-generic/logic_io.h> into asm/io.h to get
the __raw_read*/__raw_write* functions.

Optionally, an architecture may 'select LOGIC_IOMEM_FALLBACK'
in which case non-emulated regions will 'fall back' to the
various real_* functions that must then be provided.

Cc: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/asm-generic/logic_io.h |  78 ++++++++
 include/linux/logic_iomem.h    |  62 +++++++
 lib/Kconfig                    |  14 ++
 lib/Makefile                   |   2 +
 lib/logic_iomem.c              | 318 +++++++++++++++++++++++++++++++++
 5 files changed, 474 insertions(+)
 create mode 100644 include/asm-generic/logic_io.h
 create mode 100644 include/linux/logic_iomem.h
 create mode 100644 lib/logic_iomem.c

diff --git a/include/asm-generic/logic_io.h b/include/asm-generic/logic_io.h
new file mode 100644
index 000000000000..a53116b8c57e
--- /dev/null
+++ b/include/asm-generic/logic_io.h
@@ -0,0 +1,78 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2021 Intel Corporation
+ * Author: johannes@sipsolutions.net
+ */
+#ifndef _LOGIC_IO_H
+#define _LOGIC_IO_H
+#include <linux/types.h>
+
+/* include this file into asm/io.h */
+
+#ifdef CONFIG_INDIRECT_IOMEM
+
+#ifdef CONFIG_INDIRECT_IOMEM_FALLBACK
+/*
+ * If you want emulated IO memory to fall back to 'normal' IO memory
+ * if a region wasn't registered as emulated, then you need to have
+ * all of the real_* functions implemented.
+ */
+#if !defined(real_ioremap) || !defined(real_iounmap) || \
+    !defined(real_raw_readb) || !defined(real_raw_writeb) || \
+    !defined(real_raw_readw) || !defined(real_raw_writew) || \
+    !defined(real_raw_readl) || !defined(real_raw_writel) || \
+    (defined(CONFIG_64BIT) && \
+     (!defined(real_raw_readq) || !defined(real_raw_writeq))) || \
+    !defined(real_memset_io) || \
+    !defined(real_memcpy_fromio) || \
+    !defined(real_memcpy_toio)
+#error "Must provide fallbacks for real IO memory access"
+#endif /* defined ... */
+#endif /* CONFIG_INDIRECT_IOMEM_FALLBACK */
+
+#define ioremap ioremap
+void __iomem *ioremap(phys_addr_t offset, size_t size);
+
+#define iounmap iounmap
+void iounmap(void __iomem *addr);
+
+#define __raw_readb __raw_readb
+u8 __raw_readb(const volatile void __iomem *addr);
+
+#define __raw_readw __raw_readw
+u16 __raw_readw(const volatile void __iomem *addr);
+
+#define __raw_readl __raw_readl
+u32 __raw_readl(const volatile void __iomem *addr);
+
+#ifdef CONFIG_64BIT
+#define __raw_readq __raw_readq
+u64 __raw_readq(const volatile void __iomem *addr);
+#endif /* CONFIG_64BIT */
+
+#define __raw_writeb __raw_writeb
+void __raw_writeb(u8 value, volatile void __iomem *addr);
+
+#define __raw_writew __raw_writew
+void __raw_writew(u16 value, volatile void __iomem *addr);
+
+#define __raw_writel __raw_writel
+void __raw_writel(u32 value, volatile void __iomem *addr);
+
+#ifdef CONFIG_64BIT
+#define __raw_writeq __raw_writeq
+void __raw_writeq(u64 value, volatile void __iomem *addr);
+#endif /* CONFIG_64BIT */
+
+#define memset_io memset_io
+void memset_io(volatile void __iomem *addr, int value, size_t size);
+
+#define memcpy_fromio memcpy_fromio
+void memcpy_fromio(void *buffer, const volatile void __iomem *addr,
+		   size_t size);
+
+#define memcpy_toio memcpy_toio
+void memcpy_toio(volatile void __iomem *addr, const void *buffer, size_t size);
+
+#endif /* CONFIG_INDIRECT_IOMEM */
+#endif /* _LOGIC_IO_H */
diff --git a/include/linux/logic_iomem.h b/include/linux/logic_iomem.h
new file mode 100644
index 000000000000..3fa65c964379
--- /dev/null
+++ b/include/linux/logic_iomem.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2021 Intel Corporation
+ * Author: johannes@sipsolutions.net
+ */
+#ifndef __LOGIC_IOMEM_H
+#define __LOGIC_IOMEM_H
+#include <linux/types.h>
+#include <linux/ioport.h>
+
+/**
+ * struct logic_iomem_ops - emulated IO memory ops
+ * @read: read an 8, 16, 32 or 64 bit quantity from the given offset,
+ *	size is given in bytes (1, 2, 4 or 8)
+ *	(64-bit only necessary if CONFIG_64BIT is set)
+ * @write: write an 8, 16 32 or 64 bit quantity to the given offset,
+ *	size is given in bytes (1, 2, 4 or 8)
+ *	(64-bit only necessary if CONFIG_64BIT is set)
+ * @set: optional, for memset_io()
+ * @copy_from: optional, for memcpy_fromio()
+ * @copy_to: optional, for memcpy_toio()
+ * @unmap: optional, this region is getting unmapped
+ */
+struct logic_iomem_ops {
+	unsigned long (*read)(void *priv, unsigned int offset, int size);
+	void (*write)(void *priv, unsigned int offset, int size,
+		      unsigned long val);
+
+	void (*set)(void *priv, unsigned int offset, u8 value, int size);
+	void (*copy_from)(void *priv, void *buffer, unsigned int offset,
+			  int size);
+	void (*copy_to)(void *priv, unsigned int offset, const void *buffer,
+			int size);
+
+	void (*unmap)(void *priv);
+};
+
+/**
+ * struct logic_iomem_region_ops - ops for an IO memory handler
+ * @map: map a range in the registered IO memory region, must
+ *	fill *ops with the ops and may fill *priv to be passed
+ *	to the ops. The offset is given as the offset into the
+ *	registered resource region.
+ *	The return value is negative for errors, or >= 0 for
+ *	success. On success, the return value is added to the
+ *	offset for later ops, to allow for partial mappings.
+ */
+struct logic_iomem_region_ops {
+	long (*map)(unsigned long offset, size_t size,
+		    const struct logic_iomem_ops **ops,
+		    void **priv);
+};
+
+/**
+ * logic_iomem_add_region - register an IO memory region
+ * @resource: the resource description for this region
+ * @ops: the IO memory mapping ops for this resource
+ */
+int logic_iomem_add_region(struct resource *resource,
+			   const struct logic_iomem_region_ops *ops);
+
+#endif /* __LOGIC_IOMEM_H */
diff --git a/lib/Kconfig b/lib/Kconfig
index a38cc61256f1..04684ae9593d 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -102,6 +102,20 @@ config INDIRECT_PIO
 
 	  When in doubt, say N.
 
+config INDIRECT_IOMEM
+	bool
+	help
+	  This is selected by other options/architectures to provide the
+	  emulated iomem accessors.
+
+config INDIRECT_IOMEM_FALLBACK
+	bool
+	depends on INDIRECT_IOMEM
+	help
+	  If INDIRECT_IOMEM is selected, this enables falling back to plain
+	  mmio accesses when the IO memory address is not a registered
+	  emulated region.
+
 config CRC_CCITT
 	tristate "CRC-CCITT functions"
 	help
diff --git a/lib/Makefile b/lib/Makefile
index b5307d3eec1a..f50b1b5d2391 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -147,6 +147,8 @@ obj-$(CONFIG_DEBUG_LOCKING_API_SELFTESTS) += locking-selftest.o
 
 lib-y += logic_pio.o
 
+lib-$(CONFIG_INDIRECT_IOMEM) += logic_iomem.o
+
 obj-$(CONFIG_GENERIC_HWEIGHT) += hweight.o
 
 obj-$(CONFIG_BTREE) += btree.o
diff --git a/lib/logic_iomem.c b/lib/logic_iomem.c
new file mode 100644
index 000000000000..b76b92dd0f1f
--- /dev/null
+++ b/lib/logic_iomem.c
@@ -0,0 +1,318 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2021 Intel Corporation
+ * Author: Johannes Berg <johannes@sipsolutions.net>
+ */
+#include <linux/types.h>
+#include <linux/slab.h>
+#include <linux/logic_iomem.h>
+
+struct logic_iomem_region {
+	const struct resource *res;
+	const struct logic_iomem_region_ops *ops;
+	struct list_head list;
+};
+
+struct logic_iomem_area {
+	const struct logic_iomem_ops *ops;
+	void *priv;
+};
+
+#define AREA_SHIFT	24
+#define MAX_AREA_SIZE	(1 << AREA_SHIFT)
+#define MAX_AREAS	((1ULL<<32) / MAX_AREA_SIZE)
+#define AREA_BITS	((MAX_AREAS - 1) << AREA_SHIFT)
+#define AREA_MASK	(MAX_AREA_SIZE - 1)
+#ifdef CONFIG_64BIT
+#define IOREMAP_BIAS	0xDEAD000000000000UL
+#define IOREMAP_MASK	0xFFFFFFFF00000000UL
+#else
+#define IOREMAP_BIAS	0
+#define IOREMAP_MASK	0
+#endif
+
+static DEFINE_MUTEX(regions_mtx);
+static LIST_HEAD(regions_list);
+static struct logic_iomem_area mapped_areas[MAX_AREAS];
+
+int logic_iomem_add_region(struct resource *resource,
+			   const struct logic_iomem_region_ops *ops)
+{
+	struct logic_iomem_region *rreg;
+	int err;
+
+	if (WARN_ON(!resource || !ops))
+		return -EINVAL;
+
+	if (WARN_ON((resource->flags & IORESOURCE_TYPE_BITS) != IORESOURCE_MEM))
+		return -EINVAL;
+
+	rreg = kzalloc(sizeof(*rreg), GFP_KERNEL);
+	if (!rreg)
+		return -ENOMEM;
+
+	err = request_resource(&iomem_resource, resource);
+	if (err) {
+		kfree(rreg);
+		return -ENOMEM;
+	}
+
+	mutex_lock(&regions_mtx);
+	rreg->res = resource;
+	rreg->ops = ops;
+	list_add_tail(&rreg->list, &regions_list);
+	mutex_unlock(&regions_mtx);
+
+	return 0;
+}
+EXPORT_SYMBOL(logic_iomem_add_region);
+
+#ifndef CONFIG_LOGIC_IOMEM_FALLBACK
+static void __iomem *real_ioremap(phys_addr_t offset, size_t size)
+{
+	WARN(1, "invalid ioremap(0x%llx, 0x%zx)\n",
+	     (unsigned long long)offset, size);
+	return NULL;
+}
+
+static void real_iounmap(void __iomem *addr)
+{
+	WARN(1, "invalid iounmap for addr 0x%llx\n",
+	     (unsigned long long)addr);
+}
+#endif /* CONFIG_LOGIC_IOMEM_FALLBACK */
+
+void __iomem *ioremap(phys_addr_t offset, size_t size)
+{
+	void __iomem *ret = NULL;
+	struct logic_iomem_region *rreg, *found = NULL;
+	int i;
+
+	mutex_lock(&regions_mtx);
+	list_for_each_entry(rreg, &regions_list, list) {
+		if (rreg->res->start > offset)
+			continue;
+		if (rreg->res->end < offset + size - 1)
+			continue;
+		found = rreg;
+		break;
+	}
+
+	if (!found)
+		goto out;
+
+	for (i = 0; i < MAX_AREAS; i++) {
+		long offs;
+
+		if (mapped_areas[i].ops)
+			continue;
+
+		offs = rreg->ops->map(offset - found->res->start,
+				      size, &mapped_areas[i].ops,
+				      &mapped_areas[i].priv);
+		if (offs < 0) {
+			mapped_areas[i].ops = NULL;
+			break;
+		}
+
+		if (WARN_ON(!mapped_areas[i].ops)) {
+			mapped_areas[i].ops = NULL;
+			break;
+		}
+
+		ret = (void __iomem *)(IOREMAP_BIAS + (i << AREA_SHIFT) + offs);
+		break;
+	}
+out:
+	mutex_unlock(&regions_mtx);
+	if (ret)
+		return ret;
+	return real_ioremap(offset, size);
+}
+EXPORT_SYMBOL(ioremap);
+
+static inline struct logic_iomem_area *
+get_area(const volatile void __iomem *addr)
+{
+	unsigned long a = (unsigned long)addr;
+	unsigned int idx;
+
+	if (WARN_ON((a & IOREMAP_MASK) != IOREMAP_BIAS))
+		return NULL;
+
+	idx = (a & AREA_BITS) >> AREA_SHIFT;
+
+	if (mapped_areas[idx].ops)
+		return &mapped_areas[idx];
+
+	return NULL;
+}
+
+void iounmap(void __iomem *addr)
+{
+	struct logic_iomem_area *area = get_area(addr);
+
+	if (!area) {
+		real_iounmap(addr);
+		return;
+	}
+
+	if (area->ops->unmap)
+		area->ops->unmap(area->priv);
+
+	mutex_lock(&regions_mtx);
+	area->ops = NULL;
+	area->priv = NULL;
+	mutex_unlock(&regions_mtx);
+}
+EXPORT_SYMBOL(iounmap);
+
+#ifndef CONFIG_LOGIC_IOMEM_FALLBACK
+#define MAKE_FALLBACK(op, sz) 						\
+static u##sz real_raw_read ## op(const volatile void __iomem *addr)	\
+{									\
+	WARN(1, "Invalid read" #op " at address %llx\n",		\
+	     (unsigned long long)addr);					\
+	return (u ## sz)~0ULL;						\
+}									\
+									\
+void real_raw_write ## op(u ## sz val, volatile void __iomem *addr)	\
+{									\
+	WARN(1, "Invalid writeq" #op " of 0x%llx at address %llx\n",	\
+	     (unsigned long long)val, (unsigned long long)addr);	\
+}									\
+
+MAKE_FALLBACK(b, 8);
+MAKE_FALLBACK(w, 16);
+MAKE_FALLBACK(l, 32);
+#ifdef CONFIG_64BIT
+MAKE_FALLBACK(q, 64);
+#endif
+
+static void real_memset_io(volatile void __iomem *addr, int value, size_t size)
+{
+	WARN(1, "Invalid memset_io at address 0x%llx\n",
+	     (unsigned long long)addr);
+}
+
+static void real_memcpy_fromio(void *buffer, const volatile void __iomem *addr,
+			       size_t size)
+{
+	WARN(1, "Invalid memcpy_fromio at address 0x%llx\n",
+	     (unsigned long long)addr);
+
+	memset(buffer, 0xff, size);
+}
+
+static void real_memcpy_toio(volatile void __iomem *addr, const void *buffer,
+			     size_t size)
+{
+	WARN(1, "Invalid memcpy_toio at address 0x%llx\n",
+	     (unsigned long long)addr);
+}
+#endif /* CONFIG_LOGIC_IOMEM_FALLBACK */
+
+#define MAKE_OP(op, sz) 						\
+u##sz __raw_read ## op(const volatile void __iomem *addr)		\
+{									\
+	struct logic_iomem_area *area = get_area(addr);			\
+									\
+	if (!area)							\
+		return real_raw_read ## op(addr);			\
+									\
+	return (u ## sz) area->ops->read(area->priv,			\
+					 (unsigned long)addr & AREA_MASK,\
+					 sz / 8);			\
+}									\
+EXPORT_SYMBOL(__raw_read ## op);					\
+									\
+void __raw_write ## op(u ## sz val, volatile void __iomem *addr)	\
+{									\
+	struct logic_iomem_area *area = get_area(addr);			\
+									\
+	if (!area) {							\
+		real_raw_write ## op(val, addr);			\
+		return;							\
+	}								\
+									\
+	area->ops->write(area->priv,					\
+			 (unsigned long)addr & AREA_MASK,		\
+			 sz / 8, val);					\
+}									\
+EXPORT_SYMBOL(__raw_write ## op)
+
+MAKE_OP(b, 8);
+MAKE_OP(w, 16);
+MAKE_OP(l, 32);
+#ifdef CONFIG_64BIT
+MAKE_OP(q, 64);
+#endif
+
+void memset_io(volatile void __iomem *addr, int value, size_t size)
+{
+	struct logic_iomem_area *area = get_area(addr);
+	unsigned long offs, start;
+
+	if (!area) {
+		real_memset_io(addr, value, size);
+		return;
+	}
+
+	start = (unsigned long)addr & AREA_MASK;
+
+	if (area->ops->set) {
+		area->ops->set(area->priv, start, value, size);
+		return;
+	}
+
+	for (offs = 0; offs < size; offs++)
+		area->ops->write(area->priv, start + offs, 1, value);
+}
+EXPORT_SYMBOL(memset_io);
+
+void memcpy_fromio(void *buffer, const volatile void __iomem *addr,
+                   size_t size)
+{
+	struct logic_iomem_area *area = get_area(addr);
+	u8 *buf = buffer;
+	unsigned long offs, start;
+
+	if (!area) {
+		real_memcpy_fromio(buffer, addr, size);
+		return;
+	}
+
+	start = (unsigned long)addr & AREA_MASK;
+
+	if (area->ops->copy_from) {
+		area->ops->copy_from(area->priv, buffer, start, size);
+		return;
+	}
+
+	for (offs = 0; offs < size; offs++)
+		buf[offs] = area->ops->read(area->priv, start + offs, 1);
+}
+EXPORT_SYMBOL(memcpy_fromio);
+
+void memcpy_toio(volatile void __iomem *addr, const void *buffer, size_t size)
+{
+	struct logic_iomem_area *area = get_area(addr);
+	const u8 *buf = buffer;
+	unsigned long offs, start;
+
+	if (!area) {
+		real_memcpy_toio(addr, buffer, size);
+		return;
+	}
+
+	start = (unsigned long)addr & AREA_MASK;
+
+	if (area->ops->copy_to) {
+		area->ops->copy_to(area->priv, start, buffer, size);
+		return;
+	}
+
+	for (offs = 0; offs < size; offs++)
+		area->ops->write(area->priv, start + offs, 1, buf[offs]);
+}
+EXPORT_SYMBOL(memcpy_toio);
-- 
2.26.2

