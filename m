Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D291831723E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 22:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233508AbhBJVXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 16:23:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233006AbhBJVWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 16:22:39 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA86C0617A9
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 13:22:15 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id r15so2755496qke.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 13:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=GZiDGzBZc6CdQco6utSqJxvMDhSmOX0vGMrGoDVipFA=;
        b=CSNZplzMVyec7GHEIAFJ1eRCsQNhOq/fj6tcy3OeZYMxVQ0KVyYmb0dTEK7zKHFTGS
         yebuUuuasp9KvEVUdZL5opsPRGziEruE1yuW80GOuHJd8OTK/AQMO0URaaXVNWOY9yE4
         XwdwtnodywYIMXJ5E9ykKtwlxvJbCfYQpihPabgZwv1gJm/69Elh2UqDmzr/MRnIhC89
         RrBQfdi3VBH3neG0sO+qFV+9OgWaH109CixY6+ca6R1+eIxQFqRkHSIbkvO6G12QDnrZ
         EclOhkjUfZdpL44LIIw/9EUTZdEtY13TGdzOUzevn0BlDx3rM1E1JbTX41JR1mf0SBsE
         zYoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GZiDGzBZc6CdQco6utSqJxvMDhSmOX0vGMrGoDVipFA=;
        b=GQUs5CbWsaKDRK+Hsjw1oVwM8YIw5CeeHJLh6za/To/L3XkqLxH/osAmxcD+zOlPzH
         B3K7Ef+/qI9BsvjQdgzKXKCtHWOYQcyIf4XkrQyDheKJiaA0PgmDN37zO4Sbryc2KlG8
         MxxUb0oHeoOz2GY7de0EGMJZa4q8CXry95iHA7ZIwq9qCLqQaGzlgsRNN1Od3CgmnC1j
         uEgQTgQ0oIfXOvnYl23bIwVEiI80Y4FLijw7hVqqz30VEeQb9iWMZgei3m4/T3rGI5ye
         /ONDlTMSESkJdIF5g4eO+hNaItRnpdEmau3L2D1l42egUZH6JCuRBa+39VPu/fJHj8BB
         VnnA==
X-Gm-Message-State: AOAM533rDGrmocTros6A/+WfqGuWlj5fLiApbOEldiC3nAELuK1Z/IX6
        Rj5Zl75xlIaGo5sm/gREnAGJ+GHrBtwxDd/4/+lf
X-Google-Smtp-Source: ABdhPJyeUvHSePNxBk4zXDwQilv7B/ls1YQ+N4EzdaCrrLILHIqkJGtRKVUfnXXG71oYRXMNeelVp+MO89+DHWJBPIcN
Sender: "axelrasmussen via sendgmr" <axelrasmussen@ajr0.svl.corp.google.com>
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:94ee:de01:168:9f20])
 (user=axelrasmussen job=sendgmr) by 2002:a0c:fec3:: with SMTP id
 z3mr4869971qvs.52.1612992134367; Wed, 10 Feb 2021 13:22:14 -0800 (PST)
Date:   Wed, 10 Feb 2021 13:21:54 -0800
In-Reply-To: <20210210212200.1097784-1-axelrasmussen@google.com>
Message-Id: <20210210212200.1097784-5-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210210212200.1097784-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH v5 04/10] hugetlb/userfaultfd: Unshare all pmds for hugetlbfs
 when register wp
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Huang Ying <ying.huang@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>,
        Michel Lespinasse <walken@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Xu <peterx@redhat.com>, Shaohua Li <shli@fb.com>,
        Shawn Anastasio <shawn@anastas.io>,
        Steven Rostedt <rostedt@goodmis.org>,
        Steven Price <steven.price@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Adam Ruprecht <ruprecht@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Xu <peterx@redhat.com>

Huge pmd sharing for hugetlbfs is racy with userfaultfd-wp because
userfaultfd-wp is always based on pgtable entries, so they cannot be shared.

Walk the hugetlb range and unshare all such mappings if there is, right before
UFFDIO_REGISTER will succeed and return to userspace.

This will pair with want_pmd_share() in hugetlb code so that huge pmd sharing
is completely disabled for userfaultfd-wp registered range.

Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 fs/userfaultfd.c             | 48 ++++++++++++++++++++++++++++++++++++
 include/linux/mmu_notifier.h |  1 +
 2 files changed, 49 insertions(+)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 0be8cdd4425a..1f4a34b1a1e7 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -15,6 +15,7 @@
 #include <linux/sched/signal.h>
 #include <linux/sched/mm.h>
 #include <linux/mm.h>
+#include <linux/mmu_notifier.h>
 #include <linux/poll.h>
 #include <linux/slab.h>
 #include <linux/seq_file.h>
@@ -1191,6 +1192,50 @@ static ssize_t userfaultfd_read(struct file *file, char __user *buf,
 	}
 }
 
+/*
+ * This function will unconditionally remove all the shared pmd pgtable entries
+ * within the specific vma for a hugetlbfs memory range.
+ */
+static void hugetlb_unshare_all_pmds(struct vm_area_struct *vma)
+{
+#ifdef CONFIG_HUGETLB_PAGE
+	struct hstate *h = hstate_vma(vma);
+	unsigned long sz = huge_page_size(h);
+	struct mm_struct *mm = vma->vm_mm;
+	struct mmu_notifier_range range;
+	unsigned long address;
+	spinlock_t *ptl;
+	pte_t *ptep;
+
+	if (!(vma->vm_flags & VM_MAYSHARE))
+		return;
+
+	/*
+	 * No need to call adjust_range_if_pmd_sharing_possible(), because
+	 * we're going to operate on the whole vma
+	 */
+	mmu_notifier_range_init(&range, MMU_NOTIFY_HUGETLB_UNSHARE,
+				0, vma, mm, vma->vm_start, vma->vm_end);
+	mmu_notifier_invalidate_range_start(&range);
+	i_mmap_lock_write(vma->vm_file->f_mapping);
+	for (address = vma->vm_start; address < vma->vm_end; address += sz) {
+		ptep = huge_pte_offset(mm, address, sz);
+		if (!ptep)
+			continue;
+		ptl = huge_pte_lock(h, mm, ptep);
+		huge_pmd_unshare(mm, vma, &address, ptep);
+		spin_unlock(ptl);
+	}
+	flush_hugetlb_tlb_range(vma, vma->vm_start, vma->vm_end);
+	i_mmap_unlock_write(vma->vm_file->f_mapping);
+	/*
+	 * No need to call mmu_notifier_invalidate_range(), see
+	 * Documentation/vm/mmu_notifier.rst.
+	 */
+	mmu_notifier_invalidate_range_end(&range);
+#endif
+}
+
 static void __wake_userfault(struct userfaultfd_ctx *ctx,
 			     struct userfaultfd_wake_range *range)
 {
@@ -1449,6 +1494,9 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 		vma->vm_flags = new_flags;
 		vma->vm_userfaultfd_ctx.ctx = ctx;
 
+		if (is_vm_hugetlb_page(vma) && uffd_disable_huge_pmd_share(vma))
+			hugetlb_unshare_all_pmds(vma);
+
 	skip:
 		prev = vma;
 		start = vma->vm_end;
diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
index b8200782dede..ff50c8528113 100644
--- a/include/linux/mmu_notifier.h
+++ b/include/linux/mmu_notifier.h
@@ -51,6 +51,7 @@ enum mmu_notifier_event {
 	MMU_NOTIFY_SOFT_DIRTY,
 	MMU_NOTIFY_RELEASE,
 	MMU_NOTIFY_MIGRATE,
+	MMU_NOTIFY_HUGETLB_UNSHARE,
 };
 
 #define MMU_NOTIFIER_RANGE_BLOCKABLE (1 << 0)
-- 
2.30.0.478.g8a0d178c01-goog

