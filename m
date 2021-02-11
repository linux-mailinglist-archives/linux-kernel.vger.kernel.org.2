Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04F3B3195C3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 23:24:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbhBKWXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 17:23:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbhBKWWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 17:22:13 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF350C061574;
        Thu, 11 Feb 2021 14:21:30 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 2E0561F4604B
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     dhowells@redhat.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH 1/2] watch_queue: Fold info_id initialization into init_watch
Date:   Thu, 11 Feb 2021 17:21:11 -0500
Message-Id: <20210211222112.1518161-2-krisman@collabora.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210211222112.1518161-1-krisman@collabora.com>
References: <20210211222112.1518161-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

info_id needs to be or'ed when initializing a struct watch.  That's an
internal detail to the watch_queue api, so fold that logic into the
watch_queue implementation, instead of replicating it on multiple
callers.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 Documentation/watch_queue.rst | 5 +++--
 include/linux/watch_queue.h   | 2 +-
 kernel/watch_queue.c          | 5 ++++-
 security/keys/keyctl.c        | 3 +--
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/Documentation/watch_queue.rst b/Documentation/watch_queue.rst
index 54f13ad5fc17..426038e10276 100644
--- a/Documentation/watch_queue.rst
+++ b/Documentation/watch_queue.rst
@@ -170,10 +170,11 @@ different ID are ignored.
 
 The following functions are provided to manage watches:
 
-  * ``void init_watch(struct watch *watch, struct watch_queue *wqueue);``
+  * ``void init_watch(struct watch *watch, struct watch_queue *wqueue, int tag);``
 
     Initialise a watch object, setting its pointer to the watch queue, using
-    appropriate barriering to avoid lockdep complaints.
+    appropriate barriering to avoid lockdep complaints. tag is the user
+    provided value returned in the notification's info_id field.
 
   * ``int add_watch_to_object(struct watch *watch, struct watch_list *wlist);``
 
diff --git a/include/linux/watch_queue.h b/include/linux/watch_queue.h
index 2f5a7446bca6..eec43e43de51 100644
--- a/include/linux/watch_queue.h
+++ b/include/linux/watch_queue.h
@@ -82,7 +82,7 @@ extern void __post_watch_notification(struct watch_list *,
 				      u64, const char*, va_list*);
 extern struct watch_queue *get_watch_queue(int);
 extern void put_watch_queue(struct watch_queue *);
-extern void init_watch(struct watch *, struct watch_queue *);
+extern void init_watch(struct watch *, struct watch_queue *, char);
 extern int add_watch_to_object(struct watch *, struct watch_list *);
 extern int remove_watch_from_object(struct watch_list *, struct watch_queue *, u64, bool);
 extern long watch_queue_set_size(struct pipe_inode_info *, unsigned int);
diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
index 89fcf0420ce7..55a730278d3f 100644
--- a/kernel/watch_queue.c
+++ b/kernel/watch_queue.c
@@ -435,14 +435,17 @@ static void put_watch(struct watch *watch)
  * init_watch_queue - Initialise a watch
  * @watch: The watch to initialise.
  * @wqueue: The queue to assign.
+ * @tag: The tag identifying this entry in watch_queues
  *
  * Initialise a watch and set the watch queue.
  */
-void init_watch(struct watch *watch, struct watch_queue *wqueue)
+void init_watch(struct watch *watch, struct watch_queue *wqueue, char tag)
 {
 	kref_init(&watch->usage);
 	INIT_HLIST_NODE(&watch->list_node);
 	INIT_HLIST_NODE(&watch->queue_node);
+	watch->info_id = (u32) tag << WATCH_INFO_ID__SHIFT;
+
 	rcu_assign_pointer(watch->queue, wqueue);
 }
 
diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index 61a614c21b9b..cffabd33d1ca 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -1801,9 +1801,8 @@ long keyctl_watch_key(key_serial_t id, int watch_queue_fd, int watch_id)
 		if (!watch)
 			goto err_wlist;
 
-		init_watch(watch, wqueue);
+		init_watch(watch, wqueue, (char) watch_id);
 		watch->id	= key->serial;
-		watch->info_id	= (u32)watch_id << WATCH_INFO_ID__SHIFT;
 
 		ret = security_watch_key(key);
 		if (ret < 0)
-- 
2.30.0

