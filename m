Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E49F73D3421
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 07:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233818AbhGWEyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 00:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbhGWEx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 00:53:59 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAEF1C061575
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 22:34:32 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id m2-20020a17090a71c2b0290175cf22899cso2342312pjs.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 22:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=R31IBsRAfuuPKWQktgrPBsM8qqZTNdn0VUlW4YQ6CmU=;
        b=shYdbYpKnnZqm3nw+0kpBihqH8f7KJROTlNmKF6YN4j4mx9oxE9amV1mosmOA6XqFB
         MVjyzhtn+B+ahOWqplFIYkLSU+nMzE6N0JSo+x9HY2zsO60MQfzTIzwgg3AhDYqimSRh
         6eu3wJ5bfyiCjKf6iRfpZ6d4Jg5azuCRs9nxkVvmhtu2Rd8yMNQb1ekVMChSypNwNlXs
         6g9SbsBaiRoWq4MfOTVh7QP4eU0iNr9hbYlLRSY3nVX5f/8wWbNux4QWD8B5f7XDPD0m
         WUsIdOtdX1g8NK05c0UHfuBF42+/UItgWfFng0ZZJ0q/BRt1URVN1jPQzVX26cA+NuqH
         X8Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=R31IBsRAfuuPKWQktgrPBsM8qqZTNdn0VUlW4YQ6CmU=;
        b=XkfVhPA9b8hOIVcL4jEqD9yIoW19wch84BeZKwEFioSf4Mqxp9OsWTQ4URrsBieMs9
         DbdrRwSKmH7A0G8sLhx/S3C4zgOJdEgBXhuTRYb3rhd0/J2X9dIQLgzHc246KlDpoLgr
         tFOkBsguYs+FFmsoOTqXAAWj0ogrJmBVDNTg8I28WJGg9s1E2cBz4WQApsubndqFeLiv
         RZVooSwvdeJHzsP5zi9f4/G4Lk2WKCcCg9W8j84H/CnZ678swGSXoEgYwnDk9zGLYAQs
         UIEfFLmTJ6hTQY+7FrdRQstooS8pSgnCvwh2qr+DuWEbK+8+tHOs94g7SmIJc36TtHgT
         zqMQ==
X-Gm-Message-State: AOAM531UBhVgzxgB41lp3CP86hBSbnJ0kb+PxneV8pllZesOBsETIgBy
        5XZDLSQ1WEqfRebhq4r6doY41Q==
X-Google-Smtp-Source: ABdhPJx3Ec2rarEh2fRASsiuYDsAF/2MRAJnhHTqu5M1OIbZbAHGF9soOBmIOC9+kPoM1DowUbhUPg==
X-Received: by 2002:a17:90a:420c:: with SMTP id o12mr3076303pjg.101.1627018472138;
        Thu, 22 Jul 2021 22:34:32 -0700 (PDT)
Received: from [192.168.10.23] (219-90-184-65.ip.adam.com.au. [219.90.184.65])
        by smtp.gmail.com with UTF8SMTPSA id n22sm31926155pfo.125.2021.07.22.22.34.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jul 2021 22:34:31 -0700 (PDT)
Message-ID: <75c84c0b-46b3-2600-c186-257aec05c645@ozlabs.ru>
Date:   Fri, 23 Jul 2021 15:34:25 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0
Subject: Re: [PATCH v5 10/11] powerpc/pseries/iommu: Make use of DDW for
 indirect mapping
Content-Language: en-US
To:     Frederic Barrat <fbarrat@linux.ibm.com>,
        Leonardo Bras <leobras.c@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        kernel test robot <lkp@intel.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20210716082755.428187-1-leobras.c@gmail.com>
 <20210716082755.428187-11-leobras.c@gmail.com>
 <b98f696a-ed64-4c9e-ccb6-549ae8bc7fd6@linux.ibm.com>
 <8dfb28d5-b654-746c-03d8-aeee3d438240@ozlabs.ru>
 <994051df-73b3-4dad-76aa-1a03d9afaf6d@linux.ibm.com>
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
In-Reply-To: <994051df-73b3-4dad-76aa-1a03d9afaf6d@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/07/2021 01:04, Frederic Barrat wrote:
> 
> 
> On 21/07/2021 05:32, Alexey Kardashevskiy wrote:
>>>> +        struct iommu_table *newtbl;
>>>> +        int i;
>>>> +
>>>> +        for (i = 0; i < ARRAY_SIZE(pci->phb->mem_resources); i++) {
>>>> +            const unsigned long mask = IORESOURCE_MEM_64 | 
>>>> IORESOURCE_MEM;
>>>> +
>>>> +            /* Look for MMIO32 */
>>>> +            if ((pci->phb->mem_resources[i].flags & mask) == 
>>>> IORESOURCE_MEM)
>>>> +                break;
>>>> +        }
>>>> +
>>>> +        if (i == ARRAY_SIZE(pci->phb->mem_resources))
>>>> +            goto out_del_list;
>>>
>>>
>>> So we exit and do nothing if there's no MMIO32 bar?
>>> Isn't the intent just to figure out the MMIO32 area to reserve it 
>>> when init'ing the table? In which case we could default to 0,0
>>>
>>> I'm actually not clear why we are reserving this area on pseries.
>>
>>
>>
>> If we do not reserve it, then the iommu code will allocate DMA pages 
>> from there and these addresses are MMIO32 from the kernel pov at 
>> least. I saw crashes when (I think) a device tried DMAing to the top 
>> 2GB of the bus space which happened to be a some other device's BAR.
> 
> 
> hmmm... then figuring out the correct range needs more work. We could 
> have more than one MMIO32 bar. And they don't have to be adjacent. 

They all have to be within the MMIO32 window of a PHB and we reserve the 
entire window here.

> I 
> don't see that we are reserving any range on the initial table though 
> (on pseries).
True, we did not need to, as the hypervisor always took care of DMA and 
MMIO32 regions to not overlap.

And in this series we do not (strictly speaking) need this either as 
phyp never allocates more than one window dynamically and that only 
window is always the second one starting from 0x800.0000.0000.0000. It 
is probably my mistake that KVM allows a new window to start from 0 - 
PAPR did not prohibit this explicitly.

And for the KVM case, we do not need to remove the default window as KVM 
can pretty much always allocate as many TCE as the VM wants. But we 
still allow removing the default window and creating a huge one instead 
at 0x0 as this way we can allow 1:1 for every single PCI device even if 
it only allows 48 (or similar but less than 64bit) DMA. Hope this makes 
sense. Thanks,


-- 
Alexey
