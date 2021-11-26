Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D88C45EBAE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 11:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376973AbhKZKgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 05:36:23 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:28176 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345920AbhKZKeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 05:34:22 -0500
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4J0rZf59Kkz8vfM;
        Fri, 26 Nov 2021 18:29:14 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 26 Nov 2021 18:31:07 +0800
Received: from [10.67.102.185] (10.67.102.185) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 26 Nov 2021 18:31:06 +0800
Subject: Re: [PATCH v4 2/2] arm64: kprobe: Enable OPTPROBE for arm64
To:     Mark Rutland <mark.rutland@arm.com>, <mhiramat@kernel.org>
CC:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <naveen.n.rao@linux.ibm.com>, <anil.s.keshavamurthy@intel.com>,
        <davem@davemloft.net>, <mhiramat@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <song.bao.hua@hisilicon.com>, <prime.zeng@hisilicon.com>,
        <robin.murphy@arm.com>, <f.fangjian@huawei.com>,
        <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>
References: <20210818073336.59678-1-liuqi115@huawei.com>
 <20210818073336.59678-3-liuqi115@huawei.com>
 <20210824105001.GA96738@C02TD0UTHF1T.local>
From:   "liuqi (BA)" <liuqi115@huawei.com>
Message-ID: <aebcfbcb-eded-ff48-9d1f-2a93539575ca@huawei.com>
Date:   Fri, 26 Nov 2021 18:31:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20210824105001.GA96738@C02TD0UTHF1T.local>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.185]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/8/24 18:50, Mark Rutland wrote:
>> diff --git a/arch/arm64/kernel/probes/optprobe_trampoline.S b/arch/arm64/kernel/probes/optprobe_trampoline.S
>> new file mode 100644
>> index 000000000000..24d713d400cd
>> --- /dev/null
>> +++ b/arch/arm64/kernel/probes/optprobe_trampoline.S
>> @@ -0,0 +1,37 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * trampoline entry and return code for optprobes.
>> + */
>> +
>> +#include <linux/linkage.h>
>> +#include <asm/asm-offsets.h>
>> +#include <asm/assembler.h>
>> +
>> +	.global optprobe_template_entry
>> +optprobe_template_entry:
> Please use SYM_*(); see arch/arm64/kernel/entry-ftrace.S for examples of
> how to use that for trampolines.
> 
> This should be:
> 
> SYM_CODE_START(optprobe_template)
> 
Hi all,

I meet a problem when I use SYM_CODE_START(optprobe_template) to replace 
optprobe_template_entry.

If SYM_CODE_START is used, all optprobe will share one trampoline space. 
Under this circumstances, if user register two optprobes, trampoline 
will be overwritten by the newer one, and this will cause kernel panic 
when the old optprobe is trigger.

Using optprobe_template_entry will not have this problem, as each 
optprobe has its own trampoline space (alloced in get_opinsn_slot()).

So how to reuse SYM_CODE_START  in this situation, does anyone has a 
good idea?

Thanks,
Qi
> ... and note the matching end below.
> 
>> +	sub sp, sp, #PT_REGS_SIZE
>> +	save_all_base_regs
>> +	/* Get parameters to optimized_callback() */
>> +	ldr	x0, 1f
>> +	mov	x1, sp
>> +	/* Branch to optimized_callback() */
>> +	.global optprobe_template_call
>> +optprobe_template_call:
> SYM_INNER_LABEL(optprobe_template_call, SYM_L_GLOBAL)
> 
> ...and likewise for all the other labels.
> 
>> +	nop
>> +	restore_all_base_regs
>> +	ldr lr, [sp, #S_LR]
>> +        add sp, sp, #PT_REGS_SIZE
>> +	.global optprobe_template_restore_orig_insn
>> +optprobe_template_restore_orig_insn:
>> +	nop
>> +	.global optprobe_template_restore_end
>> +optprobe_template_restore_end:
>> +	nop
>> +	.global optprobe_template_end
>> +optprobe_template_end:
>> +	.global optprobe_template_val
>> +optprobe_template_val:
>> +	1:	.long 0
>> +		.long 0
>> +	.global optprobe_template_max_length
>> +optprobe_template_max_length:
> SYM_INNER_LABEL(optprobe_template_end, SYM_L_GLOBAL)
> SYM_CODE_END(optprobe_template)
> 
> Thanks,
> Mark.
> 
>> -- 
