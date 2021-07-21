Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB1F3D0D09
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 13:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238789AbhGUK1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 06:27:52 -0400
Received: from foss.arm.com ([217.140.110.172]:51724 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238935AbhGUKSs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 06:18:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DAA7631B;
        Wed, 21 Jul 2021 03:58:46 -0700 (PDT)
Received: from [10.163.64.235] (unknown [10.163.64.235])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3935E3F99C;
        Wed, 21 Jul 2021 03:58:42 -0700 (PDT)
Subject: Re: [PATCH v3 01/12] mm/debug_vm_pgtable: Introduce struct
 pgtable_debug_args
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     Gavin Shan <gshan@redhat.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        will@kernel.org, akpm@linux-foundation.org, chuhu@redhat.com,
        shan.gavin@gmail.com,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Qian Cai <cai@lca.pw>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
References: <20210719130613.334901-1-gshan@redhat.com>
 <20210719130613.334901-2-gshan@redhat.com>
 <ab0f9daa-0c49-e74c-e073-6e03a3cabb07@arm.com>
 <280a5740-b5dc-4b78-3a38-67e5adbb0afd@redhat.com>
 <e579e969-e344-8678-ca56-f933000fa7c1@arm.com>
Message-ID: <23bb5363-fd36-5161-0ba2-da1efc3e3018@arm.com>
Date:   Wed, 21 Jul 2021 16:29:33 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e579e969-e344-8678-ca56-f933000fa7c1@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/21/21 4:09 PM, Anshuman Khandual wrote:
> 
> On 7/21/21 3:50 PM, Gavin Shan wrote:
>> Hi Anshuman,
>>
>> On 7/21/21 3:44 PM, Anshuman Khandual wrote:
>>> On 7/19/21 6:36 PM, Gavin Shan wrote:
>>>> In debug_vm_pgtable(), there are many local variables introduced to
>>>> track the needed information and they are passed to the functions for
>>>> various test cases. It'd better to introduce a struct as place holder
>>>> for these information. With it, what the functions for various test
>>>> cases need is the struct, to simplify the code. It also makes code
>>>> easier to be maintained.
>>>>
>>>> Besides, set_xxx_at() could access the data on the corresponding pages
>>>> in the page table modifying tests. So the accessed pages in the tests
>>>> should have been allocated from buddy. Otherwise, we're accessing pages
>>>> that aren't owned by us. This causes issues like page flag corruption.
>>>>
>>>> This introduces "struct pgtable_debug_args". The struct is initialized
>>>> and destroyed, but the information in the struct isn't used yet. They
>>>> will be used in subsequent patches.
>>>>
>>>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>>>> ---
>>>>   mm/debug_vm_pgtable.c | 197 +++++++++++++++++++++++++++++++++++++++++-
>>>>   1 file changed, 196 insertions(+), 1 deletion(-)
>>>>
>> I saw you've finished the review on PATCH[v3 01/12] and PATCH[v3 02/12].
>> I will wait to integrate your comments to v4 until you finish the review
>> on all patches in v3 series
> Yes, please do wait for the complete review and test before going for V4.
> Also please add the following emails on copy next time, so that we might
> have some more reviews here. Thank you.
> 
> + Christophe Leroy <christophe.leroy@csgroup.eu>
> + Gerald Schaefer <gerald.schaefer@de.ibm.com>

This one instead.

Gerald Schaefer <gerald.schaefer@linux.ibm.com>
