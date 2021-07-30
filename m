Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 991CD3DC0FF
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 00:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbhG3WUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 18:20:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:52672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234357AbhG3WT5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 18:19:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4853D6108E;
        Fri, 30 Jul 2021 22:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627683592;
        bh=eymSPNa/TShtYv9U+nLrPRjDCp95bQdCZy22yEiy6Ok=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KXy6Vyl6m36STisPeXh+7/hG5UjvgoprI0Vk6NXpV1dglkyEOYQWHVlz0l6onT51r
         jz9TLdegV7JdNemfxYZldBxqIQT64qHDoQMUJu4+HXP+eKivaNs7C4Hqris4yHOwGL
         RQvmv78vATrETUChTHRjNzdXUG+4x84f9ikZ7L/99vRfXERl9qEy6zpBzX1ORWRVls
         8znxc3hcCbbjwzoey/QizLY+99cw1XQMRF5LeM9pVwCXfMDDOnzyjy4R76/Jp3rOaY
         f2rWT/Etm0amxspsLFQ6ALojtxyc4wDjG+IIdUnvOEnb3hsSnq/FrljUJ5835AKZJT
         DKXt7mfdCU41A==
Date:   Fri, 30 Jul 2021 15:19:50 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     Chao Yu <chao.yu@linux.dev>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: fix to force keeping write barrier
 for strict fsync mode
Message-ID: <YQR7Bi9lI+k2QuYG@google.com>
References: <20210720010329.3975-1-chao@kernel.org>
 <YPYjzAVq04LfUO2Y@google.com>
 <014d1b9d-0698-fda1-0765-cce81d915280@kernel.org>
 <bdd499d9-1272-9fe3-8024-f53fbda458bc@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdd499d9-1272-9fe3-8024-f53fbda458bc@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/29, Chao Yu wrote:
> Ping,

Added. Thanks.

> 
> On 2021/7/20 9:19, Chao Yu wrote:
> > On 2021/7/20 9:15, Jaegeuk Kim wrote:
> > > Wasn't it supposed to be v1?
> > 
> > I skip IPU case for v1, and resend it as v3, is it fine to you?
> > 
> > Thanks,
> > 
> > > 
> > > On 07/20, Chao Yu wrote:
> > > > [1] https://www.mail-archive.com/linux-f2fs-devel@lists.sourceforge.net/msg15126.html
> > > > 
> > > > As [1] reported, if lower device doesn't support write barrier, in below
> > > > case:
> > > > 
> > > > - write page #0; persist
> > > > - overwrite page #0
> > > > - fsync
> > > >    - write data page #0 OPU into device's cache
> > > >    - write inode page into device's cache
> > > >    - issue flush
> > > > 
> > > > If SPO is triggered during flush command, inode page can be persisted
> > > > before data page #0, so that after recovery, inode page can be recovered
> > > > with new physical block address of data page #0, however there may
> > > > contains dummy data in new physical block address.
> > > > 
> > > > Then what user will see is: after overwrite & fsync + SPO, old data in
> > > > file was corrupted, if any user do care about such case, we can suggest
> > > > user to use STRICT fsync mode, in this mode, we will force to use atomic
> > > > write sematics to keep write order in between data/node and last node,
> > > > so that it avoids potential data corruption during fsync().
> > > > 
> > > > Signed-off-by: Chao Yu <chao@kernel.org>
> > > > ---
> > > >    fs/f2fs/file.c | 12 ++++++++++++
> > > >    1 file changed, 12 insertions(+)
> > > > 
> > > > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > > > index 6afd4562335f..00b45876eaa1 100644
> > > > --- a/fs/f2fs/file.c
> > > > +++ b/fs/f2fs/file.c
> > > > @@ -301,6 +301,18 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
> > > >    				f2fs_exist_written_data(sbi, ino, UPDATE_INO))
> > > >    			goto flush_out;
> > > >    		goto out;
> > > > +	} else {
> > > > +		/*
> > > > +		 * for OPU case, during fsync(), node can be persisted before
> > > > +		 * data when lower device doesn't support write barrier, result
> > > > +		 * in data corruption after SPO.
> > > > +		 * So for strict fsync mode, force to use atomic write sematics
> > > > +		 * to keep write order in between data/node and last node to
> > > > +		 * avoid potential data corruption.
> > > > +		 */
> > > > +		if (F2FS_OPTION(sbi).fsync_mode ==
> > > > +				FSYNC_MODE_STRICT && !atomic)
> > > > +			atomic = true;
> > > >    	}
> > > >    go_write:
> > > >    	/*
> > > > -- 
> > > > 2.22.1
> > 
> > 
> > _______________________________________________
> > Linux-f2fs-devel mailing list
> > Linux-f2fs-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> > 
