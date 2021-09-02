Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFDA3FF7C0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 01:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348046AbhIBXTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 19:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348008AbhIBXT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 19:19:29 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFDEBC0613D9
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 16:18:23 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 83-20020a251956000000b0059948f541cbso4601054ybz.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 16:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2WeVbVbWOPeuv0gWvnGWonjb29LnYgYvNCL7xfEPtdY=;
        b=NoG5gDVRZUZYLkdC69Sge1tzAFdVFrOxSUsQmNoV7vq2oPpVIqlb+HOfTG82C4naOr
         jM1gXNN8XQlG07S3EOmUFQeuW1gcZeMofaHUWf2X0D7KtYK6uu2G8yGo2/xWC1lTNSwo
         3XykedzRYzlPtOajU5eolPet7ggw5AcdnKyDSNXx3+VW0kP5cMzhHIbzKrtNUH7dFi74
         NsJTO4DdVMDLj6LPkU1JJ+9ipLZSLQYeZPvsanhW7gwHaAt/pwZ3Iw/hVI3ZBBkC/FiO
         QJaukd56F+4VO22aIJCQnoxwGH5vz06cy42IXEyNcyun0Xwm3HowQKsAM8wKJruV40SO
         EaKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2WeVbVbWOPeuv0gWvnGWonjb29LnYgYvNCL7xfEPtdY=;
        b=OSNcAdrYz/Z5njGCrNyoqNScx+L6wpLtEl+ELM6Veto53VAbZuGOFrOhdK8o2RGXTv
         4n9rIa8LGWM1tXSxmW+nIEWgOiToNikKZ4gkxch8LiXIhHX7Uu1RLIyeWORbIYAawJSP
         rWSXP1ACGnhdp0ULIcdqZu9YXLKNrOUsllqAvvnEPOdjylVGBFjdFrpTmkZu3gk0Gejf
         fkGIbtdcT8eX61doUutXNVcOhEJmG0e0bmKpMqFkHMsAoUzGwlvonW71H2mM99B4isJY
         Fem9GXpAvAJH8ZwrTxesUVVz72DaaPcdmeFJqcU+Z/0tO28AQ5P+9mGMioYfmk/rMDIc
         QFvg==
X-Gm-Message-State: AOAM530L4QMCGMEpXk7rW8H0HtriyjORSUT6fdNExjjbQ/LFDX7hn/g+
        rLToNnS1KDcZZgha7JTR2JwrGe/WhBM=
X-Google-Smtp-Source: ABdhPJwK63IjY6KzOIWvlD0gI/A4jV/zg48XzkYrNXuNNAJPEQrVXYoi9ip/wNDPu5W6DlX0NSnCCeySU+w=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:556f:98c8:f567:be6])
 (user=surenb job=sendgmr) by 2002:a25:2008:: with SMTP id g8mr1057773ybg.502.1630624703097;
 Thu, 02 Sep 2021 16:18:23 -0700 (PDT)
Date:   Thu,  2 Sep 2021 16:18:13 -0700
In-Reply-To: <20210902231813.3597709-1-surenb@google.com>
Message-Id: <20210902231813.3597709-3-surenb@google.com>
Mime-Version: 1.0
References: <20210902231813.3597709-1-surenb@google.com>
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24-goog
Subject: [PATCH v9 3/3] mm: add anonymous vma name refcounting
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     ccross@google.com, sumit.semwal@linaro.org, mhocko@suse.com,
        dave.hansen@intel.com, keescook@chromium.org, willy@infradead.org,
        kirill.shutemov@linux.intel.com, vbabka@suse.cz,
        hannes@cmpxchg.org, corbet@lwn.net, viro@zeniv.linux.org.uk,
        rdunlap@infradead.org, kaleshsingh@google.com, peterx@redhat.com,
        rppt@kernel.org, peterz@infradead.org, catalin.marinas@arm.com,
        vincenzo.frascino@arm.com, chinwen.chang@mediatek.com,
        axelrasmussen@google.com, aarcange@redhat.com, jannh@google.com,
        apopple@nvidia.com, jhubbard@nvidia.com, yuzhao@google.com,
        will@kernel.org, fenghua.yu@intel.com, thunder.leizhen@huawei.com,
        hughd@google.com, feng.tang@intel.com, jgg@ziepe.ca, guro@fb.com,
        tglx@linutronix.de, krisman@collabora.com, chris.hyser@oracle.com,
        pcc@google.com, ebiederm@xmission.com, axboe@kernel.dk,
        legion@kernel.org, eb@emlix.com, gorcunov@gmail.com,
        songmuchun@bytedance.com, viresh.kumar@linaro.org,
        thomascedeno@google.com, sashal@kernel.org, cxfcosmos@gmail.com,
        linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@android.com, surenb@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While forking a process with high number (64K) of named anonymous vmas the
overhead caused by strdup() is noticeable. Experiments with ARM64 Android
device show up to 40% performance regression when forking a process with
64k unpopulated anonymous vmas using the max name lengths vs the same
process with the same number of anonymous vmas having no name.
Introduce anon_vma_name refcounted structure to avoid the overhead of
copying vma names during fork() and when splitting named anonymous vmas.
When a vma is duplicated, instead of copying the name we increment the
refcount of this structure. Multiple vmas can point to the same
anon_vma_name as long as they increment the refcount. The name member of
anon_vma_name structure is assigned at structure allocation time and is
never changed. If vma name changes then the refcount of the original
structure is dropped, a new anon_vma_name structure is allocated
to hold the new name and the vma pointer is updated to point to the new
structure.
With this approach the fork() performance regressions is reduced 3-4x
times and with usecases using more reasonable number of VMAs (a few
thousand) the regressions is not measurable.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
previous version including cover letter with test results is at:
https://lore.kernel.org/linux-mm/20210827191858.2037087-1-surenb@google.com/

changes in v9
- Replaced kzalloc with kmalloc in anon_vma_name_alloc, per Rolf Eike Beer

 include/linux/mm_types.h |  9 ++++++++-
 mm/madvise.c             | 43 +++++++++++++++++++++++++++++++++-------
 2 files changed, 44 insertions(+), 8 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 968a1d0463d8..7feb43daee6c 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -5,6 +5,7 @@
 #include <linux/mm_types_task.h>
 
 #include <linux/auxvec.h>
+#include <linux/kref.h>
 #include <linux/list.h>
 #include <linux/spinlock.h>
 #include <linux/rbtree.h>
@@ -310,6 +311,12 @@ struct vm_userfaultfd_ctx {
 struct vm_userfaultfd_ctx {};
 #endif /* CONFIG_USERFAULTFD */
 
+struct anon_vma_name {
+	struct kref kref;
+	/* The name needs to be at the end because it is dynamically sized. */
+	char name[];
+};
+
 /*
  * This struct describes a virtual memory area. There is one of these
  * per VM-area/task. A VM area is any part of the process virtual memory
@@ -361,7 +368,7 @@ struct vm_area_struct {
 			unsigned long rb_subtree_last;
 		} shared;
 		/* Serialized by mmap_sem. */
-		char *anon_name;
+		struct anon_vma_name *anon_name;
 	};
 
 	/*
diff --git a/mm/madvise.c b/mm/madvise.c
index 0c6d0f64d432..adc53edd3fe7 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -63,6 +63,28 @@ static int madvise_need_mmap_write(int behavior)
 	}
 }
 
+static struct anon_vma_name *anon_vma_name_alloc(const char *name)
+{
+	struct anon_vma_name *anon_name;
+	size_t len = strlen(name);
+
+	/* Add 1 for NUL terminator at the end of the anon_name->name */
+	anon_name = kmalloc(sizeof(*anon_name) + len + 1, GFP_KERNEL);
+	if (anon_name) {
+		kref_init(&anon_name->kref);
+		strcpy(anon_name->name, name);
+	}
+
+	return anon_name;
+}
+
+static void vma_anon_name_free(struct kref *kref)
+{
+	struct anon_vma_name *anon_name =
+			container_of(kref, struct anon_vma_name, kref);
+	kfree(anon_name);
+}
+
 static inline bool has_vma_anon_name(struct vm_area_struct *vma)
 {
 	return !vma->vm_file && vma->anon_name;
@@ -75,7 +97,7 @@ const char *vma_anon_name(struct vm_area_struct *vma)
 
 	mmap_assert_locked(vma->vm_mm);
 
-	return vma->anon_name;
+	return vma->anon_name->name;
 }
 
 void dup_vma_anon_name(struct vm_area_struct *orig_vma,
@@ -84,37 +106,44 @@ void dup_vma_anon_name(struct vm_area_struct *orig_vma,
 	if (!has_vma_anon_name(orig_vma))
 		return;
 
-	new_vma->anon_name = kstrdup(orig_vma->anon_name, GFP_KERNEL);
+	kref_get(&orig_vma->anon_name->kref);
+	new_vma->anon_name = orig_vma->anon_name;
 }
 
 void free_vma_anon_name(struct vm_area_struct *vma)
 {
+	struct anon_vma_name *anon_name;
+
 	if (!has_vma_anon_name(vma))
 		return;
 
-	kfree(vma->anon_name);
+	anon_name = vma->anon_name;
 	vma->anon_name = NULL;
+	kref_put(&anon_name->kref, vma_anon_name_free);
 }
 
 /* mmap_lock should be write-locked */
 static int replace_vma_anon_name(struct vm_area_struct *vma, const char *name)
 {
+	const char *anon_name;
+
 	if (!name) {
 		free_vma_anon_name(vma);
 		return 0;
 	}
 
-	if (vma->anon_name) {
+	anon_name = vma_anon_name(vma);
+	if (anon_name) {
 		/* Should never happen, to dup use dup_vma_anon_name() */
-		WARN_ON(vma->anon_name == name);
+		WARN_ON(anon_name == name);
 
 		/* Same name, nothing to do here */
-		if (!strcmp(name, vma->anon_name))
+		if (!strcmp(name, anon_name))
 			return 0;
 
 		free_vma_anon_name(vma);
 	}
-	vma->anon_name = kstrdup(name, GFP_KERNEL);
+	vma->anon_name = anon_vma_name_alloc(name);
 	if (!vma->anon_name)
 		return -ENOMEM;
 
-- 
2.33.0.153.gba50c8fa24-goog

