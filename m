Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F337347077
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 05:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbhCXEWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 00:22:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:39858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231185AbhCXEWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 00:22:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D22F6619E0;
        Wed, 24 Mar 2021 04:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616559723;
        bh=JUMOPNlFXenu8b+jfOqqANM0mC2Z8hnowz+qX2OCQdI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u/J8/9w3HYkY1/vsmGH+9h6jcA1zy3y25aSDyz4I4wUoL5y/zey99NLVk1yYkJkQI
         of247FptTlN+R34Mu9VPMAZKEq8/mfAcuLWgN8WL0agEMIXPG+T9xVNmQ6HMFKsfuc
         pg40odZ7IjHy1+QTBIZEb0zqTZ89tGsVNql0c2vLqwlV0N2Q1sjHhWG1Ht+HaEk7Xm
         dxqbm5XgjoqBfHZtnIP1cl+LjnObf8dyyL1VNYwaZcdDbdhgfyC8eyaWBTw2BqJjpR
         9YIBf/StAB1L9Wxi1RTGi2iOHuiWkUpnuJ9w9QmZJslLnA2UbW3jxc1cyL5FsB64fW
         Sj6qTqC+r6ftg==
Date:   Tue, 23 Mar 2021 21:22:01 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [PATCH] Revert "f2fs: give a warning only for readonly partition"
Message-ID: <YFq+aQW7eihFuSst@google.com>
References: <20210323064155.12582-1-yuchao0@huawei.com>
 <YFo16ADpWJ7OUAvK@google.com>
 <107e671d-68ea-1a74-521e-ab2b6fe36416@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <107e671d-68ea-1a74-521e-ab2b6fe36416@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/24, Chao Yu wrote:
> On 2021/3/24 2:39, Jaegeuk Kim wrote:
> > On 03/23, Chao Yu wrote:
> > > This reverts commit 938a184265d75ea474f1c6fe1da96a5196163789.
> > > 
> > > Because that commit fails generic/050 testcase which expect failure
> > > during mount a recoverable readonly partition.
> > 
> > I think we need to change generic/050, since f2fs can recover this partition,
> 
> Well, not sure we can change that testcase, since it restricts all generic
> filesystems behavior. At least, ext4's behavior makes sense to me:
> 
> 	journal_dev_ro = bdev_read_only(journal->j_dev);
> 	really_read_only = bdev_read_only(sb->s_bdev) | journal_dev_ro;
> 
> 	if (journal_dev_ro && !sb_rdonly(sb)) {
> 		ext4_msg(sb, KERN_ERR,
> 			 "journal device read-only, try mounting with '-o ro'");
> 		err = -EROFS;
> 		goto err_out;
> 	}
> 
> 	if (ext4_has_feature_journal_needs_recovery(sb)) {
> 		if (sb_rdonly(sb)) {
> 			ext4_msg(sb, KERN_INFO, "INFO: recovery "
> 					"required on readonly filesystem");
> 			if (really_read_only) {
> 				ext4_msg(sb, KERN_ERR, "write access "
> 					"unavailable, cannot proceed "
> 					"(try mounting with noload)");
> 				err = -EROFS;
> 				goto err_out;
> 			}
> 			ext4_msg(sb, KERN_INFO, "write access will "
> 			       "be enabled during recovery");
> 		}
> 	}
> 
> > even though using it as readonly. And, valid checkpoint can allow for user to
> > read all the data without problem.
> 
> >>   		if (f2fs_hw_is_readonly(sbi)) {
> 
> Since device is readonly now, all write to the device will fail, checkpoint can
> not persist recovered data, after page cache is expired, user can see stale data.

My point is, after mount with ro, there'll be no data write which preserves the
current status. So, in the next time, we can recover fsync'ed data later, if
user succeeds to mount as rw. Another point is, with the current checkpoint, we
should not have any corrupted metadata. So, why not giving a chance to show what
data remained to user? I think this can be doable only with CoW filesystems.

> 
> Am I missing something?
> 
> Thanks,
> 
> > 
> > > 
> > > Fixes: 938a184265d7 ("f2fs: give a warning only for readonly partition")
> > > Signed-off-by: Chao Yu <yuchao0@huawei.com>
> > > ---
> > >   fs/f2fs/super.c | 8 +++++---
> > >   1 file changed, 5 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > > index b48281642e98..2b78ee11f093 100644
> > > --- a/fs/f2fs/super.c
> > > +++ b/fs/f2fs/super.c
> > > @@ -3952,10 +3952,12 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
> > >   		 * previous checkpoint was not done by clean system shutdown.
> > >   		 */
> > >   		if (f2fs_hw_is_readonly(sbi)) {
> > > -			if (!is_set_ckpt_flags(sbi, CP_UMOUNT_FLAG))
> > > +			if (!is_set_ckpt_flags(sbi, CP_UMOUNT_FLAG)) {
> > > +				err = -EROFS;
> > >   				f2fs_err(sbi, "Need to recover fsync data, but write access unavailable");
> > > -			else
> > > -				f2fs_info(sbi, "write access unavailable, skipping recovery");
> > > +				goto free_meta;
> > > +			}
> > > +			f2fs_info(sbi, "write access unavailable, skipping recovery");
> > >   			goto reset_checkpoint;
> > >   		}
> > > -- 
> > > 2.29.2
> > .
> > 
