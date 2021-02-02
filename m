Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEB0430B521
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 03:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbhBBCQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 21:16:16 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:11967 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbhBBCQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 21:16:13 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DV7fn2wtrzjGdm;
        Tue,  2 Feb 2021 10:14:25 +0800 (CST)
Received: from [10.174.179.241] (10.174.179.241) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Tue, 2 Feb 2021 10:15:26 +0800
Subject: Re: [PATCH] mm/page_io: Use pr_alert_ratelimited for swap read/write
 errors
To:     Georgi Djakov <georgi.djakov@linaro.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210201142055.29068-1-georgi.djakov@linaro.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <dc9e1b85-b657-565c-cec1-683eafb35f9f@huawei.com>
Date:   Tue, 2 Feb 2021 10:15:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210201142055.29068-1-georgi.djakov@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.241]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:
On 2021/2/1 22:20, Georgi Djakov wrote:
> If there are errors during swap read or write, they can easily fill
> the log buffer and remove any previous messages that might be useful
> for debugging, especially on systems that rely for logging only on
> the kernel ring-buffer.
> 
> For example, on a systems using zram as swap, we are more likely to
> see any page allocation errors preceding the swap write errors if the
> alerts are ratelimited.
> 
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>

Make sense for me. Thanks.
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

> ---
>  mm/page_io.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/page_io.c b/mm/page_io.c
> index 92f7941c6d01..485fa5cca4a2 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -41,9 +41,9 @@ void end_swap_bio_write(struct bio *bio)
>  		 * Also clear PG_reclaim to avoid rotate_reclaimable_page()
>  		 */
>  		set_page_dirty(page);
> -		pr_alert("Write-error on swap-device (%u:%u:%llu)\n",
> -			 MAJOR(bio_dev(bio)), MINOR(bio_dev(bio)),
> -			 (unsigned long long)bio->bi_iter.bi_sector);
> +		pr_alert_ratelimited("Write-error on swap-device (%u:%u:%llu)\n",
> +				     MAJOR(bio_dev(bio)), MINOR(bio_dev(bio)),
> +				     (unsigned long long)bio->bi_iter.bi_sector);
>  		ClearPageReclaim(page);
>  	}
>  	end_page_writeback(page);
> @@ -106,9 +106,9 @@ static void end_swap_bio_read(struct bio *bio)
>  	if (bio->bi_status) {
>  		SetPageError(page);
>  		ClearPageUptodate(page);
> -		pr_alert("Read-error on swap-device (%u:%u:%llu)\n",
> -			 MAJOR(bio_dev(bio)), MINOR(bio_dev(bio)),
> -			 (unsigned long long)bio->bi_iter.bi_sector);
> +		pr_alert_ratelimited("Read-error on swap-device (%u:%u:%llu)\n",
> +				     MAJOR(bio_dev(bio)), MINOR(bio_dev(bio)),
> +				     (unsigned long long)bio->bi_iter.bi_sector);
>  		goto out;
>  	}
>  
> 
> .
> 

