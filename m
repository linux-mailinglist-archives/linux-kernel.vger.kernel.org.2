Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A309436118
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 14:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbhJUMNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 08:13:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:56122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229765AbhJUMNj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 08:13:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BA95D6120C;
        Thu, 21 Oct 2021 12:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634818284;
        bh=l6RlEt0NEP+wUUaiwunsNXw+CERWuWBXIp8i5TT1qUs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=heKUUSPIqGR8MdLQKSk32+oNXXHyTM5L0UO/E4WKrptRN3zaROJS5aY1SDlt7V14h
         HNH1+t4Hv9S8Nof+xJtQUmhKICWZ2yANGNI6CDI86RxrxnZMmNCnLWN3mLMMPphXsX
         916vECaeqmliZjpbu05MOq4xAZMtsSmmGL1Li6c7LaxOHA+zW9RLpSCvDRsL51fzYw
         BvAOELBGozQND8uxb2IhG18Fc6JjYuhMD4beAr0rrpPGzSYkiiq9uxlqinG5HWnaSK
         KMwTUPcEcdQpQG5dVZ2LsQgZ9MtTR9xD5K+OxYDtP8gpYcKZ6Hh3+GsqbOumSLRoLs
         JdDI5Ar3sggHg==
Message-ID: <e8b106fb-2878-2fa9-788f-965eef179a85@kernel.org>
Date:   Thu, 21 Oct 2021 20:11:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [f2fs-dev] [PATCH] f2fs: remove circular locking between
 sb_internal and fs_reclaim
Content-Language: en-US
To:     Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
References: <20211014190503.717830-1-daeho43@gmail.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20211014190503.717830-1-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/10/15 3:05, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> We detected the below circular locking dependency between sb_internal
> and fs_reclaim. So, removed it by calling dquot_initialize() before
> sb_start_intwrite().
> 
>   ======================================================
>   WARNING: possible circular locking dependency detected
>   ------------------------------------------------------
>   kswapd0/133 is trying to acquire lock:
> ffffff80d5fb9680 (sb_internal#2){.+.+}-{0:0}, at: evict+0xd4/0x2f8
> 
> but task is already holding lock:
> ffffffda597c93a8 (fs_reclaim){+.+.}-{0:0}, at:
> __fs_reclaim_acquire+0x4/0x50
> 
> which lock already depends on the new lock.
> ...
> other info that might help us debug this:
> 
>   Chain exists of:
> 
> sb_internal#2 --> &s->s_dquot.dqio_sem --> fs_reclaim
> 
>    Possible unsafe locking scenario:
> 
>          CPU0                    CPU1
>          ----                    ----
>     lock(fs_reclaim);
>                                  lock(&s->s_dquot.dqio_sem);
>                                  lock(fs_reclaim);
>     lock(sb_internal#2);

Sorry, I still didn't get the root cause of this deadlock issue, could
you please explain more about this?

And why calling dquot_initialize() in drop_inode() could break the
circular locking dependency?

Thanks,

> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
>   fs/f2fs/super.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 86eeb019cc52..a133932333c5 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1370,6 +1370,8 @@ static int f2fs_drop_inode(struct inode *inode)
>   			/* should remain fi->extent_tree for writepage */
>   			f2fs_destroy_extent_node(inode);
>   
> +			dquot_initialize(inode);
> +
>   			sb_start_intwrite(inode->i_sb);
>   			f2fs_i_size_write(inode, 0);
>   
> 
