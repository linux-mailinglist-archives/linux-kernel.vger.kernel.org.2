Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 733D13279F2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 09:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233665AbhCAIto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 03:49:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37368 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233504AbhCAIqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 03:46:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614588315;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NDfpZiBORFcwJhka5rTFwKHAeoR+PqV6dRvqqfDZlpQ=;
        b=V2fexq1q0y0AAX1ax+qaeRktwXEdGF7+ISKSo+vzDORYsCDQezMC2BMNKBrjozogVXXYRv
        Y3yQOooHNeN3FejAZo3DEQuVdecMS8/SZRsuddWypivmPhLwbpbfEbbh6T7H2w+ioVoTHo
        5tkWcDO3sZumADuWwITOFf6TqJ/SY9g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-510-FA3ltOZ9O9SOY20SxFpyvw-1; Mon, 01 Mar 2021 03:45:11 -0500
X-MC-Unique: FA3ltOZ9O9SOY20SxFpyvw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC507107ACE3;
        Mon,  1 Mar 2021 08:45:09 +0000 (UTC)
Received: from [10.36.114.87] (ovpn-114-87.ams2.redhat.com [10.36.114.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5188A60657;
        Mon,  1 Mar 2021 08:45:08 +0000 (UTC)
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, VlastimilBabkavbabka@suse.cz,
        pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Anshuman Khandual <anshuman.khandual@arm.com>
References: <20210209133854.17399-1-osalvador@suse.de>
 <20210209133854.17399-7-osalvador@suse.de>
 <dc044ae2-efce-0639-87de-3a3167c07a06@redhat.com>
 <20210226120451.GA3661@localhost.localdomain>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: [PATCH v2 6/7] x86/Kconfig: Introduce
 ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE
Message-ID: <de1e2213-7dea-da52-607b-d4d718a3e04e@redhat.com>
Date:   Mon, 1 Mar 2021 09:45:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210226120451.GA3661@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.02.21 13:04, Oscar Salvador wrote:
> On Thu, Feb 25, 2021 at 07:29:07PM +0100, David Hildenbrand wrote:
>> On 09.02.21 14:38, Oscar Salvador wrote:
>>> Enable x86_64 platform to use the MHP_MEMMAP_ON_MEMORY feature.
>>>
>>> Signed-off-by: Oscar Salvador <osalvador@suse.de>
>>> ---
>>>    arch/x86/Kconfig | 4 ++++
>>>    1 file changed, 4 insertions(+)
>>>
>>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>>> index 72663de8b04c..81046b7adb10 100644
>>> --- a/arch/x86/Kconfig
>>> +++ b/arch/x86/Kconfig
>>> @@ -2440,6 +2440,10 @@ config ARCH_ENABLE_MEMORY_HOTREMOVE
>>>    	def_bool y
>>>    	depends on MEMORY_HOTPLUG
>>> +config ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE
>>> +	def_bool y
>>> +	depends on X86_64 && MEMORY_HOTPLUG && SPARSEMEM_VMEMMAP_ENABLE
>>
>> It depends on SPARSEMEM_VMEMMAP, no?
>>
>> I think we could have
>>
>> SPARSEMEM_VMEMMAP_ENABLE=y
>> and
>> SPARSEMEM_VMEMMAP=n
>>
>> on manually tuned configs.
> 
> I do not think this can happen:
> 
> from mm/Kconfig:
> 
> config SPARSEMEM_VMEMMAP_ENABLE
>          bool
> 
> config SPARSEMEM_VMEMMAP
>          bool "Sparse Memory virtual memmap"
>          depends on SPARSEMEM && SPARSEMEM_VMEMMAP_ENABLE
>          default y
>          help
>            SPARSEMEM_VMEMMAP uses a virtually mapped memmap to optimise
>            pfn_to_page and page_to_pfn operations.  This is the most
>            efficient option when sufficient kernel resources are available
> 
> and from arch/x86/Kconfig:
> 
> config ARCH_SPARSEMEM_ENABLE
>          def_bool y
>          depends on X86_64 || NUMA || X86_32 || X86_32_NON_STANDARD
>          select SPARSEMEM_STATIC if X86_32
>          select SPARSEMEM_VMEMMAP_ENABLE if X86_64
> 
> 
> So, if I read this correctly, for SPARSEMEM_VMEMMAP to be true,
> SPARSEMEM_VMEMMAP_ENABLE needs to be true as well.
> 
> Am I missing something?

Take your config and set
	X86_5LEVEL=n
(because it enforces SPARSEMEM_VMEMMAP)
and
	SPARSEMEM_VMEMMAP=n

When compiling, you'll end up with a config like
	CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
	# CONFIG_SPARSEMEM_VMEMMAP is not set

Yet, with your patch you would get

ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y

And it would not get fenced off in the code, right?


I think you either have to check (IS_ENABLED(CONFIG_SPARSEMEM_VMEMMAP)) 
in addition in your code, or enforce it differently. Like


config MHP_MEMMAP_ON_MEMORY
	depends on SPARSEMEM_VMEMMAP && ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE
	bool


Then you can simplify the arch Kconfig settings, removing the sparesemem 
dependency there.

-- 
Thanks,

David / dhildenb

