Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBEA1379C0B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 03:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhEKBaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 21:30:16 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2683 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbhEKBaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 21:30:16 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FfKyF6NNmz1BHww;
        Tue, 11 May 2021 09:26:29 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by smtp.huawei.com
 (10.3.19.203) with Microsoft SMTP Server (TLS) id 14.3.498.0; Tue, 11 May
 2021 09:29:07 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: avoid null pointer access when handling
 IPU error
To:     Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20210510142804.511265-1-jaegeuk@kernel.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <9df7d088-3580-122b-60a3-799ea665cfeb@huawei.com>
Date:   Tue, 11 May 2021 09:29:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20210510142804.511265-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.110.154]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/5/10 22:28, Jaegeuk Kim wrote:
>   Unable to handle kernel NULL pointer dereference at virtual address 000000000000001a
>   pc : f2fs_inplace_write_data+0x144/0x208
>   lr : f2fs_inplace_write_data+0x134/0x208
>   Call trace:
>    f2fs_inplace_write_data+0x144/0x208
>    f2fs_do_write_data_page+0x270/0x770
>    f2fs_write_single_data_page+0x47c/0x830
>    __f2fs_write_data_pages+0x444/0x98c
>    f2fs_write_data_pages.llvm.16514453770497736882+0x2c/0x38
>    do_writepages+0x58/0x118
>    __writeback_single_inode+0x44/0x300
>    writeback_sb_inodes+0x4b8/0x9c8
>    wb_writeback+0x148/0x42c
>    wb_do_writeback+0xc8/0x390
>    wb_workfn+0xb0/0x2f4
>    process_one_work+0x1fc/0x444
>    worker_thread+0x268/0x4b4
>    kthread+0x13c/0x158
>    ret_from_fork+0x10/0x18
> 
> Fixes: 955772787667 ("f2fs: drop inplace IO if fs status is abnormal")

My bad, thanks for fixing this.

> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>   fs/f2fs/segment.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index c605415840b5..ae875557d693 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -3577,9 +3577,11 @@ int f2fs_inplace_write_data(struct f2fs_io_info *fio)
>   	if (fio->bio) {
>   		struct bio *bio = *(fio->bio);
>   
> -		bio->bi_status = BLK_STS_IOERR;
> -		bio_endio(bio);
> -		fio->bio = NULL;
> +		if (bio) {
> +			bio->bi_status = BLK_STS_IOERR;
> +			bio_endio(bio);
> +			fio->bio = NULL;

fio->bio points a bio assigned in writepages(), so it should reset
that bio to NULL by *(fio->bio) = NULL.

Thanks,

> +		}
>   	}
>   	return err;
>   }
> 
