Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52B5D36D93F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 16:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240149AbhD1OHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 10:07:22 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:40335 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231359AbhD1OHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 10:07:21 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R531e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=xuyu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UX4Z7HA_1619618792;
Received: from xuyu-mbp15.local(mailfrom:xuyu@linux.alibaba.com fp:SMTPD_---0UX4Z7HA_1619618792)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 28 Apr 2021 22:06:33 +0800
Subject: Re: [PATCH] mm, compaction: avoid isolating pinned tmpfs pages
From:   Yu Xu <xuyu@linux.alibaba.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org
References: <e2f0689e00cce7ac73716da14a971a4f1ab88359.1619618267.git.xuyu@linux.alibaba.com>
Message-ID: <b6d1e9f1-0601-6e48-9488-8b674a405a62@linux.alibaba.com>
Date:   Wed, 28 Apr 2021 22:06:55 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <e2f0689e00cce7ac73716da14a971a4f1ab88359.1619618267.git.xuyu@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/28/21 10:00 PM, Xu Yu wrote:
> This makes pinned tmpfs pages bail out early in the process of page
> migration, like what pinned anonymous pages do.
> 
> Signed-off-by: Xu Yu <xuyu@linux.alibaba.com>
> ---
>   mm/compaction.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index e04f4476e68e..78c3b992a1c9 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -964,11 +964,11 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>   		}
>   
>   		/*
> -		 * Migration will fail if an anonymous page is pinned in memory,
> -		 * so avoid taking lru_lock and isolating it unnecessarily in an
> -		 * admittedly racy check.
> +		 * Migration will fail if an anonymous or tmpfs page is pinned
> +		 * in memory, so avoid taking lru_lock and isolating it
> +		 * unnecessarily in an admittedly racy check.
>   		 */
> -		if (!page_mapping(page) &&
> +		if (!page_is_file_lru(page) &&
>   		    page_count(page) > page_mapcount(page))
Sorry, this patch is flawed, since tmpfs page cache takes an extra page
count.

Please ignore this patch.

>   			goto isolate_fail;
>   
> 

-- 
Thanks,
Yu
