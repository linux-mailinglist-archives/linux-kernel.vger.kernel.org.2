Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4C438760D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 12:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348353AbhERKIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 06:08:07 -0400
Received: from foss.arm.com ([217.140.110.172]:47466 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348324AbhERKIC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 06:08:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A5D7A1FB;
        Tue, 18 May 2021 03:06:44 -0700 (PDT)
Received: from [192.168.0.130] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E8F3C3F719;
        Tue, 18 May 2021 03:06:42 -0700 (PDT)
Subject: Re: [PATCH] mm/debug_vm_pgtable: Ensure THP availability via
 has_transparent_hugepage()
To:     Christophe Leroy <christophe.leroy@csgroup.eu>, linux-mm@kvack.org,
        akpm@linux-foundation.org
Cc:     "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        linux-kernel@vger.kernel.org
References: <1621325590-18199-1-git-send-email-anshuman.khandual@arm.com>
 <8b9cb771-8fa1-4fc2-bb45-20673240edd8@csgroup.eu>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <4f1e1a56-2820-cbf4-d5a6-0ed7715afd9b@arm.com>
Date:   Tue, 18 May 2021 15:37:27 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <8b9cb771-8fa1-4fc2-bb45-20673240edd8@csgroup.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/18/21 2:20 PM, Christophe Leroy wrote:
> 
> 
> Le 18/05/2021 à 10:13, Anshuman Khandual a écrit :
>> On certain platforms, THP support could not just be validated via the build
>> option CONFIG_TRANSPARENT_HUGEPAGE. Instead has_transparent_hugepage() also
>> needs to be called upon to verify THP runtime support. Otherwise the debug
>> test might just run into unusable THP helpers like in the case of a 4K hash
> 
> s/might/will/

Sure, will replace.

> 
>> config on powerpc platform [1]. This just moves all pfn_pmd() and pfn_pud()
>> after THP runtime validation with has_transparent_hugepage() which prevents
>> the mentioned problem.
>>
>> [1] https://bugzilla.kernel.org/show_bug.cgi?id=213069
>>
>> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: linux-mm@kvack.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> 
> There should be a Fixes:  tag

Considering pmd_basic_tests() as the earliest test which is being
impacted here, this actually fixes an earlier fix which tried the
very same thing but was probably not complete. But it also applies
to portions of advanced tests which came later on as well, which
should have taken this problem into account.

Fixes: 787d563b8642 ("mm/debug_vm_pgtable: fix kernel crash by checking for THP support")

> 
>> ---
>> This applies on v5.13-rc2 after the following patches.
>>
>> [1] https://lore.kernel.org/linux-mm/20210419071820.750217-1-liushixin2@huawei.com/
>> [2] https://lore.kernel.org/linux-mm/20210419071820.750217-2-liushixin2@huawei.com/
> 
> I can't see any fixes: tag in those patches, and their subject line even targets them to -next. Are they meant to go to 5.13 and stable ?
> 
> If not, how do you coordinate between your patch that must go in 5.13 and in stable, and those two patches ? Shouldn't your patch go first and those other patches be rebased on top ?

Right, will rebase this patch on v5.13-rc2 directly without those two
patches. Hence this can be merged in v5.13 and backported to stable
if required.
