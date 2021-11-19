Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24132457659
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 19:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234445AbhKSS2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 13:28:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234330AbhKSS2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 13:28:21 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF88C061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 10:25:19 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id m27so46910974lfj.12
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 10:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=dStovpyAqgT5U5ysBg+VG+BHTqF1d8vTbvMZkrKkCSc=;
        b=C1S78urN/PwZ2238ZZ8v0Yfq4JayJ9cmA9S71w0saJBJtUAqZJFJBwFF4VdQrsSVsV
         TI8AgZU7zRbtWw6G5Nxnv2W/wnlp6gi0Tc9kfQB+OOUXSmUJ4pum8dy5HgbifJoTdD4B
         LDoGO7xdDHlLFYOi+yTAjf8aoXEOco1gHgbPd6/wFbQ958xknUoiEccP9mCE2YYV5Vkr
         mzZrC+u+ZIHBb3CqHs1ZQhbRdW0RuQcPuIPds5MWRCr6anp5+Yx0W/y1hHbIhPSTAtKV
         Zvztg60giqnmeWQJ3dHgTBaUl+Q8kSZHuP4vckbijYAwpXCGn3Ia4P6B1A5mb0EAnPkZ
         l8lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=dStovpyAqgT5U5ysBg+VG+BHTqF1d8vTbvMZkrKkCSc=;
        b=72Qh+guPzQn9dG2CuurLSCLQzVVem9XLN8l3AVTEaJONvOX8qtTcmkadLl7gQOkfvJ
         F8wRkuVq0HN8y1+IV6JDWf/7qT7a8bF7SDIUIQRVl9Yw62GE+F58J1s95Su9bFWavfXy
         vmt7jxFmbo9+QsNRte7KIYcn8sc+YAl8zqy90uqZwQIGg5hYX/BjheP9OJ1pSBM4DL3J
         azwVuzFIjiv0to0LlM9eTWXmIkN6o8U63gtjanRuRd2RAHwajIDfIwNQuuvUm9CghX04
         f/OCQqj707/aLwTnHTK2JALdkn2cfp4RFk8oGJJbkh3PsI0rnoYt1qXcm5/oqRkl6Peq
         +25A==
X-Gm-Message-State: AOAM532NDtD4Yvc2BEsC3sjPvhKmxeNjotrj4cUA0F70DP8Seir07+aX
        yx5U7eISFSlkQi1QFrjoa/k=
X-Google-Smtp-Source: ABdhPJwKxQTJ0weHanMCnalDEiro//ui7b8M59uWsvOwheX/+TMgUIAFnmvOt+T3fES5Uqade+NFNw==
X-Received: by 2002:a19:c102:: with SMTP id r2mr32754899lff.672.1637346317680;
        Fri, 19 Nov 2021 10:25:17 -0800 (PST)
Received: from [192.168.1.7] ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id d22sm56050lfe.158.2021.11.19.10.25.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Nov 2021 10:25:17 -0800 (PST)
Subject: Re: [PATCH V2 2/4] arm/xen: Switch to use
 gnttab_setup_auto_xlat_frames() for DT
To:     Stefano Stabellini <sstabellini@kernel.org>
Cc:     xen-devel@lists.xenproject.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Russell King <linux@armlinux.org.uk>,
        Julien Grall <julien@xen.org>
References: <1635264312-3796-1-git-send-email-olekstysh@gmail.com>
 <1635264312-3796-3-git-send-email-olekstysh@gmail.com>
 <alpine.DEB.2.21.2110271754400.20134@sstabellini-ThinkPad-T480s>
 <60cc5b07-5935-aa26-8690-353c779bbab5@gmail.com>
 <alpine.DEB.2.22.394.2111181631020.1412361@ubuntu-linux-20-04-desktop>
From:   Oleksandr <olekstysh@gmail.com>
Message-ID: <1c32b559-16f0-c993-eca3-86cf70f97132@gmail.com>
Date:   Fri, 19 Nov 2021 20:25:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2111181631020.1412361@ubuntu-linux-20-04-desktop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 19.11.21 02:32, Stefano Stabellini wrote:

Hi Stefano

> On Thu, 11 Nov 2021, Oleksandr wrote:
>> On 28.10.21 04:28, Stefano Stabellini wrote:
>>
>> Hi Stefano
>>
>> I am sorry for the late response.
>>
>>> On Tue, 26 Oct 2021, Oleksandr Tyshchenko wrote:
>>>> From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
>>>>
>>>> Read the start address of the grant table space from DT
>>>> (region 0).
>>>>
>>>> This patch mostly restores behaviour before commit 3cf4095d7446
>>>> ("arm/xen: Use xen_xlate_map_ballooned_pages to setup grant table")
>>>> but trying not to break the ACPI support added after that commit.
>>>> So the patch touches DT part only and leaves the ACPI part with
>>>> xen_xlate_map_ballooned_pages().
>>>>
>>>> This is a preparation for using Xen extended region feature
>>>> where unused regions of guest physical address space (provided
>>>> by the hypervisor) will be used to create grant/foreign/whatever
>>>> mappings instead of wasting real RAM pages from the domain memory
>>>> for establishing these mappings.
>>>>
>>>> The immediate benefit of this change:
>>>> - Avoid superpage shattering in Xen P2M when establishing
>>>>     stage-2 mapping (GFN <-> MFN) for the grant table space
>>>> - Avoid wasting real RAM pages (reducing the amount of memory
>>>>     usuable) for mapping grant table space
>>>> - The grant table space is always mapped at the exact
>>>>     same place (region 0 is reserved for the grant table)
>>>>
>>>> Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
>>>> ---
>>>> Changes RFC -> V2:
>>>>      - new patch
>>>> ---
>>>>    arch/arm/xen/enlighten.c | 32 +++++++++++++++++++++++++-------
>>>>    1 file changed, 25 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
>>>> index 7f1c106b..dea46ec 100644
>>>> --- a/arch/arm/xen/enlighten.c
>>>> +++ b/arch/arm/xen/enlighten.c
>>>> @@ -59,6 +59,9 @@ unsigned long xen_released_pages;
>>>>    struct xen_memory_region xen_extra_mem[XEN_EXTRA_MEM_MAX_REGIONS]
>>>> __initdata;
>>>>      static __read_mostly unsigned int xen_events_irq;
>>>> +static phys_addr_t xen_grant_frames;
>>> __read_mostly
>> ok
>>
>>
>>>
>>>> +#define GRANT_TABLE_INDEX   0
>>>>      uint32_t xen_start_flags;
>>>>    EXPORT_SYMBOL(xen_start_flags);
>>>> @@ -303,6 +306,7 @@ static void __init xen_acpi_guest_init(void)
>>>>    static void __init xen_dt_guest_init(void)
>>>>    {
>>>>    	struct device_node *xen_node;
>>>> +	struct resource res;
>>>>      	xen_node = of_find_compatible_node(NULL, NULL, "xen,xen");
>>>>    	if (!xen_node) {
>>>> @@ -310,6 +314,12 @@ static void __init xen_dt_guest_init(void)
>>>>    		return;
>>>>    	}
>>>>    +	if (of_address_to_resource(xen_node, GRANT_TABLE_INDEX, &res)) {
>>>> +		pr_err("Xen grant table region is not found\n");
>>>> +		return;
>>>> +	}
>>>> +	xen_grant_frames = res.start;
>>>> +
>>>>    	xen_events_irq = irq_of_parse_and_map(xen_node, 0);
>>>>    }
>>>>    @@ -317,16 +327,20 @@ static int __init xen_guest_init(void)
>>>>    {
>>>>    	struct xen_add_to_physmap xatp;
>>>>    	struct shared_info *shared_info_page = NULL;
>>>> -	int cpu;
>>>> +	int rc, cpu;
>>>>      	if (!xen_domain())
>>>>    		return 0;
>>>>      	if (!acpi_disabled)
>>>>    		xen_acpi_guest_init();
>>>> -	else
>>>> +	else {
>>>>    		xen_dt_guest_init();
>>>>    +		if (!xen_grant_frames)
>>>> +			return -ENODEV;
>>> maybe we can avoid this, see below
>>>
>>>
>>>> +	}
>>>> +
>>>>    	if (!xen_events_irq) {
>>>>    		pr_err("Xen event channel interrupt not found\n");
>>>>    		return -ENODEV;
>>>> @@ -370,12 +384,16 @@ static int __init xen_guest_init(void)
>>>>    	for_each_possible_cpu(cpu)
>>>>    		per_cpu(xen_vcpu_id, cpu) = cpu;
>>>>    -	xen_auto_xlat_grant_frames.count = gnttab_max_grant_frames();
>>>> -	if (xen_xlate_map_ballooned_pages(&xen_auto_xlat_grant_frames.pfn,
>>>> -					  &xen_auto_xlat_grant_frames.vaddr,
>>>> -					  xen_auto_xlat_grant_frames.count)) {
>>>> +	if (!acpi_disabled) {
>>> To make the code more resilient couldn't we do:
>>>
>>> if (!acpi_disabled || !xen_grant_frames) {
>> I think, we can.
>>
>> On the one hand, indeed the code more resilient and less change.
>>  From the other hand if grant table region is not found then something weird
>> happened as region 0 is always present in reg property if hypervisor node is
>> exposed to the guest.
>> The behavior before commit 3cf4095d7446 ("arm/xen: Use
>> xen_xlate_map_ballooned_pages to setup grant table") was exactly the same in
>> the context of the failure if region wasn't found.
>>
>> ...
>>
>> Well, if we want to make code more resilient, I will update. But, looks like
>> we also need to switch actions in xen_dt_guest_init() in order to process
>> xen_events_irq before xen_grant_frames, otherwise we may return after failing
>> with region and end up not initializing xen_events_irq so xen_guest_init()
>> will fail earlier than reaches that check.
>> What do you think?
>   
> Yes, you are right. I was re-reading the patch to refresh my memory and
> I noticed immediately that xen_dt_guest_init also need to be changed so
> that xen_events_irq is set before xen_grant_frames.
>   
> I think it is a minor change that doesn't add complexity but make the
> code more robust so I think it is a good idea


Great, thank you. Will do in next version.


>
>   
>>>> +		xen_auto_xlat_grant_frames.count = gnttab_max_grant_frames();
>>>> +		rc =
>>>> xen_xlate_map_ballooned_pages(&xen_auto_xlat_grant_frames.pfn,
>>>> +
>>>> &xen_auto_xlat_grant_frames.vaddr,
>>>> +
>>>> xen_auto_xlat_grant_frames.count);
>>>> +	} else
>>>> +		rc = gnttab_setup_auto_xlat_frames(xen_grant_frames);
>>>> +	if (rc) {
>>>>    		free_percpu(xen_vcpu_info);
>>>> -		return -ENOMEM;
>>>> +		return rc;
>>>>    	}
>>>>    	gnttab_init();

-- 
Regards,

Oleksandr Tyshchenko

