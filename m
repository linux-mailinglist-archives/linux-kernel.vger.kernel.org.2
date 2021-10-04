Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 826094212B4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 17:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235485AbhJDPda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 11:33:30 -0400
Received: from mga12.intel.com ([192.55.52.136]:40823 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234917AbhJDPd2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 11:33:28 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10127"; a="205589003"
X-IronPort-AV: E=Sophos;i="5.85,346,1624345200"; 
   d="scan'208";a="205589003"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2021 07:37:24 -0700
X-IronPort-AV: E=Sophos;i="5.85,346,1624345200"; 
   d="scan'208";a="622303735"
Received: from shearne-mobl.ger.corp.intel.com (HELO tursulin-mobl2.home) ([10.213.208.122])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2021 07:37:23 -0700
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
To:     Intel-gfx@lists.freedesktop.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Subject: [RFC 8/8] drm/i915: Connect with the process nice change notifier
Date:   Mon,  4 Oct 2021 15:36:50 +0100
Message-Id: <20211004143650.699120-9-tvrtko.ursulin@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211004143650.699120-1-tvrtko.ursulin@linux.intel.com>
References: <20211004143650.699120-1-tvrtko.ursulin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

Connect i915 with the process nice change notifier so that our scheduling
can react to runtime adjustments, on top of previously added nice value
inheritance at context create time.

To achieve this we use the previously added map of clients per owning
tasks in combination with the list of GEM contexts per client.

To avoid possibly unnecessary complications the updated context nice value
will only apply to future submissions against the context.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
---
 drivers/gpu/drm/i915/i915_drm_client.c | 31 ++++++++++++++++++++++++++
 drivers/gpu/drm/i915/i915_drm_client.h |  3 +++
 2 files changed, 34 insertions(+)

diff --git a/drivers/gpu/drm/i915/i915_drm_client.c b/drivers/gpu/drm/i915/i915_drm_client.c
index 82b9636482ef..e34c1228f65b 100644
--- a/drivers/gpu/drm/i915/i915_drm_client.c
+++ b/drivers/gpu/drm/i915/i915_drm_client.c
@@ -7,10 +7,35 @@
 #include <linux/slab.h>
 #include <linux/types.h>
 
+#include "gem/i915_gem_context.h"
 #include "i915_drm_client.h"
 #include "i915_gem.h"
 #include "i915_utils.h"
 
+static int
+clients_notify(struct notifier_block *nb, unsigned long val, void *ptr)
+{
+	struct i915_drm_clients *clients =
+		container_of(nb, typeof(*clients), prio_notifier);
+	struct i915_drm_client *client;
+
+	rcu_read_lock();
+	read_lock(&clients->lock);
+	hash_for_each_possible(clients->tasks, client, node, (uintptr_t)ptr) {
+		struct i915_gem_context *ctx;
+
+		if (client->owner != ptr)
+			continue;
+
+		list_for_each_entry_rcu(ctx, &client->ctx_list, client_link)
+			ctx->sched.nice = (int)val;
+	}
+	read_unlock(&clients->lock);
+	rcu_read_unlock();
+
+	return NOTIFY_DONE;
+}
+
 void i915_drm_clients_init(struct i915_drm_clients *clients,
 			   struct drm_i915_private *i915)
 {
@@ -21,6 +46,10 @@ void i915_drm_clients_init(struct i915_drm_clients *clients,
 
 	rwlock_init(&clients->lock);
 	hash_init(clients->tasks);
+
+	memset(&clients->prio_notifier, 0, sizeof(clients->prio_notifier));
+	clients->prio_notifier.notifier_call = clients_notify;
+	register_user_nice_notifier(&clients->prio_notifier);
 }
 
 struct i915_drm_client *i915_drm_client_add(struct i915_drm_clients *clients)
@@ -75,6 +104,8 @@ void __i915_drm_client_free(struct kref *kref)
 
 void i915_drm_clients_fini(struct i915_drm_clients *clients)
 {
+	unregister_user_nice_notifier(&clients->prio_notifier);
+
 	GEM_BUG_ON(!xa_empty(&clients->xarray));
 	xa_destroy(&clients->xarray);
 }
diff --git a/drivers/gpu/drm/i915/i915_drm_client.h b/drivers/gpu/drm/i915/i915_drm_client.h
index 42fd79f0558a..dda26aa42ac9 100644
--- a/drivers/gpu/drm/i915/i915_drm_client.h
+++ b/drivers/gpu/drm/i915/i915_drm_client.h
@@ -9,6 +9,7 @@
 #include <linux/hashtable.h>
 #include <linux/kref.h>
 #include <linux/list.h>
+#include <linux/notifier.h>
 #include <linux/rwlock.h>
 #include <linux/sched.h>
 #include <linux/spinlock.h>
@@ -24,6 +25,8 @@ struct i915_drm_clients {
 
 	rwlock_t lock;
 	DECLARE_HASHTABLE(tasks, 6);
+
+	struct notifier_block prio_notifier;
 };
 
 struct i915_drm_client {
-- 
2.30.2

