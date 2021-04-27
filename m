Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5351E36C629
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 14:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236160AbhD0MiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 08:38:08 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:5140 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235476AbhD0MiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 08:38:07 -0400
Received: from dggemx753-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FV1S64fNPzYbXh;
        Tue, 27 Apr 2021 20:35:02 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by
 dggemx753-chm.china.huawei.com (10.0.44.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 27 Apr 2021 20:37:18 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: reset free segment to prefree status
 when do_checkpoint() fail
To:     Yangtao Li <frank.li@vivo.com>, <jaegeuk@kernel.org>,
        <chao@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20210427082106.2755-1-frank.li@vivo.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <12ae52df-bc5e-82c3-4f78-1eafe7723f93@huawei.com>
Date:   Tue, 27 Apr 2021 20:37:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20210427082106.2755-1-frank.li@vivo.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.110.154]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggemx753-chm.china.huawei.com (10.0.44.37)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/4/27 16:21, Yangtao Li wrote:
> When do_checkpoint() fails, the prefree bitmap is not cleared,
> but these segments are already in the free state. If these segments
> are used, the segments in use will be reset to the free state when
> f2fs_clear_prefree_segments is called next time.
> 
> So reset free segments to prefree status when do_checkpoint() fail
> to avoid this situation.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   fs/f2fs/checkpoint.c |  6 ++++--
>   fs/f2fs/f2fs.h       |  1 +
>   fs/f2fs/segment.c    | 13 +++++++++++++
>   fs/f2fs/segment.h    |  7 ++++++-
>   4 files changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index be5415a0dbbc..0200af4d02ef 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -1647,10 +1647,12 @@ int f2fs_write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>   	f2fs_save_inmem_curseg(sbi);
>   
>   	err = do_checkpoint(sbi, cpc);
> -	if (err)
> +	if (err) {
>   		f2fs_release_discard_addrs(sbi);
> -	else
> +		f2fs_set_free_as_prefree_segments(sbi);
> +	} else {
>   		f2fs_clear_prefree_segments(sbi, cpc);
> +	}
>   
>   	f2fs_restore_inmem_curseg(sbi);
>   stop:
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index e2d302ae3a46..1618e9a74e89 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -3369,6 +3369,7 @@ bool f2fs_is_checkpointed_data(struct f2fs_sb_info *sbi, block_t blkaddr);
>   void f2fs_drop_discard_cmd(struct f2fs_sb_info *sbi);
>   void f2fs_stop_discard_thread(struct f2fs_sb_info *sbi);
>   bool f2fs_issue_discard_timeout(struct f2fs_sb_info *sbi);
> +void f2fs_set_free_as_prefree_segments(struct f2fs_sb_info *sbi);
>   void f2fs_clear_prefree_segments(struct f2fs_sb_info *sbi,
>   					struct cp_control *cpc);
>   void f2fs_dirty_to_prefree(struct f2fs_sb_info *sbi);
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index c2866561263e..334e499a0f43 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -1959,6 +1959,19 @@ static void set_prefree_as_free_segments(struct f2fs_sb_info *sbi)
>   	mutex_unlock(&dirty_i->seglist_lock);
>   }
>   
> +void f2fs_set_free_as_prefree_segments(struct f2fs_sb_info *sbi)
> +{
> +	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
> +	unsigned int segno;
> +
> +	mutex_lock(&dirty_i->seglist_lock);
> +	for_each_set_bit(segno, dirty_i->dirty_segmap[PRE], MAIN_SEGS(sbi)) {
> +		if (__set_test_and_inuse(sbi, segno))
> +			test_and_clear_bit(segno, dirty_i->dirty_segmap[PRE]);
> +	}
> +	mutex_unlock(&dirty_i->seglist_lock);
> +}
> +
>   void f2fs_clear_prefree_segments(struct f2fs_sb_info *sbi,
>   						struct cp_control *cpc)
>   {
> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> index e9a7a637d688..5da8d1100b87 100644
> --- a/fs/f2fs/segment.h
> +++ b/fs/f2fs/segment.h
> @@ -487,19 +487,24 @@ static inline void __set_test_and_free(struct f2fs_sb_info *sbi,
>   	spin_unlock(&free_i->segmap_lock);
>   }
>   
> -static inline void __set_test_and_inuse(struct f2fs_sb_info *sbi,
> +static inline bool __set_test_and_inuse(struct f2fs_sb_info *sbi,
>   		unsigned int segno)
>   {
>   	struct free_segmap_info *free_i = FREE_I(sbi);
>   	unsigned int secno = GET_SEC_FROM_SEG(sbi, segno);
> +	bool is_inuse = false;
>   
>   	spin_lock(&free_i->segmap_lock);
>   	if (!test_and_set_bit(segno, free_i->free_segmap)) {
>   		free_i->free_segments--;
>   		if (!test_and_set_bit(secno, free_i->free_secmap))

if (!IS_CURSEC(sbi, secno) &&
	!test_and_set_bit(secno, free_i->free_secmap))

I think just reverting dirty/free bitmap is not enough if checkpoint fails,
due to we have updated sbi->cur_cp_pack and nat/sit bitmap, next CP tries
to overwrite last valid meta/node/data, then filesystem will be corrupted.

So I suggest to set cp_error if do_checkpoint() fails until we can handle
all cases, which is not so easy.

How do you think?

Thanks,

>   			free_i->free_sections--;
> +	} else {
> +		is_inuse = true;
>   	}
>   	spin_unlock(&free_i->segmap_lock);
> +
> +	return is_inuse;
>   }
>   
>   static inline void get_sit_bitmap(struct f2fs_sb_info *sbi,
> 
