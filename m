Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 001BB368A61
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 03:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbhDWBaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 21:30:52 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:17027 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236126AbhDWBau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 21:30:50 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FRGqL6ZBQzPtTq;
        Fri, 23 Apr 2021 09:27:10 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server (TLS) id 14.3.498.0; Fri, 23 Apr
 2021 09:30:09 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: set prefree as free segments after clear
 prefree segments
To:     Yangtao Li <frank.li@vivo.com>, <jaegeuk@kernel.org>,
        <chao@kernel.org>, <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <20210422125910.127871-1-frank.li@vivo.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <247c6055-c004-72a6-5093-3949c2ed8495@huawei.com>
Date:   Fri, 23 Apr 2021 09:30:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20210422125910.127871-1-frank.li@vivo.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.110.154]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/4/22 20:59, Yangtao Li wrote:
> For now, when do_checkpoint fails, the prefree bitmap is not cleared,
> but these segments are already in the free state. If these segments
> are used, the segments in use will be reset to the free state when
> f2fs_clear_prefree_segments is called next time.
> 
> So move set_prefree_as_free_segments after clear_prefree_segments.

That's not correct.

/*
  * Should call f2fs_clear_prefree_segments after checkpoint is done.
  */
static void set_prefree_as_free_segments(struct f2fs_sb_info *sbi)

Comments above set_prefree_as_free_segments() should have told you
the rule, otherwise if checkpoint failed, valid data in last valid
checkpoint could be corrupted after segment reuse.

Thanks,

> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   fs/f2fs/segment.c | 17 +----------------
>   1 file changed, 1 insertion(+), 16 deletions(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index c2866561263e..ea1334e17a0d 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -1945,20 +1945,6 @@ void f2fs_release_discard_addrs(struct f2fs_sb_info *sbi)
>   		release_discard_addr(entry);
>   }
>   
> -/*
> - * Should call f2fs_clear_prefree_segments after checkpoint is done.
> - */
> -static void set_prefree_as_free_segments(struct f2fs_sb_info *sbi)
> -{
> -	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
> -	unsigned int segno;
> -
> -	mutex_lock(&dirty_i->seglist_lock);
> -	for_each_set_bit(segno, dirty_i->dirty_segmap[PRE], MAIN_SEGS(sbi))
> -		__set_test_and_free(sbi, segno, false);
> -	mutex_unlock(&dirty_i->seglist_lock);
> -}
> -
>   void f2fs_clear_prefree_segments(struct f2fs_sb_info *sbi,
>   						struct cp_control *cpc)
>   {
> @@ -1993,6 +1979,7 @@ void f2fs_clear_prefree_segments(struct f2fs_sb_info *sbi,
>   		for (i = start; i < end; i++) {
>   			if (test_and_clear_bit(i, prefree_map))
>   				dirty_i->nr_dirty[PRE]--;
> +			__set_test_and_free(sbi, i, false);
>   		}
>   
>   		if (!f2fs_realtime_discard_enable(sbi))
> @@ -4188,8 +4175,6 @@ void f2fs_flush_sit_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>   		cpc->trim_start = trim_start;
>   	}
>   	up_write(&sit_i->sentry_lock);
> -
> -	set_prefree_as_free_segments(sbi);
>   }
>   
>   static int build_sit_info(struct f2fs_sb_info *sbi)
> 
