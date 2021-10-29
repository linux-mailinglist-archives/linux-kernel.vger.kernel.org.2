Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12106440162
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 19:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbhJ2Rp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 13:45:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:56948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230075AbhJ2Rp4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 13:45:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 92B7A61040;
        Fri, 29 Oct 2021 17:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635529407;
        bh=rsaoqoFMJRkFW8HbI1/g5SAhlNrxOJ2ODlLw2rtjQVw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TWI+jjY0ML1p9Nw0Dtl1KOyq5HJqk87BImQU70Cl4KdrO+WFa4/1eXJxAHGo0I3B1
         P/NvnMbfHSuOP2R46KsW2PdDpFH+Ejzgy2WcXm8VdW+MoO8hklvBq403DcDAKYxGDV
         mHxsKA5ZC4yWlQanMq8jCrM8qWeXEku+Kg22esQqwvs1SMJSMjIlaZ5R1n656tYy3b
         Lx5l4t9du+GMlRyUCeJsgwxECQ88Oq1feTNOL4xZBJ0gQ0YwGpafGfCWUZB7L8YPix
         ksi7CCHYMIS34CwUiqSHNy3RC+DlXPwoPjbQWjjzyX44QJPRpzSWY2aJhdtHO45LE4
         YcDzGXpMmMTQA==
Date:   Fri, 29 Oct 2021 10:43:26 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: skip f2fs_preallocate_blocks() for
 overwrite case
Message-ID: <YXwyvllUOm6jLiF5@google.com>
References: <20210928151911.11189-1-chao@kernel.org>
 <YVNoHudG5c65X85G@google.com>
 <65f6c366-9e5b-fe7f-7c38-061996d1882b@kernel.org>
 <dec765de-407b-07c3-75f6-ec7f71c618b7@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dec765de-407b-07c3-75f6-ec7f71c618b7@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/29, Chao Yu wrote:
> Ping,
> 
> On 2021/9/29 8:05, Chao Yu wrote:
> > On 2021/9/29 3:08, Jaegeuk Kim wrote:
> > > On 09/28, Chao Yu wrote:
> > > > In f2fs_file_write_iter(), let's use f2fs_overwrite_io() to
> > > > check whethere it is overwrite case, for such case, we can skip
> > > > f2fs_preallocate_blocks() in order to avoid f2fs_do_map_lock(),
> > > > which may be blocked by checkpoint() potentially.
> > > > 
> > > > Signed-off-by: Chao Yu <chao@kernel.org>
> > > > ---
> > > >   fs/f2fs/file.c | 4 ++++
> > > >   1 file changed, 4 insertions(+)
> > > > 
> > > > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > > > index 13deae03df06..51fecb2f4db5 100644
> > > > --- a/fs/f2fs/file.c
> > > > +++ b/fs/f2fs/file.c
> > > > @@ -4321,6 +4321,10 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
> > > >           preallocated = true;
> > > >           target_size = iocb->ki_pos + iov_iter_count(from);
> > > > +        if (f2fs_overwrite_io(inode, iocb->ki_pos,
> > > > +                        iov_iter_count(from)))
> > > > +            goto write;
> > > 
> > > This calls f2fs_map_blocks() which can be duplicate, if it's not the overwirte
> > > case. Do we have other benefit?
> > 
> > f2fs_overwrite_io() will break for append write case w/ below check:
> > 
> >      if (pos + len > i_size_read(inode))
> >          return false;
> > 
> > I guess we may only suffer double f2fs_map_blocks() for write hole
> > case, e.g. truncate to large size & write inside the filesize. For
> > this case, how about adding a condition to allow double f2fs_map_blocks()
> > only if write size is smaller than a threshold?

I still don't see the benefit much to do double f2fs_map_blocks. What is the
problem here?

> > 
> > Thanks,
> > 
> > > 
> > > > +
> > > >           err = f2fs_preallocate_blocks(iocb, from);
> > > >           if (err) {
> > > >   out_err:
> > > > -- 
> > > > 2.32.0
> > 
> > 
> > _______________________________________________
> > Linux-f2fs-devel mailing list
> > Linux-f2fs-devel@lists.sourceforge.net
> > https://apc01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.sourceforge.net%2Flists%2Flistinfo%2Flinux-f2fs-devel&amp;data=04%7C01%7Cchao.yu%40oppo.com%7C421c06812eba4f922b0908d982dcdcc5%7Cf1905eb1c35341c5951662b4a54b5ee6%7C0%7C0%7C637684707374940190%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=u22eEWDAPaAZCyISyjTUOtQDLDuyKxTnNCI3eSwwWro%3D&amp;reserved=0
