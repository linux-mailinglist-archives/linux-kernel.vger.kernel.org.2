Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D940F43BFD3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 04:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238020AbhJ0Ccy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 22:32:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:57306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230493AbhJ0Ccw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 22:32:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 188576103C;
        Wed, 27 Oct 2021 02:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635301827;
        bh=8jfjUOtLlxe1Xc4nIX3DS+wXCQH4UmC6cRfApye30ew=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lQ88DKTfET9VPgoo7bj4HF9AIg8fkFwu1V9yt58FgYGuGNXJg/Yuv9HngrNE+SbBq
         dc9aQhcCXXDCq4NEsBTx6qvJXvkOsdJ2lwEeQqdBIUdgn/slFkaigH/pZRvqX6aEs2
         mkNUE75+CYcVbviuw9NoGGfD3PTduW5S/2SFoRrJO6b0my4qPI37Ru4Jr1nIAGeem9
         S8PmFraPsy3rmY47cFuormXDVMwIPAvWvDUiYPWAuPG7c1qf3ePR/TQ6Ty5wnBv5uE
         xMK6AaY8EVQgIW9Er7ntE9Nr227wmrojlXe57zIkG2zdpz3J9qlnKP2qiTFxd1AYkh
         r1rwGJOQPVWiQ==
Message-ID: <d5ac2754-85a3-8935-d1f8-829539664ca0@kernel.org>
Date:   Wed, 27 Oct 2021 10:30:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Subject: Re: [PATCH] f2fs: compress: disallow disabling compress on non-empty
 compressed file
Content-Language: en-US
To:     Hyeong-Jun Kim <hj514.kim@samsung.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Sungjong Seo <sj1557.seo@samsung.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <CGME20211025140526epcas1p3b4a59df0935297572c6417c841a4c514@epcas1p3.samsung.com>
 <20211025140517.14741-1-hj514.kim@samsung.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20211025140517.14741-1-hj514.kim@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/10/25 22:05, Hyeong-Jun Kim wrote:
> Compresse file and normal file has differ in i_addr addressing,
> specifically addrs per inode/block. So, we will face data loss, if we
> disable the compression flag on non-empty files. Therefore we should
> disallow not only enabling but disabling the compression flag on
> non-empty files. >

Hi Hyeong-Jun,

I think this makes sense.

But one more case may bypass below condition, could you please take a look
at this case:

touch file
chattr +c file
f2fs_io pinfile set file
fallocate file -o 0 -l 16384 -n
chattr -c file

So it's better to check F2FS_HAS_BLOCKS() as well in the condition?

Fixes: 4c8ff7095bef ("f2fs: support data compression")

Thanks,

> Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
> Signed-off-by: Hyeong-Jun Kim <hj514.kim@samsung.com>
> ---
>   fs/f2fs/f2fs.h | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index b8e8f8c716b0..19146c834abd 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -4177,8 +4177,7 @@ static inline bool f2fs_disable_compressed_file(struct inode *inode)
>   
>   	if (!f2fs_compressed_file(inode))
>   		return true;
> -	if (S_ISREG(inode->i_mode) &&
> -		(get_dirty_pages(inode) || atomic_read(&fi->i_compr_blocks)))
> +	if (S_ISREG(inode->i_mode) && inode->i_size)
>   		return false;
>   
>   	fi->i_flags &= ~F2FS_COMPR_FL;
> 
