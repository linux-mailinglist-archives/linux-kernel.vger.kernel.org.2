Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1D663DB4EA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 10:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237961AbhG3IKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 04:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbhG3IKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 04:10:06 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1AB7C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 01:10:00 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id x3so8650214qkl.6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 01:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=iO85ZMC6Pth+31xPvVbOO8VKXEmUR+jk3X7hFax1vLE=;
        b=gL63kdkFN7iyXAPotPB2doPP4eoWZKnl2sfroPBPAmL0gzVw5Upydd4gfixGG7s4WC
         giXC1QKX0/mEwYnfv2DX5x83kim9pV5K+Gm8NMUXleRvZrKLiKonmPtcs7J3ioWqHe6F
         Ckfr9iXkkJcyYmswDgsxzVxSxBIysXhiyCXSKrZy8vVuiXmWrD2T+1NhJYm15q+9DkgU
         XwXZEF2H4svRElS8LTbSdUa4RDEDk42LvlEa7OxioJzfqS/+4IOmq0XGsfWVqB2JgtX/
         zTuwoWGUPFo1/OuUj+lNosYVHJAFcNXFHYHIbWeDozDiEk7Ux5ckytcnsj1H/ae+IAiB
         bTCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=iO85ZMC6Pth+31xPvVbOO8VKXEmUR+jk3X7hFax1vLE=;
        b=MVP5DV/LVgfEaSuh2sOR83+y7fbn5HnOpzO8PJ6x81T6MwjzCYt3c25zgm+q0HMsEw
         qIj+KGz9ylpRm5guJdMxCVPYwTdKPIx3iEtHnRhvTukTv46GzuaH8COlP99vfrHXSpue
         P1tcirEt2Xe+jttkK35SWJpljXliAtQpaYnb6Rkie+JpeIt1S5bWEzZvqjE/NgYzY0Ya
         mRtu2fmMUZE7KQbg6T1BtzDKUnKZBRE4zEES4Z2zrpwvo+44JiZw2G0SthqEYlHWq26a
         Gw8BJfKZGQGaUgtIxtru1avtzKOAiBdDCJRQkuAzAu3RLK2rNGajnQklSYr6oi4Qy6e+
         X5qQ==
X-Gm-Message-State: AOAM532P2+1rQ82TnvtMd79nFUe3j1mQ/Gsp10VjiyzU9a+5u3Fi5Xjy
        cvAIhE1+YOtsPKJMpu4aeBtfVA==
X-Google-Smtp-Source: ABdhPJzxLMkX99MbqShrEgAY7r7lr2pFJKeO21G4hsIJ29P9sxgcQLfSXm9uBiPHU0BoiYUpJA2ihQ==
X-Received: by 2002:ae9:e90e:: with SMTP id x14mr1119707qkf.118.1627632599619;
        Fri, 30 Jul 2021 01:09:59 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id w71sm571098qkb.67.2021.07.30.01.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 01:09:58 -0700 (PDT)
Date:   Fri, 30 Jul 2021 01:09:56 -0700 (PDT)
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
Subject: [PATCH 15/16] tmpfs: permit changing size of memlocked file
In-Reply-To: <2862852d-badd-7486-3a8e-c5ea9666d6fb@google.com>
Message-ID: <ed60e16e-3fcc-35f8-3880-cd39f24be9c3@google.com>
References: <2862852d-badd-7486-3a8e-c5ea9666d6fb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have users who change the size of their memlocked file by F_MEM_UNLOCK,
ftruncate, F_MEM_LOCK.  That risks swapout in between, and is distasteful:
particularly if the file is very large (when shmem_unlock_mapping() has a
lot of work to move pages off the Unevictable list, only for them to be
moved back there later on).

Modify shmem_setattr() to grow or shrink, and shmem_fallocate() to grow,
the locked extent.  But forbid (EPERM) both if current_ucounts() differs
from the locker's mlock_ucounts (without even a CAP_IPC_LOCK override).
They could be permitted (the caller already has unsealed write access),
but it's probably less confusing to restrict size change to the locker.

But leave shmem_write_begin() as is, preventing the memlocked file from
being extended implicitly by writes beyond EOF: I think that it's best to
demand an explicit size change, by truncate or fallocate, when memlocked.

(But notice in testing "echo x >memlockedfile" how the O_TRUNC succeeds
but the write fails: would F_MEM_UNLOCK on truncation to 0 be better?)

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/shmem.c | 48 ++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 38 insertions(+), 10 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 1ddb910e976c..fa4a264453bf 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1123,15 +1123,30 @@ static int shmem_setattr(struct user_namespace *mnt_userns,
 
 		/* protected by i_mutex */
 		if ((newsize < oldsize && (info->seals & F_SEAL_SHRINK)) ||
-		    (newsize > oldsize && (info->seals & F_SEAL_GROW)) ||
-		    (newsize != oldsize && info->mlock_ucounts))
+		    (newsize > oldsize && (info->seals & F_SEAL_GROW)))
 			return -EPERM;
 
 		if (newsize != oldsize) {
-			error = shmem_reacct_size(SHMEM_I(inode)->flags,
-					oldsize, newsize);
+			struct ucounts *ucounts = info->mlock_ucounts;
+
+			if (ucounts && ucounts != current_ucounts())
+				return -EPERM;
+			error = shmem_reacct_size(info->flags,
+						  oldsize, newsize);
 			if (error)
 				return error;
+			if (ucounts) {
+				loff_t mlock = round_up(newsize, PAGE_SIZE) -
+						round_up(oldsize, PAGE_SIZE);
+				if (mlock < 0) {
+					user_shm_unlock(-mlock, ucounts, false);
+				} else if (mlock > 0 &&
+					!user_shm_lock(mlock, ucounts, false)) {
+					shmem_reacct_size(info->flags,
+							  newsize, oldsize);
+					return -EPERM;
+				}
+			}
 			i_size_write(inode, newsize);
 			inode->i_ctime = inode->i_mtime = current_time(inode);
 		}
@@ -2784,6 +2799,7 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
 	struct shmem_inode_info *info = SHMEM_I(inode);
 	struct shmem_falloc shmem_falloc;
 	pgoff_t start, index, end, undo_fallocend;
+	loff_t mlock = 0;
 	int error;
 
 	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE))
@@ -2830,13 +2846,23 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
 	if (error)
 		goto out;
 
-	if ((info->seals & F_SEAL_GROW) && offset + len > inode->i_size) {
-		error = -EPERM;
-		goto out;
-	}
-	if (info->mlock_ucounts && offset + len > inode->i_size) {
+	if (offset + len > inode->i_size) {
 		error = -EPERM;
-		goto out;
+		if (info->seals & F_SEAL_GROW)
+			goto out;
+		if (info->mlock_ucounts) {
+			if (info->mlock_ucounts != current_ucounts() ||
+			    (mode & FALLOC_FL_KEEP_SIZE))
+				goto out;
+			mlock = round_up(offset + len, PAGE_SIZE) -
+				round_up(inode->i_size, PAGE_SIZE);
+			if (mlock > 0 &&
+			    !user_shm_lock(mlock, info->mlock_ucounts, false)) {
+				mlock = 0;
+				goto out;
+			}
+		}
+		error = 0;
 	}
 
 	start = offset >> PAGE_SHIFT;
@@ -2932,6 +2958,8 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
 	inode->i_private = NULL;
 	spin_unlock(&inode->i_lock);
 out:
+	if (error && mlock > 0)
+		user_shm_unlock(mlock, info->mlock_ucounts, false);
 	inode_unlock(inode);
 	return error;
 }
-- 
2.26.2

