Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85527345CB0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 12:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhCWLTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 07:19:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45851 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229504AbhCWLT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 07:19:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616498368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rItqcrfiSSCIyGFXFE6rhbI0SFnZjCLml20Heqjbrig=;
        b=A36Dn0pVENF60gjBqHy/a56Dr7gUOlSOzZyLD4nS0vuKSFYU4t1GhVUp4YjkIiwA9GRqmv
        zilbB3hUJx2ErrKhk1Na225i0ulAI0rHVwGUA+RqggTKD0SdS4pUsSOBX9jOBSoXTR1wDl
        092zfQmVbRd3i6f3LCcxgnrxn0+hV6w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-574-FWIp0ggzOJu8kJo4TYszdA-1; Tue, 23 Mar 2021 07:19:24 -0400
X-MC-Unique: FWIp0ggzOJu8kJo4TYszdA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 63EF05B361;
        Tue, 23 Mar 2021 11:19:21 +0000 (UTC)
Received: from [10.36.115.54] (ovpn-115-54.ams2.redhat.com [10.36.115.54])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DA4BE708E0;
        Tue, 23 Mar 2021 11:19:11 +0000 (UTC)
Subject: Re: [PATCH v1 3/3] kernel/resource: remove first_lvl / siblings_only
 logic
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Michal Hocko <mhocko@suse.com>, Qian Cai <cai@lca.pw>,
        Oscar Salvador <osalvador@suse.de>,
        Eric Biederman <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org,
        kexec@lists.infradead.org
References: <20210322160200.19633-1-david@redhat.com>
 <20210322160200.19633-4-david@redhat.com>
 <YFnMyJl7dAZLM6S3@smile.fi.intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <c726f596-3d55-5128-f810-947904cfe2c8@redhat.com>
Date:   Tue, 23 Mar 2021 12:19:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YFnMyJl7dAZLM6S3@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.03.21 12:11, Andy Shevchenko wrote:
> On Mon, Mar 22, 2021 at 05:02:00PM +0100, David Hildenbrand wrote:
>> All IORESOURCE_SYSTEM_RAM and IORESOURCE_MEM now properly consider the
>> whole resource tree, not just the first level. Let's drop the unused
>> first_lvl / siblings_only logic.
>>
>> All functions properly search the whole tree, so remove documentation
>> that indicates that some functions behave differently.
> 
> 
> Like this clean up!
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Although a few nit-picks below.
> 
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
>> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>> Cc: Signed-off-by: David Hildenbrand <david@redhat.com>
>> Cc: Dave Young <dyoung@redhat.com>
>> Cc: Baoquan He <bhe@redhat.com>
>> Cc: Vivek Goyal <vgoyal@redhat.com>
>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>> Cc: Keith Busch <keith.busch@intel.com>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: Qian Cai <cai@lca.pw>
>> Cc: Oscar Salvador <osalvador@suse.de>
>> Cc: Eric Biederman <ebiederm@xmission.com>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Borislav Petkov <bp@alien8.de>
>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>> Cc: Tom Lendacky <thomas.lendacky@amd.com>
>> Cc: Brijesh Singh <brijesh.singh@amd.com>
>> Cc: x86@kernel.org
>> Cc: kexec@lists.infradead.org
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>   kernel/resource.c | 45 ++++++++++++---------------------------------
>>   1 file changed, 12 insertions(+), 33 deletions(-)
>>
>> diff --git a/kernel/resource.c b/kernel/resource.c
>> index 16e0c7e8ed24..7e00239a023a 100644
>> --- a/kernel/resource.c
>> +++ b/kernel/resource.c
>> @@ -64,12 +64,8 @@ static DEFINE_RWLOCK(resource_lock);
>>   static struct resource *bootmem_resource_free;
>>   static DEFINE_SPINLOCK(bootmem_resource_lock);
>>   
>> -static struct resource *next_resource(struct resource *p, bool sibling_only)
>> +static struct resource *next_resource(struct resource *p)
>>   {
>> -	/* Caller wants to traverse through siblings only */
>> -	if (sibling_only)
>> -		return p->sibling;
>> -
>>   	if (p->child)
>>   		return p->child;
>>   	while (!p->sibling && p->parent)
>> @@ -81,7 +77,7 @@ static void *r_next(struct seq_file *m, void *v, loff_t *pos)
>>   {
>>   	struct resource *p = v;
>>   	(*pos)++;
>> -	return (void *)next_resource(p, false);
>> +	return (void *)next_resource(p);
>>   }
>>   
>>   #ifdef CONFIG_PROC_FS
>> @@ -330,14 +326,10 @@ EXPORT_SYMBOL(release_resource);
>>    * of the resource that's within [@start..@end]; if none is found, returns
>>    * -ENODEV.  Returns -EINVAL for invalid parameters.
>>    *
>> - * This function walks the whole tree and not just first level children
>> - * unless @first_lvl is true.
>> - *
>>    * @start:	start address of the resource searched for
>>    * @end:	end address of same resource
>>    * @flags:	flags which the resource must have
>>    * @desc:	descriptor the resource must have
>> - * @first_lvl:	walk only the first level children, if set
>>    * @res:	return ptr, if resource found
>>    *
>>    * The caller must specify @start, @end, @flags, and @desc
>> @@ -345,9 +337,8 @@ EXPORT_SYMBOL(release_resource);
>>    */
>>   static int find_next_iomem_res(resource_size_t start, resource_size_t end,
>>   			       unsigned long flags, unsigned long desc,
>> -			       bool first_lvl, struct resource *res)
>> +			       struct resource *res)
>>   {
>> -	bool siblings_only = true;
>>   	struct resource *p;
>>   
>>   	if (!res)
>> @@ -358,7 +349,7 @@ static int find_next_iomem_res(resource_size_t start, resource_size_t end,
>>   
>>   	read_lock(&resource_lock);
>>   
>> -	for (p = iomem_resource.child; p; p = next_resource(p, siblings_only)) {
>> +	for (p = iomem_resource.child; p; p = next_resource(p)) {
>>   		/* If we passed the resource we are looking for, stop */
>>   		if (p->start > end) {
>>   			p = NULL;
>> @@ -369,13 +360,6 @@ static int find_next_iomem_res(resource_size_t start, resource_size_t end,
>>   		if (p->end < start)
>>   			continue;
>>   
>> -		/*
>> -		 * Now that we found a range that matches what we look for,
>> -		 * check the flags and the descriptor. If we were not asked to
>> -		 * use only the first level, start looking at children as well.
>> -		 */
>> -		siblings_only = first_lvl;
>> -
>>   		if ((p->flags & flags) != flags)
>>   			continue;
>>   		if ((desc != IORES_DESC_NONE) && (desc != p->desc))
>> @@ -402,14 +386,14 @@ static int find_next_iomem_res(resource_size_t start, resource_size_t end,
>>   
>>   static int __walk_iomem_res_desc(resource_size_t start, resource_size_t end,
>>   				 unsigned long flags, unsigned long desc,
>> -				 bool first_lvl, void *arg,
> 
>> +				 void *arg,
>>   				 int (*func)(struct resource *, void *))
> 
> Can it be one line?
> 
>>   {
>>   	struct resource res;
>>   	int ret = -EINVAL;
>>   
>>   	while (start < end &&
>> -	       !find_next_iomem_res(start, end, flags, desc, first_lvl, &res)) {
>> +	       !find_next_iomem_res(start, end, flags, desc, &res)) {
>>   		ret = (*func)(&res, arg);
>>   		if (ret)
>>   			break;
>> @@ -431,7 +415,6 @@ static int __walk_iomem_res_desc(resource_size_t start, resource_size_t end,
>>    * @arg: function argument for the callback @func
>>    * @func: callback function that is called for each qualifying resource area
>>    *
>> - * This walks through whole tree and not just first level children.
>>    * All the memory ranges which overlap start,end and also match flags and
>>    * desc are valid candidates.
>>    *
>> @@ -441,7 +424,7 @@ static int __walk_iomem_res_desc(resource_size_t start, resource_size_t end,
>>   int walk_iomem_res_desc(unsigned long desc, unsigned long flags, u64 start,
>>   		u64 end, void *arg, int (*func)(struct resource *, void *))
>>   {
>> -	return __walk_iomem_res_desc(start, end, flags, desc, false, arg, func);
>> +	return __walk_iomem_res_desc(start, end, flags, desc, arg, func);
>>   }
>>   EXPORT_SYMBOL_GPL(walk_iomem_res_desc);
>>   
>> @@ -457,8 +440,8 @@ int walk_system_ram_res(u64 start, u64 end, void *arg,
>>   {
>>   	unsigned long flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
>>   
>> -	return __walk_iomem_res_desc(start, end, flags, IORES_DESC_NONE, false,
>> -				     arg, func);
> 
>> +	return __walk_iomem_res_desc(start, end, flags, IORES_DESC_NONE, arg,
>> +				     func);
> 
> I guess you may do it on one line.
> 
>>   }
>>   
>>   /*
>> @@ -470,17 +453,14 @@ int walk_mem_res(u64 start, u64 end, void *arg,
>>   {
>>   	unsigned long flags = IORESOURCE_MEM | IORESOURCE_BUSY;
>>   
>> -	return __walk_iomem_res_desc(start, end, flags, IORES_DESC_NONE, false,
>> -				     arg, func);
>> +	return __walk_iomem_res_desc(start, end, flags, IORES_DESC_NONE, arg,
>> +				     func);
> 
> Ditto.

To all your comments:

"The preferred limit on the length of a single line is 80 columns."

"Statements longer than 80 columns should be broken into sensible chunks 
... unless exceeding 80 columns significantly increases readability"

I don't think it significantly increases readability.


-- 
Thanks,

David / dhildenb

