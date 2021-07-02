Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBF53B9A92
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 03:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234743AbhGBBfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 21:35:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:52166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234708AbhGBBfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 21:35:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7E1AA613BC;
        Fri,  2 Jul 2021 01:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625189549;
        bh=x/cZLU8gLdFXi9n2Y5IATFQF9pEIi5JCiI99YW3rBRE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VfMcQoeK3ZoEMkwoJqws8BVhZSz4DxiT6HAGhBVmKqaAb6IiHe1b5epTXAtdDqHu+
         nDICz5+SGgFnKFT5rUk6ZhNnPoamJ1SRBNNPnmt7nCTv33T+UE8BHEAqb1hTdFVNIQ
         wF84i5f1Y0KO4H0mJCTibirBqDCk1G+4jg44w8izkKP/oeYuvNWhQr08QgSOf4EDTp
         gUbjeS9dM2p0HNPYD39d6z7jKHbCZW5MJr8rK0babaX/wSbTTGo4r4F2NUl26k3cUb
         OAF4NgUnO9wvyuWtnxO0MUMhM+n+klNroU7rjZAPXreinZx+R+QZig3c7KFytBJ9R8
         pVUhk6XvGICHg==
Date:   Thu, 1 Jul 2021 18:32:28 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 RFC] f2fs: fix to force keeping write barrier for
 strict fsync mode
Message-ID: <YN5srPRZaPN9gpZ0@google.com>
References: <20210601101024.119356-1-yuchao0@huawei.com>
 <YN32/NsjqJONbvz7@google.com>
 <648a96f7-2c83-e9ed-0cbd-4ee8e4797724@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <648a96f7-2c83-e9ed-0cbd-4ee8e4797724@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02, Chao Yu wrote:
> On 2021/7/2 1:10, Jaegeuk Kim wrote:
> > On 06/01, Chao Yu wrote:
> > > [1] https://www.mail-archive.com/linux-f2fs-devel@lists.sourceforge.net/msg15126.html
> > > 
> > > As [1] reported, if lower device doesn't support write barrier, in below
> > > case:
> > > 
> > > - write page #0; persist
> > > - overwrite page #0
> > > - fsync
> > >   - write data page #0 OPU into device's cache
> > >   - write inode page into device's cache
> > >   - issue flush
> > 
> > Well, we have preflush for node writes, so I don't think this is the case.
> > 
> >   fio.op_flags |= REQ_PREFLUSH | REQ_FUA;
> 
> This is only used for atomic write case, right?
> 
> I mean the common case which is called from f2fs_issue_flush() in
> f2fs_do_sync_file().

How about adding PREFLUSH when writing node blocks aligned to the above set?

> 
> And please see do_checkpoint(), we call f2fs_flush_device_cache() and
> commit_checkpoint() separately to keep persistence order of CP datas.
> 
> See commit 46706d5917f4 ("f2fs: flush cp pack except cp pack 2 page at first")
> for details.
> 
> Thanks,
> 
> > 
> > > 
> > > If SPO is triggered during flush command, inode page can be persisted
> > > before data page #0, so that after recovery, inode page can be recovered
> > > with new physical block address of data page #0, however there may
> > > contains dummy data in new physical block address.
> > > 
> > > Then what user will see is: after overwrite & fsync + SPO, old data in
> > > file was corrupted, if any user do care about such case, we can suggest
> > > user to use STRICT fsync mode, in this mode, we will force to trigger
> > > preflush command to persist data in device cache in prior to node
> > > writeback, it avoids potential data corruption during fsync().
> > > 
> > > Signed-off-by: Chao Yu <yuchao0@huawei.com>
> > > ---
> > > v2:
> > > - fix this by adding additional preflush command rather than using
> > > atomic write flow.
> > >   fs/f2fs/file.c | 14 ++++++++++++++
> > >   1 file changed, 14 insertions(+)
> > > 
> > > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > > index 7d5311d54f63..238ca2a733ac 100644
> > > --- a/fs/f2fs/file.c
> > > +++ b/fs/f2fs/file.c
> > > @@ -301,6 +301,20 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
> > >   				f2fs_exist_written_data(sbi, ino, UPDATE_INO))
> > >   			goto flush_out;
> > >   		goto out;
> > > +	} else {
> > > +		/*
> > > +		 * for OPU case, during fsync(), node can be persisted before
> > > +		 * data when lower device doesn't support write barrier, result
> > > +		 * in data corruption after SPO.
> > > +		 * So for strict fsync mode, force to trigger preflush to keep
> > > +		 * data/node write order to avoid potential data corruption.
> > > +		 */
> > > +		if (F2FS_OPTION(sbi).fsync_mode == FSYNC_MODE_STRICT &&
> > > +								!atomic) {
> > > +			ret = f2fs_issue_flush(sbi, inode->i_ino);
> > > +			if (ret)
> > > +				goto out;
> > > +		}
> > >   	}
> > >   go_write:
> > >   	/*
> > > -- 
> > > 2.29.2
