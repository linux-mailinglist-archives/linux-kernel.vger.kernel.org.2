Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A656C3467BC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 19:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbhCWSdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 14:33:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:49508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231562AbhCWSct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 14:32:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F2AEB619BB;
        Tue, 23 Mar 2021 18:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616524369;
        bh=SrXcVBV4nIQgyIM/fSLSVHs7w6pMJ/2dsxCVsXvB8zY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rUjxWZ9gdwrdHn6tWK74f9t7uFHKIpK1FRY4C4+u0het+B+AG2OxVB/nx9jgS0UZ4
         FeEa1ualNfMqtREFs8w3W4sm7yjOWOkDAfLCe7cmp1zF9fshivPKLAaE9ixmB0sYH2
         h7pIoYN8jeDMLuja7RyiDJ4RaZ+rc4OzDcIN4OaocgEfAnB0tSypo3qDOidK6xAUW+
         FKfU+nIIJu0GFVoBGQQTZtRqT9AEbm1ZuvpcGLhusOL7GeMzMmsE+of5ydaXRxPUMa
         GI4OJ/q8aY5AeSIiVeGwy513R4nCNr/TwchCu0ZLrTIawt7d1abEKHM01bgbrtP437
         R3wvGVqQYIWwQ==
Date:   Tue, 23 Mar 2021 11:32:47 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: fix to align to section for fallocate() on pinned
 file
Message-ID: <YFo0Tz1zl4tw7lUP@google.com>
References: <20210305095601.96591-1-yuchao0@huawei.com>
 <d9c118eb-45b3-7f35-70bd-cb016957e6e8@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9c118eb-45b3-7f35-70bd-cb016957e6e8@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/23, Chao Yu wrote:
> On 2021/3/5 17:56, Chao Yu wrote:
> > Now, fallocate() on a pinned file only allocates blocks which aligns
> > to segment rather than section, so GC may try to migrate pinned file's
> > block, and after several times of failure, pinned file's block could
> > be migrated to other place, however user won't be aware of such
> > condition, and then old obsolete block address may be readed/written
> > incorrectly.
> > 
> > To avoid such condition, let's try to allocate pinned file's blocks
> > with section alignment.
> > 
> > Signed-off-by: Chao Yu <yuchao0@huawei.com>
> 
> Jaegeuk,
> 
> Could you please check and apply below diff into original patch?
> 
> ---
>  fs/f2fs/file.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 236f3f69681a..24fa68fdcaa0 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -1648,13 +1648,13 @@ static int expand_inode_data(struct inode *inode, loff_t offset,
>  		return 0;
> 
>  	if (f2fs_is_pinned_file(inode)) {
> -		block_t len = (map.m_len >> sbi->log_blocks_per_seg) <<
> -					sbi->log_blocks_per_seg;
> +		block_t sec_blks = BLKS_PER_SEC(sbi);
> +		block_t len = rounddown(map.m_len, sec_blks);

len is declared above, so let me rephrase this as well.

> 
> -		if (map.m_len % sbi->blocks_per_seg)
> -			len += sbi->blocks_per_seg;
> +		if (map.m_len % sec_blks)
> +			len += sec_blks;

is this roundup()?

Could you check this?
https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev&id=e1175f02291141bbd924fc578299305fcde35855

> 
> -		map.m_len = sbi->blocks_per_seg;
> +		map.m_len = sec_blks;
>  next_alloc:
>  		if (has_not_enough_free_secs(sbi, 0,
>  			GET_SEC_FROM_SEG(sbi, overprovision_segments(sbi)))) {
> -- 
> 2.22.1
> 
