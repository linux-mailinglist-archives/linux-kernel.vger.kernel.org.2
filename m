Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B39ED3B6788
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 19:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbhF1RWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 13:22:21 -0400
Received: from smtpbg702.qq.com ([203.205.195.102]:39869 "EHLO
        smtpproxy21.qq.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232601AbhF1RWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 13:22:12 -0400
X-QQ-mid: bizesmtp54t1624900777t9azchgn
Received: from localhost.localdomain (unknown [182.148.13.55])
        by esmtp6.qq.com (ESMTP) with 
        id ; Tue, 29 Jun 2021 01:19:30 +0800 (CST)
X-QQ-SSF: 01000000002000B0B000B00A0000000
X-QQ-FEAT: /mQQSsXFegSriAZDE3x/iJDEuP0KAbaKoTz5NohIqLQozcM13k2yrxAdsX+tQ
        +htBTTXZWe75npDiNlEEwF6zLZcOegowPnDslMkWekHI/XOdxd+0VIar5uc4Dnl0TCo6pd4
        31CnyzucVH3UfbbYtf5/niLi2lGlf54LLwgbBfRzR0em7JfoJExa9g4AT/bLmU1HJO/FRmE
        /lIfTjASCtCKNAP97EIb/9RHH76xmm3IQWN6ZTJXgtrAHkwbiw7BbOVQ1j/SgZOKvJUTUmt
        XjgvfJeZAhkgV35U06oUSNLa47F6U9M2VQuUl0od7M/llJzEzv0kLMBxG1avvfFFWNZsmVS
        RUchDHc
X-QQ-GoodBg: 0
From:   Jinchao Wang <wjc@cdjrlc.com>
To:     broonie@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, Jinchao Wang <wjc@cdjrlc.com>
Subject: [PATCH v2 2/2] driver: base: Prefer unsigned int to bare use of unsigned
Date:   Tue, 29 Jun 2021 01:19:07 +0800
Message-Id: <20210628171907.63646-2-wjc@cdjrlc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210628171907.63646-1-wjc@cdjrlc.com>
References: <20210628171907.63646-1-wjc@cdjrlc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch warnings:
    WARNING: Prefer 'unsigned int' to bare use of 'unsigned'

Signed-off-by: Jinchao Wang <wjc@cdjrlc.com>
---
-change for v2 2/2:
-Split patch
---
 drivers/base/cpu.c  |  4 ++--
 drivers/base/map.c  | 12 ++++++------
 drivers/base/node.c |  8 ++++----
 3 files changed, 12 insertions(+), 12 deletions(-)

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
-- 
2.31.1



