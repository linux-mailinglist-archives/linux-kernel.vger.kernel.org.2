Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5F7330FBC6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 19:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238757AbhBDSmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 13:42:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239092AbhBDSf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 13:35:57 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83ABCC061356
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 10:34:52 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id v65so3304037qtd.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 10:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=BOdWGt2YrrFhUAh6Oya9odQ31xPXJajGw7XfNah1Ei0=;
        b=NBHdLCMVmjlgN5mUcDN7btxS+7ZLWcclBrRA56QJlXrMR8QRMxe4LKcc+rDaJR88Tg
         81ZpUhmRyV+2iRs9b9i6X1F53gwpkWEkrPHiso9lwqtE01nZ0LC76zIowyeGwRQger9n
         MvN1CUkSc5RzCH3+1uJPnTf4lcAKThO0g7tGROkLDYgTOlEt+CYUjMazGvYBxhzJ26is
         2gH5HlvO0XbpfhMs2p9bBdRgOCjFHHwlv8y9M7F5y30awvPM3pYsdA3nlMCVnO+SfpbC
         VJuVKmjkYK4vCc8vvFkmNhpnzIoB+2Lu2ef0b8fXz1jWw9ZJYS+CaSQD16ThR+WRoF/o
         1JOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BOdWGt2YrrFhUAh6Oya9odQ31xPXJajGw7XfNah1Ei0=;
        b=R7NuxlVHtgq8xhBgMzGTTIMvjWOe/eF0DNhngl4aPFarHAv55Z6EkwB9+bw98Gt7VQ
         pt8iztXBFYzpgxM1zFUlH26+IEnzkWbvErccmxIDBiVeeD2lsjF9Rqa2dVRo1x5ECS7O
         ToIPQCdbBpAoybgMkrgrlBD5PonpMuq3kLS2NEwrvuKst7i47rX2FBYM/0z4pniBA9UR
         0QlBZkkBLJ2Je67QSqSc3h3BfMLX17Kw/e+VRH9QfxDyqqJbJawV6QhAP6LszfeX/m/H
         GgwKpHf/1IUA+W/hUj88h7U2L5YaPre4FFE48CRIf2Ooy5fqGA52QEkjVNki41P4Rcg+
         6Y2Q==
X-Gm-Message-State: AOAM5333SVK0QRO7OC8UiPXKKGoKdURyXR5I9wuxmhMyGaAAeyFzjkn7
        4yktipfJnsPO4Hn8Q46HAsmPafcr4dFf32Y1CJ7C
X-Google-Smtp-Source: ABdhPJyPb3Mlg/0ElAXzwxLs8sVTCzLB5QqJgGLurcVZpTtQkepWRndQWdvko4eXoVcaKAI92jkYW/tc6Gcw4S4Evpba
Sender: "axelrasmussen via sendgmr" <axelrasmussen@ajr0.svl.corp.google.com>
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:b001:12c1:dc19:2089])
 (user=axelrasmussen job=sendgmr) by 2002:a05:6214:2ee:: with SMTP id
 h14mr785467qvu.34.1612463691582; Thu, 04 Feb 2021 10:34:51 -0800 (PST)
Date:   Thu,  4 Feb 2021 10:34:27 -0800
In-Reply-To: <20210204183433.1431202-1-axelrasmussen@google.com>
Message-Id: <20210204183433.1431202-5-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210204183433.1431202-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v4 04/10] hugetlb/userfaultfd: Unshare all pmds for hugetlbfs
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
index 894cc28142e7..a0f66e12026b 100644
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
@@ -1190,6 +1191,50 @@ static ssize_t userfaultfd_read(struct file *file, char __user *buf,
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
@@ -1448,6 +1493,9 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
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
2.30.0.365.g02bc693789-goog

