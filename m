Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 870BC444E2A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 06:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbhKDFYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 01:24:51 -0400
Received: from esa8.hc1455-7.c3s2.iphmx.com ([139.138.61.253]:8501 "EHLO
        esa8.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229824AbhKDFYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 01:24:50 -0400
IronPort-SDR: +IeWx5p0MiWf3AKoy3IQnOId6l5WCJbD/ww6BDsRDh95ZCxjHn2BH7g3kUCc0DUQLNOOeyjewa
 0XJ6DzT1Gd8pKudbmggOuHzJkTJdtE+YFGdqes0Lnj8hDOxAZxOf33xFIPZ166S45PdiyjGFoV
 vw5zVKK4jogmc4aD+coqRXhJaSGJsZFS30l7m+T2rsrZlURM6EpgwoKBO3hhlT1O8ZMVu7R8aP
 4aNznWxC4k6vaIB+7HMkkzTfM3bHEm+FftcAw8gI82JoQqtQQBWACSJ3JvWqurYRqnuEVbqNTC
 9oW1dxPQWu6McCsOuxu52VoI
X-IronPort-AV: E=McAfee;i="6200,9189,10157"; a="39213806"
X-IronPort-AV: E=Sophos;i="5.87,207,1631545200"; 
   d="scan'208";a="39213806"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa8.hc1455-7.c3s2.iphmx.com with ESMTP; 04 Nov 2021 14:22:10 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
        by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 031C4F3085
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 14:22:09 +0900 (JST)
Received: from yto-om3.fujitsu.com (yto-om3.o.css.fujitsu.com [10.128.89.164])
        by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 1D909D974C
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 14:22:08 +0900 (JST)
Received: from localhost.localdomain (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by yto-om3.fujitsu.com (Postfix) with ESMTP id C70E6400C07D4;
        Thu,  4 Nov 2021 14:22:07 +0900 (JST)
From:   Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
To:     catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     tarumizu.kohei@fujitsu.com
Subject: [RFC PATCH v2 1/5] driver: hwpf: Add hardware prefetch core driver register/unregister functions
Date:   Thu,  4 Nov 2021 14:21:18 +0900
Message-Id: <20211104052122.553868-2-tarumizu.kohei@fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211104052122.553868-1-tarumizu.kohei@fujitsu.com>
References: <20211104052122.553868-1-tarumizu.kohei@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds hardware prefetch core driver register/unregister EXPORT_SYMBOL.
We use this symbol to support the new environment.
Following commits will add A64FX and Intel support.

Signed-off-by: Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
---
 drivers/hwpf/hwpf.c  | 452 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/hwpf.h |  38 ++++
 2 files changed, 490 insertions(+)
 create mode 100644 drivers/hwpf/hwpf.c
 create mode 100644 include/linux/hwpf.h

diff --git a/drivers/hwpf/hwpf.c b/drivers/hwpf/hwpf.c
new file mode 100644
index 000000000..1c86fd0cf
--- /dev/null
+++ b/drivers/hwpf/hwpf.c
@@ -0,0 +1,452 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2021 FUJITSU LIMITED
+ *
+ * This driver provides Hardware Prefetch (HWPF) tunable sysfs interface
+ * by using implementation defined registers.
+ */
+
+#include <linux/cpu.h>
+#include <linux/hwpf.h>
+#include <linux/slab.h>
+
+#ifdef pr_fmt
+#undef pr_fmt
+#endif
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+struct hwpf_dir {
+	struct kobject *kobj;
+	struct list_head level_dir_list; /* linked list of hwpf_level_dir */
+	unsigned int cpu;
+};
+
+struct hwpf_level_dir {
+	struct hwpf_dir *parent;
+	struct kobject kobj;
+	struct list_head entry; /* Membership in level_dir_list */
+	unsigned int level;
+};
+
+static DEFINE_PER_CPU(struct hwpf_dir *, hwpf_dir_pcpu);
+#define per_cpu_hwpf_dir(cpu)  (per_cpu(hwpf_dir_pcpu, cpu))
+
+static struct hwpf_driver *hwpf_driver;
+
+enum cpuhp_state hp_online;
+
+static bool hwpf_enable_support;
+static bool hwpf_dist_support;
+static bool hwpf_strong_support;
+
+#define kobj_to_hwpf_level_dir(k) container_of(k, struct hwpf_level_dir, kobj)
+
+static int create_hwpf_dir(unsigned int cpu)
+{
+	struct device *cpu_dev = get_cpu_device(cpu);
+	struct kobject *kobj;
+	struct hwpf_dir *hwpf_dir;
+
+	if (unlikely(!cpu_dev))
+		return -ENODEV;
+
+	kobj = kobject_create_and_add("hwpf", &cpu_dev->kobj);
+	if (!kobj)
+		return -EINVAL;
+
+	hwpf_dir = kzalloc(sizeof(*hwpf_dir), GFP_KERNEL);
+	if (!hwpf_dir) {
+		kobject_put(kobj);
+		return -ENOMEM;
+	}
+
+	hwpf_dir->kobj = kobj;
+	hwpf_dir->cpu = cpu;
+	INIT_LIST_HEAD(&hwpf_dir->level_dir_list);
+
+	per_cpu_hwpf_dir(cpu) = hwpf_dir;
+
+	return 0;
+}
+
+static void remove_hwpf_dir(unsigned int cpu)
+{
+	struct hwpf_dir *hwpf_dir;
+
+	hwpf_dir = per_cpu_hwpf_dir(cpu);
+	if (!hwpf_dir)
+		return;
+
+	kobject_put(hwpf_dir->kobj);
+	kfree(hwpf_dir);
+
+	hwpf_dir = NULL;
+}
+
+#define hwpf_show(name)							\
+static ssize_t name##_show(struct kobject *kobj,			\
+			   struct kobj_attribute *attr, char *buf)	\
+{									\
+	int ret;							\
+	struct hwpf_level_dir *level_dir;				\
+									\
+	level_dir = kobj_to_hwpf_level_dir(kobj);			\
+									\
+	ret = hwpf_driver->get_##name(level_dir->parent->cpu,		\
+				      level_dir->level);		\
+	if (ret < 0)							\
+		return ret;						\
+									\
+	return sprintf(buf, "%u\n", ret);				\
+}
+
+hwpf_show(enable);
+hwpf_show(strong);
+
+#define hwpf_store(name)						\
+static ssize_t name##_store(struct kobject *kobj,			\
+			    struct kobj_attribute *attr,		\
+			    const char *buf, size_t count)		\
+{									\
+	int ret, arg;							\
+	struct hwpf_level_dir *level_dir;				\
+									\
+	ret = kstrtoint(buf, 10, &arg);					\
+	if (ret < 0)							\
+		return -EINVAL;						\
+									\
+	if (arg < 0)							\
+		return -EINVAL;						\
+									\
+	level_dir = kobj_to_hwpf_level_dir(kobj);			\
+									\
+	ret = hwpf_driver->set_##name(level_dir->parent->cpu,		\
+				      level_dir->level, arg);		\
+	if (ret < 0)							\
+		return ret;						\
+									\
+	return count;							\
+}
+
+hwpf_store(enable);
+hwpf_store(strong);
+
+static const char dist_auto_string[] = "auto";
+
+static ssize_t dist_show(struct kobject *kobj, struct kobj_attribute *attr,
+			 char *buf)
+{
+	int ret;
+	struct hwpf_level_dir *level_dir;
+
+	level_dir = kobj_to_hwpf_level_dir(kobj);
+
+	ret = hwpf_driver->get_dist(level_dir->parent->cpu,
+				    level_dir->level);
+	if (ret < 0)
+		return ret;
+
+	if (ret == DIST_AUTO_VALUE)
+		return sprintf(buf, "%s\n", dist_auto_string);
+	else
+		return sprintf(buf, "%u\n", ret);
+}
+
+static ssize_t dist_store(struct kobject *kobj, struct kobj_attribute *attr,
+			  const char *buf, size_t count)
+{
+	int ret, arg;
+	struct hwpf_level_dir *level_dir;
+
+	if (sysfs_streq(buf, dist_auto_string)) {
+		arg = DIST_AUTO_VALUE;
+	} else {
+		ret = kstrtoint(buf, 10, &arg);
+		if (ret < 0)
+			return -EINVAL;
+	}
+
+	if (arg < 0)
+		return -EINVAL;
+
+	level_dir = kobj_to_hwpf_level_dir(kobj);
+
+	ret = hwpf_driver->set_dist(level_dir->parent->cpu,
+				    level_dir->level, arg);
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
+static struct dist_table *get_dist_table(struct list_head dist_list,
+					  unsigned int level)
+{
+	struct dist_table *table;
+
+	list_for_each_entry(table, &dist_list, entry)
+		if (table->level == level)
+			return table;
+
+	return NULL;
+}
+
+static ssize_t available_dist_show(struct kobject *kobj,
+				   struct kobj_attribute *attr, char *buf)
+{
+	struct dist_table *table;
+	struct hwpf_level_dir *level_dir;
+	int i;
+	ssize_t count = 0;
+
+	level_dir = kobj_to_hwpf_level_dir(kobj);
+
+	table = get_dist_table(hwpf_driver->dist_list, level_dir->level);
+	if (!table)
+		return -EINVAL;
+
+	for (i = 0; i < table->table_size; i++) {
+		int available_dist = table->available_dist[i];
+
+		if (available_dist == DIST_AUTO_VALUE)
+			count += sprintf(&buf[count], "%s ", dist_auto_string);
+		else
+			count += sprintf(&buf[count], "%d ", available_dist);
+	}
+	count += sprintf(&buf[count], "\n");
+
+	return count;
+}
+
+#define HWPF_ATTR_RW(name)					\
+	static struct kobj_attribute hwpf_##name##_attribute =	\
+	__ATTR(name, 0664, name##_show, name##_store)
+
+HWPF_ATTR_RW(enable);
+HWPF_ATTR_RW(dist);
+HWPF_ATTR_RW(strong);
+
+#define HWPF_ATTR_RO(name)					\
+	static struct kobj_attribute hwpf_##name##_attribute =	\
+	__ATTR(name, 0664, name##_show, NULL)
+
+HWPF_ATTR_RO(available_dist);
+
+static struct attribute *hwpf_attrs[] = {
+	&hwpf_enable_attribute.attr,
+	&hwpf_dist_attribute.attr,
+	&hwpf_strong_attribute.attr,
+	&hwpf_available_dist_attribute.attr,
+	NULL
+};
+
+static umode_t hwpf_attrs_is_visible(struct kobject *kobj,
+				     struct attribute *attr, int unused)
+{
+	umode_t mode = attr->mode;
+
+	if ((attr == &hwpf_enable_attribute.attr) && (hwpf_enable_support))
+		return mode;
+	if ((attr == &hwpf_dist_attribute.attr) && (hwpf_dist_support))
+		return mode;
+	if ((attr == &hwpf_available_dist_attribute.attr) && (hwpf_dist_support))
+		return mode;
+	if ((attr == &hwpf_strong_attribute.attr) && (hwpf_strong_support))
+		return mode;
+
+	return 0;
+}
+
+static const struct attribute_group hwpf_attr_group = {
+	.attrs = hwpf_attrs,
+	.is_visible = hwpf_attrs_is_visible,
+};
+
+static void level_dir_release(struct kobject *kobj)
+{
+	struct hwpf_level_dir *level_dir;
+
+	level_dir = kobj_to_hwpf_level_dir(kobj);
+
+	kfree(level_dir);
+}
+
+static struct kobj_type hwpf_level_type = {
+	.sysfs_ops = &kobj_sysfs_ops,
+	.release = level_dir_release,
+};
+
+static int create_level_dir(struct hwpf_dir *hwpf_dir, unsigned int level)
+{
+	struct hwpf_level_dir *level_dir;
+	int ret;
+
+	if (level >= hwpf_driver->cache_leaves)
+		return -EINVAL;
+
+	level_dir = kzalloc(sizeof(*level_dir), GFP_KERNEL);
+	if (!level_dir)
+		return -ENOMEM;
+
+	ret = kobject_init_and_add(&level_dir->kobj, &hwpf_level_type,
+				   hwpf_dir->kobj, "l%d", level + 1);
+	if (ret < 0) {
+		kfree(level_dir);
+		return ret;
+	}
+
+	ret = sysfs_create_group(&level_dir->kobj, &hwpf_attr_group);
+	if (ret) {
+		kobject_put(&level_dir->kobj);
+		kfree(level_dir);
+		return ret;
+	}
+
+	level_dir->level = level;
+	level_dir->parent = hwpf_dir;
+	list_add(&level_dir->entry, &hwpf_dir->level_dir_list);
+
+	return 0;
+}
+
+static void remove_level_dirs(unsigned int cpu)
+{
+	struct hwpf_dir *hwpf_dir;
+	struct hwpf_level_dir *dir, *tmp;
+
+	hwpf_dir = per_cpu_hwpf_dir(cpu);
+	if (!hwpf_dir)
+		return;
+
+	list_for_each_entry_safe(dir, tmp, &hwpf_dir->level_dir_list, entry) {
+		list_del(&dir->entry);
+		kobject_put(&dir->kobj);
+	}
+}
+
+static int create_level_dirs(unsigned int cpu)
+{
+	int level, ret;
+	struct hwpf_dir *hwpf_dir;
+
+	hwpf_dir = per_cpu_hwpf_dir(cpu);
+
+	for (level = 0; level < hwpf_driver->cache_leaves; level++) {
+		ret = create_level_dir(hwpf_dir, level);
+		if (ret < 0) {
+			remove_level_dirs(cpu);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int hwpf_online(unsigned int cpu)
+{
+	int ret;
+
+	if (hwpf_driver->cpuhp_online) {
+		ret = hwpf_driver->cpuhp_online(cpu);
+		if (ret < 0)
+			return ret;
+	}
+
+	ret = create_hwpf_dir(cpu);
+	if (ret < 0)
+		return ret;
+
+	ret = create_level_dirs(cpu);
+	if (ret < 0) {
+		remove_hwpf_dir(cpu);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int hwpf_prepare_down(unsigned int cpu)
+{
+	remove_level_dirs(cpu);
+
+	remove_hwpf_dir(cpu);
+
+	if (hwpf_driver->cpuhp_prepare_down)
+		hwpf_driver->cpuhp_prepare_down(cpu);
+
+	return 0;
+}
+
+/**
+ * hwpf_register_driver - register a Hardware Prefetch driver
+ * @driver_data: struct hwpf_driver contains a function pointer to create
+ *               attribute. If the function pointer is defined, corresponding
+ *               attribute is created.
+ *
+ * Context: Any context.
+ * Return: 0 on success, negative error code on failure.
+ */
+int hwpf_register_driver(struct hwpf_driver *driver_data)
+{
+	int ret;
+
+	if (hwpf_driver)
+		return -EEXIST;
+
+	if (!driver_data || driver_data->cache_leaves == 0)
+		return -EINVAL;
+
+	if (!driver_data->get_enable || !driver_data->set_enable)
+		hwpf_enable_support = false;
+	else
+		hwpf_enable_support = true;
+
+	if (!driver_data->get_dist || !driver_data->set_dist ||
+	    list_empty(&driver_data->dist_list))
+		hwpf_dist_support = false;
+	else
+		hwpf_dist_support = true;
+
+	if (!driver_data->get_strong || !driver_data->set_strong)
+		hwpf_strong_support = false;
+	else
+		hwpf_strong_support = true;
+
+	if (!hwpf_enable_support && !hwpf_dist_support &&
+	    !hwpf_strong_support)
+		return -EINVAL;
+
+	hwpf_driver = driver_data;
+
+	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "hwpf/hwpf:online",
+				hwpf_online, hwpf_prepare_down);
+	if (ret < 0) {
+		pr_err("failed to register hotplug callbacks\n");
+		return ret;
+	}
+
+	hp_online = ret;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(hwpf_register_driver);
+
+/**
+ * hwpf_unregister_driver - unregister the Hardware Prefetch driver
+ * @driver_data: Used to verify that this function is called by the driver that
+ *               called hwpf_register_driver by determining if driver_data is
+ *               the same.
+ *
+ * Context: Any context.
+ * Return: nothing.
+ */
+void hwpf_unregister_driver(struct hwpf_driver *driver_data)
+{
+	if (!hwpf_driver || (driver_data != hwpf_driver))
+		return;
+
+	cpuhp_remove_state(hp_online);
+
+	hwpf_driver = NULL;
+}
+EXPORT_SYMBOL_GPL(hwpf_unregister_driver);
diff --git a/include/linux/hwpf.h b/include/linux/hwpf.h
new file mode 100644
index 000000000..6a87e4591
--- /dev/null
+++ b/include/linux/hwpf.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_HWPF_H
+#define _LINUX_HWPF_H
+
+#define DIST_AUTO_VALUE 0 /* Special value when dist is "auto" */
+
+struct dist_table {
+	unsigned int level;		/* Cache level */
+	unsigned int *available_dist;	/* Array of available dists */
+	size_t table_size;		/* Number of elements in array */
+	struct list_head entry;		/* Membership in dist_list */
+};
+
+struct hwpf_driver {
+	unsigned int cache_leaves; /* Number of hwpf/l* directories */
+
+	/* Set these function pointer if support enable attribute. */
+	int (*get_enable)(unsigned int cpu, unsigned int level);
+	int (*set_enable)(unsigned int cpu, unsigned int level, int val);
+
+	/* Set these function pointer and dist_list if support dist attribute. */
+	int (*get_dist)(unsigned int cpu, unsigned int level);
+	int (*set_dist)(unsigned int cpu, unsigned int level, int val);
+	struct list_head dist_list; /* linked list of dist_table */
+
+	/* Set these function pointer if support strong attribute. */
+	int (*get_strong)(unsigned int cpu, unsigned int level);
+	int (*set_strong)(unsigned int cpu, unsigned int level, int val);
+
+	/* Set these function pointer if register them in cpuhp_*_state. */
+	int (*cpuhp_online)(unsigned int cpu);
+	void (*cpuhp_prepare_down)(unsigned int cpu);
+};
+
+int hwpf_register_driver(struct hwpf_driver *driver_data);
+void hwpf_unregister_driver(struct hwpf_driver *driver_data);
+
+#endif
-- 
2.27.0

