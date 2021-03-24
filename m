Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE9C63484CF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 23:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238872AbhCXWpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 18:45:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:54194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238873AbhCXWpA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 18:45:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9CB9F61A0A;
        Wed, 24 Mar 2021 22:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616625899;
        bh=oRJw9N2CYdxmQ8g7HDQZYwcLUHHvN38l9BdcxP6M1Dc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jku2oBAesk/+b1S5md937sEhXLoksk4ofuiWKfiG7YGqDx6pcjac6oajE/s9HX5/T
         xboP16kJlXUqZUE5dDIPCID8lX9/JLbV9d4m1XAOBSoqz2LkdFzx5JOSNzvJ0lxqsj
         QaOCr3MBY+MIrpxLWjlL8Cwq1tDMYChFVbuP3KWkTw6C5ICERwnau45T9DoyiOsFYu
         3gOOgJzarsJi7I+w4bx/tB5tCgTzAN9Rob5Utz7Xfnsq8L5QfWP6INCScOkUV54MTW
         wZhjYMSpjiYv0vCSyL4h1/zAXqAraf76LCwlh5SZ0XNwcwyjveiBfIHSFyCF6DMVFz
         GklU23x/jaZtw==
Date:   Wed, 24 Mar 2021 15:44:58 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [PATCH] Revert "f2fs: give a warning only for readonly partition"
Message-ID: <YFvA6uzDLeD7dRdY@google.com>
References: <20210323064155.12582-1-yuchao0@huawei.com>
 <YFo16ADpWJ7OUAvK@google.com>
 <107e671d-68ea-1a74-521e-ab2b6fe36416@huawei.com>
 <YFq+aQW7eihFuSst@google.com>
 <c5850f4b-ebe8-bc34-10c6-ab27d562d621@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5850f4b-ebe8-bc34-10c6-ab27d562d621@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/24, Chao Yu wrote:
> On 2021/3/24 12:22, Jaegeuk Kim wrote:
> > On 03/24, Chao Yu wrote:
> > > On 2021/3/24 2:39, Jaegeuk Kim wrote:
> > > > On 03/23, Chao Yu wrote:
> > > > > This reverts commit 938a184265d75ea474f1c6fe1da96a5196163789.
> > > > > 
> > > > > Because that commit fails generic/050 testcase which expect failure
> > > > > during mount a recoverable readonly partition.
> > > > 
> > > > I think we need to change generic/050, since f2fs can recover this partition,
> > > 
> > > Well, not sure we can change that testcase, since it restricts all generic
> > > filesystems behavior. At least, ext4's behavior makes sense to me:
> > > 
> > > 	journal_dev_ro = bdev_read_only(journal->j_dev);
> > > 	really_read_only = bdev_read_only(sb->s_bdev) | journal_dev_ro;
> > > 
> > > 	if (journal_dev_ro && !sb_rdonly(sb)) {
> > > 		ext4_msg(sb, KERN_ERR,
> > > 			 "journal device read-only, try mounting with '-o ro'");
> > > 		err = -EROFS;
> > > 		goto err_out;
> > > 	}
> > > 
> > > 	if (ext4_has_feature_journal_needs_recovery(sb)) {
> > > 		if (sb_rdonly(sb)) {
> > > 			ext4_msg(sb, KERN_INFO, "INFO: recovery "
> > > 					"required on readonly filesystem");
> > > 			if (really_read_only) {
> > > 				ext4_msg(sb, KERN_ERR, "write access "
> > > 					"unavailable, cannot proceed "
> > > 					"(try mounting with noload)");
> > > 				err = -EROFS;
> > > 				goto err_out;
> > > 			}
> > > 			ext4_msg(sb, KERN_INFO, "write access will "
> > > 			       "be enabled during recovery");
> > > 		}
> > > 	}
> > > 
> > > > even though using it as readonly. And, valid checkpoint can allow for user to
> > > > read all the data without problem.
> > > 
> > > > >    		if (f2fs_hw_is_readonly(sbi)) {
> > > 
> > > Since device is readonly now, all write to the device will fail, checkpoint can
> > > not persist recovered data, after page cache is expired, user can see stale data.
> > 
> > My point is, after mount with ro, there'll be no data write which preserves the
> > current status. So, in the next time, we can recover fsync'ed data later, if
> > user succeeds to mount as rw. Another point is, with the current checkpoint, we
> > should not have any corrupted metadata. So, why not giving a chance to show what
> > data remained to user? I think this can be doable only with CoW filesystems.
> 
> I guess we're talking about the different things...
> 
> Let me declare two different readonly status:
> 
> 1. filesystem readonly: file system is mount with ro mount option, and
> app from userspace can not modify any thing of filesystem, but filesystem
> itself can modify data on device since device may be writable.
> 
> 2. device readonly: device is set to readonly status via 'blockdev --setro'
> command, and then filesystem should never issue any write IO to the device.
> 
> So, what I mean is, *when device is readonly*, rather than f2fs mountpoint
> is readonly (f2fs_hw_is_readonly() returns true as below code, instead of
> f2fs_readonly() returns true), in this condition, we should not issue any
> write IO to device anyway, because, AFAIK, write IO will fail due to
> bio_check_ro() check.

In that case, mount(2) will try readonly, no?

# blockdev --setro /dev/vdb
# mount -t f2fs /dev/vdb /mnt/test/
mount: /mnt/test: WARNING: source write-protected, mounted read-only.

> 
>  		if (f2fs_hw_is_readonly(sbi)) {
> -			if (!is_set_ckpt_flags(sbi, CP_UMOUNT_FLAG)) {
> -				err = -EROFS;
> +			if (!is_set_ckpt_flags(sbi, CP_UMOUNT_FLAG))
>  				f2fs_err(sbi, "Need to recover fsync data, but write access unavailable");
> -				goto free_meta;
> -			}
> -			f2fs_info(sbi, "write access unavailable, skipping recovery");
> +			else
> +				f2fs_info(sbi, "write access unavailable, skipping recovery");
>  			goto reset_checkpoint;
>  		}
> 
> For the case of filesystem is readonly and device is writable, it's fine
> to do recovery in order to let user to see fsynced data.
> 
> Thanks,
> 
> > 
> > > 
> > > Am I missing something?
> > > 
> > > Thanks,
> > > 
> > > > 
> > > > > 
> > > > > Fixes: 938a184265d7 ("f2fs: give a warning only for readonly partition")
> > > > > Signed-off-by: Chao Yu <yuchao0@huawei.com>
> > > > > ---
> > > > >    fs/f2fs/super.c | 8 +++++---
> > > > >    1 file changed, 5 insertions(+), 3 deletions(-)
> > > > > 
> > > > > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > > > > index b48281642e98..2b78ee11f093 100644
> > > > > --- a/fs/f2fs/super.c
> > > > > +++ b/fs/f2fs/super.c
> > > > > @@ -3952,10 +3952,12 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
> > > > >    		 * previous checkpoint was not done by clean system shutdown.
> > > > >    		 */
> > > > >    		if (f2fs_hw_is_readonly(sbi)) {
> > > > > -			if (!is_set_ckpt_flags(sbi, CP_UMOUNT_FLAG))
> > > > > +			if (!is_set_ckpt_flags(sbi, CP_UMOUNT_FLAG)) {
> > > > > +				err = -EROFS;
> > > > >    				f2fs_err(sbi, "Need to recover fsync data, but write access unavailable");
> > > > > -			else
> > > > > -				f2fs_info(sbi, "write access unavailable, skipping recovery");
> > > > > +				goto free_meta;
> > > > > +			}
> > > > > +			f2fs_info(sbi, "write access unavailable, skipping recovery");
> > > > >    			goto reset_checkpoint;
> > > > >    		}
> > > > > -- 
> > > > > 2.29.2
> > > > .
> > > > 
> > .
> > 
