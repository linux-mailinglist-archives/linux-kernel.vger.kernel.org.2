Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14CE2457EAB
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 14:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbhKTNmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 08:42:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbhKTNmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 08:42:06 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781EAC061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 05:39:02 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id bu18so57248220lfb.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 05:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=87cVwmsOyzRtODMfQvo3i1gOs01RxXi43XiAXYC9uZU=;
        b=EdqlKkn1SBMZl5J1aPqnuvHZl1J9QT6p0FJPPvguJNUNs8vipEmaQK1+1j2AYsWnHR
         JyYIfMoVMiyB8UluyhIldsEyuFYMheD5AkASUvwVPKsTJLQwutjvkTMWZ8jmNL3ASLdK
         S7Mol04GTg/RFBB00dksds2mAWgRVeVmDzvseKU65wvWXWaCYV9SBdf4MTBa/+b56bhQ
         iClZOq2tVLe/Mr9gQpC/p4hM0SP80loQm1sx6e2ZDehxSeMVmT1vQUqk2fIQVjpwtwFC
         3yW1CoYQmx+HTmJHYlRjb7WXdX8pEpaUocCRfVbTSboXJMlM/dPc8QJnwTi4m0DE2UQm
         e0ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=87cVwmsOyzRtODMfQvo3i1gOs01RxXi43XiAXYC9uZU=;
        b=akdJRnBchqOqzPG4NNXvnPmQ6i7bQL7GpO8ctfsliHTSkBze5d3tOeitmOzuxjD0LY
         vdZnEoQfOIbgz68grDSVEBSLUdvrB4IHb2X2C7S4AGzb3nwz7jo5zAXhlZEw3Z615VTu
         IAUC4qiE4Tws/mXWvoyj74hzmbe8Rb6InO/1GY3z7Trr0pkcIEIyfjI+E7degtLpEv9H
         1lmQershY//OXoedEbwxMLsb93reNaspBwvRO3I0fmMrQd4MdtJpH+1Zo5NPtKA9BRuH
         kN2EgiqXI7Fx+mPqhpzfbLHedNYL8Wsf8nC4xecTCAW3I+j8l/IpS9giEvWLVqBHpUAR
         Z4TA==
X-Gm-Message-State: AOAM530dJbUAAY6rhJ8wlLFJS7LCaHqiyLVWPTVmU15LCp87eI92adcu
        p6Lxy2KC3WwkACjvilApE5c=
X-Google-Smtp-Source: ABdhPJxOLTeL6kIUTEm12QQG2lBcTnCGLQfsvbJ+xjMD5gpYjA0x+qhdxLzHybe818jhpOAM2tAV8w==
X-Received: by 2002:a2e:9953:: with SMTP id r19mr33626907ljj.442.1637415540697;
        Sat, 20 Nov 2021 05:39:00 -0800 (PST)
Received: from [192.168.1.7] ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id bd27sm229655ljb.127.2021.11.20.05.38.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Nov 2021 05:39:00 -0800 (PST)
Subject: Re: [PATCH V2 4/4] arm/xen: Read extended regions from DT and init
 Xen resource
To:     Stefano Stabellini <sstabellini@kernel.org>
Cc:     xen-devel@lists.xenproject.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Russell King <linux@armlinux.org.uk>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, Julien Grall <julien@xen.org>
References: <1635264312-3796-1-git-send-email-olekstysh@gmail.com>
 <1635264312-3796-5-git-send-email-olekstysh@gmail.com>
 <alpine.DEB.2.21.2110271803060.20134@sstabellini-ThinkPad-T480s>
 <237f832d-5175-5653-18ee-058a7d7fa7a6@gmail.com>
 <alpine.DEB.2.22.394.2111181701110.1412361@ubuntu-linux-20-04-desktop>
 <ee5a226b-0e12-8823-0961-bf2fe0bd494e@gmail.com>
 <alpine.DEB.2.22.394.2111191820130.1412361@ubuntu-linux-20-04-desktop>
From:   Oleksandr <olekstysh@gmail.com>
Message-ID: <a7a5b5c1-15c0-df58-c0e5-67358f92d7d1@gmail.com>
Date:   Sat, 20 Nov 2021 15:38:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2111191820130.1412361@ubuntu-linux-20-04-desktop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 20.11.21 04:36, Stefano Stabellini wrote:


Hi Stefano

> On Fri, 19 Nov 2021, Oleksandr wrote:
>> On 19.11.21 03:19, Stefano Stabellini wrote:
>>> On Wed, 10 Nov 2021, Oleksandr wrote:
>>>> On 28.10.21 04:40, Stefano Stabellini wrote:
>>>>
>>>> Hi Stefano
>>>>
>>>> I am sorry for the late response.
>>>>
>>>>> On Tue, 26 Oct 2021, Oleksandr Tyshchenko wrote:
>>>>>> From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
>>>>>>
>>>>>> This patch implements arch_xen_unpopulated_init() on Arm where
>>>>>> the extended regions (if any) are gathered from DT and inserted
>>>>>> into passed Xen resource to be used as unused address space
>>>>>> for Xen scratch pages by unpopulated-alloc code.
>>>>>>
>>>>>> The extended region (safe range) is a region of guest physical
>>>>>> address space which is unused and could be safely used to create
>>>>>> grant/foreign mappings instead of wasting real RAM pages from
>>>>>> the domain memory for establishing these mappings.
>>>>>>
>>>>>> The extended regions are chosen by the hypervisor at the domain
>>>>>> creation time and advertised to it via "reg" property under
>>>>>> hypervisor node in the guest device-tree. As region 0 is reserved
>>>>>> for grant table space (always present), the indexes for extended
>>>>>> regions are 1...N.
>>>>>>
>>>>>> If arch_xen_unpopulated_init() fails for some reason the default
>>>>>> behaviour will be restored (allocate xenballooned pages).
>>>>>>
>>>>>> This patch also removes XEN_UNPOPULATED_ALLOC dependency on x86.
>>>>>>
>>>>>> Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
>>>>>> ---
>>>>>> Changes RFC -> V2:
>>>>>>       - new patch, instead of
>>>>>>        "[RFC PATCH 2/2] xen/unpopulated-alloc: Query hypervisor to
>>>>>> provide
>>>>>> unallocated space"
>>>>>> ---
>>>>>>     arch/arm/xen/enlighten.c | 112
>>>>>> +++++++++++++++++++++++++++++++++++++++++++++++
>>>>>>     drivers/xen/Kconfig      |   2 +-
>>>>>>     2 files changed, 113 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
>>>>>> index dea46ec..1a1e0d3 100644
>>>>>> --- a/arch/arm/xen/enlighten.c
>>>>>> +++ b/arch/arm/xen/enlighten.c
>>>>>> @@ -62,6 +62,7 @@ static __read_mostly unsigned int xen_events_irq;
>>>>>>     static phys_addr_t xen_grant_frames;
>>>>>>       #define GRANT_TABLE_INDEX   0
>>>>>> +#define EXT_REGION_INDEX    1
>>>>>>       uint32_t xen_start_flags;
>>>>>>     EXPORT_SYMBOL(xen_start_flags);
>>>>>> @@ -303,6 +304,117 @@ static void __init xen_acpi_guest_init(void)
>>>>>>     #endif
>>>>>>     }
>>>>>>     +#ifdef CONFIG_XEN_UNPOPULATED_ALLOC
>>>>>> +int arch_xen_unpopulated_init(struct resource *res)
>>>>>> +{
>>>>>> +	struct device_node *np;
>>>>>> +	struct resource *regs, *tmp_res;
>>>>>> +	uint64_t min_gpaddr = -1, max_gpaddr = 0;
>>>>>> +	unsigned int i, nr_reg = 0;
>>>>>> +	struct range mhp_range;
>>>>>> +	int rc;
>>>>>> +
>>>>>> +	if (!xen_domain())
>>>>>> +		return -ENODEV;
>>>>>> +
>>>>>> +	np = of_find_compatible_node(NULL, NULL, "xen,xen");
>>>>>> +	if (WARN_ON(!np))
>>>>>> +		return -ENODEV;
>>>>>> +
>>>>>> +	/* Skip region 0 which is reserved for grant table space */
>>>>>> +	while (of_get_address(np, nr_reg + EXT_REGION_INDEX, NULL,
>>>>>> NULL))
>>>>>> +		nr_reg++;
>>>>>> +	if (!nr_reg) {
>>>>>> +		pr_err("No extended regions are found\n");
>>>>>> +		return -EINVAL;
>>>>>> +	}
>>>>>> +
>>>>>> +	regs = kcalloc(nr_reg, sizeof(*regs), GFP_KERNEL);
>>>>>> +	if (!regs)
>>>>>> +		return -ENOMEM;
>>>>>> +
>>>>>> +	/*
>>>>>> +	 * Create resource from extended regions provided by the
>>>>>> hypervisor to
>>>>>> be
>>>>>> +	 * used as unused address space for Xen scratch pages.
>>>>>> +	 */
>>>>>> +	for (i = 0; i < nr_reg; i++) {
>>>>>> +		rc = of_address_to_resource(np, i + EXT_REGION_INDEX,
>>>>>> &regs[i]);
>>>>>> +		if (rc)
>>>>>> +			goto err;
>>>>>> +
>>>>>> +		if (max_gpaddr < regs[i].end)
>>>>>> +			max_gpaddr = regs[i].end;
>>>>>> +		if (min_gpaddr > regs[i].start)
>>>>>> +			min_gpaddr = regs[i].start;
>>>>>> +	}
>>>>>> +
>>>>>> +	/* Check whether the resource range is within the hotpluggable
>>>>>> range
>>>>>> */
>>>>>> +	mhp_range = mhp_get_pluggable_range(true);
>>>>>> +	if (min_gpaddr < mhp_range.start)
>>>>>> +		min_gpaddr = mhp_range.start;
>>>>>> +	if (max_gpaddr > mhp_range.end)
>>>>>> +		max_gpaddr = mhp_range.end;
>>>>>> +
>>>>>> +	res->start = min_gpaddr;
>>>>>> +	res->end = max_gpaddr;
>>>>>> +
>>>>>> +	/*
>>>>>> +	 * Mark holes between extended regions as unavailable. The
>>>>>> rest of
>>>>>> that
>>>>>> +	 * address space will be available for the allocation.
>>>>>> +	 */
>>>>>> +	for (i = 1; i < nr_reg; i++) {
>>>>>> +		resource_size_t start, end;
>>>>>> +
>>>>>> +		start = regs[i - 1].end + 1;
>>>>>> +		end = regs[i].start - 1;
>>>>>> +
>>>>>> +		if (start > (end + 1)) {
>>>>> Should this be:
>>>>>
>>>>> if (start >= end)
>>>>>
>>>>> ?
>>>> Yes, we can do this here (since the checks are equivalent) but ...
>>>>
>>>>>> +			rc = -EINVAL;
>>>>>> +			goto err;
>>>>>> +		}
>>>>>> +
>>>>>> +		/* There is no hole between regions */
>>>>>> +		if (start == (end + 1))
>>>>> Also here, shouldn't it be:
>>>>>
>>>>> if (start == end)
>>>>>
>>>>> ?
>>>>      ... not here.
>>>>
>>>> As
>>>>
>>>> "(start == (end + 1))" is equal to "(regs[i - 1].end + 1 ==
>>>> regs[i].start)"
>>>>
>>>> but
>>>>
>>>> "(start == end)" is equal to "(regs[i - 1].end + 1 == regs[i].start - 1)"
>>>    OK. But the check:
>>>
>>>     if (start >= end)
>>>
>>> Actually covers both cases so that's the only check we need?
>> Sorry, I don't entirely understand the question.
>> Is the question to use only a single check in that loop?
>>
>> Paste the updated code which I have locally for the convenience.
>>
>>   [snip]
>>
>>      /*
>>       * Mark holes between extended regions as unavailable. The rest of that
>>       * address space will be available for the allocation.
>>       */
>>      for (i = 1; i < nr_reg; i++) {
>>          resource_size_t start, end;
>>
>>          start = regs[i - 1].end + 1;
>>          end = regs[i].start - 1;
>>
>>          if (start > (end + 1)) {
>>              rc = -EINVAL;
>>              goto err;
>>          }
>>
>>          /* There is no hole between regions */
>>          if (start == (end + 1))
>>              continue;
>>
>>          tmp_res = kzalloc(sizeof(*tmp_res), GFP_KERNEL);
>>          if (!tmp_res) {
>>              rc = -ENOMEM;
>>              goto err;
>>          }
>>
>>          tmp_res->name = "Unavailable space";
>>          tmp_res->start = start;
>>          tmp_res->end = end;
>>
>>          rc = insert_resource(&xen_resource, tmp_res);
>>          if (rc) {
>>              pr_err("Cannot insert resource %pR (%d)\n", tmp_res, rc);
>>              kfree(tmp_res);
>>              goto err;
>>          }
>>      }
>>
>> [snip]
>>
>>
>> 1. The first check is to detect an overlap (which is a wrong configuration,
>> correct?) and bail out if true (for example, regX: 0x81000000...0x82FFFFFF and
>> regY: 0x82000000...0x83FFFFFF).
>> 2. The second check is just to skip current iteration as there is no
>> space/hole between regions (for example, regX: 0x81000000...0x82FFFFFF and
>> regY: 0x83000000...0x83FFFFFF).
>> Therefore I think they should be distinguished.
>>
>> Yes, both check could be transformed to a single one, but this way the
>> overlaps will be ignored:
>> if (start >= (end + 1))
>>      continue;
>>
>> Or I really missed something?
> You are right it is better to distinguish the two cases. I suggest the
> code below because I think it is a clearer, even if it might be slightly
> less efficient. I don't feel too strongly about it though.
>
> 		resource_size_t start, end;
>
> 		/* There is no hole between regions */
> 		if ( regs[i - 1].end + 1 == regs[i].start )
> 			continue;
>
> 		if ( regs[i - 1].end + 1 > regs[i].start) {
> 			rc = -EINVAL;
> 			goto err;
> 		}
>
> 		start = regs[i - 1].end + 1;
> 		end = regs[i].start - 1;

OK, let's make code clearer, will do.


-- 
Regards,

Oleksandr Tyshchenko

