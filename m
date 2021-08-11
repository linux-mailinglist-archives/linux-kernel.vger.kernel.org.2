Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 821A53E87FB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 04:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbhHKCZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 22:25:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:52630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231233AbhHKCZf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 22:25:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D302260EB2;
        Wed, 11 Aug 2021 02:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628648712;
        bh=SNkK8Gy4KILIfp0TFUEVNShMLEV17bUDZoDxLk6DdOY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=EHXpHMMJrXJs3zQ1Cujlqr2KCcv2Ys70sq5B8xU8l3YegJg+syhUJvfZj8VDY77h5
         QXNrQbZv36IMKTtr6MrCzWW9l7spwGKLly+uHtrLBBri8jovJKLq7LPBX0L5NaC4eA
         n6/jEAKVF9jgFcPUoAnCXAGlA41jnyD0Mak8bENZlDSbK5cmRmSLi0xX5pAPwLJHad
         hebfpFTmiXHeIsnwky/xeimoMEHECKMXejbqSfjNle3QENeOT87InacrDTt/cMYzOX
         EKUAvWOaxgBUEAQwLZy1zX6zJPFN023BKtJDHLyF1KxyNYNRCUyuzIZNInunrmaogl
         P6kDAysC7Kbbg==
Subject: Re: [f2fs-dev] [PATCH] f2fs: improve sbi status info in
 debugfs/f2fs/status
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20210810132707.349147-1-frank.li@vivo.com>
 <20210810132707.349147-2-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <bb2f564d-325b-b082-c001-a33187329d27@kernel.org>
Date:   Wed, 11 Aug 2021 10:25:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210810132707.349147-2-frank.li@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/8/10 21:27, Yangtao Li wrote:
> Do not use numbers but strings to improve readability.

I'm fine with this, but not sure it's what Jaeguek wants.

> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   fs/f2fs/debug.c | 28 +++++++++++++++++++++++-----
>   1 file changed, 23 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
> index 473ad04d1891..91c0910b0bb7 100644
> --- a/fs/f2fs/debug.c
> +++ b/fs/f2fs/debug.c
> @@ -323,22 +323,40 @@ static void update_mem_info(struct f2fs_sb_info *sbi)
>   #endif
>   }
>   
> +static char *s_flag[] = {
> +	[SBI_IS_DIRTY]		= " dirty",

fs_dirty

> +	[SBI_IS_CLOSE]		= " close",

closing

> +	[SBI_NEED_FSCK]		= " fsck",

need_fsck

> +	[SBI_POR_DOING]		= " doing",

recovering

> +	[SBI_NEED_SB_WRITE]	= " sb_write",

sb_dirty

> +	[SBI_NEED_CP]		= " cp",

need_cp

> +	[SBI_IS_SHUTDOWN]	= " shutdown",
> +	[SBI_IS_RECOVERED]	= " recovered",
> +	[SBI_CP_DISABLED]	= " cp_disabled",
> +	[SBI_CP_DISABLED_QUICK]	= " cp_disabled_quick",
> +	[SBI_QUOTA_NEED_FLUSH]	= " quota_need_flush",
> +	[SBI_QUOTA_SKIP_FLUSH]	= " quota_skip_flush",
> +	[SBI_QUOTA_NEED_REPAIR]	= " quota_need_repair",
> +	[SBI_IS_RESIZEFS]	= " resizefs",
> +};
> +
>   static int stat_show(struct seq_file *s, void *v)
>   {
>   	struct f2fs_stat_info *si;
> -	int i = 0;
> -	int j;
> +	int i = 0, j = 0;
>   
>   	mutex_lock(&f2fs_stat_mutex);
>   	list_for_each_entry(si, &f2fs_stat_list, stat_list) {
>   		update_general_status(si->sbi);
>   
> -		seq_printf(s, "\n=====[ partition info(%pg). #%d, %s, CP: %s (sbi: 0x%lx)]=====\n",
> +		seq_printf(s, "\n=====[ partition info(%pg). #%d, %s, CP: %s (sbi:",
>   			si->sbi->sb->s_bdev, i++,
>   			f2fs_readonly(si->sbi->sb) ? "RO": "RW",
>   			is_set_ckpt_flags(si->sbi, CP_DISABLED_FLAG) ?
> -			"Disabled": (f2fs_cp_error(si->sbi) ? "Error": "Good"),
> -			si->sbi->s_flag);
> +			"Disabled" : (f2fs_cp_error(si->sbi) ? "Error" : "Good"));
> +		for_each_set_bit(j, &si->sbi->s_flag, 32)
> +			seq_puts(s, s_flag[j]);

How about starting to print sb related status in a new line to avoid
extreme long line.

Thanks,

> +		seq_puts(s, ") ]=====\n");
>   		seq_printf(s, "[SB: 1] [CP: 2] [SIT: %d] [NAT: %d] ",
>   			   si->sit_area_segs, si->nat_area_segs);
>   		seq_printf(s, "[SSA: %d] [MAIN: %d",
> 
