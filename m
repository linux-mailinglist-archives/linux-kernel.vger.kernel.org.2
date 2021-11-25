Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F61445D981
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 12:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237667AbhKYLtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 06:49:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235319AbhKYLq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 06:46:57 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241D9C0613F1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 03:41:30 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id b1so15514812lfs.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 03:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=c+s/ogUtJiq8S6eCkJtlg22v9K/HbWbi58ZiTPq2lfQ=;
        b=fEsKucNIoXRU8fo1RSw4S8M/6nduiyxDjhqJA4RiKZ+9nzT/MbK9afRfBn5g5SUR18
         iglOJ+IYQZcHBXgOfPgSM2Ue3RD9HGykxe7VGf/+Bw/5irbG8S3T0RiiZs1QvQiDgX8D
         IhT6G73L4XYoVnu1AvVvCvbFtXgOT0gZnOPImOJF6q4jEXt8IqMunTAcrJ5Yvk2XLyUt
         kAnJkjO1id1VHd8fkz4VwIdRw5FNGPfOWVApGLzWSDB1CJYRJzz5bsxA0EiQK3Lwc54P
         NHNyuVTP68C85JrREwxySo6awlAUd/uTo3L+vt2dcuWhGniSh/jgGevZW2tAxqMKI12A
         xb9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=c+s/ogUtJiq8S6eCkJtlg22v9K/HbWbi58ZiTPq2lfQ=;
        b=WbiPEkISW8tRugVa82kdjv6awZsXEPlugEZtiGs/TZqYSPY8g0bGfBWsVraHj8+DmZ
         zJCyFxoHd8RTM4dXBuwP0bZc8liXEbjG5/udJNlxxrEkqP2Z4Ury4NKTMQdC/yIB/WAm
         NUYgM1RL4sbNuix2RmtBKWogWxx4SxLu8vi8GJKt1eCNBRdLGa7/t8XZePK1FMoeWSSZ
         WWPFllBY6Bu/4XZtDDZjBXPgnsCwW8UrI7ItO6o1vvQmjttbop43tpePz6PsRYF6f/VO
         aP3sp2VXjkbyyYtmgRTnsSeILMIKjZ9lz4PjIlwIl+PhrMpaIClC7QQ8fQagLa1pwLKZ
         c4cQ==
X-Gm-Message-State: AOAM533DDCpHZPIJ/hQMh957+g6MbK+BKFfnfG0hMOLLHilCShUf1wBK
        bLEhA9bpV/WAVPXzlMonBDA=
X-Google-Smtp-Source: ABdhPJwMfQ7CxY+YVrpFAi0AiKCeie5qzWnKWf11oidpWyS5Ss9HlABYbHfrCBdhkQNwbB3mJec7pw==
X-Received: by 2002:a05:6512:10c5:: with SMTP id k5mr15043810lfg.367.1637840488404;
        Thu, 25 Nov 2021 03:41:28 -0800 (PST)
Received: from [192.168.1.7] ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id n15sm213163ljm.32.2021.11.25.03.41.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Nov 2021 03:41:28 -0800 (PST)
Subject: Re: [PATCH V3 2/6] arm/xen: Switch to use
 gnttab_setup_auto_xlat_frames() for DT
To:     Stefano Stabellini <sstabellini@kernel.org>
Cc:     xen-devel@lists.xenproject.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Russell King <linux@armlinux.org.uk>,
        Julien Grall <julien@xen.org>
References: <1637787223-21129-1-git-send-email-olekstysh@gmail.com>
 <1637787223-21129-3-git-send-email-olekstysh@gmail.com>
 <alpine.DEB.2.22.394.2111241534090.1412361@ubuntu-linux-20-04-desktop>
From:   Oleksandr <olekstysh@gmail.com>
Message-ID: <f69cb505-d14f-c37c-cccb-49d79a66af54@gmail.com>
Date:   Thu, 25 Nov 2021 13:41:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2111241534090.1412361@ubuntu-linux-20-04-desktop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 25.11.21 01:35, Stefano Stabellini wrote:

Hi Stefano


> On Wed, 24 Nov 2021, Oleksandr Tyshchenko wrote:
>> From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
>>
>> Read the start address of the grant table space from DT
>> (region 0).
>>
>> This patch mostly restores behaviour before commit 3cf4095d7446
>> ("arm/xen: Use xen_xlate_map_ballooned_pages to setup grant table")
>> but trying not to break the ACPI support added after that commit.
>> So the patch touches DT part only and leaves the ACPI part with
>> xen_xlate_map_ballooned_pages(). Also in order to make a code more
>> resilient use a fallback to xen_xlate_map_ballooned_pages() if grant
>> table region wasn't found.
>>
>> This is a preparation for using Xen extended region feature
>> where unused regions of guest physical address space (provided
>> by the hypervisor) will be used to create grant/foreign/whatever
>> mappings instead of wasting real RAM pages from the domain memory
>> for establishing these mappings.
>>
>> The immediate benefit of this change:
>> - Avoid superpage shattering in Xen P2M when establishing
>>    stage-2 mapping (GFN <-> MFN) for the grant table space
>> - Avoid wasting real RAM pages (reducing the amount of memory
>>    usuable) for mapping grant table space
>> - The grant table space is always mapped at the exact
>>    same place (region 0 is reserved for the grant table)
>>
>> Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
>> ---
>> Changes RFC -> V2:
>>     - new patch
>>
>> Changes V2 -> V3:
>>     - add __read_mostly specifier to xen_grant_frames
>>     - retain a fallback to xen_xlate_map_ballooned_pages() if
>>       xen_grant_frames is invalid
>>     - process xen_events_irq before xen_grant_frames in
>>       xen_dt_guest_init()
>>     - update patch description
>> ---
>>   arch/arm/xen/enlighten.c | 26 ++++++++++++++++++++------
>>   1 file changed, 20 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
>> index 7619fbf..3fb3384 100644
>> --- a/arch/arm/xen/enlighten.c
>> +++ b/arch/arm/xen/enlighten.c
>> @@ -59,6 +59,9 @@ unsigned long xen_released_pages;
>>   struct xen_memory_region xen_extra_mem[XEN_EXTRA_MEM_MAX_REGIONS] __initdata;
>>   
>>   static __read_mostly unsigned int xen_events_irq;
>> +static __read_mostly phys_addr_t xen_grant_frames;
>> +
>> +#define GRANT_TABLE_INDEX   0
>>   
>>   uint32_t xen_start_flags;
>>   EXPORT_SYMBOL(xen_start_flags);
>> @@ -303,6 +306,7 @@ static void __init xen_acpi_guest_init(void)
>>   static void __init xen_dt_guest_init(void)
>>   {
>>   	struct device_node *xen_node;
>> +	struct resource res;
>>   
>>   	xen_node = of_find_compatible_node(NULL, NULL, "xen,xen");
>>   	if (!xen_node) {
>> @@ -311,13 +315,19 @@ static void __init xen_dt_guest_init(void)
>>   	}
>>   
>>   	xen_events_irq = irq_of_parse_and_map(xen_node, 0);
>> +
>> +	if (of_address_to_resource(xen_node, GRANT_TABLE_INDEX, &res)) {
>> +		pr_err("Xen grant table region is not found\n");
>> +		return;
>> +	}
>> +	xen_grant_frames = res.start;
>>   }
>>   
>>   static int __init xen_guest_init(void)
>>   {
>>   	struct xen_add_to_physmap xatp;
>>   	struct shared_info *shared_info_page = NULL;
>> -	int cpu;
>> +	int rc, cpu;
>>   
>>   	if (!xen_domain())
>>   		return 0;
>> @@ -370,12 +380,16 @@ static int __init xen_guest_init(void)
>>   	for_each_possible_cpu(cpu)
>>   		per_cpu(xen_vcpu_id, cpu) = cpu;
>>   
>> -	xen_auto_xlat_grant_frames.count = gnttab_max_grant_frames();
>> -	if (xen_xlate_map_ballooned_pages(&xen_auto_xlat_grant_frames.pfn,
>> -					  &xen_auto_xlat_grant_frames.vaddr,
>> -					  xen_auto_xlat_grant_frames.count)) {
>> +	if (!acpi_disabled || !xen_grant_frames) {
> I realize now that we only need:
>
>      if (!xen_grant_frames) {

Indeed, the first part of the check looks superfluous, will do.


>
> with that:
>
> Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>

Thanks!


>
>
>
>> +		xen_auto_xlat_grant_frames.count = gnttab_max_grant_frames();
>> +		rc = xen_xlate_map_ballooned_pages(&xen_auto_xlat_grant_frames.pfn,
>> +										   &xen_auto_xlat_grant_frames.vaddr,
>> +										   xen_auto_xlat_grant_frames.count);
>> +	} else
>> +		rc = gnttab_setup_auto_xlat_frames(xen_grant_frames);
>> +	if (rc) {
>>   		free_percpu(xen_vcpu_info);
>> -		return -ENOMEM;
>> +		return rc;
>>   	}
>>   	gnttab_init();

-- 
Regards,

Oleksandr Tyshchenko

