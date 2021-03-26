Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 436A934A75E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 13:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbhCZMdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 08:33:52 -0400
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:28818 "EHLO
        ste-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbhCZMdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 08:33:37 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 860423FAE7;
        Fri, 26 Mar 2021 13:33:35 +0100 (CET)
Authentication-Results: ste-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=lImiUJbV;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
        DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
        URIBL_BLOCKED=0.001] autolearn=ham autolearn_force=no
Authentication-Results: ste-ftg-msa2.bahnhof.se (amavisd-new);
        dkim=pass (1024-bit key) header.d=shipmail.org
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8mseWCPLjN5N; Fri, 26 Mar 2021 13:33:34 +0100 (CET)
Received: by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id D68353FA0A;
        Fri, 26 Mar 2021 13:33:32 +0100 (CET)
Received: from [10.249.254.17] (unknown [192.198.151.44])
        by mail1.shipmail.org (Postfix) with ESMTPSA id A1D6F360060;
        Fri, 26 Mar 2021 13:33:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1616762012; bh=PzQwASPwsFfyMyzuI1D/RjQZilyjqX+o1nNIMEz2WeQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=lImiUJbVa/5KNadlW6pW8lJ/UxWXtxu1+OkemcRAKpcMmJkaFDhkFmF+4D8OFEsRn
         N+dkOUZAzJumsXzhTU1lZy6HuElM8OuQwJ4ODgl8kPDzRD5u+0s4YAzxpY7+68Bbil
         8J9mRO6RIFFDcWLrkX/8RsAIYaWJzYniOudaBv1Q=
Subject: Re: [RFC PATCH 1/2] mm,drm/ttm: Block fast GUP to TTM huge pages
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>
References: <YFsNRIUYrwVQanVF@phenom.ffwll.local>
 <a1fa7fa2-914b-366d-9902-e5b784e8428c@shipmail.org>
 <75423f64-adef-a2c4-8e7d-2cb814127b18@intel.com>
 <e5199438-9a0d-2801-f9f6-ceb13d7a9c61@shipmail.org>
 <6b0de827-738d-b3c5-fc79-8ca9047bad35@intel.com>
 <9f789d64-940f-c728-8d5e-aab74d562fb6@shipmail.org>
 <20210325175504.GH2356281@nvidia.com>
 <1ed48d99-1cd9-d87b-41dd-4169afc77f70@shipmail.org>
 <20210325182442.GI2356281@nvidia.com>
 <1eda588b-ae51-9b69-4bd4-da37b2aa1e4b@shipmail.org>
 <20210326114654.GL2356281@nvidia.com>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28Intel=29?= 
        <thomas_os@shipmail.org>
Message-ID: <a30e4116-4d51-9143-3195-791fc1e70e87@shipmail.org>
Date:   Fri, 26 Mar 2021 13:33:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210326114654.GL2356281@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/26/21 12:46 PM, Jason Gunthorpe wrote:
> On Fri, Mar 26, 2021 at 10:08:09AM +0100, Thomas Hellström (Intel) wrote:
>> On 3/25/21 7:24 PM, Jason Gunthorpe wrote:
>>> On Thu, Mar 25, 2021 at 07:13:33PM +0100, Thomas Hellström (Intel) wrote:
>>>> On 3/25/21 6:55 PM, Jason Gunthorpe wrote:
>>>>> On Thu, Mar 25, 2021 at 06:51:26PM +0100, Thomas Hellström (Intel) wrote:
>>>>>> On 3/24/21 9:25 PM, Dave Hansen wrote:
>>>>>>> On 3/24/21 1:22 PM, Thomas Hellström (Intel) wrote:
>>>>>>>>> We also have not been careful at *all* about how _PAGE_BIT_SOFTW* are
>>>>>>>>> used.  It's quite possible we can encode another use even in the
>>>>>>>>> existing bits.
>>>>>>>>>
>>>>>>>>> Personally, I'd just try:
>>>>>>>>>
>>>>>>>>> #define _PAGE_BIT_SOFTW5        57      /* available for programmer */
>>>>>>>>>
>>>>>>>> OK, I'll follow your advise here. FWIW I grepped for SW1 and it seems
>>>>>>>> used in a selftest, but only for PTEs AFAICT.
>>>>>>>>
>>>>>>>> Oh, and we don't care about 32-bit much anymore?
>>>>>>> On x86, we have 64-bit PTEs when running 32-bit kernels if PAE is
>>>>>>> enabled.  IOW, we can handle the majority of 32-bit CPUs out there.
>>>>>>>
>>>>>>> But, yeah, we don't care about 32-bit. :)
>>>>>> Hmm,
>>>>>>
>>>>>> Actually it makes some sense to use SW1, to make it end up in the same dword
>>>>>> as the PSE bit, as from what I can tell, reading of a 64-bit pmd_t on 32-bit
>>>>>> PAE is not atomic, so in theory a huge pmd could be modified while reading
>>>>>> the pmd_t making the dwords inconsistent.... How does that work with fast
>>>>>> gup anyway?
>>>>> It loops to get an atomic 64 bit value if the arch can't provide an
>>>>> atomic 64 bit load
>>>> Hmm, ok, I see a READ_ONCE() in gup_pmd_range(), and then the resulting pmd
>>>> is dereferenced either in try_grab_compound_head() or __gup_device_huge(),
>>>> before the pmd is compared to the value the pointer is currently pointing
>>>> to. Couldn't those dereferences be on invalid pointers?
>>> Uhhhhh.. That does look questionable, yes. Unless there is some tricky
>>> reason why a 64 bit pmd entry on a 32 bit arch either can't exist or
>>> has a stable upper 32 bits..
>>>
>>> The pte does it with ptep_get_lockless(), we probably need the same
>>> for the other levels too instead of open coding a READ_ONCE?
>>>
>>> Jason
>> TBH, ptep_get_lockless() also looks a bit fishy. it says
>> "it will not switch to a completely different present page without a TLB
>> flush in between".
>>
>> What if the following happens:
>>
>> processor 1: Reads lower dword of PTE.
>> processor 2: Zaps PTE. Gets stuck waiting to do TLB flush
>> processor 1: Reads upper dword of PTE, which is now zero.
>> processor 3: Hits a TLB miss, reads an unpopulated PTE and faults in a new
>> PTE value which happens to be the same as the original one before the zap.
>> processor 1: Reads the newly faulted in lower dword, compares to the old
>> one, gives an OK and returns a bogus PTE.
> So you are saying that while the zap will wait for the TLB flush to
> globally finish once it gets started any other processor can still
> write to the pte?
>
> I can't think of any serialization that would cause fault to wait for
> the zap/TLB flush, especially if the zap comes from the address_space
> and doesn't hold the mmap lock.

I might of course be completely wrong, but It seems there is an 
assumption made that all potentially affected processors would have a 
valid TLB entry for the PTE. Then the fault would not happen (well 
unless of course the TLB flush completes on some processors before 
getting stuck on the local_irq_disable() on processor 1).

+CC: Nick Piggin

Seems like Nick Piggin is the original author of the comment. Perhaps he 
can can clarify a bit.

/Thomas


>
> Seems worth bringing up in a bigger thread, maybe someone else knows?
>
> Jason
