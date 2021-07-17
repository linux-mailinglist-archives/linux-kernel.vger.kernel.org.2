Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6C2D3CC212
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 10:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbhGQI7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 04:59:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:55202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229781AbhGQI7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 04:59:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 64216613C0;
        Sat, 17 Jul 2021 08:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626512164;
        bh=Wuy4aT3AF+AKu9usxoWce9QDgBSD5R94pgf5H1/EgCo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Cm+FcwNJiex1lUkuru4Rs6Npk57fUiXFtrXRmO3CZIluRR84TBxUBBEkOo8iwZlBD
         WzinCdbCbhQLfrJPIfq3Ytpguotw562bALHxdOAPlLNc6AzImrG0uW54aTF6uolbaB
         8trXmYDN/lSj8tPJiESA6UWmNVphyeZbE/RAtzkwbm+9zIM9FjUkf611wAKuMF0FdK
         S97630P0cYcpMHA7Mw4YkvyuMmcS+GAMvUw8MYVdoCAn0K8q7egjzaE0tuuXTcS8EB
         2unHQBKlFdjmU0OWCNgfs/S25uuCc0Uiyh9m8aB/tOOBMq4lVMwBOTv1bnFfMpOwSx
         EGmaspGy83jOQ==
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix ctx->pos in f2fs_read_inline_dir()
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20210717034955.344408-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <2d651236-40de-2e7b-d6c6-9a18ce9a25ff@kernel.org>
Date:   Sat, 17 Jul 2021 16:56:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210717034955.344408-1-frank.li@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/7/17 11:49, Yangtao Li wrote:
> I recently found a case where de->name_len is 0 in f2fs_fill_dentries() easily reproduced,
> and finally set the fsck flag.
> 
> Thread A					Thread B
> 
> f2fs_readdir
> 	f2fs_read_inline_dir
> 		ctx->pos = d.max
> 						f2fs_add_dentry
> 							f2fs_add_inline_entry
> 								do_convert_inline_dir
> 							f2fs_add_regular_entry
> f2fs_readdir
> 	f2fs_fill_dentries
> 		set_sbi_flag(sbi, SBI_NEED_FSCK)
> 
> Process A opens the folder, and has been reading without closing it. During this period,
> Process B created a file under the folder (occupying multiple f2fs_dir_entry, exceeding
> the d.max of the inline dir). After creation, process A uses the d.max of inline dir to
> read it again, and it will read that de->name_len is 0.

Nice catch!

> 
> And returning early in f2fs_read_inline_dir will cause the process to be unable to see
> the changes before reopening the file.
> 
> So don't return early and remove the modification of ctx->pos in f2fs_read_inline_dir().
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   fs/f2fs/inline.c | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
> index 56a20d5c15da..fc6551139a3d 100644
> --- a/fs/f2fs/inline.c
> +++ b/fs/f2fs/inline.c
> @@ -729,9 +729,6 @@ int f2fs_read_inline_dir(struct file *file, struct dir_context *ctx,
>   
>   	make_dentry_ptr_inline(inode, &d, inline_dentry);
>   
> -	if (ctx->pos == d.max)
> -		return 0;
> -
>   	ipage = f2fs_get_node_page(F2FS_I_SB(inode), inode->i_ino);
>   	if (IS_ERR(ipage))
>   		return PTR_ERR(ipage);
> @@ -747,8 +744,6 @@ int f2fs_read_inline_dir(struct file *file, struct dir_context *ctx,
>   	make_dentry_ptr_inline(inode, &d, inline_dentry);
>   
>   	err = f2fs_fill_dentries(ctx, &d, 0, fstr);

After this function, ctx->pos will point to start position of first free slot after
last dir_entry, we can't guarantee that the free slot won't be used in above race
condition, right?

Moreover, w/o inline conversion, the race condition still can happen as below, right?

dir_entry1: A
dir_entry2: B
dir_entry3: C
free slot: _

Before:
AAAABBBB___
         ^
Thread B delete dir_entry2, and create dir_entry3.

After:
AAAACCCCC__
         ^
Thanks,

> -	if (!err)
> -		ctx->pos = d.max;
>   
>   	f2fs_put_page(ipage, 0);
>   	return err < 0 ? err : 0;
> 
