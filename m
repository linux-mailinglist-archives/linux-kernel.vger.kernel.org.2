Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 772303E1A2F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 19:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238691AbhHERPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 13:15:14 -0400
Received: from foss.arm.com ([217.140.110.172]:50784 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232651AbhHERPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 13:15:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C1D4D1042;
        Thu,  5 Aug 2021 10:14:58 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8EEA13F66F;
        Thu,  5 Aug 2021 10:14:57 -0700 (PDT)
Subject: Re: [PATCH] iommu/arm-smmu-v3: Remove some unneeded init in
 arm_smmu_cmdq_issue_cmdlist()
To:     John Garry <john.garry@huawei.com>, will@kernel.org
Cc:     joro@8bytes.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com
References: <1624293394-202509-1-git-send-email-john.garry@huawei.com>
 <ee1f3ab5-3acc-f442-f2d2-898cf88bc447@arm.com>
 <45a8af4f-4202-ecd8-0882-507acf9b2eb2@huawei.com>
 <577a625a-4fc5-7402-8e4f-4e0e5be93144@arm.com>
 <44c5e07b-e663-5b96-a142-ec25666e2a14@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <2af4315a-c02a-2185-93a2-b07a891314a6@arm.com>
Date:   Thu, 5 Aug 2021 18:14:52 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <44c5e07b-e663-5b96-a142-ec25666e2a14@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-05 16:16, John Garry wrote:
> On 05/08/2021 15:41, Robin Murphy wrote:
>>> I suppose they could be combined into a smaller sub-struct and loaded 
>>> in a single operation, but it looks messy, and prob without much gain.
>>
>> Indeed I wouldn't say that saving memory is the primary concern here, 
>> and any more convoluted code is hardly going to help performance. Plus 
>> it still wouldn't help the other cases where we're just copying the 
>> size into a fake queue to do some prod arithmetic - I hadn't fully 
>> clocked what was going on there when I skimmed through things earlier.
>>
>> Disregarding the bogus layout change, though, do you reckon the rest 
>> of my idea makes sense?
> 
> I tried the similar change to avoid zero-init the padding in 
> arm_smmu_cmdq_write_entries() and the 
> _arm_smmu_cmdq_poll_set_valid_map(), but the disassembly was the same. 
> So the compiler must have got smart there.

Yeah, in my build __arm_smmu_cmdq_poll_set_valid_map() only uses 32 
bytes of stack, so clearly it's managed to see through the macro magic 
once queue_inc_prod_n() is inlined and elide the whole struct. 
arm_smmu_cmdq_write_entries() is inlined already, but logically must be 
the same deal since it's a similarly inlined queue_inc_prod_n().

However, that may all change if different compiler flags or a different 
compiler lead to different inlining decisions, so I'd argue that if this 
can matter anywhere then it's worth treating consistently everywhere.

> But for the original change in this patch, it did make a difference. 
> It's nice to remove what was a memcpy:
> 
>      1770: a9077eff stp xzr, xzr, [x23, #112]
> }, head = llq;
>      1774: 94000000 bl 0 <memcpy>
> 
> And performance was very fractionally better.

Heh, mine was this beauty:

         struct arm_smmu_ll_queue llq = {
     17d4:       a9017f7f        stp     xzr, xzr, [x27, #16]
     17d8:       a9027f7f        stp     xzr, xzr, [x27, #32]
     17dc:       a9037f7f        stp     xzr, xzr, [x27, #48]
     17e0:       a9047f7f        stp     xzr, xzr, [x27, #64]
         }, head = llq;
     17e4:       b900c340        str     w0, [x26, #192]
{
     17e8:       290d0be1        stp     w1, w2, [sp, #104]
         }, head = llq;
     17ec:       a9440f62        ldp     x2, x3, [x27, #64]
     17f0:       a9007f5f        stp     xzr, xzr, [x26]
     17f4:       a9017f5f        stp     xzr, xzr, [x26, #16]
     17f8:       a9027f5f        stp     xzr, xzr, [x26, #32]
     17fc:       a9037f5f        stp     xzr, xzr, [x26, #48]
     1800:       a9040f42        stp     x2, x3, [x26, #64]
         struct arm_smmu_ll_queue llq = {
     1804:       a9057f7f        stp     xzr, xzr, [x27, #80]
         }, head = llq;
     1808:       a9057f5f        stp     xzr, xzr, [x26, #80]
         struct arm_smmu_ll_queue llq = {
     180c:       a9067f7f        stp     xzr, xzr, [x27, #96]
         }, head = llq;
     1810:       a9067f5f        stp     xzr, xzr, [x26, #96]
         struct arm_smmu_ll_queue llq = {
     1814:       a9077f7f        stp     xzr, xzr, [x27, #112]
         }, head = llq;
     1818:       a9077f5f        stp     xzr, xzr, [x26, #112]
         struct arm_smmu_ll_queue llq = {
     181c:       a9087f5f        stp     xzr, xzr, [x26, #128]

> As for pre-evaluating "nents", I'm not sure how much that can help, but 
> I am not too optimistic. I can try some testing when I get a chance. 
> Having said that, I would need to check the disassembly also.

It'll just turn MOV,LDR,LSL sequences into plain LDRs - a small saving 
but with no real downside, and a third of it is in the place where doing 
less work matters most:

add/remove: 0/0 grow/shrink: 0/8 up/down: 0/-100 (-100)
Function                                     old     new   delta
arm_smmu_priq_thread                         532     528      -4
arm_smmu_evtq_thread                         368     364      -4
arm_smmu_device_probe                       4564    4556      -8
__arm_smmu_cmdq_poll_set_valid_map.isra      316     308      -8
arm_smmu_init_one_queue.isra                 320     308     -12
queue_remove_raw                             192     176     -16
arm_smmu_gerror_handler                      752     736     -16
arm_smmu_cmdq_issue_cmdlist                 1812    1780     -32
Total: Before=23776, After=23676, chg -0.42%


Robin.
