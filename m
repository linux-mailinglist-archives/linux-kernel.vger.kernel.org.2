Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 088B831A5D0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 21:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbhBLUJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 15:09:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbhBLUJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 15:09:40 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3003C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 12:08:59 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id b62so495154wmc.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 12:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=Yt8QroauzMxSaO8dfOJkOemr7RXc+gc/JDflCqQTAVk=;
        b=ri92KeJxTQmZDYwPc9CI1JAo1D1ryQFfgFIYBWpGFyAFqMNYOwh0bVZZOtPBYCHINt
         JXq4uovQhwEBqXp4m8r22GMI+KUzbMp8Y6em6kYTTic5PPM9dub7i9oEcNJg03qdaq1y
         rZkB1N85zdJ2cXshg3MTsu6LH141DL+75izXKKm5zhrJNEtD47qXcIkCkiwz/V5XYVHS
         WdVc/9cKFurKK/3wO6ckHf472nbQJbhXXDeOLDPSaXO9q96LV65Q0SFPY9aDjJWe7C8x
         jW3i6gT2DM5ik1XqbZEeq/gILY+Rx9FKfkd0yl26m1c18hXQoVvczc8tOxmxQhVzjntb
         U8ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=Yt8QroauzMxSaO8dfOJkOemr7RXc+gc/JDflCqQTAVk=;
        b=Bd29h/wKKQAnlTUPlrsafnJkeEytZPimFAIVmZTJj/2KFIk5ANgMhIz4+gRpCUK2xs
         UvX0BagoPq2xwYEpNwDYAs8qjgNN7P9V6bEdhGCsaAMcuLQkSHIMvGI5WMR52WU4Bjl8
         L3+zIG1hFlhOKaJOZ1rc6VrzsMibwaSS2hn/dVdDp4YABBYiImi9VoVXXn4HBuQmfWVJ
         86nUZa/fM/mmRss2crx6NpyJA7eeMbBcram0Dtchy5ORvL1d9k9D7oOA1brf4xvgtskH
         NwFc7it9IG4kSOpCgteuSJvOrByHHUn6p2h597hnx0z7zei1cSmuidxejuV/fdJ5zuLm
         MtHw==
X-Gm-Message-State: AOAM532czSfdrf7KLNRn6XkKKvDaoJirftbYn7SZsXqdaYERSfn4EQ8K
        3LvZYtGei1D2spLzydy8fj13A8pjKIAd9WOR
X-Google-Smtp-Source: ABdhPJzE2cAe228eOqgK3Bsnp2vYCX8C+miv+96QZ9bSkzK8DaWHuZTD+wNAnyJPdbflLU6JRbQ5zCku4iMbjMUW
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:19dd:6137:bedc:2fae])
 (user=andreyknvl job=sendgmr) by 2002:a1c:3546:: with SMTP id
 c67mr2778wma.1.1613160536016; Fri, 12 Feb 2021 12:08:56 -0800 (PST)
Date:   Fri, 12 Feb 2021 21:08:52 +0100
Message-Id: <e7eeb252da408b08f0c81b950a55fb852f92000b.1613155970.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH mm] kasan: export HW_TAGS symbols for KUnit tests
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, building KASAN-KUnit tests as a module fails with:

ERROR: modpost: "mte_enable_kernel" [lib/test_kasan.ko] undefined!
ERROR: modpost: "mte_set_report_once" [lib/test_kasan.ko] undefined!

This change adds KASAN wrappers for mte_enable_kernel() and
mte_set_report_once() and only defines and exports them when KASAN-KUnit
tests are enabled.

The wrappers aren't defined when tests aren't enabled to avoid misuse.
The mte_() functions aren't exported directly to avoid having low-level
KASAN ifdefs in the arch code.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

---

Changes v1->v2:
- Add wrappers instead of exporting MTE symbols directly.
- Only define and export wrappers when KASAN-KUnit tests are enabled.

---
 lib/test_kasan.c   |  6 +++---
 mm/kasan/hw_tags.c | 16 ++++++++++++++++
 mm/kasan/kasan.h   | 12 ++++++++++++
 3 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index 1328c468fdb5..e5647d147b35 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -53,13 +53,13 @@ static int kasan_test_init(struct kunit *test)
 	}
 
 	multishot = kasan_save_enable_multi_shot();
-	hw_set_tagging_report_once(false);
+	kasan_set_tagging_report_once(false);
 	return 0;
 }
 
 static void kasan_test_exit(struct kunit *test)
 {
-	hw_set_tagging_report_once(true);
+	kasan_set_tagging_report_once(true);
 	kasan_restore_multi_shot(multishot);
 }
 
@@ -97,7 +97,7 @@ static void kasan_test_exit(struct kunit *test)
 			READ_ONCE(fail_data.report_found));	\
 	if (IS_ENABLED(CONFIG_KASAN_HW_TAGS)) {			\
 		if (READ_ONCE(fail_data.report_found))		\
-			hw_enable_tagging();			\
+			kasan_enable_tagging();			\
 		migrate_enable();				\
 	}							\
 } while (0)
diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
index 1dfe4f62a89e..2aad21fda156 100644
--- a/mm/kasan/hw_tags.c
+++ b/mm/kasan/hw_tags.c
@@ -185,3 +185,19 @@ struct kasan_track *kasan_get_free_track(struct kmem_cache *cache,
 
 	return &alloc_meta->free_track[0];
 }
+
+#if IS_ENABLED(CONFIG_KASAN_KUNIT_TEST)
+
+void kasan_set_tagging_report_once(bool state)
+{
+	hw_set_tagging_report_once(state);
+}
+EXPORT_SYMBOL_GPL(kasan_set_tagging_report_once);
+
+void kasan_enable_tagging(void)
+{
+	hw_enable_tagging();
+}
+EXPORT_SYMBOL_GPL(kasan_enable_tagging);
+
+#endif
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index cc787ba47e1b..3436c6bf7c0c 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -308,6 +308,18 @@ static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
 
 #endif /* CONFIG_KASAN_HW_TAGS */
 
+#if defined(CONFIG_KASAN_HW_TAGS) && IS_ENABLED(CONFIG_KASAN_KUNIT_TEST)
+
+void kasan_set_tagging_report_once(bool state);
+void kasan_enable_tagging(void);
+
+#else /* CONFIG_KASAN_HW_TAGS || CONFIG_KASAN_KUNIT_TEST */
+
+static inline void kasan_set_tagging_report_once(bool state) { }
+static inline void kasan_enable_tagging(void) { }
+
+#endif /* CONFIG_KASAN_HW_TAGS || CONFIG_KASAN_KUNIT_TEST */
+
 #ifdef CONFIG_KASAN_SW_TAGS
 u8 kasan_random_tag(void);
 #elif defined(CONFIG_KASAN_HW_TAGS)
-- 
2.30.0.478.g8a0d178c01-goog

