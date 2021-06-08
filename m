Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6E039EF35
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 09:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbhFHHHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 03:07:32 -0400
Received: from foss.arm.com ([217.140.110.172]:50704 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229678AbhFHHHb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 03:07:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9DE33ED1;
        Tue,  8 Jun 2021 00:05:38 -0700 (PDT)
Received: from [10.163.83.140] (unknown [10.163.83.140])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9BF443F73D;
        Tue,  8 Jun 2021 00:05:35 -0700 (PDT)
Subject: Re: Arm64 crash while reading memory sysfs
To:     Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Qian Cai <quic_qiancai@quicinc.com>,
        David Hildenbrand <david@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <DM5PR0201MB355723819DDAC439273F68848E259@DM5PR0201MB3557.namprd02.prod.outlook.com>
 <YK3tQ0a0S/CLxyyb@linux.ibm.com>
 <CY4PR0201MB35539FF5EE729283C4241F5A8E249@CY4PR0201MB3553.namprd02.prod.outlook.com>
 <YK6EXNZHY1xt7Kjs@linux.ibm.com>
 <d55f915c-ad01-e729-1e29-b57d78257cbb@quicinc.com>
 <YK9e0LgDOfCFo6TM@linux.ibm.com>
 <ce5a5920-3046-21b5-42c0-2237ec1eef13@quicinc.com>
 <YK/HKMgajBCwpLt8@linux.ibm.com> <20210527175047.GK8661@arm.com>
 <20210527155644.7792b4eaa16ec56645e1080c@linux-foundation.org>
 <YLB8AvgC2Ov6N6Pt@linux.ibm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <daaf6faa-b5c1-b201-28c9-07f8e1fe4a82@arm.com>
Date:   Tue, 8 Jun 2021 12:36:21 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YLB8AvgC2Ov6N6Pt@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/28/21 10:43 AM, Mike Rapoport wrote:
> On Thu, May 27, 2021 at 03:56:44PM -0700, Andrew Morton wrote:
>> On Thu, 27 May 2021 18:50:48 +0100 Catalin Marinas <catalin.marinas@arm.com> wrote:
>>
>>>> Can you please try Anshuman's patch "arm64/mm: Drop HAVE_ARCH_PFN_VALID":
>>>>
>>>> https://lore.kernel.org/lkml/1621947349-25421-1-git-send-email-anshuman.khandual@arm.com
>>>>
>>>> It seems to me that the check for memblock_is_memory() in
>>>> arm64::pfn_valid() is what makes init_unavailable_range() to bail out for
>>>> section parts that are not actually populated and then we have
>>>> VM_BUG_ON_PAGE(PagePoisoned(p)) for these pages.
>>>
>>> I acked Anshuman's patch, I think they all need to go in together.
>>
>> That's neat.   Specifically which patches are we referring to here?
> 
> arm64: drop pfn_valid_within() and simplify pfn_valid():
> https://lore.kernel.org/lkml/20210511100550.28178-5-rppt@kernel.org
> 
> arm64/mm: Drop HAVE_ARCH_PFN_VALID:
> https://lore.kernel.org/lkml/1621947349-25421-1-git-send-email-anshuman.khandual@arm.com

I dont see the above patch (which drops HAVE_ARCH_PFN_VALID on arm64) on linux-next
i.e. next-20210607. I might have missed some earlier context here but do not we want
to fallback on generic pfn_valid() after Mike's series ?
