Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61CB0445FC8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 07:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbhKEGlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 02:41:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35885 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232365AbhKEGl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 02:41:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636094328;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7MzSJBDS29IOMUDtXrVUz+OaQ2N//CapA2UKaWP7lEM=;
        b=QhtbgFNT74/IsglHQ+6fZkC2Y7CePxZr+ftfUY6H3Aac02g6DKlQbyMqlkS/TTDQe3ECjK
        +wDr6zlnU2Jk+KotoJuW1NhNvLYSi/bVFlB/QTD6F+/UhzdeMQ9WnDXS3EVWMYlE5XXVmh
        i7QncGLECi1Z+/Kn0iCQA3dS+n0Xcfw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240--I5fRV5UM4qltVggdfgl-g-1; Fri, 05 Nov 2021 02:38:45 -0400
X-MC-Unique: -I5fRV5UM4qltVggdfgl-g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F47810A8E02;
        Fri,  5 Nov 2021 06:38:44 +0000 (UTC)
Received: from localhost (ovpn-8-32.pek2.redhat.com [10.72.8.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1473216A32;
        Fri,  5 Nov 2021 06:38:23 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 2/2] kobject: wait until kobject is cleaned up before freeing module
Date:   Fri,  5 Nov 2021 14:37:10 +0800
Message-Id: <20211105063710.4092936-3-ming.lei@redhat.com>
In-Reply-To: <20211105063710.4092936-1-ming.lei@redhat.com>
References: <20211105063710.4092936-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kobject_put() may become asynchronously because of
CONFIG_DEBUG_KOBJECT_RELEASE, so once kobject_put() returns, the caller may
expect the kobject is released after the last refcnt is dropped, however
CONFIG_DEBUG_KOBJECT_RELEASE just schedules one delayed work function
for cleaning up the kobject. Inside the cleanup handler, kobj->ktype and
kobj->ktype->release are required.

It is supposed that no activity is on kobject itself any more since
module_exit() is started, so it is reasonable for the kobject user or
driver to expect that kobject can be really released in the last run of
kobject_put() in module_exit() code path. Otherwise, it can be thought as
one driver's bug since the module is going away.

When the ->ktype and ->ktype->release are allocated as module static
variable, it can cause trouble because the delayed cleanup handler may
be run after the module is unloaded.

Fixes the issue by flushing scheduled kobject cleanup work before
freeing module.

Reported-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/kobject.h |  1 +
 lib/kobject.c           | 62 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/include/linux/kobject.h b/include/linux/kobject.h
index ea30529fba08..e5e3419cf36b 100644
--- a/include/linux/kobject.h
+++ b/include/linux/kobject.h
@@ -70,6 +70,7 @@ struct kobject {
 	struct kernfs_node	*sd; /* sysfs directory entry */
 	struct kref		kref;
 #ifdef CONFIG_DEBUG_KOBJECT_RELEASE
+	struct list_head	node;
 	struct delayed_work	release;
 #endif
 	unsigned int state_initialized:1;
diff --git a/lib/kobject.c b/lib/kobject.c
index 4c0dbe11be3d..f5fd6017d8ce 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -17,6 +17,12 @@
 #include <linux/slab.h>
 #include <linux/random.h>
 #include <linux/module.h>
+#include <linux/delay.h>
+
+#ifdef CONFIG_DEBUG_KOBJECT_RELEASE
+static LIST_HEAD(kobj_cleanup_list);
+static DEFINE_SPINLOCK(kobj_cleanup_lock);
+#endif
 
 /**
  * kobject_namespace() - Return @kobj's namespace tag.
@@ -682,6 +688,13 @@ static void kobject_cleanup(struct kobject *kobj)
 	struct kobject *parent = kobj->parent;
 	struct kobj_type *t = get_ktype(kobj);
 	const char *name = kobj->name;
+#ifdef CONFIG_DEBUG_KOBJECT_RELEASE
+	unsigned long flags;
+
+	spin_lock_irqsave(&kobj_cleanup_lock, flags);
+	list_del(&kobj->node);
+	spin_unlock_irqrestore(&kobj_cleanup_lock, flags);
+#endif
 
 	pr_debug("kobject: '%s' (%p): %s, parent %p\n",
 		 kobject_name(kobj), kobj, __func__, kobj->parent);
@@ -716,11 +729,49 @@ static void kobject_cleanup(struct kobject *kobj)
 }
 
 #ifdef CONFIG_DEBUG_KOBJECT_RELEASE
+/*
+ * Module notifier call back, flushing scheduled kobject cleanup work
+ * before freeing module
+ */
+static int kobj_module_callback(struct notifier_block *nb,
+				   unsigned long val, void *data)
+{
+	LIST_HEAD(pending);
+
+	if (val != MODULE_STATE_GOING)
+		return NOTIFY_DONE;
+
+	spin_lock_irq(&kobj_cleanup_lock);
+	list_splice_init(&kobj_cleanup_list, &pending);
+	spin_unlock_irq(&kobj_cleanup_lock);
+
+	while (!list_empty_careful(&pending))
+		msleep(jiffies_to_msecs(HZ / 10));
+
+	flush_scheduled_work();
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block kobj_module_nb = {
+	.notifier_call = kobj_module_callback,
+};
+
 static void kobject_delayed_cleanup(struct work_struct *work)
 {
 	kobject_cleanup(container_of(to_delayed_work(work),
 				     struct kobject, release));
 }
+
+static int __init kobj_delayed_cleanup_init(void)
+{
+	WARN_ON(register_module_notifier(&kobj_module_nb));
+	return 0;
+}
+#else
+static int __init kobj_delayed_cleanup_init(void)
+{
+	return 0;
+}
 #endif
 
 static void kobject_release(struct kref *kref)
@@ -728,6 +779,7 @@ static void kobject_release(struct kref *kref)
 	struct kobject *kobj = container_of(kref, struct kobject, kref);
 #ifdef CONFIG_DEBUG_KOBJECT_RELEASE
 	unsigned long delay = HZ + HZ * (get_random_int() & 0x3);
+	unsigned long flags;
 
 	if (kobj->ktype == &module_ktype)
 		delay = 0;
@@ -736,6 +788,10 @@ static void kobject_release(struct kref *kref)
 		 kobject_name(kobj), kobj, __func__, kobj->parent, delay);
 	INIT_DELAYED_WORK(&kobj->release, kobject_delayed_cleanup);
 
+	spin_lock_irqsave(&kobj_cleanup_lock, flags);
+	list_add(&kobj->node, &kobj_cleanup_list);
+	spin_unlock_irqrestore(&kobj_cleanup_lock, flags);
+
 	schedule_delayed_work(&kobj->release, delay);
 #else
 	kobject_cleanup(kobj);
@@ -1146,3 +1202,9 @@ void kobj_ns_drop(enum kobj_ns_type type, void *ns)
 	spin_unlock(&kobj_ns_type_lock);
 }
 EXPORT_SYMBOL_GPL(kobj_ns_drop);
+
+static int __init kobj_subsys_init(void)
+{
+	return kobj_delayed_cleanup_init();
+}
+core_initcall(kobj_subsys_init)
-- 
2.31.1

