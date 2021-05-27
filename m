Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF73393072
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 16:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236277AbhE0OJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 10:09:45 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2438 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235440AbhE0OJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 10:09:39 -0400
Received: from dggeml758-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FrV2G3Rsqz6778;
        Thu, 27 May 2021 22:05:10 +0800 (CST)
Received: from dggema769-chm.china.huawei.com (10.1.198.211) by
 dggeml758-chm.china.huawei.com (10.1.199.159) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 27 May 2021 22:08:03 +0800
Received: from localhost (10.174.179.215) by dggema769-chm.china.huawei.com
 (10.1.198.211) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 27
 May 2021 22:08:02 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <peterz@infradead.org>, <vincent.donnefort@arm.com>
CC:     <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] kernel/cpu: use DEVICE_ATTR_*() macro
Date:   Thu, 27 May 2021 22:08:02 +0800
Message-ID: <20210527140802.12428-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggema769-chm.china.huawei.com (10.1.198.211)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEVICE_ATTR_*() helper instead of plain DEVICE_ATTR,
which makes the code a bit shorter and easier to read.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 kernel/cpu.c | 50 +++++++++++++++++++++++---------------------------
 1 file changed, 23 insertions(+), 27 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index e538518556f4..00ffe7f023bc 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2183,18 +2183,17 @@ int cpuhp_smt_enable(void)
 #endif
 
 #if defined(CONFIG_SYSFS) && defined(CONFIG_HOTPLUG_CPU)
-static ssize_t show_cpuhp_state(struct device *dev,
-				struct device_attribute *attr, char *buf)
+static ssize_t state_show(struct device *dev,
+			  struct device_attribute *attr, char *buf)
 {
 	struct cpuhp_cpu_state *st = per_cpu_ptr(&cpuhp_state, dev->id);
 
 	return sprintf(buf, "%d\n", st->state);
 }
-static DEVICE_ATTR(state, 0444, show_cpuhp_state, NULL);
+static DEVICE_ATTR_RO(state);
 
-static ssize_t write_cpuhp_target(struct device *dev,
-				  struct device_attribute *attr,
-				  const char *buf, size_t count)
+static ssize_t target_store(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t count)
 {
 	struct cpuhp_cpu_state *st = per_cpu_ptr(&cpuhp_state, dev->id);
 	struct cpuhp_step *sp;
@@ -2232,19 +2231,17 @@ static ssize_t write_cpuhp_target(struct device *dev,
 	return ret ? ret : count;
 }
 
-static ssize_t show_cpuhp_target(struct device *dev,
-				 struct device_attribute *attr, char *buf)
+static ssize_t target_show(struct device *dev,
+			   struct device_attribute *attr, char *buf)
 {
 	struct cpuhp_cpu_state *st = per_cpu_ptr(&cpuhp_state, dev->id);
 
 	return sprintf(buf, "%d\n", st->target);
 }
-static DEVICE_ATTR(target, 0644, show_cpuhp_target, write_cpuhp_target);
-
+static DEVICE_ATTR_RW(target);
 
-static ssize_t write_cpuhp_fail(struct device *dev,
-				struct device_attribute *attr,
-				const char *buf, size_t count)
+static ssize_t fail_store(struct device *dev, struct device_attribute *attr,
+			  const char *buf, size_t count)
 {
 	struct cpuhp_cpu_state *st = per_cpu_ptr(&cpuhp_state, dev->id);
 	struct cpuhp_step *sp;
@@ -2293,15 +2290,15 @@ static ssize_t write_cpuhp_fail(struct device *dev,
 	return count;
 }
 
-static ssize_t show_cpuhp_fail(struct device *dev,
-			       struct device_attribute *attr, char *buf)
+static ssize_t fail_show(struct device *dev,
+			 struct device_attribute *attr, char *buf)
 {
 	struct cpuhp_cpu_state *st = per_cpu_ptr(&cpuhp_state, dev->id);
 
 	return sprintf(buf, "%d\n", st->fail);
 }
 
-static DEVICE_ATTR(fail, 0644, show_cpuhp_fail, write_cpuhp_fail);
+static DEVICE_ATTR_RW(fail);
 
 static struct attribute *cpuhp_cpu_attrs[] = {
 	&dev_attr_state.attr,
@@ -2316,7 +2313,7 @@ static const struct attribute_group cpuhp_cpu_attr_group = {
 	NULL
 };
 
-static ssize_t show_cpuhp_states(struct device *dev,
+static ssize_t states_show(struct device *dev,
 				 struct device_attribute *attr, char *buf)
 {
 	ssize_t cur, res = 0;
@@ -2335,7 +2332,7 @@ static ssize_t show_cpuhp_states(struct device *dev,
 	mutex_unlock(&cpuhp_state_mutex);
 	return res;
 }
-static DEVICE_ATTR(states, 0444, show_cpuhp_states, NULL);
+static DEVICE_ATTR_RO(states);
 
 static struct attribute *cpuhp_cpu_root_attrs[] = {
 	&dev_attr_states.attr,
@@ -2408,28 +2405,27 @@ static const char *smt_states[] = {
 	[CPU_SMT_NOT_IMPLEMENTED]	= "notimplemented",
 };
 
-static ssize_t
-show_smt_control(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t control_show(struct device *dev,
+			    struct device_attribute *attr, char *buf)
 {
 	const char *state = smt_states[cpu_smt_control];
 
 	return snprintf(buf, PAGE_SIZE - 2, "%s\n", state);
 }
 
-static ssize_t
-store_smt_control(struct device *dev, struct device_attribute *attr,
-		  const char *buf, size_t count)
+static ssize_t control_store(struct device *dev, struct device_attribute *attr,
+			     const char *buf, size_t count)
 {
 	return __store_smt_control(dev, attr, buf, count);
 }
-static DEVICE_ATTR(control, 0644, show_smt_control, store_smt_control);
+static DEVICE_ATTR_RW(control);
 
-static ssize_t
-show_smt_active(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t active_show(struct device *dev,
+			   struct device_attribute *attr, char *buf)
 {
 	return snprintf(buf, PAGE_SIZE - 2, "%d\n", sched_smt_active());
 }
-static DEVICE_ATTR(active, 0444, show_smt_active, NULL);
+static DEVICE_ATTR_RO(active);
 
 static struct attribute *cpuhp_smt_attrs[] = {
 	&dev_attr_control.attr,
-- 
2.17.1

