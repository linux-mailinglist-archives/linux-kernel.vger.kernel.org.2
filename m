Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 650823C7BA2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 04:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237550AbhGNCWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 22:22:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:55350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237530AbhGNCWK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 22:22:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EC2BA61361;
        Wed, 14 Jul 2021 02:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626229160;
        bh=i4eEglXPWeRoBvQUL6FzZPjJYWoDlvaJfAAc3qlwTWU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LgkqHbJZAzEn6uKw0qpFx6ln7UosMGIId1eejH4/UBWbHINvip8cSTIArsl1gVFhh
         tlhrrl+SjMzc4ePvztBw/IChvH/H3+dU9Gfwu9i9IJ2XZniDXKToweGJ+n8pBo1E62
         zWk7bfneeE946gfv4GRMDkj8NrR+yFZK45AisyWQ2tjACrl4uQ1Vj/x4HDlIS/+OXY
         Axia7uulEB8J7vyeRmTm5uc0VrIaxpz91cKku2IrkGspoXTIZyFL0+8gKNpW5P0SGw
         GWe7xqorm1QA0VQ6HF6r+vQbR5V9IoQ8IvAxoQYkXwMUGz0fQwhaAkd4sHhEZIko9C
         iO5IclZLFUOUQ==
Date:   Tue, 13 Jul 2021 19:19:18 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 RFC] f2fs: fix to force keeping write barrier for
 strict fsync mode
Message-ID: <YO5JptcNuT28JJtX@google.com>
References: <20210601101024.119356-1-yuchao0@huawei.com>
 <YN32/NsjqJONbvz7@google.com>
 <648a96f7-2c83-e9ed-0cbd-4ee8e4797724@kernel.org>
 <YN5srPRZaPN9gpZ0@google.com>
 <b828fc22-f15a-8be4-631a-ed4ecb631386@kernel.org>
 <YOXo3CT5sBvj6p0J@google.com>
 <55e069f7-662d-630c-1201-d0163b38bc17@kernel.org>
 <YO4jGkKLQWZKrgny@google.com>
 <8f8d5645-9860-3e16-a09d-1a988ca6be72@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f8d5645-9860-3e16-a09d-1a988ca6be72@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/14, Chao Yu wrote:
> On 2021/7/14 7:34, Jaegeuk Kim wrote:
> > On 07/13, Chao Yu wrote:
> > > On 2021/7/8 1:48, Jaegeuk Kim wrote:
> > > > On 07/02, Chao Yu wrote:
> > > > > On 2021/7/2 9:32, Jaegeuk Kim wrote:
> > > > > > On 07/02, Chao Yu wrote:
> > > > > > > On 2021/7/2 1:10, Jaegeuk Kim wrote:
> > > > > > > > On 06/01, Chao Yu wrote:
> > > > > > > > > [1] https://www.mail-archive.com/linux-f2fs-devel@lists.sourceforge.net/msg15126.html
> > > > > > > > > 
> > > > > > > > > As [1] reported, if lower device doesn't support write barrier, in below
> > > > > > > > > case:
> > > > > > > > > 
> > > > > > > > > - write page #0; persist
> > > > > > > > > - overwrite page #0
> > > > > > > > > - fsync
> > > > > > > > >      - write data page #0 OPU into device's cache
> > > > > > > > >      - write inode page into device's cache
> > > > > > > > >      - issue flush
> > > > > > > > 
> > > > > > > > Well, we have preflush for node writes, so I don't think this is the case.
> > > > > > > > 
> > > > > > > >      fio.op_flags |= REQ_PREFLUSH | REQ_FUA;
> > > > > > > 
> > > > > > > This is only used for atomic write case, right?
> > > > > > > 
> > > > > > > I mean the common case which is called from f2fs_issue_flush() in
> > > > > > > f2fs_do_sync_file().
> > > > > > 
> > > > > > How about adding PREFLUSH when writing node blocks aligned to the above set?
> > > > > 
> > > > > You mean implementation like v1 as below?
> > > > > 
> > > > > https://lore.kernel.org/linux-f2fs-devel/20200120100045.70210-1-yuchao0@huawei.com/
> > > > 
> > > > Yea, I think so. :P
> > > 
> > > I prefer v2, we may have several schemes to improve performance with v2, e.g.
> > > - use inplace IO to avoid newly added preflush
> > > - use flush_merge option to avoid redundant preflush
> > > - if lower device supports barrier IO, we can avoid newly added preflush
> > 
> > Doesn't v2 give one more flush than v1? Why do you want to take worse one and
> 
> FUA implies an extra preflush command or similar mechanism in lower device to keep data
> in bio being persistent before this command's completion.
> 
> Also if lower device doesn't support FUA natively, block layer turns it into an empty
> PREFLUSH command.
> 
> So, it's hard to say which one will win the benchmark game, maybe we need some
> performance data before making the choice, but you know, it depends on device's
> character.

I was looking at # of bios.

> 
> > try to improve back? Not clear the benefit on v2.
> 
> Well, if user suffer and complain performance regression with v1, any plan to improve it?
> 
> I just thought about plan B/C/D for no matter v1 or v2.

I assumed you wanted v2 since it might be used for B/C/D improvements. But, it
seems it wasn't. My point is to save one bio, but piggyback the flag to the
device driver.

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
> > > > > > > And please see do_checkpoint(), we call f2fs_flush_device_cache() and
> > > > > > > commit_checkpoint() separately to keep persistence order of CP datas.
> > > > > > > 
> > > > > > > See commit 46706d5917f4 ("f2fs: flush cp pack except cp pack 2 page at first")
> > > > > > > for details.
> > > > > > > 
> > > > > > > Thanks,
> > > > > > > 
> > > > > > > > 
> > > > > > > > > 
> > > > > > > > > If SPO is triggered during flush command, inode page can be persisted
> > > > > > > > > before data page #0, so that after recovery, inode page can be recovered
> > > > > > > > > with new physical block address of data page #0, however there may
> > > > > > > > > contains dummy data in new physical block address.
> > > > > > > > > 
> > > > > > > > > Then what user will see is: after overwrite & fsync + SPO, old data in
> > > > > > > > > file was corrupted, if any user do care about such case, we can suggest
> > > > > > > > > user to use STRICT fsync mode, in this mode, we will force to trigger
> > > > > > > > > preflush command to persist data in device cache in prior to node
> > > > > > > > > writeback, it avoids potential data corruption during fsync().
> > > > > > > > > 
> > > > > > > > > Signed-off-by: Chao Yu <yuchao0@huawei.com>
> > > > > > > > > ---
> > > > > > > > > v2:
> > > > > > > > > - fix this by adding additional preflush command rather than using
> > > > > > > > > atomic write flow.
> > > > > > > > >      fs/f2fs/file.c | 14 ++++++++++++++
> > > > > > > > >      1 file changed, 14 insertions(+)
> > > > > > > > > 
> > > > > > > > > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > > > > > > > > index 7d5311d54f63..238ca2a733ac 100644
> > > > > > > > > --- a/fs/f2fs/file.c
> > > > > > > > > +++ b/fs/f2fs/file.c
> > > > > > > > > @@ -301,6 +301,20 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
> > > > > > > > >      				f2fs_exist_written_data(sbi, ino, UPDATE_INO))
> > > > > > > > >      			goto flush_out;
> > > > > > > > >      		goto out;
> > > > > > > > > +	} else {
> > > > > > > > > +		/*
> > > > > > > > > +		 * for OPU case, during fsync(), node can be persisted before
> > > > > > > > > +		 * data when lower device doesn't support write barrier, result
> > > > > > > > > +		 * in data corruption after SPO.
> > > > > > > > > +		 * So for strict fsync mode, force to trigger preflush to keep
> > > > > > > > > +		 * data/node write order to avoid potential data corruption.
> > > > > > > > > +		 */
> > > > > > > > > +		if (F2FS_OPTION(sbi).fsync_mode == FSYNC_MODE_STRICT &&
> > > > > > > > > +								!atomic) {
> > > > > > > > > +			ret = f2fs_issue_flush(sbi, inode->i_ino);
> > > > > > > > > +			if (ret)
> > > > > > > > > +				goto out;
> > > > > > > > > +		}
> > > > > > > > >      	}
> > > > > > > > >      go_write:
> > > > > > > > >      	/*
> > > > > > > > > -- 
> > > > > > > > > 2.29.2
