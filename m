Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4A338E6A7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 14:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232692AbhEXMfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 08:35:52 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5683 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbhEXMft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 08:35:49 -0400
Received: from dggems705-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Fpc5X6jDwz1BR7C;
        Mon, 24 May 2021 20:31:28 +0800 (CST)
Received: from dggeme703-chm.china.huawei.com (10.1.199.99) by
 dggems705-chm.china.huawei.com (10.3.19.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 20:34:19 +0800
Received: from [10.174.178.68] (10.174.178.68) by
 dggeme703-chm.china.huawei.com (10.1.199.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 24 May 2021 20:34:18 +0800
Subject: Re: [PATCH] mm/swapfile: move scan_swap_map() under
 CONFIG_HIBERNATION
To:     Christoph Hellwig <hch@infradead.org>
CC:     <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
References: <20210521070855.2015094-1-linmiaohe@huawei.com>
 <YKuW3C6kAOwSfqnr@infradead.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <83041232-d5a7-1dc1-3137-d497ee7405bd@huawei.com>
Date:   Mon, 24 May 2021 20:34:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YKuW3C6kAOwSfqnr@infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.68]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/5/24 20:06, Christoph Hellwig wrote:
> Please just fold it into the only caller and update the comments
> referring to it.  Something like:

Sounds reasonable. Many thanks for your suggestion! Will do it in next version.

> 
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 149e77454e3c..0e575b45bb87 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -452,10 +452,10 @@ static void swap_cluster_schedule_discard(struct swap_info_struct *si,
>  		unsigned int idx)
>  {
>  	/*
> -	 * If scan_swap_map() can't find a free cluster, it will check
> +	 * If scan_swap_map_slots() can't find a free cluster, it will check
>  	 * si->swap_map directly. To make sure the discarding cluster isn't
> -	 * taken by scan_swap_map(), mark the swap entries bad (occupied). It
> -	 * will be cleared after discard
> +	 * taken by scan_swap_map_slots(), mark the swap entries bad (occupied).
> +	 * It will be cleared after discard
>  	 */
>  	memset(si->swap_map + idx * SWAPFILE_CLUSTER,
>  			SWAP_MAP_BAD, SWAPFILE_CLUSTER);
> @@ -580,7 +580,7 @@ static void dec_cluster_info_page(struct swap_info_struct *p,
>  }
>  
>  /*
> - * It's possible scan_swap_map() uses a free cluster in the middle of free
> + * It's possible scan_swap_map_slots() uses a free cluster in the middle of free
>   * cluster list. Avoiding such abuse to avoid list corruption.
>   */
>  static bool
> @@ -1028,21 +1028,6 @@ static void swap_free_cluster(struct swap_info_struct *si, unsigned long idx)
>  	swap_range_free(si, offset, SWAPFILE_CLUSTER);
>  }
>  
> -static unsigned long scan_swap_map(struct swap_info_struct *si,
> -				   unsigned char usage)
> -{
> -	swp_entry_t entry;
> -	int n_ret;
> -
> -	n_ret = scan_swap_map_slots(si, usage, 1, &entry);
> -
> -	if (n_ret)
> -		return swp_offset(entry);
> -	else
> -		return 0;
> -
> -}
> -
>  int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_size)
>  {
>  	unsigned long size = swap_entry_size(entry_size);
> @@ -1105,14 +1090,14 @@ int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_size)
>  nextsi:
>  		/*
>  		 * if we got here, it's likely that si was almost full before,
> -		 * and since scan_swap_map() can drop the si->lock, multiple
> -		 * callers probably all tried to get a page from the same si
> -		 * and it filled up before we could get one; or, the si filled
> -		 * up between us dropping swap_avail_lock and taking si->lock.
> -		 * Since we dropped the swap_avail_lock, the swap_avail_head
> -		 * list may have been modified; so if next is still in the
> -		 * swap_avail_head list then try it, otherwise start over
> -		 * if we have not gotten any slots.
> +		 * and since scan_swap_map_slots() can drop the si->lock,
> +		 * multiple callers probably all tried to get a page from the
> +		 * same si and it filled up before we could get one; or, the si
> +		 * filled up between us dropping swap_avail_lock and taking
> +		 * si->lock.  Since we dropped the swap_avail_lock, the
> +		 * swap_avail_head list may have been modified; so if next is
> +		 * still in the swap_avail_head list then try it, otherwise
> +		 * start over if we have not gotten any slots.
>  		 */
>  		if (plist_node_empty(&next->avail_lists[node]))
>  			goto start_over;
> @@ -1132,24 +1117,18 @@ int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_size)
>  swp_entry_t get_swap_page_of_type(int type)
>  {
>  	struct swap_info_struct *si = swap_type_to_swap_info(type);
> -	pgoff_t offset;
> +	swp_entry_t entry = { };
>  
>  	if (!si)
>  		goto fail;
>  
> +	/* This is called for allocating swap entry, not cache */
>  	spin_lock(&si->lock);
> -	if (si->flags & SWP_WRITEOK) {
> -		/* This is called for allocating swap entry, not cache */
> -		offset = scan_swap_map(si, 1);
> -		if (offset) {
> -			atomic_long_dec(&nr_swap_pages);
> -			spin_unlock(&si->lock);
> -			return swp_entry(type, offset);
> -		}
> -	}
> +	if ((si->flags & SWP_WRITEOK) && scan_swap_map_slots(si, 1, 1, &entry))
> +		atomic_long_dec(&nr_swap_pages);
>  	spin_unlock(&si->lock);
>  fail:
> -	return (swp_entry_t) {0};
> +	return entry;
>  }
>  
>  static struct swap_info_struct *__swap_info_get(swp_entry_t entry)
> .
> 

