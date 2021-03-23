Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A50F34654E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 17:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233329AbhCWQfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 12:35:30 -0400
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:21037 "EHLO
        ste-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233316AbhCWQe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 12:34:59 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id AF9363FD99;
        Tue, 23 Mar 2021 17:34:57 +0100 (CET)
Authentication-Results: ste-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=dWhU36oH;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
        DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
        URIBL_BLOCKED=0.001] autolearn=ham autolearn_force=no
Authentication-Results: ste-ftg-msa2.bahnhof.se (amavisd-new);
        dkim=pass (1024-bit key) header.d=shipmail.org
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9IherXCBi9lB; Tue, 23 Mar 2021 17:34:56 +0100 (CET)
Received: by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id B899F3FD1E;
        Tue, 23 Mar 2021 17:34:54 +0100 (CET)
Received: from [192.168.0.209] (unknown [192.198.151.43])
        by mail1.shipmail.org (Postfix) with ESMTPSA id B711336062E;
        Tue, 23 Mar 2021 17:34:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1616517294; bh=gIwnz5YrpsvMLr1ZSuPnF+kvE+yWmQ+lrSIsK/yX9/I=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=dWhU36oHnZbX8U7bf7qWiXkbbDKceZ/x7UyGk/7i1aBzR0TvA9LH9lzV6kmq4XyQB
         wORqOco+jomxT/WEyvcBbXxqkpKtCF3gresSz/G8v8tlnZOC2JStyhn9LU9EPMB97v
         ISBy4xgjnQESYi2ph174xiD/L9m3ADfw4ZwHb+AI=
Subject: Re: [RFC PATCH 1/2] mm,drm/ttm: Block fast GUP to TTM huge pages
To:     dri-devel@lists.freedesktop.org,
        Christian Koenig <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210321184529.59006-1-thomas_os@shipmail.org>
 <20210321184529.59006-2-thomas_os@shipmail.org>
 <YFnST5VLcEgv9q+s@phenom.ffwll.local>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28Intel=29?= 
        <thomas_os@shipmail.org>
Message-ID: <314fc020-d243-dbf0-acb3-ecfcc9c2443c@shipmail.org>
Date:   Tue, 23 Mar 2021 17:34:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YFnST5VLcEgv9q+s@phenom.ffwll.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/23/21 12:34 PM, Daniel Vetter wrote:
> On Sun, Mar 21, 2021 at 07:45:28PM +0100, Thomas Hellström (Intel) wrote:
>> TTM sets up huge page-table-entries both to system- and device memory,
>> and we don't want gup to assume there are always valid backing struct
>> pages for these. For PTEs this is handled by setting the pte_special bit,
>> but for the huge PUDs and PMDs, we have neither pmd_special nor
>> pud_special. Normally, huge TTM entries are identified by looking at
>> vma_is_special_huge(), but fast gup can't do that, so as an alternative
>> define _devmap entries for which there are no backing dev_pagemap as
>> special, update documentation and make huge TTM entries _devmap, after
>> verifying that there is no backing dev_pagemap.
>>
>> One other alternative would be to block TTM huge page-table-entries
>> completely, and while currently only vmwgfx use them, they would be
>> beneficial to other graphis drivers moving forward as well.
>>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Cc: David Airlie <airlied@linux.ie>
>> Cc: Daniel Vetter <daniel@ffwll.ch>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Jason Gunthorpe <jgg@nvidia.com>
>> Cc: linux-mm@kvack.org
>> Cc: dri-devel@lists.freedesktop.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Thomas Hellström (Intel) <thomas_os@shipmail.org>
>> ---
>>   drivers/gpu/drm/ttm/ttm_bo_vm.c | 17 ++++++++++++++++-
>>   mm/gup.c                        | 21 +++++++++++----------
>>   mm/memremap.c                   |  5 +++++
>>   3 files changed, 32 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c b/drivers/gpu/drm/ttm/ttm_bo_vm.c
>> index 6dc96cf66744..1c34983480e5 100644
>> --- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
>> +++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
>> @@ -195,6 +195,7 @@ static vm_fault_t ttm_bo_vm_insert_huge(struct vm_fault *vmf,
>>   	pfn_t pfnt;
>>   	struct ttm_tt *ttm = bo->ttm;
>>   	bool write = vmf->flags & FAULT_FLAG_WRITE;
>> +	struct dev_pagemap *pagemap;
>>   
>>   	/* Fault should not cross bo boundary. */
>>   	page_offset &= ~(fault_page_size - 1);
>> @@ -210,6 +211,20 @@ static vm_fault_t ttm_bo_vm_insert_huge(struct vm_fault *vmf,
>>   	if ((pfn & (fault_page_size - 1)) != 0)
>>   		goto out_fallback;
>>   
>> +	/*
>> +	 * Huge entries must be special, that is marking them as devmap
>> +	 * with no backing device map range. If there is a backing
>> +	 * range, Don't insert a huge entry.
>> +	 * If this check turns out to be too much of a performance hit,
>> +	 * we can instead have drivers indicate whether they may have
>> +	 * backing device map ranges and if not, skip this lookup.
>> +	 */
> I think we can do this statically:
> - if it's system memory we know there's no devmap for it, and we do the
>    trick to block gup_fast
Yes, that should work.
> - if it's iomem, we know gup_fast wont work anyway if don't set PFN_DEV,
>    so might as well not do that

I think gup_fast will unfortunately mistake a huge iomem page for an 
ordinary page and try to access a non-existant struct page for it, 
unless we do the devmap trick.

And the lookup would then be for the rare case where a driver would have 
already registered a dev_pagemap for an iomem area which may also be 
mapped through TTM (like the patch from Felix a couple of weeks ago). If 
a driver can promise not to do that, then we can safely remove the lookup.

/Thomas


