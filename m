Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 883C23F9FF8
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 21:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbhH0TUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 15:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbhH0TUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 15:20:30 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5673C061224
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 12:19:13 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id b4-20020a3799040000b02903b899a4309cso1078922qke.14
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 12:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=92AD8OF4VIc1rlAFfcwW/pEz9e2egvqx/M9b8ZJAWpE=;
        b=U1r28Zn21CMYH1IWX1+CqiQPJum6eut/4WKOlqpJA4LXxU9BnjStINa9tWEQcyXqdA
         2GC8K6g8qxZzYAtsKLExS6CTUdnrmUNotKOsIsb8oPbJKmVBL3yOh1aM/fZMmT7DTQKx
         5FzYiOnBP4AFk1fM85v+rgAhdRIMmMctyf+b3QmPgeuh4IvzQxWVbmQs5sIMV1fbgJUO
         AWFMVLC+J00Jqn+jxZcgPCFZoxkthxgzrpI0Mb32Hax6smgI2qnnC+rWNH4fk6/jGYrp
         0+JMPysJ0sLFnfoeUGacmt+92YG19EERqdizt0rUcvnkDJziPqvDp39iiFIhvJv2n+zA
         s1XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=92AD8OF4VIc1rlAFfcwW/pEz9e2egvqx/M9b8ZJAWpE=;
        b=ls6d4hPHplIf+9NrITovagfyYLx8JDzQJIHJDkLJ6/N7e85+ZEglJGri0BciLkvW/N
         LDn/B68LIdoKEvZu9IJk4ICKKsVloLwgtaqxXh+4/PK3MuNLS+Vi9vKqDdsEi/Baaa26
         auUHZ1e+3GFroM72sBr9M9YctgOGuyrk8Hq7peM+5cG+KYTww6KUUsAjayKuQeTgT6RE
         je/OeEyobgoRfn4iM2SGnmT3CxBwwhiyxBgYuniRgsu056vGPX5QuPrqLHdX9nlUSQhZ
         TQzebdK65XNGJzRF5Qx4IOdkp/gjzzSaxue8a/DWwjCPV4SUgPxR/KGzScP3qXDHcYHR
         4g/A==
X-Gm-Message-State: AOAM532BiZsBenUz2LiYOh+dz42SQMBgHWcYBJyaI+Jfb1AuYXvlaX09
        EV2oObrdVU2moxDapcx3UHNJ6rridnk=
X-Google-Smtp-Source: ABdhPJwT8bSKRR/90ZvLEsSj8F7NXY06PlZN4un4/T72i/BmMxtmSrmqf3pUsR2YfyBD8tO+04YlzB+EGKU=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:fd8e:f32b:a64b:dd89])
 (user=surenb job=sendgmr) by 2002:a05:6214:762:: with SMTP id
 f2mr11382474qvz.48.1630091952884; Fri, 27 Aug 2021 12:19:12 -0700 (PDT)
Date:   Fri, 27 Aug 2021 12:18:58 -0700
In-Reply-To: <20210827191858.2037087-1-surenb@google.com>
Message-Id: <20210827191858.2037087-4-surenb@google.com>
Mime-Version: 1.0
References: <20210827191858.2037087-1-surenb@google.com>
X-Mailer: git-send-email 2.33.0.259.gc128427fd7-goog
Subject: [PATCH v8 3/3] mm: add anonymous vma name refcounting
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
        legion@kernel.org, eb@emlix.com, songmuchun@bytedance.com,
        viresh.kumar@linaro.org, thomascedeno@google.com,
        sashal@kernel.org, cxfcosmos@gmail.com, linux@rasmusvillemoes.dk,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        kernel-team@android.com, surenb@google.com
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
 include/linux/mm_types.h |  9 ++++++++-
 mm/madvise.c             | 42 +++++++++++++++++++++++++++++++++-------
 2 files changed, 43 insertions(+), 8 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 26a30f7a5228..a7361acf2921 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -5,6 +5,7 @@
 #include <linux/mm_types_task.h>
 
 #include <linux/auxvec.h>
+#include <linux/kref.h>
 #include <linux/list.h>
 #include <linux/spinlock.h>
 #include <linux/rbtree.h>
@@ -302,6 +303,12 @@ struct vm_userfaultfd_ctx {
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
@@ -353,7 +360,7 @@ struct vm_area_struct {
 			unsigned long rb_subtree_last;
 		} shared;
 		/* Serialized by mmap_sem. */
-		char *anon_name;
+		struct anon_vma_name *anon_name;
 	};
 
 	/*
diff --git a/mm/madvise.c b/mm/madvise.c
index bc029f3fca6a..32ac5dc5ebf3 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -63,6 +63,27 @@ static int madvise_need_mmap_write(int behavior)
 	}
 }
 
+static struct anon_vma_name *anon_vma_name_alloc(const char *name)
+{
+	struct anon_vma_name *anon_name;
+	size_t len = strlen(name);
+
+	/* Add 1 for NUL terminator at the end of the anon_name->name */
+	anon_name = kzalloc(sizeof(*anon_name) + len + 1,
+			    GFP_KERNEL);
+	kref_init(&anon_name->kref);
+	strcpy(anon_name->name, name);
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
@@ -75,7 +96,7 @@ const char *vma_anon_name(struct vm_area_struct *vma)
 
 	mmap_assert_locked(vma->vm_mm);
 
-	return vma->anon_name;
+	return vma->anon_name->name;
 }
 
 void dup_vma_anon_name(struct vm_area_struct *orig_vma,
@@ -84,37 +105,44 @@ void dup_vma_anon_name(struct vm_area_struct *orig_vma,
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
 static void replace_vma_anon_name(struct vm_area_struct *vma, const char *name)
 {
+	const char *anon_name;
+
 	if (!name) {
 		free_vma_anon_name(vma);
 		return;
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
 			return;
 
 		free_vma_anon_name(vma);
 	}
-	vma->anon_name = kstrdup(name, GFP_KERNEL);
+	vma->anon_name = anon_vma_name_alloc(name);
 }
 
 /*
-- 
2.33.0.259.gc128427fd7-goog

