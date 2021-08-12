Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 090FD3EA1AE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 11:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235700AbhHLJPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 05:15:15 -0400
Received: from foss.arm.com ([217.140.110.172]:40642 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234895AbhHLJPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 05:15:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2DEECD6E;
        Thu, 12 Aug 2021 02:14:48 -0700 (PDT)
Received: from [10.163.68.17] (unknown [10.163.68.17])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8C3EB3F718;
        Thu, 12 Aug 2021 02:14:44 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [RFC V2 01/10] mm/mmap: Dynamically initialize protection_map[]
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        suzuki.poulose@arm.com, mark.rutland@arm.com, will@kernel.org,
        maz@kernel.org, james.morse@arm.com, steven.price@arm.com
References: <1627281445-12445-1-git-send-email-anshuman.khandual@arm.com>
 <1627281445-12445-2-git-send-email-anshuman.khandual@arm.com>
 <20210805170318.GB6719@arm.com>
Message-ID: <d52e8af9-61af-45c2-837b-5a489e7e2916@arm.com>
Date:   Thu, 12 Aug 2021 14:45:37 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210805170318.GB6719@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/5/21 10:33 PM, Catalin Marinas wrote:
> On Mon, Jul 26, 2021 at 12:07:16PM +0530, Anshuman Khandual wrote:
>> The protection_map[] elements (__PXXX and __SXXX) might sometimes contain
>> runtime variables in certain platforms like arm64 preventing a successful
>> build because of the current static initialization. So it just defers the
>> initialization until mmmap_init() via a new helper init_protection_map().
>>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>  mm/mmap.c | 26 ++++++++++++++++++++++----
>>  1 file changed, 22 insertions(+), 4 deletions(-)
>>
>> diff --git a/mm/mmap.c b/mm/mmap.c
>> index ca54d36..a95b078 100644
>> --- a/mm/mmap.c
>> +++ b/mm/mmap.c
>> @@ -100,10 +100,7 @@ static void unmap_region(struct mm_struct *mm,
>>   *								w: (no) no
>>   *								x: (yes) yes
>>   */
>> -pgprot_t protection_map[16] __ro_after_init = {
>> -	__P000, __P001, __P010, __P011, __P100, __P101, __P110, __P111,
>> -	__S000, __S001, __S010, __S011, __S100, __S101, __S110, __S111
>> -};
>> +pgprot_t protection_map[16] __ro_after_init;
> 
> Mips, x86, sparc, arm32, m68k all adjust protection_map[] during boot.
> Could we do something similar here and avoid changing the generic code?

If __P[000..111] and __S[000..111] be made dummy values (e.g 0 or something
standard prot temporarily), hence the compilation problem could be avoided.
Later in the platform code, protection_map[] could be adjusted with actual
prot values which would involve variable.
