Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57AA135E547
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 19:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347280AbhDMRqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 13:46:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:43748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231224AbhDMRq3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 13:46:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 224B060200;
        Tue, 13 Apr 2021 17:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618335969;
        bh=hce5BP80dHrW/3zrskwEpTFPq4gPKx30JhoHYeCX4p8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HDxZW2S7VGKpduPoCK3JbvmJ92tof7TzmeFggChD8HDZ3hm2JmAJBBWp1ff4alNOu
         l2uwNoQ8Jcm6A7Vn6TKYeRERD88PZjAhMmK5hHxYJ6w5YrRjIbz8UpHu9ewOAvcukz
         7jSWP/gB5BcJkk0PhWZvXSciXPv44Bji6XfSezipbt9mwKBpvdO+J07guLEkHm1o4Y
         UVyXX7sUPhIw0fmydzyM7lG93Jevf7/74Ml/aRpIO8s6k0wxKO/iCPHlixwivTpApn
         PXr04ex2FJ1CVeBZ3W5474qF1wV4nslUwI4zLotgvndOGGU+/ezCYD0pNshDAzdkIL
         JlqnPlVj7c9bA==
Date:   Tue, 13 Apr 2021 10:46:07 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org,
        Yi Chen <chenyi77@huawei.com>
Subject: Re: [PATCH v3] f2fs: fix to keep isolation of atomic write
Message-ID: <YHXY34T6+GLHLqKv@google.com>
References: <20210412081512.103592-1-yuchao0@huawei.com>
 <YHUPjDY9ifsffk4z@google.com>
 <1171d722-8810-998c-e4b3-0845dbbdea19@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1171d722-8810-998c-e4b3-0845dbbdea19@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/13, Chao Yu wrote:
> On 2021/4/13 11:27, Jaegeuk Kim wrote:
> > On 04/12, Chao Yu wrote:
> > > As Yi Chen reported, there is a potential race case described as below:
> > > 
> > > Thread A			Thread B
> > > - f2fs_ioc_start_atomic_write
> > > 				- mkwrite
> > > 				 - set_page_dirty
> > > 				  - f2fs_set_page_private(page, 0)
> > >   - set_inode_flag(FI_ATOMIC_FILE)
> > > 				- mkwrite same page
> > > 				 - set_page_dirty
> > > 				  - f2fs_register_inmem_page
> > > 				   - f2fs_set_page_private(ATOMIC_WRITTEN_PAGE)
> > > 				     failed due to PagePrivate flag has been set
> > > 				   - list_add_tail
> > > 				- truncate_inode_pages
> > > 				 - f2fs_invalidate_page
> > > 				  - clear page private but w/o remove it from
> > > 				    inmem_list
> > > 				 - set page->mapping to NULL
> > > - f2fs_ioc_commit_atomic_write
> > >   - __f2fs_commit_inmem_pages
> > >     - __revoke_inmem_pages
> > >      - f2fs_put_page panic as page->mapping is NULL
> > > 
> > > The root cause is we missed to keep isolation of atomic write in the case
> > > of start_atomic_write vs mkwrite, let start_atomic_write helds i_mmap_sem
> > > lock to avoid this issue.
> > 
> > My only concern is performance regression. Could you please verify the numbers?
> 
> Do you have specific test script?
> 
> IIRC, the scenario you mean is multi-threads write/mmap the same db, right?

I suggest to run sqlite transaction/check operations in android devices in parallel.

> 
> Thanks,
> 
> > 
> > > 
> > > Reported-by: Yi Chen <chenyi77@huawei.com>
> > > Signed-off-by: Chao Yu <yuchao0@huawei.com>
> > > ---
> > > v3:
> > > - rebase to last dev branch
> > > - update commit message because this patch fixes a different racing issue
> > > of atomic write
> > >   fs/f2fs/file.c    | 3 +++
> > >   fs/f2fs/segment.c | 6 ++++++
> > >   2 files changed, 9 insertions(+)
> > > 
> > > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > > index d697c8900fa7..6284b2f4a60b 100644
> > > --- a/fs/f2fs/file.c
> > > +++ b/fs/f2fs/file.c
> > > @@ -2054,6 +2054,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
> > >   		goto out;
> > >   	down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
> > > +	down_write(&F2FS_I(inode)->i_mmap_sem);
> > >   	/*
> > >   	 * Should wait end_io to count F2FS_WB_CP_DATA correctly by
> > > @@ -2064,6 +2065,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
> > >   			  inode->i_ino, get_dirty_pages(inode));
> > >   	ret = filemap_write_and_wait_range(inode->i_mapping, 0, LLONG_MAX);
> > >   	if (ret) {
> > > +		up_write(&F2FS_I(inode)->i_mmap_sem);
> > >   		up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
> > >   		goto out;
> > >   	}
> > > @@ -2077,6 +2079,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
> > >   	/* add inode in inmem_list first and set atomic_file */
> > >   	set_inode_flag(inode, FI_ATOMIC_FILE);
> > >   	clear_inode_flag(inode, FI_ATOMIC_REVOKE_REQUEST);
> > > +	up_write(&F2FS_I(inode)->i_mmap_sem);
> > >   	up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
> > >   	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
> > > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > > index 0cb1ca88d4aa..78c8342f52fd 100644
> > > --- a/fs/f2fs/segment.c
> > > +++ b/fs/f2fs/segment.c
> > > @@ -325,6 +325,7 @@ void f2fs_drop_inmem_pages(struct inode *inode)
> > >   	struct f2fs_inode_info *fi = F2FS_I(inode);
> > >   	do {
> > > +		down_write(&F2FS_I(inode)->i_mmap_sem);
> > >   		mutex_lock(&fi->inmem_lock);
> > >   		if (list_empty(&fi->inmem_pages)) {
> > >   			fi->i_gc_failures[GC_FAILURE_ATOMIC] = 0;
> > > @@ -339,11 +340,13 @@ void f2fs_drop_inmem_pages(struct inode *inode)
> > >   			spin_unlock(&sbi->inode_lock[ATOMIC_FILE]);
> > >   			mutex_unlock(&fi->inmem_lock);
> > > +			up_write(&F2FS_I(inode)->i_mmap_sem);
> > >   			break;
> > >   		}
> > >   		__revoke_inmem_pages(inode, &fi->inmem_pages,
> > >   						true, false, true);
> > >   		mutex_unlock(&fi->inmem_lock);
> > > +		up_write(&F2FS_I(inode)->i_mmap_sem);
> > >   	} while (1);
> > >   }
> > > @@ -468,6 +471,7 @@ int f2fs_commit_inmem_pages(struct inode *inode)
> > >   	f2fs_balance_fs(sbi, true);
> > >   	down_write(&fi->i_gc_rwsem[WRITE]);
> > > +	down_write(&F2FS_I(inode)->i_mmap_sem);
> > >   	f2fs_lock_op(sbi);
> > >   	set_inode_flag(inode, FI_ATOMIC_COMMIT);
> > > @@ -479,6 +483,8 @@ int f2fs_commit_inmem_pages(struct inode *inode)
> > >   	clear_inode_flag(inode, FI_ATOMIC_COMMIT);
> > >   	f2fs_unlock_op(sbi);
> > > +
> > > +	up_write(&F2FS_I(inode)->i_mmap_sem);
> > >   	up_write(&fi->i_gc_rwsem[WRITE]);
> > >   	return err;
> > > -- 
> > > 2.29.2
> > .
> > 
