Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B48535923F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 04:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbhDICy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 22:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbhDICy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 22:54:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8BC2C061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 19:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=beEidYj5HqBklT5YHQ/YB4yuKaRShJ1XHQtoMRZj1F4=; b=CN+EZ4LRo5Nxaqn38JyCdT9ozs
        rGd04D1G81D4d3jIrfJfaZfH2gFTq57n/eqAGXuCjjwr1XDYloERAj0VD0Uliv6qrA1JXK2vMxJ5W
        S0riWzjTmNOqSZcD4FbDeZOXPnGAlBabRPiMWvSR0FsdwtPbbLcOowjLwVDo9W0QoT4jutioqkjkq
        K4rnvtfsN4ZGninMRgusJi6F7nngcWOjC4vECikqwiTKZmFIWIrf05AC9LtO3GMh6jBpBWM9+TRId
        U2LhIb6J60s3VH0zGqAXLRHEXkYhb3/fs7zd68kBPJyG5JFVdAPEHv6S+j4HxT7xpFPaPmu1y50QV
        buNigAOg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lUhGG-00HGL9-8p; Fri, 09 Apr 2021 02:52:50 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     neilb@suse.de, peterz@infradead.org, mingo@redhat.com,
        will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
        tglx@linutronix.de, bigeasy@linutronix.de
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/17] locking: Add split_lock
Date:   Fri,  9 Apr 2021 03:51:16 +0100
Message-Id: <20210409025131.4114078-3-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210409025131.4114078-1-willy@infradead.org>
References: <20210409025131.4114078-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bitlocks do not currently participate in lockdep.  Conceptually, a
bit_spinlock is a split lock, eg across each bucket in a hash table.
The struct split_lock gives us somewhere to record the lockdep_map.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/split_lock.h | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 include/linux/split_lock.h

diff --git a/include/linux/split_lock.h b/include/linux/split_lock.h
new file mode 100644
index 000000000000..8d64cfa0bbad
--- /dev/null
+++ b/include/linux/split_lock.h
@@ -0,0 +1,37 @@
+#ifndef _LINUX_SPLIT_LOCK_H
+#define _LINUX_SPLIT_LOCK_H
+
+#include <linux/lockdep_types.h>
+
+struct split_lock {
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	struct lockdep_map dep_map;
+#endif
+};
+
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+#define SPLIT_DEP_MAP_INIT(lockname)					\
+	.dep_map = {							\
+		.name = #lockname,					\
+		.wait_type_inner = LD_WAIT_SPIN,			\
+	}
+#else
+#define SPLIT_DEP_MAP_INIT(lockname)
+#endif
+
+#define DEFINE_SPLIT_LOCK(name)						\
+struct split_lock name = {						\
+	SPLIT_DEP_MAP_INIT(name)					\
+};
+
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+#define split_lock_init(_lock) do {					\
+	static struct lock_class_key __key;				\
+	lockdep_init_map_wait(&(_lock)->dep_map, #_lock, &__key, 0,	\
+				LD_WAIT_SPIN);				\
+} while (0)
+#else
+static inline void split_lock_init(struct split_lock *sl) { }
+#endif
+
+#endif /* _LINUX_SPLIT_LOCK_H */
-- 
2.30.2

