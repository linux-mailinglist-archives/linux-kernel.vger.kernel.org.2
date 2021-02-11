Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34C47318A2A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 13:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbhBKMNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 07:13:55 -0500
Received: from foss.arm.com ([217.140.110.172]:51092 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229712AbhBKMLH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 07:11:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D6301063;
        Thu, 11 Feb 2021 04:10:12 -0800 (PST)
Received: from [192.168.0.130] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 73EA03F73B;
        Thu, 11 Feb 2021 04:10:08 -0800 (PST)
Subject: Re: [PATCH V2 1/2] arm64/mm: Fix pfn_valid() for ZONE_DEVICE based
 memory
To:     Will Deacon <will@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        linux-mm@kvack.org,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        James Morse <james.morse@arm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <1612239114-28428-1-git-send-email-anshuman.khandual@arm.com>
 <1612239114-28428-2-git-send-email-anshuman.khandual@arm.com>
 <20210202123215.GA16868@willie-the-truck>
 <20210202123524.GB16868@willie-the-truck>
 <f32e7caa-3414-9dd7-eb8c-220da1d925a1@redhat.com>
 <20210202125152.GC16868@willie-the-truck>
 <4d8f5156-8628-5531-1485-322ad92aa15c@redhat.com>
 <0e649f28-4d54-319d-f876-8a93870cda7f@arm.com>
 <20210205185552.GA23216@willie-the-truck>
 <20210211115354.GB29894@willie-the-truck>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <23e5eb93-a39c-c68e-eac1-c5ccf9036079@arm.com>
Date:   Thu, 11 Feb 2021 17:40:35 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210211115354.GB29894@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/11/21 5:23 PM, Will Deacon wrote:
> On Fri, Feb 05, 2021 at 06:55:53PM +0000, Will Deacon wrote:
>> On Wed, Feb 03, 2021 at 09:20:39AM +0530, Anshuman Khandual wrote:
>>> On 2/2/21 6:26 PM, David Hildenbrand wrote:
>>>> On 02.02.21 13:51, Will Deacon wrote:
>>>>> On Tue, Feb 02, 2021 at 01:39:29PM +0100, David Hildenbrand wrote:
>>>>>> As I expressed already, long term we should really get rid of the arm64
>>>>>> variant and rather special-case the generic one. Then we won't go out of
>>>>>> sync - just as it happened with ZONE_DEVICE handling here.
>>>>>
>>>>> Why does this have to be long term? This ZONE_DEVICE stuff could be the
>>>>> carrot on the stick :)
>>>>
>>>> Yes, I suggested to do it now, but Anshuman convinced me that doing a
>>>> simple fix upfront might be cleaner --- for example when it comes to
>>>> backporting :)
>>>
>>> Right. The current pfn_valid() breaks for ZONE_DEVICE memory and this fixes
>>> the problem in the present context which can be easily backported if required.
>>>
>>> Changing or rather overhauling the generic code with new configs as proposed
>>> earlier (which I am planning to work on subsequently) would definitely be an
>>> improvement for the current pfn_valid() situation in terms of maintainability
>>> but then it should not stop us from fixing the problem now.
>>
>> Alright, I've mulled this over a bit. I don't agree that this patch helps
>> with maintainability (quite the opposite, in fact), but perfection is the
>> enemy of the good so I'll queue the series for 5.12. However, I'll revert
>> the changes at the first sign of a problem, so please do work towards a
>> generic solution which can replace this in the medium term.
> 
> ... and dropped. These patches appear to be responsible for a boot
> regression reported by CKI:

Ahh, boot regression ? These patches only change the behaviour
for non boot memory only.

> 
> https://lore.kernel.org/r/cki.8D1CB60FEC.K6NJMEFQPV@redhat.com

Will look into the logs and see if there is something pointing to
the problem.
