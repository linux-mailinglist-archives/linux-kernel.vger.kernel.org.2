Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77ABE44B2C1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 19:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242494AbhKIShb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 13:37:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241812AbhKISh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 13:37:28 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2951C061767
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 10:34:40 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id t11so295359ljh.6
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 10:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=wYP3HVRde9HU03o1pyiBUvyAhQ1zAXnZFwQs8FMc5XA=;
        b=d6RdCnuz1sHqg4dhfAoqeam1gDpCZrmMg3MQfrdsTdIV+utHuLtBnDS2lNDGJL4v6e
         vs2VpDeDZ6/1yfiqaNAW0wFv706OPsI7nlGX0PwE+v/rPOo53Kj6miiHufsvbeiCg3dR
         3oelBP7b0XHKz02Vj/A4GjuPWSosC3m2hMn9YHAKp1Cu86vjq1sXdo6LTnNAhJa/kCF0
         ziZVklS57cwny7TDn2xzSkk8JtLFIGbbCUbPjov191oEsUiFB8OBIaXRHwZFJ1thCkS9
         gIvVYVzNeLGlzpMmavg/znkKcuemW1XYvC1PQz8yzuUhFL8yaSmNJVS/tTq7ZtNKWIsg
         7NGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=wYP3HVRde9HU03o1pyiBUvyAhQ1zAXnZFwQs8FMc5XA=;
        b=qs8m6Xc7/Vnju0Wyh27XhQnZ8fMEhLc0ux9UtF5mPOSMAVqxVIAq81EGdMgMpkK35I
         wiCdiEWqD+cgXM8leckcHsIe1X0gcKrNzTJE3wpPtUpypQ1dIpEZ7d9wbC5W4bGunmRA
         GuKZLdb2b2HTgMdL31SYhn0XS77QrAQ6B8P+aIOo4Idjg8BiuWfM+cwv4acil0jUGYEW
         uK49ceBcz2rbiZzN3Nr5i9f7OJw4/GGIv1rzNjEt5VFA8maqRiF2EX75uTNmAXU8p53p
         D/xHEa/wt2U0+BiecBD/R9mQmX9lB3g7WaNitPW8dytRuWxxrkafSy9LiZATfN1h6rhb
         vD3A==
X-Gm-Message-State: AOAM533ROfPupabR7EgfA9Zw5L/kcnW7Y35QfOmhzix3JE31b/AHC3QS
        ypWeOXnJfWQ//0ZQUJX43GCU5q646Y0=
X-Google-Smtp-Source: ABdhPJzYv7I/BvTSlq5EXRYbHB3jWpC8Gdowimy1snNngGv2wohniKWet4DUB5x3Ut13ijuLiMoWlA==
X-Received: by 2002:a2e:9a09:: with SMTP id o9mr10078085lji.21.1636482879047;
        Tue, 09 Nov 2021 10:34:39 -0800 (PST)
Received: from [192.168.1.7] ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id i3sm1184844lfu.156.2021.11.09.10.34.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Nov 2021 10:34:38 -0800 (PST)
Subject: Re: [PATCH V2 3/4] xen/unpopulated-alloc: Add mechanism to use Xen
 resource
To:     Stefano Stabellini <sstabellini@kernel.org>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, Julien Grall <julien@xen.org>
References: <1635264312-3796-1-git-send-email-olekstysh@gmail.com>
 <1635264312-3796-4-git-send-email-olekstysh@gmail.com>
 <alpine.DEB.2.21.2110280920110.20134@sstabellini-ThinkPad-T480s>
From:   Oleksandr <olekstysh@gmail.com>
Message-ID: <1d122e60-df9c-2ac6-8148-f6a836b9e51d@gmail.com>
Date:   Tue, 9 Nov 2021 20:34:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2110280920110.20134@sstabellini-ThinkPad-T480s>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 28.10.21 19:37, Stefano Stabellini wrote:

Hi Stefano

I am sorry for the late response.

> On Tue, 26 Oct 2021, Oleksandr Tyshchenko wrote:
>> From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
>>
>> The main reason of this change is that unpopulated-alloc
>> code cannot be used in its current form on Arm, but there
>> is a desire to reuse it to avoid wasting real RAM pages
>> for the grant/foreign mappings.
>>
>> The problem is that system "iomem_resource" is used for
>> the address space allocation, but the really unallocated
>> space can't be figured out precisely by the domain on Arm
>> without hypervisor involvement. For example, not all device
>> I/O regions are known by the time domain starts creating
>> grant/foreign mappings. And following the advise from
>> "iomem_resource" we might end up reusing these regions by
>> a mistake. So, the hypervisor which maintains the P2M for
>> the domain is in the best position to provide unused regions
>> of guest physical address space which could be safely used
>> to create grant/foreign mappings.
>>
>> Introduce new helper arch_xen_unpopulated_init() which purpose
>> is to create specific Xen resource based on the memory regions
>> provided by the hypervisor to be used as unused space for Xen
>> scratch pages.
>>
>> If arch doesn't implement arch_xen_unpopulated_init() to
>> initialize Xen resource the default "iomem_resource" will be used.
>> So the behavior on x86 won't be changed.
>>
>> Also fall back to allocate xenballooned pages (steal real RAM
>> pages) if we do not have any suitable resource to work with and
>> as the result we won't be able to provide unpopulated pages.
>>
>> Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
>> ---
>> Changes RFC -> V2:
>>     - new patch, instead of
>>      "[RFC PATCH 2/2] xen/unpopulated-alloc: Query hypervisor to provide unallocated space"
>> ---
>>   drivers/xen/unpopulated-alloc.c | 89 +++++++++++++++++++++++++++++++++++++++--
>>   include/xen/xen.h               |  2 +
>>   2 files changed, 88 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/xen/unpopulated-alloc.c b/drivers/xen/unpopulated-alloc.c
>> index a03dc5b..1f1d8d8 100644
>> --- a/drivers/xen/unpopulated-alloc.c
>> +++ b/drivers/xen/unpopulated-alloc.c
>> @@ -8,6 +8,7 @@
>>   
>>   #include <asm/page.h>
>>   
>> +#include <xen/balloon.h>
>>   #include <xen/page.h>
>>   #include <xen/xen.h>
>>   
>> @@ -15,13 +16,29 @@ static DEFINE_MUTEX(list_lock);
>>   static struct page *page_list;
>>   static unsigned int list_count;
>>   
>> +static struct resource *target_resource;
>> +static struct resource xen_resource = {
>> +	.name = "Xen unused space",
>> +};
>> +
>> +/*
>> + * If arch is not happy with system "iomem_resource" being used for
>> + * the region allocation it can provide it's own view by initializing
>> + * "xen_resource" with unused regions of guest physical address space
>> + * provided by the hypervisor.
>> + */
>> +int __weak arch_xen_unpopulated_init(struct resource *res)
>> +{
>> +	return -ENOSYS;
>> +}
>> +
>>   static int fill_list(unsigned int nr_pages)
>>   {
>>   	struct dev_pagemap *pgmap;
>> -	struct resource *res;
>> +	struct resource *res, *tmp_res = NULL;
>>   	void *vaddr;
>>   	unsigned int i, alloc_pages = round_up(nr_pages, PAGES_PER_SECTION);
>> -	int ret = -ENOMEM;
>> +	int ret;
>>   
>>   	res = kzalloc(sizeof(*res), GFP_KERNEL);
>>   	if (!res)
>> @@ -30,7 +47,7 @@ static int fill_list(unsigned int nr_pages)
>>   	res->name = "Xen scratch";
>>   	res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
>>   
>> -	ret = allocate_resource(&iomem_resource, res,
>> +	ret = allocate_resource(target_resource, res,
>>   				alloc_pages * PAGE_SIZE, 0, -1,
>>   				PAGES_PER_SECTION * PAGE_SIZE, NULL, NULL);
>>   	if (ret < 0) {
>> @@ -38,6 +55,31 @@ static int fill_list(unsigned int nr_pages)
>>   		goto err_resource;
>>   	}
>>   
>> +	/*
>> +	 * Reserve the region previously allocated from Xen resource to avoid
>> +	 * re-using it by someone else.
>> +	 */
>> +	if (target_resource != &iomem_resource) {
>> +		tmp_res = kzalloc(sizeof(*tmp_res), GFP_KERNEL);
>> +		if (!res) {
>> +			ret = -ENOMEM;
>> +			goto err_insert;
>> +		}
>> +
>> +		tmp_res->name = res->name;
>> +		tmp_res->start = res->start;
>> +		tmp_res->end = res->end;
>> +		tmp_res->flags = res->flags;
>> +
>> +		ret = insert_resource(&iomem_resource, tmp_res);
>> +		if (ret < 0) {
>> +			pr_err("Cannot insert IOMEM resource [%llx - %llx]\n",
>> +			       tmp_res->start, tmp_res->end);
>> +			kfree(tmp_res);
>> +			goto err_insert;
>> +		}
>> +	}
> I am a bit confused.. why do we need to do this? Who could be
> erroneously re-using the region? Are you saying that the next time
> allocate_resource is called it could find the same region again? It
> doesn't seem possible?


No, as I understand the allocate_resource() being called for the same 
root resource won't provide the same region... We only need to do this 
(insert the region into "iomem_resource") if we allocated it from our 
*internal* "xen_resource", as *global* "iomem_resource" (which is used 
everywhere) is not aware of that region has been already allocated. So 
inserting a region here we reserving it, otherwise it could be reused 
elsewhere.


>
>
>>   	pgmap = kzalloc(sizeof(*pgmap), GFP_KERNEL);
>>   	if (!pgmap) {
>>   		ret = -ENOMEM;
>> @@ -95,12 +137,40 @@ static int fill_list(unsigned int nr_pages)
>>   err_memremap:
>>   	kfree(pgmap);
>>   err_pgmap:
>> +	if (tmp_res) {
>> +		release_resource(tmp_res);
>> +		kfree(tmp_res);
>> +	}
>> +err_insert:
>>   	release_resource(res);
>>   err_resource:
>>   	kfree(res);
>>   	return ret;
>>   }
>>   
>> +static void unpopulated_init(void)
>> +{
>> +	static bool inited = false;
> initialized = false

ok.


>
>
>> +	int ret;
>> +
>> +	if (inited)
>> +		return;
>> +
>> +	/*
>> +	 * Try to initialize Xen resource the first and fall back to default
>> +	 * resource if arch doesn't offer one.
>> +	 */
>> +	ret = arch_xen_unpopulated_init(&xen_resource);
>> +	if (!ret)
>> +		target_resource = &xen_resource;
>> +	else if (ret == -ENOSYS)
>> +		target_resource = &iomem_resource;
>> +	else
>> +		pr_err("Cannot initialize Xen resource\n");
>> +
>> +	inited = true;
>> +}
> Would it make sense to call unpopulated_init from an init function,
> rather than every time xen_alloc_unpopulated_pages is called?

Good point, thank you. Will do. To be honest, I also don't like the 
current approach much.


>
>
>>   /**
>>    * xen_alloc_unpopulated_pages - alloc unpopulated pages
>>    * @nr_pages: Number of pages
>> @@ -112,6 +182,16 @@ int xen_alloc_unpopulated_pages(unsigned int nr_pages, struct page **pages)
>>   	unsigned int i;
>>   	int ret = 0;
>>   
>> +	unpopulated_init();
>> +
>> +	/*
>> +	 * Fall back to default behavior if we do not have any suitable resource
>> +	 * to allocate required region from and as the result we won't be able to
>> +	 * construct pages.
>> +	 */
>> +	if (!target_resource)
>> +		return alloc_xenballooned_pages(nr_pages, pages);
> The commit message says that the behavior on x86 doesn't change but this
> seems to be a change that could impact x86?
I don't think, however I didn't tested on x86 and might be wrong, but 
according to the current patch, on x86 the "target_resource" is always 
valid and points to the "iomem_resource" as arch_xen_unpopulated_init() 
is not implemented. So there won't be any fallback to use 
alloc_(free)_xenballooned_pages() here and fill_list() will behave as usual.

You raised a really good question, on Arm we need a fallback to balloon 
out RAM pages again if hypervisor doesn't provide extended regions (we 
run on old version, no unused regions with reasonable size, etc), so I 
decided to put a fallback code here, an indicator of the failure is 
invalid "target_resource". I noticed the patch which is about to be 
upstreamed that removes alloc_(free)xenballooned_pages API [1]. Right 
now I have no idea how/where this fallback could be implemented as this 
is under build option control (CONFIG_XEN_UNPOPULATED_ALLOC). So the API 
with the same name is either used for unpopulated pages (if set) or 
ballooned pages (if not set). I would appreciate suggestions regarding 
that. I am wondering would it be possible and correctly to have both 
mechanisms (unpopulated and ballooned) enabled by default and some init 
code to decide which one to use at runtime or some sort?


>
>>   	mutex_lock(&list_lock);
>>   	if (list_count < nr_pages) {
>>   		ret = fill_list(nr_pages - list_count);
>> @@ -159,6 +239,9 @@ void xen_free_unpopulated_pages(unsigned int nr_pages, struct page **pages)
>>   {
>>   	unsigned int i;
>>   
>> +	if (!target_resource)
>> +		return free_xenballooned_pages(nr_pages, pages);
>> +
>>   	mutex_lock(&list_lock);
>>   	for (i = 0; i < nr_pages; i++) {
>>   		pages[i]->zone_device_data = page_list;
>> diff --git a/include/xen/xen.h b/include/xen/xen.h
>> index 43efba0..55d2ef8 100644
>> --- a/include/xen/xen.h
>> +++ b/include/xen/xen.h
>> @@ -55,6 +55,8 @@ extern u64 xen_saved_max_mem_size;
>>   #ifdef CONFIG_XEN_UNPOPULATED_ALLOC
>>   int xen_alloc_unpopulated_pages(unsigned int nr_pages, struct page **pages);
>>   void xen_free_unpopulated_pages(unsigned int nr_pages, struct page **pages);
>> +struct resource;
> This is to avoid having to #include linux/ioport.h, right? Is it a
> problem or is it just to minimize the headers dependencies?
>
> It looks like adding #include <linux/ioport.h> below #include
> <linux/types.h> in include/xen/xen.h would work too. I am not sure what
> is the best way though, I'll let Juergen comment.
Yes, the initial reason to use forward declaration here was to minimize 
the headers dependencies.
I have rechecked, your suggestion works as well, thank you. So I would 
be OK either way, let's wait for other opinions.


>
>
>> +int arch_xen_unpopulated_init(struct resource *res);
>>   #else
>>   #define xen_alloc_unpopulated_pages alloc_xenballooned_pages
>>   #define xen_free_unpopulated_pages free_xenballooned_pages
>> -- 
>> 2.7.4
>>

[1] https://lore.kernel.org/lkml/20211102092234.17852-1-jgross@suse.com/

-- 
Regards,

Oleksandr Tyshchenko

