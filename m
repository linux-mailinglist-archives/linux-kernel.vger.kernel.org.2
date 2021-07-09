Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6E143C2301
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 13:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbhGILmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 07:42:19 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:14061 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbhGILmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 07:42:18 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GLrhg2mcBzbbls;
        Fri,  9 Jul 2021 19:36:19 +0800 (CST)
Received: from dggema774-chm.china.huawei.com (10.1.198.216) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 9 Jul 2021 19:39:31 +0800
Received: from [10.67.102.197] (10.67.102.197) by
 dggema774-chm.china.huawei.com (10.1.198.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 9 Jul 2021 19:39:30 +0800
Subject: Re: [PATCH 4.4.y] arm: kprobes: Allow to handle reentered kprobe on
 single-stepping
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Shaobo Huang <huangshaobo6@huawei.com>
CC:     <gregkh@linuxfoundation.org>, <chenzefeng2@huawei.com>,
        <kepler.chenxin@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux@arm.linux.org.uk>,
        <liucheng32@huawei.com>, <tixy@linaro.org>, <xiaoqian9@huawei.com>,
        <young.liuyang@huawei.com>, <zengweilin@huawei.com>
References: <YOcOcNBRou5KlbOR@kroah.com>
 <20210709024630.22268-1-huangshaobo6@huawei.com>
 <20210709180031.adc7260b54645b0292a6f02a@kernel.org>
From:   Xiaoming Ni <nixiaoming@huawei.com>
Message-ID: <9ca81fb8-8d6e-1708-db01-a29e54c79343@huawei.com>
Date:   Fri, 9 Jul 2021 19:39:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0.1
MIME-Version: 1.0
In-Reply-To: <20210709180031.adc7260b54645b0292a6f02a@kernel.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.197]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggema774-chm.china.huawei.com (10.1.198.216)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/7/9 17:00, Masami Hiramatsu wrote:
> Hi Shaobo,
> 
> Thanks for backporting!
> Greg, it seems this patch can be applied to 4.9 too without any issue.
> 
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-4.9.y&id=355a04fa1fc23c4fb1d16440e62d46a42691e96b

The v4.9 branch has been fixed.

Thanks
Xiaoming Ni



> Thank you,
> 
> On Fri, 9 Jul 2021 10:46:30 +0800
> Shaobo Huang <huangshaobo6@huawei.com> wrote:
> 
>> From: Masami Hiramatsu <mhiramat@kernel.org>
>>
>> commit f3fbd7ec62dec1528fb8044034e2885f2b257941 upstream
>>
>> This is arm port of commit 6a5022a56ac3 ("kprobes/x86: Allow to
>> handle reentered kprobe on single-stepping")
>>
>> Since the FIQ handlers can interrupt in the single stepping
>> (or preparing the single stepping, do_debug etc.), we should
>> consider a kprobe is hit in the NMI handler. Even in that
>> case, the kprobe is allowed to be reentered as same as the
>> kprobes hit in kprobe handlers
>> (KPROBE_HIT_ACTIVE or KPROBE_HIT_SSDONE).
>>
>> The real issue will happen when a kprobe hit while another
>> reentered kprobe is processing (KPROBE_REENTER), because
>> we already consumed a saved-area for the previous kprobe.
>>
>> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
>> Signed-off-by: Jon Medhurst <tixy@linaro.org>
>> Fixes: 24ba613c9d6c ("ARM kprobes: core code")
>> Cc: stable@vger.kernel.org #v2.6.25~v4.11
>> Signed-off-by: huangshaobo <huangshaobo6@huawei.com>
>> ---
>>   arch/arm/probes/kprobes/core.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/arch/arm/probes/kprobes/core.c b/arch/arm/probes/kprobes/core.c
>> index 3eb018fa1a1f..c3362ddd6c4c 100644
>> --- a/arch/arm/probes/kprobes/core.c
>> +++ b/arch/arm/probes/kprobes/core.c
>> @@ -270,6 +270,7 @@ void __kprobes kprobe_handler(struct pt_regs *regs)
>>   			switch (kcb->kprobe_status) {
>>   			case KPROBE_HIT_ACTIVE:
>>   			case KPROBE_HIT_SSDONE:
>> +			case KPROBE_HIT_SS:
>>   				/* A pre- or post-handler probe got us here. */
>>   				kprobes_inc_nmissed_count(p);
>>   				save_previous_kprobe(kcb);
>> @@ -278,6 +279,11 @@ void __kprobes kprobe_handler(struct pt_regs *regs)
>>   				singlestep(p, regs, kcb);
>>   				restore_previous_kprobe(kcb);
>>   				break;
>> +			case KPROBE_REENTER:
>> +				/* A nested probe was hit in FIQ, it is a BUG */
>> +				pr_warn("Unrecoverable kprobe detected at %p.\n",
>> +					p->addr);
>> +				/* fall through */
>>   			default:
>>   				/* impossible cases */
>>   				BUG();
>> -- 
>> 2.12.3
>>
> 
> 

