Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6FD34A28D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 08:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbhCZHd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 03:33:59 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14149 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbhCZHdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 03:33:24 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F6DCt1LM0znWrS;
        Fri, 26 Mar 2021 15:30:50 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by smtp.huawei.com
 (10.3.19.214) with Microsoft SMTP Server (TLS) id 14.3.498.0; Fri, 26 Mar
 2021 15:33:22 +0800
Subject: Re: [PATCH v2] f2fs: fix to avoid touching checkpointed data in
 get_victim()
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>
References: <20210324031828.67133-1-yuchao0@huawei.com>
 <YFvQGxLbpmDjxEzR@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <2dfb085b-80ce-050b-5650-986675a07488@huawei.com>
Date:   Fri, 26 Mar 2021 15:33:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <YFvQGxLbpmDjxEzR@google.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.110.154]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/3/25 7:49, Jaegeuk Kim wrote:
> On 03/24, Chao Yu wrote:
>> In CP disabling mode, there are two issues when using LFS or SSR | AT_SSR
>> mode to select victim:
>>
>> 1. LFS is set to find source section during GC, the victim should have
>> no checkpointed data, since after GC, section could not be set free for
>> reuse.
>>
>> Previously, we only check valid chpt blocks in current segment rather
>> than section, fix it.
>>
>> 2. SSR | AT_SSR are set to find target segment for writes which can be
>> fully filled by checkpointed and newly written blocks, we should never
>> select such segment, otherwise it can cause panic or data corruption
>> during allocation, potential case is described as below:
>>
>>   a) target segment has 128 ckpt valid blocks
>>   b) GC migrates 'n' (n < 512) valid blocks to other segment (segment is
>>      still in dirty list)

I missed to change 128 to n, so comments should be updated as below:

   a) target segment has 'n' (n < 512) ckpt valid blocks
   b) GC migrates 'n' valid blocks to other segment (segment is still
      in dirty list)

Thanks,

>>   c) GC migrates '512 - n' blocks to target segment (segment has 'n'
>>      cp_vblocks and '512 - n' vblocks)
>>   d) If GC selects target segment via {AT,}SSR allocator, however there
>>      is no free space in targe segment.
