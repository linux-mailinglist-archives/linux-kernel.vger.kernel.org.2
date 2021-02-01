Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8E730A91E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 14:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbhBANxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 08:53:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbhBANxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 08:53:35 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE13C061573
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 05:52:54 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id p20so5121565ejb.6
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 05:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f3aoNP/UNDvRkwGL1r5Sg7SiQ3sA0buxSxRtNg++7Ys=;
        b=G+uULoz+05uwHowVW3SK5MK/KUUUsw2G0FploAiNOQoWERLTOeJaW20sD5iA1pgUL2
         YDrNCanT5TILQOPGFzXfOBWDLQBPjuYj8VSk09Q1V4YxYidBjciuUHHGOOB680nClAIW
         QuC2iUfaA6no1ZiZ96VCOyGijW6V+Le/14lxDsg37j5U0iS6jjhZRvM8XqUqJBTf+X/q
         +bxrHNszoGwqkjygovvQsDom/sMw/UwJKH8duFI1bOsREBlz8BrQ7E0HsE3vG2sOJh7O
         MZjayjQn+dF/2tWfbdRkBkFrax7s0ogMzvH468r6miodYFjfGiXmeFbw8u79LqknF9dZ
         No0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f3aoNP/UNDvRkwGL1r5Sg7SiQ3sA0buxSxRtNg++7Ys=;
        b=nBbZ8kXX2zg14rsXX6xXrdWUY85dIjW9S8pS5MUfv2z86lW4WFZedFh7z9zijPNOef
         qSYmdzKGE6PjEKrjKVSA1MqnZRJa3Dq3VA6/JI9UMp+sE+6KCk1Cfvjm2g8LiZLEWE65
         +rYDsvCahPhrfb1Z9uyTPFGhmL1jNlp9AC/saG0xvcOtL76XoeJ75H5vL+skdNJO4hkI
         nrgHeDrReAKH10gUniSJvyemY3WrbK7swIUINpg9UK0AfDZi8W5YKn36XNoTF6Xr3POQ
         GuQLkZ0uk1bt0e1kPxh2WUZFiDFOZabeIRum1To17s+gnWjXIc2n+hCDWtGkUH+GJlmr
         sHdg==
X-Gm-Message-State: AOAM530wYJbY1HcyR8g/A/o9ZwAOzsHeHTtva16iLHRgPJPdU/4IJSI7
        CiiwacGESFZOurDk6lNwZ0A=
X-Google-Smtp-Source: ABdhPJzXJeaLB12sMvvZT/FjTQUqekRW1rrdHmAAHzN25RGT+W1/uAvfbzeAmP6mjexjJIJB3yBuCg==
X-Received: by 2002:a17:906:1741:: with SMTP id d1mr18142103eje.182.1612187573731;
        Mon, 01 Feb 2021 05:52:53 -0800 (PST)
Received: from abel.fritz.box ([2a02:908:1252:fb60:5339:66ca:31c4:4009])
        by smtp.gmail.com with ESMTPSA id y59sm8948505ede.59.2021.02.01.05.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 05:52:52 -0800 (PST)
From:   "=?UTF-8?q?Christian=20K=C3=B6nig?=" 
        <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
To:     mojha@codeaurora.org, jkosina@suse.cz, cezary.rojewski@intel.com,
        neilb@suse.com, b00073877@aus.edu,
        andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org
Subject: [PATCH] list: add more extensive double add check
Date:   Mon,  1 Feb 2021 14:52:51 +0100
Message-Id: <20210201135251.1884-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding the same element to a linked list multiple times
seems to be a rather common programming mistake. To debug
those I've more than once written some code to check a
linked list for duplicates.

Since re-inventing the wheel over and over again is a bad
idea this patch tries to add some common code which allows
to check linked lists for duplicates while adding new
elements.

When list debugging is enabled we currently already check
the previous and next element if they are identical to the
new one. This patch now adds a configuration option to
check N elements before and after the desired position.

By default we still only test one item since testing more
means quite a large CPU overhead. This can be overwritten
on a per C file bases by defining DEBUG_LIST_DOUBLE_ADD
before including list.h.

A new kunit test is also added to the existing list tests
which intentionally triggers the debug functionality.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 include/linux/list.h    | 18 +++++++++++++++---
 include/linux/rculist.h |  2 +-
 lib/Kconfig.debug       | 14 ++++++++++++++
 lib/list-test.c         | 27 +++++++++++++++++++++++++++
 lib/list_debug.c        | 26 +++++++++++++++++++++-----
 5 files changed, 78 insertions(+), 9 deletions(-)

diff --git a/include/linux/list.h b/include/linux/list.h
index 89bdc92e75c3..e772e5e7c96d 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -37,14 +37,26 @@ static inline void INIT_LIST_HEAD(struct list_head *list)
 }
 
 #ifdef CONFIG_DEBUG_LIST
+
+#ifndef DEBUG_LIST_DOUBLE_ADD
+#define DEBUG_LIST_DOUBLE_ADD CONFIG_DEBUG_LIST_DOUBLE_ADD
+#endif
+
 extern bool __list_add_valid(struct list_head *new,
 			      struct list_head *prev,
-			      struct list_head *next);
+			      struct list_head *next,
+			      int num_entries);
 extern bool __list_del_entry_valid(struct list_head *entry);
 #else
+
+#ifndef DEBUG_LIST_DOUBLE_ADD
+#define DEBUG_LIST_DOUBLE_ADD 0
+#endif
+
 static inline bool __list_add_valid(struct list_head *new,
 				struct list_head *prev,
-				struct list_head *next)
+				struct list_head *next,
+				int num_entries)
 {
 	return true;
 }
@@ -64,7 +76,7 @@ static inline void __list_add(struct list_head *new,
 			      struct list_head *prev,
 			      struct list_head *next)
 {
-	if (!__list_add_valid(new, prev, next))
+	if (!__list_add_valid(new, prev, next, DEBUG_LIST_DOUBLE_ADD))
 		return;
 
 	next->prev = new;
diff --git a/include/linux/rculist.h b/include/linux/rculist.h
index f8633d37e358..186618ad11d9 100644
--- a/include/linux/rculist.h
+++ b/include/linux/rculist.h
@@ -85,7 +85,7 @@ static inline void INIT_LIST_HEAD_RCU(struct list_head *list)
 static inline void __list_add_rcu(struct list_head *new,
 		struct list_head *prev, struct list_head *next)
 {
-	if (!__list_add_valid(new, prev, next))
+	if (!__list_add_valid(new, prev, next, DEBUG_LIST_DOUBLE_ADD))
 		return;
 
 	new->next = next;
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index e6e58b26e888..ded75214ea76 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1508,6 +1508,20 @@ config DEBUG_LIST
 
 	  If unsure, say N.
 
+config DEBUG_LIST_DOUBLE_ADD
+	int "How many list entries are checked for double adds"
+	depends on DEBUG_LIST
+	default 1
+	help
+	  Controls how many list entries are checked while adding new ones.
+	  Larger values catch more double adds, but reduce the performance
+	  massively.
+
+	  Can be overwritten locally in a C file by defining
+	  DEBUG_LIST_DOUBLE_ADD to an arbitrary value.
+
+	  If unsure, say 1.
+
 config DEBUG_PLIST
 	bool "Debug priority linked list manipulation"
 	depends on DEBUG_KERNEL
diff --git a/lib/list-test.c b/lib/list-test.c
index ee09505df16f..05174051977b 100644
--- a/lib/list-test.c
+++ b/lib/list-test.c
@@ -5,6 +5,9 @@
  * Copyright (C) 2019, Google LLC.
  * Author: David Gow <davidgow@google.com>
  */
+
+#define DEBUG_LIST_DOUBLE_ADD 4
+
 #include <kunit/test.h>
 
 #include <linux/list.h>
@@ -698,6 +701,27 @@ static void list_test_list_for_each_entry_reverse(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, i, -1);
 }
 
+
+#ifdef CONFIG_DEBUG_LIST
+static void list_test_list_double_add(struct kunit *test)
+{
+	struct list_head entries[DEBUG_LIST_DOUBLE_ADD];
+	LIST_HEAD(list);
+	int i;
+
+	for (i = 0; i < DEBUG_LIST_DOUBLE_ADD; ++i)
+		list_add_tail(&entries[i], &list);
+
+	/* Intentionally double add the first one, this should be catched and
+	 * prevented by the list debug code.
+	 */
+	list_add_tail(&entries[0], &list);
+
+	KUNIT_EXPECT_PTR_EQ(test, entries[0].next, &entries[1]);
+	KUNIT_EXPECT_PTR_EQ(test, entries[0].prev, &list);
+}
+#endif
+
 static struct kunit_case list_test_cases[] = {
 	KUNIT_CASE(list_test_list_init),
 	KUNIT_CASE(list_test_list_add),
@@ -735,6 +759,9 @@ static struct kunit_case list_test_cases[] = {
 	KUNIT_CASE(list_test_list_for_each_prev_safe),
 	KUNIT_CASE(list_test_list_for_each_entry),
 	KUNIT_CASE(list_test_list_for_each_entry_reverse),
+#ifdef CONFIG_DEBUG_LIST
+	KUNIT_CASE(list_test_list_double_add),
+#endif
 	{},
 };
 
diff --git a/lib/list_debug.c b/lib/list_debug.c
index 5d5424b51b74..df378b6ad3df 100644
--- a/lib/list_debug.c
+++ b/lib/list_debug.c
@@ -18,19 +18,35 @@
  */
 
 bool __list_add_valid(struct list_head *new, struct list_head *prev,
-		      struct list_head *next)
+		      struct list_head *next, int num_entries)
 {
+	struct list_head *tmp;
+	int cnt;
+
 	if (CHECK_DATA_CORRUPTION(next->prev != prev,
 			"list_add corruption. next->prev should be prev (%px), but was %px. (next=%px).\n",
 			prev, next->prev, next) ||
 	    CHECK_DATA_CORRUPTION(prev->next != next,
 			"list_add corruption. prev->next should be next (%px), but was %px. (prev=%px).\n",
-			next, prev->next, prev) ||
-	    CHECK_DATA_CORRUPTION(new == prev || new == next,
-			"list_add double add: new=%px, prev=%px, next=%px.\n",
-			new, prev, next))
+			next, prev->next, prev))
 		return false;
 
+	for (cnt = 0, tmp = prev; cnt < num_entries && tmp != next;
+	     ++cnt, tmp = tmp->prev)
+		if (CHECK_DATA_CORRUPTION(new == tmp,
+				"list_add double add: new=%px, prev=%px, next=%px.\n",
+				new, prev, next))
+			return false;
+
+	if (tmp == next)
+		return true;
+
+	for (cnt = 0, tmp = next; cnt < num_entries; ++cnt, tmp = tmp->next)
+		if (CHECK_DATA_CORRUPTION(new == tmp,
+				"list_add double add: new=%px, prev=%px, next=%px.\n",
+				new, prev, next))
+			return false;
+
 	return true;
 }
 EXPORT_SYMBOL(__list_add_valid);
-- 
2.25.1

