Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC804413C0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 07:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbhKAGbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 02:31:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:51774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229958AbhKAGbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 02:31:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7CB9160F45;
        Mon,  1 Nov 2021 06:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635748116;
        bh=Q35jh+CN4KR3qBGtwUC476UVincVnoNSqWeaxprxOfI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=R2IlUzHUzSP/BewvftxjuQt8MwiNhPrq/OUyksH0OCvt2gQUexj7tfumXGgRJ5ysH
         rBdJn/1Gt+FB9eFiy5mUlc4U3OVocTYbGeqknoXVBdq9kMK7EFI5ENtdPrXHVnjMxP
         w+guFrtqhmIBZsm+TVMetoH6eHpGE9AAOoL0H4t/138d5cH884XqggGw24uc1UbVHW
         vX5tmklSWetaX6jRIRn8PIbp7NY201+TBIYrqzKmNAke05Xdycho+1M6YHQSHYmeh0
         PPz3mFkWFRA9M4JQVyAFYglf/1ro/KbYmJ++ULKiP1gycUDDjCN0M7O3NTvLCOHHiC
         T0HvGDOfZfXFQ==
Message-ID: <d1929b64-15a3-feaf-5401-1552b2eb2461@kernel.org>
Date:   Mon, 1 Nov 2021 14:28:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH] F2FS: invalidate META_MAPPING before IPU/DIO write
Content-Language: en-US
To:     Hyeong-Jun Kim <hj514.kim@samsung.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <CGME20211101054217epcas1p3c695f37ab925f47156bd45e3adb5ed94@epcas1p3.samsung.com>
 <20211101054214.24456-1-hj514.kim@samsung.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20211101054214.24456-1-hj514.kim@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/11/1 13:42, Hyeong-Jun Kim wrote:
> Encrypted pages during GC are read and cached in META_MAPPING.
> However, due to cached pages in META_MAPPING, there is an issue where
> newly written pages are lost by IPU or DIO writes.
> 
> Thread A                              Thread B
> - f2fs_gc(): blk 0x10 -> 0x20 (a)
>                                        - IPU or DIO write on blk 0x20 (b)
> - f2fs_gc(): blk 0x20 -> 0x30 (c)
> 
> (a) page for blk 0x20 is cached in META_MAPPING and page for blk 0x10
>      is invalidated from META_MAPPING.
> (b) write new data to blk 0x200 using IPU or DIO, but outdated data
>      still remains in META_MAPPING.
> (c) f2fs_gc() try to move blk from 0x20 to 0x30 using cached page in
>      META_MAPPING. In conclusion, the newly written data in (b) is lost.

In c), f2fs_gc() will readahead encrypted block from disk via ra_data_block() anyway,
not matter cached encrypted page of meta inode is uptodate or not, so it's safe, right?

Am I missing anything?

Thanks,

> 
> To address this issue, invalidating pages in META_MAPPING before IPU or
> DIO write.
> 
> Signed-off-by: Hyeong-Jun Kim <hj514.kim@samsung.com>
> ---
>   fs/f2fs/data.c    | 2 ++
>   fs/f2fs/segment.c | 3 +++
>   2 files changed, 5 insertions(+)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 74e1a350c1d8..9f754aaef558 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -1708,6 +1708,8 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
>   		 */
>   		f2fs_wait_on_block_writeback_range(inode,
>   						map->m_pblk, map->m_len);
> +		invalidate_mapping_pages(META_MAPPING(sbi),
> +						map->m_pblk, map->m_pblk);
>   
>   		if (map->m_multidev_dio) {
>   			block_t blk_addr = map->m_pblk;
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 526423fe84ce..f57c55190f9e 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -3652,6 +3652,9 @@ int f2fs_inplace_write_data(struct f2fs_io_info *fio)
>   		goto drop_bio;
>   	}
>   
> +	invalidate_mapping_pages(META_MAPPING(fio->sbi),
> +				fio->new_blkaddr, fio->new_blkaddr);
> +
>   	stat_inc_inplace_blocks(fio->sbi);
>   
>   	if (fio->bio && !(SM_I(sbi)->ipu_policy & (1 << F2FS_IPU_NOCACHE)))
> 
