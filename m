Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8C83B4D72
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 09:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbhFZHg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Jun 2021 03:36:56 -0400
Received: from smtpbg704.qq.com ([203.205.195.105]:37162 "EHLO
        smtpproxy21.qq.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229657AbhFZHgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 03:36:51 -0400
X-Greylist: delayed 98386 seconds by postgrey-1.27 at vger.kernel.org; Sat, 26 Jun 2021 03:36:51 EDT
X-QQ-mid: bizesmtp39t1624692865tf2rwugi
Received: from localhost.localdomain (unknown [182.148.13.245])
        by esmtp6.qq.com (ESMTP) with 
        id ; Sat, 26 Jun 2021 15:34:15 +0800 (CST)
X-QQ-SSF: 0100000000200060B000B00A0000000
X-QQ-FEAT: lm51M56XDGzx/nKTqaxLkaV6Z51EBtBm8OwMuLO1WEF0xwDM1vmtJckw+7nUB
        i3ptBLz7GUQY5rsfigmVOPeDYSbz9yE05dvPsGwX6ISmIPKe13Dji5DvtuF9Xdt48jgNC9k
        tu7/ZyXekLnrvBKJtIzXI+GtEPiH1rLodO8hBHXSnBVQFGswQOyjgn14wCYcKHfsP79Clc7
        cLA77IEX4tjpHM34VC7nZnAhGxGXuL4ZypsLg6tOk5FURiq+7f4Pf9knIFiEA/tQN6Xp85r
        /v31JW3xNZruiJxUEdcQwM6Vc2h7PYkz/pbLJVxMtT7deFzew8fo0zlZiNrKJkPhxqICM8U
        5k5wkfP
X-QQ-GoodBg: 0
From:   Jinchao Wang <wjc@cdjrlc.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org, broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, Jinchao Wang <wjc@cdjrlc.com>
Subject: [PATCH] driver: base: Prefer unsigned int to bare use of unsigned
Date:   Sat, 26 Jun 2021 15:34:08 +0800
Message-Id: <20210626073408.12448-1-wjc@cdjrlc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgforeign:qybgforeign5
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch warnings:
    WARNING: Prefer 'unsigned int' to bare use of 'unsigned'

Signed-off-by: Jinchao Wang <wjc@cdjrlc.com>
---
 drivers/base/cpu.c                   |  4 ++--
 drivers/base/map.c                   | 12 ++++++------
 drivers/base/node.c                  |  8 ++++----
 drivers/base/regmap/regmap-debugfs.c |  2 +-
 drivers/base/regmap/regmap-mmio.c    |  2 +-
 drivers/base/regmap/regmap.c         |  6 +++---
 6 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 5ef14db97904..5fc258073bc7 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -388,7 +388,7 @@ int register_cpu(struct cpu *cpu, int num)
 	return 0;
 }
 
-struct device *get_cpu_device(unsigned cpu)
+struct device *get_cpu_device(unsigned int cpu)
 {
 	if (cpu < nr_cpu_ids && cpu_possible(cpu))
 		return per_cpu(cpu_sys_devices, cpu);
@@ -484,7 +484,7 @@ static const struct attribute_group *cpu_root_attr_groups[] = {
 	NULL,
 };
 
-bool cpu_is_hotpluggable(unsigned cpu)
+bool cpu_is_hotpluggable(unsigned int cpu)
 {
 	struct device *dev = get_cpu_device(cpu);
 	return dev && container_of(dev, struct cpu, dev)->hotpluggable;
diff --git a/drivers/base/map.c b/drivers/base/map.c
index 5650ab2b247a..83aeb09ca161 100644
--- a/drivers/base/map.c
+++ b/drivers/base/map.c
@@ -33,9 +33,9 @@ int kobj_map(struct kobj_map *domain, dev_t dev, unsigned long range,
 	     struct module *module, kobj_probe_t *probe,
 	     int (*lock)(dev_t, void *), void *data)
 {
-	unsigned n = MAJOR(dev + range - 1) - MAJOR(dev) + 1;
-	unsigned index = MAJOR(dev);
-	unsigned i;
+	unsigned int n = MAJOR(dev + range - 1) - MAJOR(dev) + 1;
+	unsigned int index = MAJOR(dev);
+	unsigned int i;
 	struct probe *p;
 
 	if (n > 255)
@@ -67,9 +67,9 @@ int kobj_map(struct kobj_map *domain, dev_t dev, unsigned long range,
 
 void kobj_unmap(struct kobj_map *domain, dev_t dev, unsigned long range)
 {
-	unsigned n = MAJOR(dev + range - 1) - MAJOR(dev) + 1;
-	unsigned index = MAJOR(dev);
-	unsigned i;
+	unsigned int n = MAJOR(dev + range - 1) - MAJOR(dev) + 1;
+	unsigned int index = MAJOR(dev);
+	unsigned int i;
 	struct probe *found = NULL;
 
 	if (n > 255)
diff --git a/drivers/base/node.c b/drivers/base/node.c
index 4a4ae868ad9f..2bc9089f3e78 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -75,7 +75,7 @@ static DEVICE_ATTR_RO(cpulist);
 struct node_access_nodes {
 	struct device		dev;
 	struct list_head	list_node;
-	unsigned		access;
+	unsigned int		access;
 #ifdef CONFIG_HMEM_REPORTING
 	struct node_hmem_attrs	hmem_attrs;
 #endif
@@ -122,7 +122,7 @@ static void node_access_release(struct device *dev)
 }
 
 static struct node_access_nodes *node_init_node_access(struct node *node,
-						       unsigned access)
+						       unsigned int access)
 {
 	struct node_access_nodes *access_node;
 	struct device *dev;
@@ -187,7 +187,7 @@ static struct attribute *access_attrs[] = {
  * @access: The access class the for the given attributes
  */
 void node_set_perf_attrs(unsigned int nid, struct node_hmem_attrs *hmem_attrs,
-			 unsigned access)
+			 unsigned int access)
 {
 	struct node_access_nodes *c;
 	struct node *node;
@@ -711,7 +711,7 @@ int register_cpu_under_node(unsigned int cpu, unsigned int nid)
  */
 int register_memory_node_under_compute_node(unsigned int mem_nid,
 					    unsigned int cpu_nid,
-					    unsigned access)
+					    unsigned int access)
 {
 	struct node *init_node, *targ_node;
 	struct node_access_nodes *initiator, *target;
diff --git a/drivers/base/regmap/regmap-debugfs.c b/drivers/base/regmap/regmap-debugfs.c
index 211a335a608d..ad684d37c2da 100644
--- a/drivers/base/regmap/regmap-debugfs.c
+++ b/drivers/base/regmap/regmap-debugfs.c
@@ -368,7 +368,7 @@ static ssize_t regmap_reg_ranges_read_file(struct file *file,
 	char *buf;
 	char *entry;
 	int ret;
-	unsigned entry_len;
+	unsigned int entry_len;
 
 	if (*ppos < 0 || !count)
 		return -EINVAL;
diff --git a/drivers/base/regmap/regmap-mmio.c b/drivers/base/regmap/regmap-mmio.c
index f9cd51afb9d2..71f16be7e717 100644
--- a/drivers/base/regmap/regmap-mmio.c
+++ b/drivers/base/regmap/regmap-mmio.c
@@ -15,7 +15,7 @@
 
 struct regmap_mmio_context {
 	void __iomem *regs;
-	unsigned val_bytes;
+	unsigned int val_bytes;
 	bool relaxed_mmio;
 
 	bool attached_clk;
diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index fe3e38dd5324..904e1022d12e 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1126,9 +1126,9 @@ struct regmap *__regmap_init(struct device *dev,
 		/* Make sure, that this register range has no selector
 		   or data window within its boundary */
 		for (j = 0; j < config->num_ranges; j++) {
-			unsigned sel_reg = config->ranges[j].selector_reg;
-			unsigned win_min = config->ranges[j].window_start;
-			unsigned win_max = win_min +
+			unsigned int sel_reg = config->ranges[j].selector_reg;
+			unsigned int win_min = config->ranges[j].window_start;
+			unsigned int win_max = win_min +
 					   config->ranges[j].window_len - 1;
 
 			/* Allow data window inside its own virtual range */
-- 
2.31.1



