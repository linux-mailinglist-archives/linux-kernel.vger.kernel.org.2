Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2906379122
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 16:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237319AbhEJOmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 10:42:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:60280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244974AbhEJOky (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 10:40:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2EF7C61260;
        Mon, 10 May 2021 14:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620657589;
        bh=WEU1Fz1WVVlBrDEmLzTut6W259LIfPZaGoCmipxoj9A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iQLjEKR/Z9hHUOet3dMWHFOy/rKhovLY82BUH+pra2hIL5CJQK+wQRX8/JtMToNqv
         7e/GoAo16+7l2oN9X9+TSMSxDYV8zxGIol4UCe43kVIfCXRkROQF7+fexBL2ddEeGl
         Bn6mbL6A67AQH5ozJRLkW4/Ozzd/xQZveI29S2UGghndLhbbEBBrElzgOiXar+/FZj
         iqLaaD68an9ncgYuVBgxO+G6+Ow15CAM1X4SWKdKMNeicQSUoqw/KmptSAOysqgaAO
         AtPFRbLSI2drpriwcyi/zKyefOud7ozRJ+TXF6q3+dhg/XbcPUXNz37qxA2Yw5ihtR
         Uu0fRFZR0zGlQ==
Date:   Mon, 10 May 2021 07:39:47 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: return -EPERM given generic mask
Message-ID: <YJlFs5DLGifyBR2G@google.com>
References: <20210506191347.1242802-1-jaegeuk@kernel.org>
 <YJTdp0Rj170TYm24@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJTdp0Rj170TYm24@sol.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/06, Eric Biggers wrote:
> On Thu, May 06, 2021 at 12:13:47PM -0700, Jaegeuk Kim wrote:
> > In f2fs_fileattr_set(),
> > 
> > 	if (!fa->flags_valid)
> > 		mask &= FS_COMMON_FL;
> > 
> > In this case, we should not allow to set FS_COMPR_FL, instead of BUG_ON.
> > 
> > /* Flags shared betwen flags/xflags */
> > 	(FS_SYNC_FL | FS_IMMUTABLE_FL | FS_APPEND_FL | \
> > 	 FS_NODUMP_FL |	FS_NOATIME_FL | FS_DAX_FL | \
> > 	 FS_PROJINHERIT_FL)
> > 
> > Fixes: 4c5b47997521 ("vfs: add fileattr ops")
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/file.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > index e01ce802cf10..38015ef84893 100644
> > --- a/fs/f2fs/file.c
> > +++ b/fs/f2fs/file.c
> > @@ -1817,7 +1817,9 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
> >  	struct f2fs_inode_info *fi = F2FS_I(inode);
> >  	u32 masked_flags = fi->i_flags & mask;
> >  
> > -	f2fs_bug_on(F2FS_I_SB(inode), (iflags & ~mask));
> > +	/* mask can be shrunk by flags_valid selector */
> > +	if (iflags & ~mask)
> > +		return -EPERM;
> >  
> >  	/* Is it quota file? Do not allow user to mess with it */
> >  	if (IS_NOQUOTA(inode))
> > -- 
> > 2.31.1.607.g51e8a6a459-goog
> 
> This looks like the wrong fix.  AFAICS, 'mask' is the set of inode flags that
> the specific ioctl (FS_IOC_SETFLAGS or FS_IOC_FSSETXATTR) can potentially
> modify, while 'iflags' is the new set of inode flags among the set that either
> ioctl can potentially modify.  So this change will stop FS_IOC_FSSETXATTR from
> working on files that have already flags set which are only modifiable by
> FS_IOC_SETFLAGS, e.g. the compression flag.
> 
> I think the correct fix would be to just do something like 'iflags &= mask'.

Thanks. Let me send v2.

> 
> - Eric
