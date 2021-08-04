Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE5A23DF977
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 03:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233693AbhHDB5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 21:57:20 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:54484 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233425AbhHDB5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 21:57:18 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UhuxUvO_1628042224;
Received: from B-D1K7ML85-0059.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0UhuxUvO_1628042224)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 04 Aug 2021 09:57:05 +0800
Subject: Re: [PATCH] ocfs2: reflink deadlock when clone file to the same
 directory simultaneously
To:     Gang He <ghe@suse.com>, mark@fasheh.com, jlbec@evilplan.org,
        Wengang Wang <wen.gang.wang@oracle.com>
Cc:     linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        akpm@linux-foundation.org
References: <20210729110230.18983-1-ghe@suse.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <5821fd0f-2018-dc1b-a5c0-f948a7debff4@linux.alibaba.com>
Date:   Wed, 4 Aug 2021 09:57:04 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210729110230.18983-1-ghe@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gang,
As I mentioned in your previous mail, I'd like we describe the issue in
the following way:

Node 1		Node 2		Node3
...
		...
				...

That will be more easier to understand the lock sequence.

Thanks,
Joseph

On 7/29/21 7:02 PM, Gang He wrote:
> Running reflink from multiple nodes simultaneously to clone a file
> to the same directory probably triggers a deadlock issue.
> For example, there is a three node ocfs2 cluster, each node mounts
> the ocfs2 file system to /mnt/shared, and run the reflink command
> from each node repeatedly, like
>   reflink "/mnt/shared/test" \
>   "/mnt/shared/.snapshots/test.`date +%m%d%H%M%S`.`hostname`"
> then, reflink command process will be hung on each node, and you
> can't list this file system directory.
> The problematic reflink command process is blocked at one node,
> task:reflink         state:D stack:    0 pid: 1283 ppid:  4154
> Call Trace:
>   __schedule+0x2fd/0x750
>   schedule+0x2f/0xa0
>   schedule_timeout+0x1cc/0x310
>   ? ocfs2_control_cfu+0x50/0x50 [ocfs2_stack_user]
>   ? 0xffffffffc0e3e000
>   wait_for_completion+0xba/0x140
>   ? wake_up_q+0xa0/0xa0
>   __ocfs2_cluster_lock.isra.41+0x3b5/0x820 [ocfs2]
>   ? ocfs2_inode_lock_full_nested+0x1fc/0x960 [ocfs2]
>   ocfs2_inode_lock_full_nested+0x1fc/0x960 [ocfs2]
>   ocfs2_init_security_and_acl+0xbe/0x1d0 [ocfs2]
>   ocfs2_reflink+0x436/0x4c0 [ocfs2]
>   ? ocfs2_reflink_ioctl+0x2ca/0x360 [ocfs2]
>   ocfs2_reflink_ioctl+0x2ca/0x360 [ocfs2]
>   ocfs2_ioctl+0x25e/0x670 [ocfs2]
>   do_vfs_ioctl+0xa0/0x680
>   ksys_ioctl+0x70/0x80
>   __x64_sys_ioctl+0x16/0x20
>   do_syscall_64+0x5b/0x1e0
> The other reflink command processes are blocked at other nodes,
> task:reflink         state:D stack:    0 pid:29759 ppid:  4088
> Call Trace:
>   __schedule+0x2fd/0x750
>   schedule+0x2f/0xa0
>   schedule_timeout+0x1cc/0x310
>   ? ocfs2_control_cfu+0x50/0x50 [ocfs2_stack_user]
>   ? 0xffffffffc0b19000
>   wait_for_completion+0xba/0x140
>   ? wake_up_q+0xa0/0xa0
>   __ocfs2_cluster_lock.isra.41+0x3b5/0x820 [ocfs2]
>   ? ocfs2_inode_lock_full_nested+0x1fc/0x960 [ocfs2]
>   ocfs2_inode_lock_full_nested+0x1fc/0x960 [ocfs2]
>   ocfs2_mv_orphaned_inode_to_new+0x87/0x7e0 [ocfs2]
>   ocfs2_reflink+0x335/0x4c0 [ocfs2]
>   ? ocfs2_reflink_ioctl+0x2ca/0x360 [ocfs2]
>   ocfs2_reflink_ioctl+0x2ca/0x360 [ocfs2]
>   ocfs2_ioctl+0x25e/0x670 [ocfs2]
>   do_vfs_ioctl+0xa0/0x680
>   ksys_ioctl+0x70/0x80
>   __x64_sys_ioctl+0x16/0x20
>   do_syscall_64+0x5b/0x1e0
> or
> task:reflink         state:D stack:    0 pid:18465 ppid:  4156
> Call Trace:
>   __schedule+0x302/0x940
>   ? usleep_range+0x80/0x80
>   schedule+0x46/0xb0
>   schedule_timeout+0xff/0x140
>   ? ocfs2_control_cfu+0x50/0x50 [ocfs2_stack_user]
>   ? 0xffffffffc0c3b000
>   __wait_for_common+0xb9/0x170
>   __ocfs2_cluster_lock.constprop.0+0x1d6/0x860 [ocfs2]
>   ? ocfs2_wait_for_recovery+0x49/0xd0 [ocfs2]
>   ? ocfs2_inode_lock_full_nested+0x30f/0xa50 [ocfs2]
>   ocfs2_inode_lock_full_nested+0x30f/0xa50 [ocfs2]
>   ocfs2_inode_lock_tracker+0xf2/0x2b0 [ocfs2]
>   ? dput+0x32/0x2f0
>   ocfs2_permission+0x45/0xe0 [ocfs2]
>   inode_permission+0xcc/0x170
>   link_path_walk.part.0.constprop.0+0x2a2/0x380
>   ? path_init+0x2c1/0x3f0
>   path_parentat+0x3c/0x90
>   filename_parentat+0xc1/0x1d0
>   ? filename_lookup+0x138/0x1c0
>   filename_create+0x43/0x160
>   ocfs2_reflink_ioctl+0xe6/0x380 [ocfs2]
>   ocfs2_ioctl+0x1ea/0x2c0 [ocfs2]
>   ? do_sys_openat2+0x81/0x150
>   __x64_sys_ioctl+0x82/0xb0
>   do_syscall_64+0x61/0xb0
> 
> The deadlock is caused by multiple acquiring the destination directory
> inode dlm lock in ocfs2_reflink function, we should acquire this
> directory inode dlm lock at the beginning, and hold this dlm lock until
> end of the function.
> 
> Signed-off-by: Gang He <ghe@suse.com>
> ---
>  fs/ocfs2/namei.c        | 32 +++++++++++++-------------------
>  fs/ocfs2/namei.h        |  2 ++
>  fs/ocfs2/refcounttree.c | 15 +++++++++++----
>  fs/ocfs2/xattr.c        | 12 +-----------
>  fs/ocfs2/xattr.h        |  1 +
>  5 files changed, 28 insertions(+), 34 deletions(-)
> 
> diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
> index 2c46ff6ba4ea..f8bbb22cc60b 100644
> --- a/fs/ocfs2/namei.c
> +++ b/fs/ocfs2/namei.c
> @@ -2489,6 +2489,7 @@ static int ocfs2_prep_new_orphaned_file(struct inode *dir,
>  }
>  
>  int ocfs2_create_inode_in_orphan(struct inode *dir,
> +				 struct buffer_head **dir_bh,
>  				 int mode,
>  				 struct inode **new_inode)
>  {
> @@ -2597,13 +2598,16 @@ int ocfs2_create_inode_in_orphan(struct inode *dir,
>  
>  	brelse(new_di_bh);
>  
> -	if (!status)
> -		*new_inode = inode;
> -
>  	ocfs2_free_dir_lookup_result(&orphan_insert);
>  
> -	ocfs2_inode_unlock(dir, 1);
> -	brelse(parent_di_bh);
> +	if (!status) {
> +		*new_inode = inode;
> +		*dir_bh = parent_di_bh;
> +	} else {
> +		ocfs2_inode_unlock(dir, 1);
> +		brelse(parent_di_bh);
> +	}
> +
>  	return status;
>  }
>  
> @@ -2760,11 +2764,11 @@ int ocfs2_del_inode_from_orphan(struct ocfs2_super *osb,
>  }
>  
>  int ocfs2_mv_orphaned_inode_to_new(struct inode *dir,
> +				   struct buffer_head *dir_bh,
>  				   struct inode *inode,
>  				   struct dentry *dentry)
>  {
>  	int status = 0;
> -	struct buffer_head *parent_di_bh = NULL;
>  	handle_t *handle = NULL;
>  	struct ocfs2_super *osb = OCFS2_SB(dir->i_sb);
>  	struct ocfs2_dinode *dir_di, *di;
> @@ -2778,14 +2782,7 @@ int ocfs2_mv_orphaned_inode_to_new(struct inode *dir,
>  				(unsigned long long)OCFS2_I(dir)->ip_blkno,
>  				(unsigned long long)OCFS2_I(inode)->ip_blkno);
>  
> -	status = ocfs2_inode_lock(dir, &parent_di_bh, 1);
> -	if (status < 0) {
> -		if (status != -ENOENT)
> -			mlog_errno(status);
> -		return status;
> -	}
> -
> -	dir_di = (struct ocfs2_dinode *) parent_di_bh->b_data;
> +	dir_di = (struct ocfs2_dinode *) dir_bh->b_data;
>  	if (!dir_di->i_links_count) {
>  		/* can't make a file in a deleted directory. */
>  		status = -ENOENT;
> @@ -2798,7 +2795,7 @@ int ocfs2_mv_orphaned_inode_to_new(struct inode *dir,
>  		goto leave;
>  
>  	/* get a spot inside the dir. */
> -	status = ocfs2_prepare_dir_for_insert(osb, dir, parent_di_bh,
> +	status = ocfs2_prepare_dir_for_insert(osb, dir, dir_bh,
>  					      dentry->d_name.name,
>  					      dentry->d_name.len, &lookup);
>  	if (status < 0) {
> @@ -2862,7 +2859,7 @@ int ocfs2_mv_orphaned_inode_to_new(struct inode *dir,
>  	ocfs2_journal_dirty(handle, di_bh);
>  
>  	status = ocfs2_add_entry(handle, dentry, inode,
> -				 OCFS2_I(inode)->ip_blkno, parent_di_bh,
> +				 OCFS2_I(inode)->ip_blkno, dir_bh,
>  				 &lookup);
>  	if (status < 0) {
>  		mlog_errno(status);
> @@ -2886,10 +2883,7 @@ int ocfs2_mv_orphaned_inode_to_new(struct inode *dir,
>  	iput(orphan_dir_inode);
>  leave:
>  
> -	ocfs2_inode_unlock(dir, 1);
> -
>  	brelse(di_bh);
> -	brelse(parent_di_bh);
>  	brelse(orphan_dir_bh);
>  
>  	ocfs2_free_dir_lookup_result(&lookup);
> diff --git a/fs/ocfs2/namei.h b/fs/ocfs2/namei.h
> index 9cc891eb874e..03a2c526e2c1 100644
> --- a/fs/ocfs2/namei.h
> +++ b/fs/ocfs2/namei.h
> @@ -24,6 +24,7 @@ int ocfs2_orphan_del(struct ocfs2_super *osb,
>  		     struct buffer_head *orphan_dir_bh,
>  		     bool dio);
>  int ocfs2_create_inode_in_orphan(struct inode *dir,
> +				 struct buffer_head **dir_bh,
>  				 int mode,
>  				 struct inode **new_inode);
>  int ocfs2_add_inode_to_orphan(struct ocfs2_super *osb,
> @@ -32,6 +33,7 @@ int ocfs2_del_inode_from_orphan(struct ocfs2_super *osb,
>  		struct inode *inode, struct buffer_head *di_bh,
>  		int update_isize, loff_t end);
>  int ocfs2_mv_orphaned_inode_to_new(struct inode *dir,
> +				   struct buffer_head *dir_bh,
>  				   struct inode *new_inode,
>  				   struct dentry *new_dentry);
>  
> diff --git a/fs/ocfs2/refcounttree.c b/fs/ocfs2/refcounttree.c
> index 7f6355cbb587..a9a0c7c37e8e 100644
> --- a/fs/ocfs2/refcounttree.c
> +++ b/fs/ocfs2/refcounttree.c
> @@ -4250,7 +4250,7 @@ static int ocfs2_reflink(struct dentry *old_dentry, struct inode *dir,
>  {
>  	int error, had_lock;
>  	struct inode *inode = d_inode(old_dentry);
> -	struct buffer_head *old_bh = NULL;
> +	struct buffer_head *old_bh = NULL, *dir_bh = NULL;
>  	struct inode *new_orphan_inode = NULL;
>  	struct ocfs2_lock_holder oh;
>  
> @@ -4258,7 +4258,7 @@ static int ocfs2_reflink(struct dentry *old_dentry, struct inode *dir,
>  		return -EOPNOTSUPP;
>  
>  
> -	error = ocfs2_create_inode_in_orphan(dir, inode->i_mode,
> +	error = ocfs2_create_inode_in_orphan(dir, &dir_bh, inode->i_mode,
>  					     &new_orphan_inode);
>  	if (error) {
>  		mlog_errno(error);
> @@ -4304,13 +4304,15 @@ static int ocfs2_reflink(struct dentry *old_dentry, struct inode *dir,
>  
>  	/* If the security isn't preserved, we need to re-initialize them. */
>  	if (!preserve) {
> -		error = ocfs2_init_security_and_acl(dir, new_orphan_inode,
> +		error = ocfs2_init_security_and_acl(dir, dir_bh,
> +						    new_orphan_inode,
>  						    &new_dentry->d_name);
>  		if (error)
>  			mlog_errno(error);
>  	}
>  	if (!error) {
> -		error = ocfs2_mv_orphaned_inode_to_new(dir, new_orphan_inode,
> +		error = ocfs2_mv_orphaned_inode_to_new(dir, dir_bh,
> +						       new_orphan_inode,
>  						       new_dentry);
>  		if (error)
>  			mlog_errno(error);
> @@ -4328,6 +4330,11 @@ static int ocfs2_reflink(struct dentry *old_dentry, struct inode *dir,
>  			iput(new_orphan_inode);
>  	}
>  
> +	if (dir_bh) {
> +		ocfs2_inode_unlock(dir, 1);
> +		brelse(dir_bh);
> +	}
> +
>  	return error;
>  }
>  
> diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
> index dd784eb0cd7c..3f23e3a5018c 100644
> --- a/fs/ocfs2/xattr.c
> +++ b/fs/ocfs2/xattr.c
> @@ -7203,16 +7203,13 @@ int ocfs2_reflink_xattrs(struct inode *old_inode,
>  /*
>   * Initialize security and acl for a already created inode.
>   * Used for reflink a non-preserve-security file.
> - *
> - * It uses common api like ocfs2_xattr_set, so the caller
> - * must not hold any lock expect i_mutex.
>   */
>  int ocfs2_init_security_and_acl(struct inode *dir,
> +				struct buffer_head *dir_bh,
>  				struct inode *inode,
>  				const struct qstr *qstr)
>  {
>  	int ret = 0;
> -	struct buffer_head *dir_bh = NULL;
>  
>  	ret = ocfs2_init_security_get(inode, dir, qstr, NULL);
>  	if (ret) {
> @@ -7220,17 +7217,10 @@ int ocfs2_init_security_and_acl(struct inode *dir,
>  		goto leave;
>  	}
>  
> -	ret = ocfs2_inode_lock(dir, &dir_bh, 0);
> -	if (ret) {
> -		mlog_errno(ret);
> -		goto leave;
> -	}
>  	ret = ocfs2_init_acl(NULL, inode, dir, NULL, dir_bh, NULL, NULL);
>  	if (ret)
>  		mlog_errno(ret);
>  
> -	ocfs2_inode_unlock(dir, 0);
> -	brelse(dir_bh);
>  leave:
>  	return ret;
>  }
> diff --git a/fs/ocfs2/xattr.h b/fs/ocfs2/xattr.h
> index 00308b57f64f..b27fd8ba0019 100644
> --- a/fs/ocfs2/xattr.h
> +++ b/fs/ocfs2/xattr.h
> @@ -83,6 +83,7 @@ int ocfs2_reflink_xattrs(struct inode *old_inode,
>  			 struct buffer_head *new_bh,
>  			 bool preserve_security);
>  int ocfs2_init_security_and_acl(struct inode *dir,
> +				struct buffer_head *dir_bh,
>  				struct inode *inode,
>  				const struct qstr *qstr);
>  #endif /* OCFS2_XATTR_H */
> 
