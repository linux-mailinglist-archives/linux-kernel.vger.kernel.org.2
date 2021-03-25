Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AABA2349948
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 19:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbhCYSOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 14:14:16 -0400
Received: from pio-pvt-msa1.bahnhof.se ([79.136.2.40]:56178 "EHLO
        pio-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhCYSNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 14:13:40 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 1B9DE3F58A;
        Thu, 25 Mar 2021 19:13:39 +0100 (CET)
Authentication-Results: pio-pvt-msa1.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b="bOXPgDuL";
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
        DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
        URIBL_BLOCKED=0.001] autolearn=ham autolearn_force=no
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 36X5fsGQR3cs; Thu, 25 Mar 2021 19:13:38 +0100 (CET)
Received: by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id D7A783F377;
        Thu, 25 Mar 2021 19:13:36 +0100 (CET)
Received: from [10.249.254.165] (unknown [192.198.151.44])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 880B636059E;
        Thu, 25 Mar 2021 19:13:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1616696016; bh=ccthR8+3Hk5Ox8PeQv8Va4F118+/tBSCEPzJg3VAxZs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=bOXPgDuLyt0NMxRDWcFUkrudDGfPZJamxR9X+vliH4e3m8vKYTc82qLVR8olQEqM8
         hcUxNVANfDq+5Nctk1NCiDllhxuzOm4XGIHFqcLQXqRHDFnlY2Vx6P+zBjxrbpuxD8
         EqoNkJCXBXHo0CgJvGJiCHN4wBh83heMYUFA76xg=
Subject: Re: [RFC PATCH 1/2] mm,drm/ttm: Block fast GUP to TTM huge pages
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
References: <20210321184529.59006-1-thomas_os@shipmail.org>
 <20210321184529.59006-2-thomas_os@shipmail.org>
 <ec99146c7abc35d16b245816aba3e9d14862e624.camel@intel.com>
 <c2239da2-c514-2c88-c671-918909cdba6b@shipmail.org>
 <YFsNRIUYrwVQanVF@phenom.ffwll.local>
 <a1fa7fa2-914b-366d-9902-e5b784e8428c@shipmail.org>
 <75423f64-adef-a2c4-8e7d-2cb814127b18@intel.com>
 <e5199438-9a0d-2801-f9f6-ceb13d7a9c61@shipmail.org>
 <6b0de827-738d-b3c5-fc79-8ca9047bad35@intel.com>
 <9f789d64-940f-c728-8d5e-aab74d562fb6@shipmail.org>
 <20210325175504.GH2356281@nvidia.com>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28Intel=29?= 
        <thomas_os@shipmail.org>
Message-ID: <1ed48d99-1cd9-d87b-41dd-4169afc77f70@shipmail.org>
Date:   Thu, 25 Mar 2021 19:13:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210325175504.GH2356281@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/25/21 6:55 PM, Jason Gunthorpe wrote:
> On Thu, Mar 25, 2021 at 06:51:26PM +0100, Thomas Hellström (Intel) wrote:
>> On 3/24/21 9:25 PM, Dave Hansen wrote:
>>> On 3/24/21 1:22 PM, Thomas Hellström (Intel) wrote:
>>>>> We also have not been careful at *all* about how _PAGE_BIT_SOFTW* are
>>>>> used.  It's quite possible we can encode another use even in the
>>>>> existing bits.
>>>>>
>>>>> Personally, I'd just try:
>>>>>
>>>>> #define _PAGE_BIT_SOFTW5        57      /* available for programmer */
>>>>>
>>>> OK, I'll follow your advise here. FWIW I grepped for SW1 and it seems
>>>> used in a selftest, but only for PTEs AFAICT.
>>>>
>>>> Oh, and we don't care about 32-bit much anymore?
>>> On x86, we have 64-bit PTEs when running 32-bit kernels if PAE is
>>> enabled.  IOW, we can handle the majority of 32-bit CPUs out there.
>>>
>>> But, yeah, we don't care about 32-bit. :)
>> Hmm,
>>
>> Actually it makes some sense to use SW1, to make it end up in the same dword
>> as the PSE bit, as from what I can tell, reading of a 64-bit pmd_t on 32-bit
>> PAE is not atomic, so in theory a huge pmd could be modified while reading
>> the pmd_t making the dwords inconsistent.... How does that work with fast
>> gup anyway?
> It loops to get an atomic 64 bit value if the arch can't provide an
> atomic 64 bit load

Hmm, ok, I see a READ_ONCE() in gup_pmd_range(), and then the resulting 
pmd is dereferenced either in try_grab_compound_head() or 
__gup_device_huge(), before the pmd is compared to the value the pointer 
is currently pointing to. Couldn't those dereferences be on invalid 
pointers?

/Thomas

>
> Jason
