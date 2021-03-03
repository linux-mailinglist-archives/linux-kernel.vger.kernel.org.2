Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F237A32B77B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 12:12:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357601AbhCCLLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 06:11:04 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:13111 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240148AbhCCBZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 20:25:59 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Dqx8h5ljDz16FRB;
        Wed,  3 Mar 2021 09:23:32 +0800 (CST)
Received: from [10.67.110.237] (10.67.110.237) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Wed, 3 Mar 2021 09:25:05 +0800
Subject: Re: [PATCH] recordmcount: Fix the wrong use of w* in
 arm64_is_fake_mcount()
To:     Steven Rostedt <rostedt@goodmis.org>
References: <20210225140747.10818-1-lihuafei1@huawei.com>
 <20210225094426.7729b9cc@gandalf.local.home>
 <20210225160116.GA13604@willie-the-truck>
 <20210302173058.28fd3d36@gandalf.local.home>
From:   Li Huafei <lihuafei1@huawei.com>
CC:     <will@kernel.org>, <gregory.herrero@oracle.com>,
        <catalin.marinas@arm.com>, <christophe.leroy@csgroup.eu>,
        <linux-kernel@vger.kernel.org>,
        Zhangjinhao <zhangjinhao2@huawei.com>, <yangjihong1@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>, <chenjun102@huawei.com>
Message-ID: <54eb164c-695d-57c5-6bcd-51483b7998d3@huawei.com>
Date:   Wed, 3 Mar 2021 09:25:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210302173058.28fd3d36@gandalf.local.home>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.237]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/3/3 6:30, Steven Rostedt wrote:
> On Thu, 25 Feb 2021 16:01:17 +0000
> Will Deacon <will@kernel.org> wrote:
> 
>> On Thu, Feb 25, 2021 at 09:44:26AM -0500, Steven Rostedt wrote:
>>> This requires an acked-by from one of the ARM64 maintainers.
>>>
>>> -- Steve
>>>
>>>
>>> On Thu, 25 Feb 2021 22:07:47 +0800
>>> Li Huafei <lihuafei1@huawei.com> wrote:
>>>    
>>>> When cross-compiling the kernel, the endian of the target machine and
>>>> the local machine may not match, at this time the recordmcount tool
>>>> needs byte reversal when processing elf's variables to get the correct
>>>> value. w* callback function is used to solve this problem, w is used for
>>>> 4-byte variable processing, while w8 is used for 8-byte.
>>>>
>>>> arm64_is_fake_mcount() is used to filter '_mcount' relocations that are
>>>> not used by ftrace. In arm64_is_fake_mcount(), rp->info is 8 bytes in
>>>> size, but w is used. This causes arm64_is_fake_mcount() to get the wrong
>>>> type of relocation when we cross-compile the arm64_be kernel image on an
>>>> x86_le machine, and all valid '_mcount' is filtered out. The
>>>> recordmcount tool does not collect any mcount function call locations.
>>>> At kernel startup, the following ftrace log is seen:
>>>>
>>>> 	ftrace: No functions to be traced?
>>>>
>>>> and thus ftrace cannot be used.
>>>>
>>>> Using w8 to get the value of rp->r_info will fix the problem.
>>>>
>>>> Fixes: ea0eada45632 ("recordmcount: only record relocation of type
>>>> R_AARCH64_CALL26 on arm64")
>>>> Signed-off-by: Li Huafei <lihuafei1@huawei.com>
>>>> ---
>>>>   scripts/recordmcount.c | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/scripts/recordmcount.c b/scripts/recordmcount.c
>>>> index b9c2ee7ab43f..cce12e1971d8 100644
>>>> --- a/scripts/recordmcount.c
>>>> +++ b/scripts/recordmcount.c
>>>> @@ -438,7 +438,7 @@ static int arm_is_fake_mcount(Elf32_Rel const *rp)
>>>>   
>>>>   static int arm64_is_fake_mcount(Elf64_Rel const *rp)
>>>>   {
>>>> -	return ELF64_R_TYPE(w(rp->r_info)) != R_AARCH64_CALL26;
>>>> +	return ELF64_R_TYPE(w8(rp->r_info)) != R_AARCH64_CALL26;
>>
>> Acked-by: Will Deacon <will@kernel.org>
>>
>> But you know you could avoid these sorts of problems by moving to little
>> endian along with everybody else? ;)
>>
> 
> I just realized that I received this patch twice, and thought it was the
> same patch! Chen was three days ahead of you, so he get's the credit ;-)
> 
>   https://lore.kernel.org/r/20210222135840.56250-1-chenjun102@huawei.com
> 
> -- Steve
> .
> 

That's fine, thanks Steve and Will!

Huafei
