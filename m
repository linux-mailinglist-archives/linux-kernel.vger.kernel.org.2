Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCA4A3E40E5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 09:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233488AbhHIHfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 03:35:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41984 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233498AbhHIHfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 03:35:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628494516;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rl8X9okvlYfR8iDE1jtv9Hzx9xj5s4hp+iTOYsKFl2Y=;
        b=NUakwVHoYBkJrBgHPtMf80tJ0vhA5RFYBYY3KIeGlIfwTZFGjjfskCSvwTMJSnOkG4+E7g
        Tb73P1KS0GELEKX4uOjwG6kFDnXYoeyE1YnLF2pAXNyaw7nMCnQGQmauODVSgyqPZsGlLn
        zOAItQmRSPBBy8Te/2cX5j40CoVIXAM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-580-8lX7f6EUOyW6UCZDUYUe-w-1; Mon, 09 Aug 2021 03:35:15 -0400
X-MC-Unique: 8lX7f6EUOyW6UCZDUYUe-w-1
Received: by mail-wm1-f71.google.com with SMTP id 11-20020a05600c024bb02902e679d663d1so1261723wmj.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 00:35:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=rl8X9okvlYfR8iDE1jtv9Hzx9xj5s4hp+iTOYsKFl2Y=;
        b=fhfNJrRpamt5dqe1Qs/LKzX/ydXXPlh7SxRmRrVcQOmvAB40237J0mP9GBUSIOfZIn
         PVGTT2VBT5qCRmx7ktK0V1JmXSMU1Q2pVWUHBf+6edgfYdNnAzHw1VI/2qNXo0DA9nRv
         f2PGyCXfMN8rljXDl2Zyq0SpQ7PslYlR73UQkwz1zPcG4/xcJrAbjqNNNGfdV/F0VnLW
         jgu79Q79FBb+bqf9IYzuJknBfOzIcrmVoiSkCgC0CJUzRQOEDeuh97OfESfAFkQ5LnUG
         gYVIBoXKVuo4qMGNHwhRPIDZD0N19Ccv4vpJkNN6r/bczodgwjH9I0EIIxO0NM8EnWQt
         KFRw==
X-Gm-Message-State: AOAM531tZzZ5krujw56mnVYfxzfAItv9gMpA7h9/gqQV0qMQAWZjQ8H3
        U7oF/1vktEWmkkHKpOqiQEjCBQJ9piIS2WFVVgejnTuldemZgGiliAUpXP/P+ZiE8GulOEfOG5X
        vqGrV7rhRhpIPTHGhOrmQmnFd
X-Received: by 2002:a5d:55cb:: with SMTP id i11mr23249397wrw.158.1628494513878;
        Mon, 09 Aug 2021 00:35:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwET0FjNJfOicoIvhPZYDAmrbe03wsX0H3c356yu3WbSOtd2PSqPGq14qTm/tUGbraB0CrFDg==
X-Received: by 2002:a5d:55cb:: with SMTP id i11mr23249373wrw.158.1628494513694;
        Mon, 09 Aug 2021 00:35:13 -0700 (PDT)
Received: from ?IPv6:2003:d8:2f0a:7f00:fad7:3bc9:69d:31f? (p200300d82f0a7f00fad73bc9069d031f.dip0.t-ipconnect.de. [2003:d8:2f0a:7f00:fad7:3bc9:69d:31f])
        by smtp.gmail.com with ESMTPSA id p14sm155887wmi.42.2021.08.09.00.35.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Aug 2021 00:35:13 -0700 (PDT)
To:     Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
References: <20210805190253.2795604-1-zi.yan@sent.com>
 <20210805190253.2795604-10-zi.yan@sent.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH 09/15] virtio: virtio_mem: use PAGES_PER_SECTION
 instead of MAX_ORDER_NR_PAGES
Message-ID: <3e2f1910-e7d9-ddf9-063b-d702793f1525@redhat.com>
Date:   Mon, 9 Aug 2021 09:35:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210805190253.2795604-10-zi.yan@sent.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.08.21 21:02, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> It keeps the existing behavior when MAX_ORDER grows beyond a section
> size.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: virtualization@lists.linux-foundation.org
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> ---
>   drivers/virtio/virtio_mem.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
> index 19036922f7ef..bab5a81fa796 100644
> --- a/drivers/virtio/virtio_mem.c
> +++ b/drivers/virtio/virtio_mem.c
> @@ -1105,11 +1105,11 @@ static void virtio_mem_clear_fake_offline(unsigned long pfn,
>    */
>   static void virtio_mem_fake_online(unsigned long pfn, unsigned long nr_pages)
>   {
> -	const unsigned long max_nr_pages = MAX_ORDER_NR_PAGES;
> +	const unsigned long max_nr_pages = PAGES_PER_SECTION;
>   	unsigned long i;
>   
>   	/*
> -	 * We are always called at least with MAX_ORDER_NR_PAGES
> +	 * We are always called at least with PAGES_PER_SECTION
>   	 * granularity/alignment (e.g., the way subblocks work). All pages
>   	 * inside such a block are alike.
>   	 */
> @@ -1125,7 +1125,7 @@ static void virtio_mem_fake_online(unsigned long pfn, unsigned long nr_pages)
>   		if (PageDirty(page)) {
>   			virtio_mem_clear_fake_offline(pfn + i, max_nr_pages,
>   						      false);
> -			generic_online_page(page, MAX_ORDER - 1);
> +			generic_online_page(page, PAGES_PER_SECTION - 1);
>   		} else {
>   			virtio_mem_clear_fake_offline(pfn + i, max_nr_pages,
>   						      true);
> @@ -1228,7 +1228,7 @@ static void virtio_mem_online_page_cb(struct page *page, unsigned int order)
>   		if (vm->in_sbm) {
>   			/*
>   			 * We exploit here that subblocks have at least
> -			 * MAX_ORDER_NR_PAGES size/alignment - so we cannot
> +			 * PAGES_PER_SECTION size/alignment - so we cannot
>   			 * cross subblocks within one call.
>   			 */
>   			id = virtio_mem_phys_to_mb_id(addr);
> @@ -2438,14 +2438,14 @@ static int virtio_mem_init(struct virtio_mem *vm)
>   				      VIRTIO_MEM_DEFAULT_OFFLINE_THRESHOLD);
>   
>   	/*
> -	 * We want subblocks to span at least MAX_ORDER_NR_PAGES and
> +	 * We want subblocks to span at least PAGES_PER_SECTION and
>   	 * pageblock_nr_pages pages. This:
>   	 * - Simplifies our page onlining code (virtio_mem_online_page_cb)
>   	 *   and fake page onlining code (virtio_mem_fake_online).
>   	 * - Is required for now for alloc_contig_range() to work reliably -
>   	 *   it doesn't properly handle smaller granularity on ZONE_NORMAL.
>   	 */
> -	sb_size = max_t(uint64_t, MAX_ORDER_NR_PAGES,
> +	sb_size = max_t(uint64_t, PAGES_PER_SECTION,
>   			pageblock_nr_pages) * PAGE_SIZE;
>   	sb_size = max_t(uint64_t, vm->device_block_size, sb_size);
>   
> 

This is very much completely broken and destroys most of the purpose of 
virtio-mem. It even is broken once MAX_ORDER would exceed a single 
memory section I think.

Whatever you do, keep virtio-mem working *as is* unless someone 
explicitly sets MAX_ORDER on the command line to something bigger.


virtio-mem will require some minor adjustments once MAX_ORDER_NR_PAGES 
would exceed the memory section size -- the functionality will, however, 
be heavily degraded once you increase MAX_ORDER_NR_PAGES in any way 
(again, which is fine if it's explicitly done by an admin on the command 
line).

As mentioned somewhere else already, we'll have to tackle 
alloc_contig_range() to properly deal with pageblock_order granularity, 
then we can rework virtio-mem code to be based on that instead of 
MAX_ORDER - 1.

-- 
Thanks,

David / dhildenb

