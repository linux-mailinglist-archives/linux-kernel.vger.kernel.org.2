Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF873A707E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 22:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235745AbhFNUeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 16:34:36 -0400
Received: from mail-pg1-f177.google.com ([209.85.215.177]:38559 "EHLO
        mail-pg1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233352AbhFNUec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 16:34:32 -0400
Received: by mail-pg1-f177.google.com with SMTP id t17so9626633pga.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 13:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=X0Dlg1OxNcsAdJyU64IBe8AUMc5WPVAjSibLW2UVq4k=;
        b=u/rQ3fhLYXFiYDBOqpfaVdMnzxd6fBR1/DfmyScke8pC/ffiziSws6MXqcTVQQZ7Pb
         xahdwAoWXKtSEAlqGsLgALVYebwLyupy/HuZxqRXfvvrywcuxRrVBpr8cbhIK2RZ+KOS
         su0J3AXxY+d4MG2YPFAur8SPkUwZcDfmgAg2tm4RFINhvEkB08yu+bOSTwd4Dn9n8XYb
         0kJpYABBJPz3pXA1sCDieibPiNaoERngiqXvtKqMPuoXXX4x3A2awSCVbark81IMBNlQ
         7YyAkvQ42preQ+dkLuGuA3Go8xTWgD7ChBrH7tdU8MguIcW3CZeuwKqPSw3G7SsSVaMs
         sjWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=X0Dlg1OxNcsAdJyU64IBe8AUMc5WPVAjSibLW2UVq4k=;
        b=Mmvztzy5p9hWhHsIxBlGtMEZ2zNqlHsaIGgwVlSPwCipstm8C9fqwAumF1KqavPYJk
         UadOt50zLAt5ttcGm9ZWiD0Je93UfMUB/aPb9R0z4lc3uxrdbwL+jp9iRAiL3IbXaGy+
         sEM+Amjq+Ya8IddN6rZzFaYl8wWL6NG3adgrS71BuHYBzagyY9PXIlZZzn4tNgJJ838T
         kLlOCxClMe9rH7MuhBhLblx5SGSpI5M1WC4LlcYHX0b7kgib6YfOdfudd7P9s2CHnCtu
         a5jBX1SVvyHSlb14yUftOKNLNfTxtVYFIeYKm4tW7xLpxQCpHeL1uXT4bYPH7bO3TVDj
         xyTA==
X-Gm-Message-State: AOAM533ZJmNFGCQm/v2XGsTm+jK7WWLD4cVwigca4kH+kCM0iiCATJab
        nrYkiT/5jQL2q1FDPUppeVk=
X-Google-Smtp-Source: ABdhPJxxitlMoVrI5knF2a1+7X2aj42K8fpVmke45+iVElm+Oq8nBXyo1LvwuMFm8Ibg1DnYsoOsiw==
X-Received: by 2002:aa7:820d:0:b029:2f1:d22d:f21d with SMTP id k13-20020aa7820d0000b02902f1d22df21dmr767579pfi.7.1623702679195;
        Mon, 14 Jun 2021 13:31:19 -0700 (PDT)
Received: from nuc10 (104.36.148.139.aurocloud.com. [104.36.148.139])
        by smtp.gmail.com with ESMTPSA id r24sm301621pjz.11.2021.06.14.13.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 13:31:18 -0700 (PDT)
Date:   Mon, 14 Jun 2021 13:31:14 -0700
From:   Rustam Kovhaev <rkovhaev@gmail.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        dvyukov@google.com, gregkh@linuxfoundation.org
Subject: kmemleak memory scanning
Message-ID: <YMe8ktUsdtwFKHuF@nuc10>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hello Catalin, Andrew!

while troubleshooting a false positive syzbot kmemleak report i have
noticed an interesting behavior in kmemleak and i wonder whether it is
behavior by design and should be documented, or maybe something to
improve.
apologies if some of the questions do not make sense, i am still going
through kmemleak code..

a) kmemleak scans struct page (kmemleak.c:1462), but it does not scan
the actual contents (page_address(page)) of the page.
if we allocate an object with kmalloc(), then allocate page with
alloc_page(), and if we put kmalloc pointer somewhere inside that page, 
kmemleak will report kmalloc pointer as a false positive.
should we improve kmemleak and make it scan page contents?
or will this bring too many false negatives?

b) when kmemleak object gets created (kmemleak.c:598) it gets checksum
of 0, by the time user requests kmemleak "scan" via debugfs the pointer
will be most likely changed to some value by the kernel and during
first scan kmemleak won't report the object as orphan even if it did not
find any reference to it, because it will execute update_checksum() and
after that will proceed to updating object->count (kmemleak.c:1502).
and so the user will have to initiate a second "scan" via debugfs and
only then kmemleak will produce the report.
should we document this?

below i am attaching a simplified reproducer for the false positive
kmemleak report (a).
i could have done it in the module, but i found it to be easier and
faster to test when done in a syscall, so that i did not have to
modprobe/modprobe -r.

tyvm!

---
 arch/x86/entry/syscalls/syscall_64.tbl |  1 +
 include/linux/syscalls.h               |  1 +
 mm/Makefile                            |  2 +-
 mm/kmemleak_test.c                     | 45 ++++++++++++++++++++++++++
 4 files changed, 48 insertions(+), 1 deletion(-)
 create mode 100644 mm/kmemleak_test.c

diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index ce18119ea0d0..da967a87eb78 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -343,6 +343,7 @@
 332	common	statx			sys_statx
 333	common	io_pgetevents		sys_io_pgetevents
 334	common	rseq			sys_rseq
+335	common	kmemleak_test		sys_kmemleak_test
 # don't use numbers 387 through 423, add new calls after the last
 # 'common' entry
 424	common	pidfd_send_signal	sys_pidfd_send_signal
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 050511e8f1f8..0602308aabf4 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1029,6 +1029,7 @@ asmlinkage long sys_statx(int dfd, const char __user *path, unsigned flags,
 			  unsigned mask, struct statx __user *buffer);
 asmlinkage long sys_rseq(struct rseq __user *rseq, uint32_t rseq_len,
 			 int flags, uint32_t sig);
+asmlinkage long sys_kmemleak_test()
 asmlinkage long sys_open_tree(int dfd, const char __user *path, unsigned flags);
 asmlinkage long sys_move_mount(int from_dfd, const char __user *from_path,
 			       int to_dfd, const char __user *to_path,
diff --git a/mm/Makefile b/mm/Makefile
index bf71e295e9f6..878783838fa1 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -97,7 +97,7 @@ obj-$(CONFIG_CGROUP_HUGETLB) += hugetlb_cgroup.o
 obj-$(CONFIG_GUP_TEST) += gup_test.o
 obj-$(CONFIG_MEMORY_FAILURE) += memory-failure.o
 obj-$(CONFIG_HWPOISON_INJECT) += hwpoison-inject.o
-obj-$(CONFIG_DEBUG_KMEMLEAK) += kmemleak.o
+obj-$(CONFIG_DEBUG_KMEMLEAK) += kmemleak.o kmemleak_test.o
 obj-$(CONFIG_DEBUG_RODATA_TEST) += rodata_test.o
 obj-$(CONFIG_DEBUG_VM_PGTABLE) += debug_vm_pgtable.o
 obj-$(CONFIG_PAGE_OWNER) += page_owner.o
diff --git a/mm/kmemleak_test.c b/mm/kmemleak_test.c
new file mode 100644
index 000000000000..828246e20b7f
--- /dev/null
+++ b/mm/kmemleak_test.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <linux/sched.h>
+#include <linux/syscalls.h>
+#include <linux/types.h>
+#include <linux/mm.h>
+
+struct kmemleak_check {
+	unsigned long canary;
+	struct work_struct work;
+	struct page **pages;
+};
+
+static void work_func(struct work_struct *work)
+{
+	struct page **pages;
+	struct kmemleak_check *ptr;
+
+	set_current_state(TASK_INTERRUPTIBLE);
+	schedule_timeout(3600*HZ);
+
+	ptr = container_of(work, struct kmemleak_check, work);
+	pages = ptr->pages;
+	__free_page(pages[0]);
+	kvfree(pages);
+}
+
+SYSCALL_DEFINE0(kmemleak_test)
+{
+	struct page **pages, *page;
+	struct kmemleak_check *ptr;
+
+	pages = kzalloc(sizeof(*pages), GFP_KERNEL);
+	page = alloc_page(GFP_KERNEL);
+	pages[0] = page;
+	ptr = page_address(page);
+	ptr->canary = 0x00FF00FF00FF00FF;
+	ptr->pages = pages;
+	pr_info("DEBUG: pages %px page %px ptr %px\n", pages, page, ptr);
+
+	INIT_WORK(&ptr->work, work_func);
+	schedule_work(&ptr->work);
+
+	return 0;
+}
-- 
2.30.2

