Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7BD3FE92F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 08:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238658AbhIBGU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 02:20:26 -0400
Received: from ivanoab7.miniserver.com ([37.128.132.42]:54224 "EHLO
        www.kot-begemot.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbhIBGUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 02:20:17 -0400
Received: from tun252.jain.kot-begemot.co.uk ([192.168.18.6] helo=jain.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1mLg43-0002iY-Fn; Thu, 02 Sep 2021 06:19:11 +0000
Received: from madding.kot-begemot.co.uk ([192.168.3.98])
        by jain.kot-begemot.co.uk with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1mLg3x-00060b-Ah; Thu, 02 Sep 2021 07:19:07 +0100
Subject: Re: [PATCH] drm/ttm: provide default page protection for UML
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?Q?Thomas_Hellstr=c3=b6m?= 
        <thomas.hellstrom@linux.intel.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>, dri-devel@lists.freedesktop.org,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        linux-um@lists.infradead.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
References: <20210902020129.25952-1-rdunlap@infradead.org>
 <9faacbc8-3346-8033-5b4d-60543eae959e@cambridgegreys.com>
 <f978cae5-7275-6780-8a17-c6e61247bce7@infradead.org>
From:   Anton Ivanov <anton.ivanov@cambridgegreys.com>
Organization: Cambridge Greys
Message-ID: <0887903c-483d-49c7-0d35-f59be2f85bac@cambridgegreys.com>
Date:   Thu, 2 Sep 2021 07:19:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <f978cae5-7275-6780-8a17-c6e61247bce7@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0
X-Spam-Score: -1.0
X-Clacks-Overhead: GNU Terry Pratchett
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/09/2021 06:52, Randy Dunlap wrote:
> On 9/1/21 10:48 PM, Anton Ivanov wrote:
>> On 02/09/2021 03:01, Randy Dunlap wrote:
>>> boot_cpu_data [struct cpuinfo_um (on UML)] does not have a struct
>>> member named 'x86', so provide a default page protection mode
>>> for CONFIG_UML.
>>>
>>> Mends this build error:
>>> ../drivers/gpu/drm/ttm/ttm_module.c: In function 
>>> ‘ttm_prot_from_caching’:
>>> ../drivers/gpu/drm/ttm/ttm_module.c:59:24: error: ‘struct cpuinfo_um’ 
>>> has no member named ‘x86’
>>>    else if (boot_cpu_data.x86 > 3)
>>>                          ^
>>>
>>> Fixes: 3bf3710e3718 ("drm/ttm: Add a generic TTM memcpy move for 
>>> page-based iomem")
>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>>> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>>> Cc: Christian König <christian.koenig@amd.com>
>>> Cc: Huang Rui <ray.huang@amd.com>
>>> Cc: dri-devel@lists.freedesktop.org
>>> Cc: Jeff Dike <jdike@addtoit.com>
>>> Cc: Richard Weinberger <richard@nod.at>
>>> Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
>>> Cc: linux-um@lists.infradead.org
>>> Cc: David Airlie <airlied@linux.ie>
>>> Cc: Daniel Vetter <daniel@ffwll.ch>
>>> ---
>>>   drivers/gpu/drm/ttm/ttm_module.c |    4 ++++
>>>   1 file changed, 4 insertions(+)
>>>
>>> --- linux-next-20210901.orig/drivers/gpu/drm/ttm/ttm_module.c
>>> +++ linux-next-20210901/drivers/gpu/drm/ttm/ttm_module.c
>>> @@ -53,6 +53,9 @@ pgprot_t ttm_prot_from_caching(enum ttm_
>>>       if (caching == ttm_cached)
>>>           return tmp;
>>> +#ifdef CONFIG_UML
>>> +    tmp = pgprot_noncached(tmp);
>>> +#else
>>>   #if defined(__i386__) || defined(__x86_64__)
>>>       if (caching == ttm_write_combined)
>>>           tmp = pgprot_writecombine(tmp);
>>> @@ -69,6 +72,7 @@ pgprot_t ttm_prot_from_caching(enum ttm_
>>>   #if defined(__sparc__)
>>>       tmp = pgprot_noncached(tmp);
>>>   #endif
>>> +#endif
>>>       return tmp;
>>>   }
>>
>> Patch looks OK.
>>
>> I have a question though - why all of DRM is not !UML in config. Not 
>> like we can use them.
> 
> I have no idea about that.
> Hopefully one of the (other) UML maintainers can answer you.

Touche.

We will discuss that and possibly push a patch to !UML that part of the 
tree. IMHO it is not applicable.

A.

> 
> thanks.


-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/
