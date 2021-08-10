Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E779C3E8175
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 20:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238379AbhHJR7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 13:59:33 -0400
Received: from smtprelay0175.hostedemail.com ([216.40.44.175]:42078 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234555AbhHJR4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 13:56:04 -0400
Received: from omf06.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 73407182C370A;
        Tue, 10 Aug 2021 17:55:41 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf06.hostedemail.com (Postfix) with ESMTPA id 9D9932448B5;
        Tue, 10 Aug 2021 17:55:40 +0000 (UTC)
Message-ID: <5a7cf87075177ab374c55e15f677eac167ac767a.camel@perches.com>
Subject: [PATCH] genirq/irqdesc: Use sysfs_emit in the <foo>_show functions
From:   Joe Perches <joe@perches.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Craig Gallek <kraig@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 10 Aug 2021 10:55:37 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 9D9932448B5
X-Spam-Status: No, score=-2.53
X-Stat-Signature: e9ejqwf67utbwqtm646cyc9993yftnqz
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18nKbbugOuXDegY3+4HxXNnggSK8K1BVRU=
X-HE-Tag: 1628618140-92576
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the nominally unbounded sprintf output to use sysfs_emit and the
scnprintf uses to sysfs_emit_at.

Miscellanea:

o sysfs_emit: Use the more common int len not ssize_t ret
o hwirq_show: Add a minimum newline output when irq_data.domain is not set
  and remove an unnecessary cast of an unsigned long to int ("%d" -> "%lu)
o name_show: Add a minimum newline output when desc->name is not set

trivially reduces object size (x86-64 defconfig, gcc 10.3)

$ size kernel/irq/irqdesc.o*
   text	   data	    bss	    dec	    hex	filename
   5809	    576	   1608	   7993	   1f39	kernel/irq/irqdesc.o.new
   5896	    576	   1608	   8080	   1f90	kernel/irq/irqdesc.o.old

Signed-off-by: Joe Perches <joe@perches.com>
---
 kernel/irq/irqdesc.c | 65 ++++++++++++++++++++++++++--------------------------
 1 file changed, 32 insertions(+), 33 deletions(-)

diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index fadb937660202..8d47b8667c989 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -147,19 +147,20 @@ static ssize_t per_cpu_count_show(struct kobject *kobj,
 				  struct kobj_attribute *attr, char *buf)
 {
 	struct irq_desc *desc = container_of(kobj, struct irq_desc, kobj);
-	ssize_t ret = 0;
-	char *p = "";
+	int len = 0;
+	const char *p = "";
 	int cpu;
 
 	for_each_possible_cpu(cpu) {
 		unsigned int c = irq_desc_kstat_cpu(desc, cpu);
 
-		ret += scnprintf(buf + ret, PAGE_SIZE - ret, "%s%u", p, c);
+		len += sysfs_emit_at(buf, len, "%s%u", p, c);
 		p = ",";
 	}
 
-	ret += scnprintf(buf + ret, PAGE_SIZE - ret, "\n");
-	return ret;
+	len += sysfs_emit_at(buf, len, "\n");
+
+	return len;
 }
 IRQ_ATTR_RO(per_cpu_count);
 
@@ -167,16 +168,15 @@ static ssize_t chip_name_show(struct kobject *kobj,
 			      struct kobj_attribute *attr, char *buf)
 {
 	struct irq_desc *desc = container_of(kobj, struct irq_desc, kobj);
-	ssize_t ret = 0;
+	int len = 0;
 
 	raw_spin_lock_irq(&desc->lock);
-	if (desc->irq_data.chip && desc->irq_data.chip->name) {
-		ret = scnprintf(buf, PAGE_SIZE, "%s\n",
-				desc->irq_data.chip->name);
-	}
+	len = sysfs_emit(buf, "%s\n",
+			 desc->irq_data.chip && desc->irq_data.chip->name ?
+			 desc->irq_data.chip->name : "");
 	raw_spin_unlock_irq(&desc->lock);
 
-	return ret;
+	return len;
 }
 IRQ_ATTR_RO(chip_name);
 
@@ -184,14 +184,16 @@ static ssize_t hwirq_show(struct kobject *kobj,
 			  struct kobj_attribute *attr, char *buf)
 {
 	struct irq_desc *desc = container_of(kobj, struct irq_desc, kobj);
-	ssize_t ret = 0;
+	int len = 0;
 
 	raw_spin_lock_irq(&desc->lock);
 	if (desc->irq_data.domain)
-		ret = sprintf(buf, "%d\n", (int)desc->irq_data.hwirq);
+		len = sysfs_emit(buf, "%lu\n", desc->irq_data.hwirq);
+	else
+		len = sysfs_emit(buf, "\n");
 	raw_spin_unlock_irq(&desc->lock);
 
-	return ret;
+	return len;
 }
 IRQ_ATTR_RO(hwirq);
 
@@ -199,14 +201,14 @@ static ssize_t type_show(struct kobject *kobj,
 			 struct kobj_attribute *attr, char *buf)
 {
 	struct irq_desc *desc = container_of(kobj, struct irq_desc, kobj);
-	ssize_t ret = 0;
+	int len = 0;
 
 	raw_spin_lock_irq(&desc->lock);
-	ret = sprintf(buf, "%s\n",
-		      irqd_is_level_type(&desc->irq_data) ? "level" : "edge");
+	len = sysfs_emit(buf, "%s\n",
+			 irqd_is_level_type(&desc->irq_data) ? "level" : "edge");
 	raw_spin_unlock_irq(&desc->lock);
 
-	return ret;
+	return len;
 
 }
 IRQ_ATTR_RO(type);
@@ -215,14 +217,14 @@ static ssize_t wakeup_show(struct kobject *kobj,
 			   struct kobj_attribute *attr, char *buf)
 {
 	struct irq_desc *desc = container_of(kobj, struct irq_desc, kobj);
-	ssize_t ret = 0;
+	int len = 0;
 
 	raw_spin_lock_irq(&desc->lock);
-	ret = sprintf(buf, "%s\n",
-		      irqd_is_wakeup_set(&desc->irq_data) ? "enabled" : "disabled");
+	len = sysfs_emit(buf, "%s\n",
+			 irqd_is_wakeup_set(&desc->irq_data) ? "enabled" : "disabled");
 	raw_spin_unlock_irq(&desc->lock);
 
-	return ret;
+	return len;
 
 }
 IRQ_ATTR_RO(wakeup);
@@ -231,14 +233,13 @@ static ssize_t name_show(struct kobject *kobj,
 			 struct kobj_attribute *attr, char *buf)
 {
 	struct irq_desc *desc = container_of(kobj, struct irq_desc, kobj);
-	ssize_t ret = 0;
+	int len = 0;
 
 	raw_spin_lock_irq(&desc->lock);
-	if (desc->name)
-		ret = scnprintf(buf, PAGE_SIZE, "%s\n", desc->name);
+	len = sysfs_emit(buf, "%s\n", desc->name ?: "");
 	raw_spin_unlock_irq(&desc->lock);
 
-	return ret;
+	return len;
 }
 IRQ_ATTR_RO(name);
 
@@ -247,21 +248,19 @@ static ssize_t actions_show(struct kobject *kobj,
 {
 	struct irq_desc *desc = container_of(kobj, struct irq_desc, kobj);
 	struct irqaction *action;
-	ssize_t ret = 0;
-	char *p = "";
+	int len = 0;
+	const char *p = "";
 
 	raw_spin_lock_irq(&desc->lock);
 	for (action = desc->action; action != NULL; action = action->next) {
-		ret += scnprintf(buf + ret, PAGE_SIZE - ret, "%s%s",
-				 p, action->name);
+		len += sysfs_emit_at(buf, len, "%s%s", p, action->name);
 		p = ",";
 	}
 	raw_spin_unlock_irq(&desc->lock);
 
-	if (ret)
-		ret += scnprintf(buf + ret, PAGE_SIZE - ret, "\n");
+	len += sysfs_emit_at(buf, len, "\n");
 
-	return ret;
+	return len;
 }
 IRQ_ATTR_RO(actions);
 

