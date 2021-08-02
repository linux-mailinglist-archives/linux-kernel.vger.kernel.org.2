Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 064573DDCD1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 17:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235267AbhHBPxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 11:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbhHBPxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 11:53:10 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA9FC06175F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 08:52:59 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id u3so34537485lff.9
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 08:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=rZE2kxJUwxlWS0DHYnwAhW5sZr7G/tOU41OLr3EDTSQ=;
        b=ajp27t6iySSnmVocJB9vyLIMuMEj0ELjxZwFdtRUVy3IFWSnJ8N+T+Y11N7MOlBp0j
         zS5kGUzkR9Uxs1Cdc6D83pHruxn99RF5fp5k3mdcFVzPzOStz671owVn2ENN7kL1CRx0
         UeYJfSHltOFJ4juIQkBrCz/09K5ZtbS91GL5PCLi8huE9zOmAL9BlrhdFhExJgO0mwzs
         aNfgo8Ys6CDstgOzcFF/ZtPpzF2E9x2iy8XrbbNA4+1syUhPEbSwnEqhINH1bamH9rCE
         qydcXKBZJaEmqjlLQhyZp2GVHg9ebr5e+Gm9wlh0AO9rewvIStj9Hoq7vMBtnH64qGNa
         JExA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=rZE2kxJUwxlWS0DHYnwAhW5sZr7G/tOU41OLr3EDTSQ=;
        b=UEwwWSB6JPM/NlQ2+3zcRRSqikhT9t9JFXCPNxhh9j/b3zm+OBeTwPRhgs2vxGhmWW
         c2Jc+XnkW8jBolNS2Ht1D9v/mFIO0jq0ZbWsr6Jy9aYQZO0cTaHhshe49ItBJlp9riya
         mwqa0B37m0hA7t4QzzFlKFf4pR0eTQV3P6DVq0NyVD+8WBIcgtowWvTLwPkzHyalib/O
         C4S5qWYuwe/Oxuqg8qIcrGxEfAo3W2qeaKKTHh5ESCXrgKVZmNoZUZT7zBEmU38GFoFb
         UDd3yflGLsfJJ6NmAh616W4+4J4ta4MOf1up8P1t3DA+8aoh5CPD84Dj6ICiJrMo6Fqj
         Nv3w==
X-Gm-Message-State: AOAM531q/X62aQHwZU5dWS9qWAVcLxgh4EUbBgybSH3ZmaglM6nhxb9g
        9eaiiJvlREfwY8/gJbcFkCcZ8mwTceRZNA==
X-Google-Smtp-Source: ABdhPJz3Qy3r8VpXCEKLoGBCU5VAKNGs+Ng7MPM//iI5pdJnoCZ36LkTchjxGATWAEsezMK+xWUaFQ==
X-Received: by 2002:ac2:51de:: with SMTP id u30mr13014814lfm.70.1627919578232;
        Mon, 02 Aug 2021 08:52:58 -0700 (PDT)
Received: from [192.168.1.7] ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id f6sm1089944lfr.180.2021.08.02.08.52.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Aug 2021 08:52:57 -0700 (PDT)
Subject: Re: [RFC PATCH 1/2] arm64: mm: Make virt_addr_valid to check for
 pfn_valid again
To:     Mike Rapoport <rppt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Will Deacon <will@kernel.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Juergen Gross <jgross@suse.com>, Julien Grall <julien@xen.org>,
        Wei Chen <Wei.Chen@arm.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
References: <1627490656-1267-1-git-send-email-olekstysh@gmail.com>
 <20210802121947.GF18685@arm.com> <YQgKUibfW4jZbBXM@kernel.org>
From:   Oleksandr <olekstysh@gmail.com>
Message-ID: <f9e1c4a0-a19f-6a56-7641-b4a9973c0807@gmail.com>
Date:   Mon, 2 Aug 2021 18:52:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YQgKUibfW4jZbBXM@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello, all.


On 02.08.21 18:08, Mike Rapoport wrote:
> Hi,
>
> On Mon, Aug 02, 2021 at 01:19:48PM +0100, Catalin Marinas wrote:
>> Adding Mike and Anshuman,
>>
>> On Wed, Jul 28, 2021 at 07:44:15PM +0300, Oleksandr Tyshchenko wrote:
>>> From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
>>>
>>> The problem is that Arm's implementation of virt_addr_valid()
>>> leads to memblock_is_map_memory() check, which will fail for
>>> ZONE_DEVICE based addresses. But, the pfn_valid() check in turn
>>> is able to cope with ZONE_DEVICE based memory.
>>>
>>> You can find a good explanation of that problem at:
>>> https://lore.kernel.org/lkml/1614921898-4099-2-git-send-email-anshuman.khandual@arm.com
>>>
>>> Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
>>> ---
>>> I am not quite sure whether it is a "correct" place and
>>> the change itself, I just partially restored a behaviour before:
>>> https://lore.kernel.org/lkml/20210511100550.28178-4-rppt@kernel.org
>>> So, the target of this patch is to get a feedback how to resolve
>>> this properly if, of course, this really needs to be resolved
>>> (I might miss important bits here).
>>>
>>> It is worth mentioning that patch doesn't fix the current code base
>>> (if I am not mistaken, no one calls virt_addr_valid() on Arm64 for
>>> ZONE_DEVICE based addresses at the moment, so it seems that nothing
>>> is broken), the fix is intended for the subsequent patch in this
>>> series that will try to enable Xen's "unpopulated-alloc" usage
>>> on Arm (it was enabled on x86 so far).
>>> Please see:
>>> [RFC PATCH 2/2] xen/unpopulated-alloc: Query hypervisor to provide
>>> unallocated space
>>>
>>> The subsequent patch will enable the code where virt_addr_valid()
>>> is used in drivers/xen/unpopulated-alloc.c:fill_list() to check that
>>> a virtual address returned by memremap_pages() is valid.
>   
>> I wonder what the point of calling virt_addr_valid() in fill_list() is?
>> If memremap_pages() succeeded, the pages were mapped at the returned
>> vaddr, there's no need for an additional virt_addr_valid() check.
> The virt_addr_valid() check in fill_list() looks bogus to me as well. If
> memremap_pages() succeeds the range is guaranteed to have proper page
> table.
>
> I believe the first patch should be rather removal of the virt_addr_valid()
> check in fill_list().
Thank you for the clarification, I will send a patch to remove 
virt_addr_valid()
check in fill_list() for the non-RFC version.


>   
>>> ---
>>>   arch/arm64/include/asm/memory.h | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
>>> index 824a365..1a35a44 100644
>>> --- a/arch/arm64/include/asm/memory.h
>>> +++ b/arch/arm64/include/asm/memory.h
>>> @@ -351,7 +351,7 @@ static inline void *phys_to_virt(phys_addr_t x)
>>>   
>>>   #define virt_addr_valid(addr)	({					\
>>>   	__typeof__(addr) __addr = __tag_reset(addr);			\
>>> -	__is_lm_address(__addr) && pfn_is_map_memory(virt_to_pfn(__addr));	\
>>> +	__is_lm_address(__addr) && pfn_valid(virt_to_pfn(__addr));	\
>>>   })
>> pfn_valid() only guarantees the presence of a struct page but not
>> necessarily that the virtual address is accessible (valid). So this
>> change would break the NOMAP ranges case.
> +1
Oh, I got it.

-- 
Regards,

Oleksandr Tyshchenko

