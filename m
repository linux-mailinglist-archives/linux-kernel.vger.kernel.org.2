Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29A753CED64
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 22:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384308AbhGSS2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 14:28:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:57302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1383605AbhGSR6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 13:58:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0FD7461001;
        Mon, 19 Jul 2021 18:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626719930;
        bh=XAFEEvD3nR4KfB4EUkhX7aCbFMc/mjRTf1uxFVpvuCY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qmcBF93MmkGg1pjgrYtgaC3K1iGGXdgNiriEIV2sZZP87nshMF7ZviuU8zFB50kk7
         rKUuY7/BDxhWuCxjWwlsaIxSJrjLmbeUtMOy1PQiZ36mJOEjx3+oitP1yF5CnyoSUN
         nGXDqco7AJhzG6TV5L11cgJXYJfJhYVKi/W1LfCCa+zZcAIjGxRoaBsUxBEvEFcPT+
         u1Npn7gyd658OpKeoSu76JSj32bzaKcfTu3lfWtduMicOa5p3/GR0gV+gZKof8okXX
         f1//7H/9Gxnu3+FB4Le8fn0MR6opAXci0mnKEksivTxfVh9Hn8P5qaUNV0sCtyB9Ry
         5dtn9qPynBiaQ==
Date:   Mon, 19 Jul 2021 11:38:48 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 RFC] f2fs: fix to force keeping write barrier for
 strict fsync mode
Message-ID: <YPXGuNJWESJ098o/@google.com>
References: <YN32/NsjqJONbvz7@google.com>
 <648a96f7-2c83-e9ed-0cbd-4ee8e4797724@kernel.org>
 <YN5srPRZaPN9gpZ0@google.com>
 <b828fc22-f15a-8be4-631a-ed4ecb631386@kernel.org>
 <YOXo3CT5sBvj6p0J@google.com>
 <55e069f7-662d-630c-1201-d0163b38bc17@kernel.org>
 <YO4jGkKLQWZKrgny@google.com>
 <8f8d5645-9860-3e16-a09d-1a988ca6be72@kernel.org>
 <YO5JptcNuT28JJtX@google.com>
 <c6abf9b4-adbb-f3a6-39a5-5b77ea8b1545@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6abf9b4-adbb-f3a6-39a5-5b77ea8b1545@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/14, Chao Yu wrote:
> On 2021/7/14 10:19, Jaegeuk Kim wrote:
> > On 07/14, Chao Yu wrote:
> > > On 2021/7/14 7:34, Jaegeuk Kim wrote:
> > > > On 07/13, Chao Yu wrote:
> > > > > On 2021/7/8 1:48, Jaegeuk Kim wrote:
> > > > > > On 07/02, Chao Yu wrote:
> > > > > > > On 2021/7/2 9:32, Jaegeuk Kim wrote:
> > > > > > > > On 07/02, Chao Yu wrote:
> > > > > > > > > On 2021/7/2 1:10, Jaegeuk Kim wrote:
> > > > > > > > > > On 06/01, Chao Yu wrote:
> > > > > > > > > > > [1] https://www.mail-archive.com/linux-f2fs-devel@lists.sourceforge.net/msg15126.html
> > > > > > > > > > > 
> > > > > > > > > > > As [1] reported, if lower device doesn't support write barrier, in below
> > > > > > > > > > > case:
> > > > > > > > > > > 
> > > > > > > > > > > - write page #0; persist
> > > > > > > > > > > - overwrite page #0
> > > > > > > > > > > - fsync
> > > > > > > > > > >       - write data page #0 OPU into device's cache
> > > > > > > > > > >       - write inode page into device's cache
> > > > > > > > > > >       - issue flush
> > > > > > > > > > 
> > > > > > > > > > Well, we have preflush for node writes, so I don't think this is the case.
> > > > > > > > > > 
> > > > > > > > > >       fio.op_flags |= REQ_PREFLUSH | REQ_FUA;
> > > > > > > > > 
> > > > > > > > > This is only used for atomic write case, right?
> > > > > > > > > 
> > > > > > > > > I mean the common case which is called from f2fs_issue_flush() in
> > > > > > > > > f2fs_do_sync_file().
> > > > > > > > 
> > > > > > > > How about adding PREFLUSH when writing node blocks aligned to the above set?
> > > > > > > 
> > > > > > > You mean implementation like v1 as below?
> > > > > > > 
> > > > > > > https://lore.kernel.org/linux-f2fs-devel/20200120100045.70210-1-yuchao0@huawei.com/
> > > > > > 
> > > > > > Yea, I think so. :P
> > > > > 
> > > > > I prefer v2, we may have several schemes to improve performance with v2, e.g.
> > > > > - use inplace IO to avoid newly added preflush
> > > > > - use flush_merge option to avoid redundant preflush
> > > > > - if lower device supports barrier IO, we can avoid newly added preflush
> > > > 
> > > > Doesn't v2 give one more flush than v1? Why do you want to take worse one and
> > > 
> > > FUA implies an extra preflush command or similar mechanism in lower device to keep data
> > > in bio being persistent before this command's completion.
> > > 
> > > Also if lower device doesn't support FUA natively, block layer turns it into an empty
> > > PREFLUSH command.
> > > 
> > > So, it's hard to say which one will win the benchmark game, maybe we need some
> > > performance data before making the choice, but you know, it depends on device's
> > > character.
> > 
> > I was looking at # of bios.
> > 
> > > 
> > > > try to improve back? Not clear the benefit on v2.
> > > 
> > > Well, if user suffer and complain performance regression with v1, any plan to improve it?
> > > 
> > > I just thought about plan B/C/D for no matter v1 or v2.
> > 
> > I assumed you wanted v2 since it might be used for B/C/D improvements. But, it
> > seems it wasn't. My point is to save one bio, but piggyback the flag to the
> > device driver.
> 
> I doubt the conclusion...but it needs to get some data to prove it.
> 
> I think the right way is merging v1 now to fix the bug firstly, and let me do
> the comparison on them a little bit later to see whether we need another
> implementation... thoughts?

Chao, could you please post v1 with an updated description?

> 
> Thanks,
> 
> > 
> > > 
> > > Thanks,
> > > 
> > > > 
> > > > > 
> > > > > Thanks,
> > > > > 
> > > > > > 
> > > > > > > 
> > > > > > > Thanks,
> > > > > > > 
> > > > > > > > 
> > > > > > > > > 
> > > > > > > > > And please see do_checkpoint(), we call f2fs_flush_device_cache() and
> > > > > > > > > commit_checkpoint() separately to keep persistence order of CP datas.
> > > > > > > > > 
> > > > > > > > > See commit 46706d5917f4 ("f2fs: flush cp pack except cp pack 2 page at first")
> > > > > > > > > for details.
> > > > > > > > > 
> > > > > > > > > Thanks,
> > > > > > > > > 
> > > > > > > > > > 
> > > > > > > > > > > 
> > > > > > > > > > > If SPO is triggered during flush command, inode page can be persisted
> > > > > > > > > > > before data page #0, so that after recovery, inode page can be recovered
> > > > > > > > > > > with new physical block address of data page #0, however there may
> > > > > > > > > > > contains dummy data in new physical block address.
> > > > > > > > > > > 
> > > > > > > > > > > Then what user will see is: after overwrite & fsync + SPO, old data in
> > > > > > > > > > > file was corrupted, if any user do care about such case, we can suggest
> > > > > > > > > > > user to use STRICT fsync mode, in this mode, we will force to trigger
> > > > > > > > > > > preflush command to persist data in device cache in prior to node
> > > > > > > > > > > writeback, it avoids potential data corruption during fsync().
> > > > > > > > > > > 
> > > > > > > > > > > Signed-off-by: Chao Yu <yuchao0@huawei.com>
> > > > > > > > > > > ---
> > > > > > > > > > > v2:
> > > > > > > > > > > - fix this by adding additional preflush command rather than using
> > > > > > > > > > > atomic write flow.
> > > > > > > > > > >       fs/f2fs/file.c | 14 ++++++++++++++
> > > > > > > > > > >       1 file changed, 14 insertions(+)
> > > > > > > > > > > 
> > > > > > > > > > > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > > > > > > > > > > index 7d5311d54f63..238ca2a733ac 100644
> > > > > > > > > > > --- a/fs/f2fs/file.c
> > > > > > > > > > > +++ b/fs/f2fs/file.c
> > > > > > > > > > > @@ -301,6 +301,20 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
> > > > > > > > > > >       				f2fs_exist_written_data(sbi, ino, UPDATE_INO))
> > > > > > > > > > >       			goto flush_out;
> > > > > > > > > > >       		goto out;
> > > > > > > > > > > +	} else {
> > > > > > > > > > > +		/*
> > > > > > > > > > > +		 * for OPU case, during fsync(), node can be persisted before
> > > > > > > > > > > +		 * data when lower device doesn't support write barrier, result
> > > > > > > > > > > +		 * in data corruption after SPO.
> > > > > > > > > > > +		 * So for strict fsync mode, force to trigger preflush to keep
> > > > > > > > > > > +		 * data/node write order to avoid potential data corruption.
> > > > > > > > > > > +		 */
> > > > > > > > > > > +		if (F2FS_OPTION(sbi).fsync_mode == FSYNC_MODE_STRICT &&
> > > > > > > > > > > +								!atomic) {
> > > > > > > > > > > +			ret = f2fs_issue_flush(sbi, inode->i_ino);
> > > > > > > > > > > +			if (ret)
> > > > > > > > > > > +				goto out;
> > > > > > > > > > > +		}
> > > > > > > > > > >       	}
> > > > > > > > > > >       go_write:
> > > > > > > > > > >       	/*
> > > > > > > > > > > -- 
> > > > > > > > > > > 2.29.2
