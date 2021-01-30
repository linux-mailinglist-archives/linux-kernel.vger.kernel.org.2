Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5E03098CB
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 00:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbhA3XXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 18:23:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbhA3XW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 18:22:56 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87A9C061573
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 15:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=NKrR+Lj4ywGNRc3dhLV33eCl8FFCpLqHQ8RPAMbWaq0=; b=RvXATeuxxW9BPT4eFoS+ezlA7x
        AzNeUxYcC16HVzGdJl+y74LgICGZPe+VYIS3Q62YiVrX3HON5BGuc1hGtvAM1VETG0DqKI9h0yKHc
        L5bNP9w3VjFmpMrgsxXIReZZrMRz9o+Cbz/1RT3aXew0HO984JrfPFN/z1TCmvbLcGoltgYNggYWv
        1Mdnb4hsS9tFYvbavjx8xzQY5MMXEyosFv34THawvsqDuP6n9Gx9XbQpCjUwBZiEYkMVCh90Ch8KA
        tynGusYEKRnJT0fQMhq0vaaMlXIsxuimSqolnx2jE0u98/QkL3uuaWmjuhsZT2WY8iGCQnUPg2vWB
        XJOJmbIw==;
Received: from [2601:1c0:6280:3f0::1d53]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l5zZ0-00Bft3-IK; Sat, 30 Jan 2021 23:22:02 +0000
Subject: Re: [PATCH] powerpc: fix AKEBONO build failures
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Yury Norov <yury.norov@gmail.com>,
        linuxppc-dev@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
References: <CAAH8bW8-6Dp29fe6rrnA4eL1vo+mu0HuAVJ-5yjbwxDSvaHdeQ@mail.gmail.com>
 <6c442012-3bef-321b-bbc3-09c54608661f@infradead.org>
 <875z3prcwg.fsf@mpe.ellerman.id.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <4572579a-7208-628d-cbe2-b70a74a84ae7@infradead.org>
Date:   Sat, 30 Jan 2021 15:21:55 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <875z3prcwg.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/21/21 5:14 PM, Michael Ellerman wrote:
> Randy Dunlap <rdunlap@infradead.org> writes:
>> On 1/20/21 1:29 PM, Yury Norov wrote:
>>> Hi all,
>>>
>>> I found the power pc build broken on today's
>>> linux-next (647060f3b592).
>>
>> Darn, I was building linux-5.11-rc4.
>>
>> I'll try linux-next after I send this.
>>
>> ---
>> From: Randy Dunlap <rdunlap@infradead.org>
>>
>> Fulfill AKEBONO Kconfig requirements.
>>
>> Fixes these Kconfig warnings (and more) and fixes the subsequent
>> build errors:
>>
>> WARNING: unmet direct dependencies detected for NETDEVICES
>>    Depends on [n]: NET [=n]
>>    Selected by [y]:
>>    - AKEBONO [=y] && PPC_47x [=y]
>>
>> WARNING: unmet direct dependencies detected for MMC_SDHCI
>>    Depends on [n]: MMC [=n] && HAS_DMA [=y]
>>    Selected by [y]:
>>    - AKEBONO [=y] && PPC_47x [=y]
>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Paul Mackerras <paulus@samba.org>
>> Cc: linuxppc-dev@lists.ozlabs.org
>> Cc: Yury Norov <yury.norov@gmail.com>
>> ---
>>   arch/powerpc/platforms/44x/Kconfig |    2 ++
>>   1 file changed, 2 insertions(+)
>>
>> --- lnx-511-rc4.orig/arch/powerpc/platforms/44x/Kconfig
>> +++ lnx-511-rc4/arch/powerpc/platforms/44x/Kconfig
>> @@ -206,6 +206,7 @@ config AKEBONO
>>   	select PPC4xx_HSTA_MSI
>>   	select I2C
>>   	select I2C_IBM_IIC
>> +	select NET
>>   	select NETDEVICES
>>   	select ETHERNET
>>   	select NET_VENDOR_IBM
> 
> I think the problem here is too much use of select, for things that
> should instead be in the defconfig.
> 
> The patch below results in the same result for make
> 44x/akebono_defconfig. Does it fix the original issue?

Hi Michael,
Sorry for the delay.

Changing the akebono_defconfig doesn't cause the missing symbols
to be set -- the defconfig is not being used here.

I guess that if you have users who set CONFIG_AKEBONO and expect
it to build cleanly, you will need something like my patch or the
patch that Florian just posted.

Changing the akebono_defconfig also would not help 'make randconfig'
builds to build cleanly if they had happened to enable AKEBONO.


> We don't need to add ETHERNET or NET_VENDOR_IBM to the defconfig because
> they're both default y.
> 
> cheers

