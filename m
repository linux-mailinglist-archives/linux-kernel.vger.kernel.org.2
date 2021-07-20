Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 087E43CF7D8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 12:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236354AbhGTJrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 05:47:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:58976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237147AbhGTJmj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 05:42:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1515B610D2;
        Tue, 20 Jul 2021 10:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626776597;
        bh=rd+6u+6oPp2eEsaaxYZhuL9mvgQJhUujKnfnKSFFefA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=RA8XyX3T6F5Q+lIzE+boh5ZoJJY8hEbdRkrpQlXNg1UFXSVQUygbS0Gtc7KGCoX5V
         PvkQaPcYhQygQa6rP9/PRp/N2WYilI6/eKy9RNo6C5nsln9TpTNjrkzAV76DfzwDi+
         NlMYHmCxfyfhBgKdzv3+RZqmcKKn+m7Z6ZIpiGQVmkh70VhK7QeYLFjzEIltnvIpyK
         FuGWUb9+EScUh9DH6nB2itEytX6K6cJ5ZMd7VcFzGL8Coz1ILJGtRO2toxuh6Aheb9
         BKmtOK9UMYFjnoVxs6G6BPsq+VKaH4kB6UIAtWT02bjNfyukjIEMlTRUK4oj6tlSEm
         10yEm+fllu90Q==
Subject: Re: [PATCH v3] f2fs: Reduce the scope of setting fsck tag when
 de->name_len is zero
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20210720070633.337851-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <9f221a92-6c95-8f2f-a3d9-1d7abf5a6a6e@kernel.org>
Date:   Tue, 20 Jul 2021 18:23:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210720070633.337851-1-frank.li@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/7/20 15:06, Yangtao Li wrote:
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
> 
> And Chao pointed out that w/o inline conversion, the race condition still can happen as below
> 
> dir_entry1: A
> dir_entry2: B
> dir_entry3: C
> free slot: _
> ctx->pos: ^
> 
> Before:
> AAAABBBB___
> 	 ^

please use blank instead of tab before '^'

> Thread B delete dir_entry2, and create dir_entry3.
> 
> After:
> AAAACCCCC__
> 	 ^

Ditto

> 
> In these scenarios, the file system is not damaged, and it's hard to avoid it. But we can bypass
> tagging FSCK flag if:
> a) bit_pos (:= ctx->pos % d->max) is non-zero & b) before bit_pos moves to first
> valid dir_entry.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   fs/f2fs/dir.c | 14 +++++++++-----
>   1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
> index 456651682daf..bfe942733b5e 100644
> --- a/fs/f2fs/dir.c
> +++ b/fs/f2fs/dir.c
> @@ -1000,6 +1000,7 @@ int f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr *d,
>   	struct f2fs_sb_info *sbi = F2FS_I_SB(d->inode);
>   	struct blk_plug plug;
>   	bool readdir_ra = sbi->readdir_ra == 1;
> +	bool found_valid_dirent  = false;

One more blank before '='.

bool found_valid_dirent = false;

Thanks,

>   	int err = 0;
>   
>   	bit_pos = ((unsigned long)ctx->pos % d->max);
> @@ -1014,13 +1015,15 @@ int f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr *d,
>   
>   		de = &d->dentry[bit_pos];
>   		if (de->name_len == 0) {
> +			if (found_valid_dirent || !bit_pos) {
> +				printk_ratelimited(
> +					"%sF2FS-fs (%s): invalid namelen(0), ino:%u, run fsck to fix.",
> +					KERN_WARNING, sbi->sb->s_id,
> +					le32_to_cpu(de->ino));
> +				set_sbi_flag(sbi, SBI_NEED_FSCK);
> +			}
>   			bit_pos++;
>   			ctx->pos = start_pos + bit_pos;
> -			printk_ratelimited(
> -				"%sF2FS-fs (%s): invalid namelen(0), ino:%u, run fsck to fix.",
> -				KERN_WARNING, sbi->sb->s_id,
> -				le32_to_cpu(de->ino));
> -			set_sbi_flag(sbi, SBI_NEED_FSCK);
>   			continue;
>   		}
>   
> @@ -1063,6 +1066,7 @@ int f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr *d,
>   			f2fs_ra_node_page(sbi, le32_to_cpu(de->ino));
>   
>   		ctx->pos = start_pos + bit_pos;
> +		found_valid_dirent = true;
>   	}
>   out:
>   	if (readdir_ra)
> 
