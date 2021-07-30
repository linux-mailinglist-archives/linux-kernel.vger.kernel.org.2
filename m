Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC8043DB4F0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 10:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238052AbhG3INK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 04:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238022AbhG3INJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 04:13:09 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8B0C0613C1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 01:13:04 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id l24so5858244qtj.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 01:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=6jcq19xGjLmUrRwSvlYxDwEEZEY30Ie1/WmTXGS/o98=;
        b=Kac6JXUK7HkQ+j1nfCyWf78Lx9/J8DhbK9cEe+BUdcchaQcuwA3yUFSUhn/812O94Y
         NYSWAx93XtwzseOdArk3qWr12pWQKPcJXgne/v78P0RQYFGrJ9nealVyPoIWx/EqYa7m
         hDroul1FOfEO5SGdz3xKVOhIExAaODMNchQY4wjDIFQbwb10BIZ+bstMTSQIg1LN8qqy
         eQAeDVhg1sz7SnP/E6f7lZDfkw7dTurQMEXnYyWb1vsMskpJatZ803Gdo+KCv9j+v8j+
         ZEaOVViwafQGLKntkVwsZOYOPJK6ZWRqxSUO+LBdEYTTuWXaUrj8wSn5ScQLmiKbcD64
         v8vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=6jcq19xGjLmUrRwSvlYxDwEEZEY30Ie1/WmTXGS/o98=;
        b=Fsw6mZ5iZcFTPIM/WcdtPEtrEb4tcjb9zpG02AyCueD8sr3vOxhMlWGoWTMcrbWiC/
         TJtL3OjjXLWxepin0T1Xo06FUYzJu1f2SS2edESzOK+ugaqDP+rkD4Fvh/5PvmJiKJGZ
         PzNFTQtSMeKHPdJCpofQ6lXOy1Ph4PDKuzpypp05D6F13CxGxV/uqeph6geBKfzOGWdJ
         kYY2vNzRl8OkSGNWOuqpcGY1WZBFJAzkN5XctTgTBDr8ZfD0iOlyw/DoauKApKLG6bse
         ZPHhu9ngPVXT2HjRLjMzQUyokdBMT07e3tlTJP1AyDNzTgqREfb+PSZht8momDffi3f9
         EHvw==
X-Gm-Message-State: AOAM533uCig/2M5421IWNQIvmvZp1s0515i52yeU9bgZfBFptk9oYes6
        l3l6fhhfDRRcYky1jy50/fukhA==
X-Google-Smtp-Source: ABdhPJyEd1jy6kKL/d+sUdaFX+XbhOvASGlRdpkXHz5LKfA/TN8qNb3mrpImsaMxEE6XRNqjUfjSpg==
X-Received: by 2002:ac8:5552:: with SMTP id o18mr1239016qtr.51.1627632783757;
        Fri, 30 Jul 2021 01:13:03 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id d129sm539530qkf.136.2021.07.30.01.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 01:13:02 -0700 (PDT)
Date:   Fri, 30 Jul 2021 01:13:00 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Hugh Dickins <hughd@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Matthew Auld <matthew.auld@intel.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 16/16] memfd: memfd_create(name, MFD_MEM_LOCK) for memlocked
 shmem
In-Reply-To: <2862852d-badd-7486-3a8e-c5ea9666d6fb@google.com>
Message-ID: <be7c30cc-20fd-b5d6-83a2-366410753145@google.com>
References: <2862852d-badd-7486-3a8e-c5ea9666d6fb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the size of a memlocked file can be changed, memfd_create() can
accept an MFD_MEM_LOCK flag to request memlocking, even though the initial
size is of course 0.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 include/uapi/linux/memfd.h |  1 +
 mm/memfd.c                 |  7 +++++--
 mm/shmem.c                 | 13 ++++++++++++-
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/memfd.h b/include/uapi/linux/memfd.h
index 8358a69e78cc..9113b5aa1763 100644
--- a/include/uapi/linux/memfd.h
+++ b/include/uapi/linux/memfd.h
@@ -9,6 +9,7 @@
 #define MFD_ALLOW_SEALING	0x0002U
 #define MFD_HUGETLB		0x0004U		/* Use hugetlbfs */
 #define MFD_HUGEPAGE		0x0008U		/* Use huge tmpfs */
+#define MFD_MEM_LOCK		0x0010U		/* Memlock tmpfs */
 
 /*
  * Huge page size encoding when MFD_HUGETLB is specified, and a huge page
diff --git a/mm/memfd.c b/mm/memfd.c
index 0d1a504d2fc9..e39f9eed55d2 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -248,7 +248,8 @@ long memfd_fcntl(struct file *file, unsigned int cmd, unsigned long arg)
 #define MFD_ALL_FLAGS  (MFD_CLOEXEC | \
 			MFD_ALLOW_SEALING | \
 			MFD_HUGETLB | \
-			MFD_HUGEPAGE)
+			MFD_HUGEPAGE | \
+			MFD_MEM_LOCK)
 
 SYSCALL_DEFINE2(memfd_create,
 		const char __user *, uname,
@@ -262,7 +263,7 @@ SYSCALL_DEFINE2(memfd_create,
 
 	if (flags & MFD_HUGETLB) {
 		/* Disallow huge tmpfs when choosing hugetlbfs */
-		if (flags & MFD_HUGEPAGE)
+		if (flags & (MFD_HUGEPAGE | MFD_MEM_LOCK))
 			return -EINVAL;
 		/* Allow huge page size encoding in flags. */
 		if (flags & ~(unsigned int)(MFD_ALL_FLAGS |
@@ -314,6 +315,8 @@ SYSCALL_DEFINE2(memfd_create,
 
 		if (flags & MFD_HUGEPAGE)
 			vm_flags |= VM_HUGEPAGE;
+		if (flags & MFD_MEM_LOCK)
+			vm_flags |= VM_LOCKED;
 		file = shmem_file_setup(name, 0, vm_flags);
 	}
 
diff --git a/mm/shmem.c b/mm/shmem.c
index fa4a264453bf..a0a83e59ae07 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2395,7 +2395,7 @@ static struct inode *shmem_get_inode(struct super_block *sb, const struct inode
 		spin_lock_init(&info->lock);
 		atomic_set(&info->stop_eviction, 0);
 		info->seals = F_SEAL_SEAL;
-		info->flags = flags & VM_NORESERVE;
+		info->flags = flags & (VM_NORESERVE | VM_LOCKED);
 		if ((flags & VM_HUGEPAGE) &&
 		    transparent_hugepage_allowed(sbinfo) &&
 		    !test_bit(MMF_DISABLE_THP, &current->mm->flags))
@@ -4254,6 +4254,17 @@ static struct file *__shmem_file_setup(struct vfsmount *mnt, const char *name, l
 	inode->i_size = size;
 	clear_nlink(inode);	/* It is unlinked */
 	res = ERR_PTR(ramfs_nommu_expand_for_mapping(inode, size));
+	if (!IS_ERR(res) && (flags & VM_LOCKED)) {
+		struct ucounts *ucounts = current_ucounts();
+		/*
+		 * Only memfd_create() may pass VM_LOCKED, and it passes
+		 * size 0; but avoid that assumption in case it changes.
+		 */
+		if (user_shm_lock(size, ucounts, true))
+			SHMEM_I(inode)->mlock_ucounts = ucounts;
+		else
+			res = ERR_PTR(-EPERM);
+	}
 	if (!IS_ERR(res))
 		res = alloc_file_pseudo(inode, mnt, name, O_RDWR,
 				&shmem_file_operations);
-- 
2.26.2

