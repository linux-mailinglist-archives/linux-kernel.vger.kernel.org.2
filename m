Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83575376038
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 08:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234136AbhEGG1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 02:27:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:43028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230380AbhEGG1s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 02:27:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1E20C610FA;
        Fri,  7 May 2021 06:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620368809;
        bh=26lW/SlE/3tJXeTGnqnhmb7qE4S+ECkvLL6V6VcGy/c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QY/O7ugwDFC6NdsFh2BVxwy0nlopRdBeqyFlCL9G4d5FMH1aoe3c5KPUbucOrobZX
         An4KwX3zBs3/9NYI9JlzJ8XF3s4jvqH3x4VBNEVdy1sGO9cH+M0J/p2AYfS3yzJ8mQ
         UE6ocjIkqyiBTw7N3+tIoK5VLMyipFy93ryG6QS3+heoKGeQ9KSV4jatwHFhz3elgm
         5Ayat9Y0AaHu6aFQn7ctwKXdGnjgLl7Gqlv5burxcyd5/cJrFTFS5yUgsIRauOZYK/
         HJuAwC1cuWCbHpI6D45phnn0k3NQdbY1mTEt98ajudqb88DYelL+RWOzWUxkOkPdG9
         lS14JTBbedlNg==
Date:   Thu, 6 May 2021 23:26:47 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: return -EPERM given generic mask
Message-ID: <YJTdp0Rj170TYm24@sol.localdomain>
References: <20210506191347.1242802-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210506191347.1242802-1-jaegeuk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 06, 2021 at 12:13:47PM -0700, Jaegeuk Kim wrote:
> In f2fs_fileattr_set(),
> 
> 	if (!fa->flags_valid)
> 		mask &= FS_COMMON_FL;
> 
> In this case, we should not allow to set FS_COMPR_FL, instead of BUG_ON.
> 
> /* Flags shared betwen flags/xflags */
> 	(FS_SYNC_FL | FS_IMMUTABLE_FL | FS_APPEND_FL | \
> 	 FS_NODUMP_FL |	FS_NOATIME_FL | FS_DAX_FL | \
> 	 FS_PROJINHERIT_FL)
> 
> Fixes: 4c5b47997521 ("vfs: add fileattr ops")
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/file.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index e01ce802cf10..38015ef84893 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -1817,7 +1817,9 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
>  	struct f2fs_inode_info *fi = F2FS_I(inode);
>  	u32 masked_flags = fi->i_flags & mask;
>  
> -	f2fs_bug_on(F2FS_I_SB(inode), (iflags & ~mask));
> +	/* mask can be shrunk by flags_valid selector */
> +	if (iflags & ~mask)
> +		return -EPERM;
>  
>  	/* Is it quota file? Do not allow user to mess with it */
>  	if (IS_NOQUOTA(inode))
> -- 
> 2.31.1.607.g51e8a6a459-goog

This looks like the wrong fix.  AFAICS, 'mask' is the set of inode flags that
the specific ioctl (FS_IOC_SETFLAGS or FS_IOC_FSSETXATTR) can potentially
modify, while 'iflags' is the new set of inode flags among the set that either
ioctl can potentially modify.  So this change will stop FS_IOC_FSSETXATTR from
working on files that have already flags set which are only modifiable by
FS_IOC_SETFLAGS, e.g. the compression flag.

I think the correct fix would be to just do something like 'iflags &= mask'.

- Eric
