Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B35E83E409C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 09:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233159AbhHIHAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 03:00:46 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:8383 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233069AbhHIHAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 03:00:44 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Gjn1Q5PhZz85Vp;
        Mon,  9 Aug 2021 14:56:26 +0800 (CST)
Received: from dggema757-chm.china.huawei.com (10.1.198.199) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 9 Aug 2021 15:00:19 +0800
Received: from [127.0.0.1] (10.69.38.203) by dggema757-chm.china.huawei.com
 (10.1.198.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 9 Aug
 2021 15:00:19 +0800
Subject: Re: [PATCH v2] arm64: kprobe: Enable OPTPROBE for arm64
To:     Amit Kachhap <amit.kachhap@arm.com>,
        Linuxarm <linuxarm@huawei.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <naveen.n.rao@linux.ibm.com>,
        <anil.s.keshavamurthy@intel.com>, <davem@davemloft.net>,
        <mhiramat@kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC:     <song.bao.hua@hisilicon.com>, <prime.zeng@hisilicon.com>,
        <robin.murphy@arm.com>, <f.fangjian@huawei.com>,
        <linux-kernel@vger.kernel.org>
References: <20210804060209.95817-1-liuqi115@huawei.com>
 <2fd3c78f-741a-4693-acae-4ea5465ad798@arm.com>
From:   "liuqi (BA)" <liuqi115@huawei.com>
Message-ID: <c2aa748e-14a9-1e5f-c4f2-5f6e1c140f5e@huawei.com>
Date:   Mon, 9 Aug 2021 15:00:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <2fd3c78f-741a-4693-acae-4ea5465ad798@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.69.38.203]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggema757-chm.china.huawei.com (10.1.198.199)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Amit,
On 2021/8/9 12:15, Amit Kachhap wrote:
> Hi Liu,
> 
> I am few minor comments.
> 
> On 8/4/21 11:32 AM, Qi Liu wrote:
>> This patch introduce optprobe for ARM64. In optprobe, probed
>> instruction is replaced by a branch instruction to detour
>> buffer. Detour buffer contains trampoline code and a call to
>> optimized_callback(). optimized_callback() calls opt_pre_handler()
>> to execute kprobe handler.
>>
>> Limitations:
>> - We only support !CONFIG_RANDOMIZE_MODULE_REGION_FULL case to
>> guarantee the offset between probe point and kprobe pre_handler
>> is not larger than 128MiB.
>>
>> Performance of optprobe on Hip08 platform is test using kprobe
>> example module[1] to analyze the latency of a kernel function,
>> and here is the result:
>>
>> [1] 
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/samples/kprobes/kretprobe_example.c 
>>
> 
>> +     *
>> +     * kprobe opt use a 'b' instruction to branch to optinsn.insn.
>> +     * According to ARM manual, branch instruction is:
>> +     *
>> +     *   31  30                  25              0
>> +     *  +----+---+---+---+---+---+---------------+
>> +     *  |cond| 0 | 0 | 1 | 0 | 1 |     imm26     |
>> +     *  +----+---+---+---+---+---+---------------+
>> +     *
>> +     * imm26 is a signed 26 bits integer. The real branch offset is 
>> computed
>> +     * by: imm64 = SignExtend(imm26:'00', 64);
>> +     *
>> +     * So the maximum forward branch should be:
>> +     *   (0x01ffffff << 2) = 1720x07fffffc =  0x07fffffc
> 
> 7120x07fffffc ? Shouldn't it be just 0x07fffffc.
> 

Emmm yes, 7120x07fffffc can be dropped, thanks.
>> +     * The maximum backward branch should be:
>> +     *   (0xfe000000 << 2) = 0xFFFFFFFFF8000000 = -0x08000000
>> +     *
>> +     * We can simply check (rel & 0xf8000003):
>> +     *  if rel is positive, (rel & 0xf8000003) should be 0
>> +     *  if rel is negitive, (rel & 0xf8000003) should be 0xf8000000
>> +     *  the last '3' is used for alignment checking.
>> +     */
>> +    return (offset >= -0x08000000 && offset <= 0x07fffffc && !(offset 
>> & 0x3));
>> +}
>> +
>> +int arch_prepare_optimized_kprobe(struct optimized_kprobe *op, struct 
>> kprobe *orig)
>> +{
>> +    kprobe_opcode_t *code;
>> +    u32 insn;
>> +    int ret, i;
>> +    void *addrs[TMPL_END_IDX];
>> +    void *addr;
>> +
>> +    code = get_optinsn_slot();
>> +    if (!code)
>> +        return -ENOMEM;
>> +
>> +    if (!is_offset_in_range((unsigned long)code,
>> +                (unsigned long)orig->addr + 8))
>> +        goto error;
>> +
>> +    if (!is_offset_in_range((unsigned long)code + TMPL_CALL_BACK,
>> +                (unsigned long)optimized_callback))
>> +        goto error;
>> +
>> +    if (!is_offset_in_range((unsigned long)&code[TMPL_RESTORE_END],
>> +                (unsigned long)op->kp.addr + 4))
>> +        goto error;
>> +
>> +    /* Setup template */
>> +    for (i = 0; i < TMPL_END_IDX; i++)
>> +        addrs[i] = code + i;
>> +
>> +    ret = aarch64_insn_patch_text(addrs, optprobe_template_entry,
>> +                      TMPL_END_IDX);
> 
> Here it copies nops for restore_orig_insn, restore_orig_insn and
> again overwrites them with new values below.
> 

Yes, as Masami said, I could prepare another writable buffer and build 
the trampoline code on it, like x86 optprobe. thanks.

>> +    if (ret < 0)
>> +        goto error;
>> +
[...]
>> +    mrs x1, CurrentEL
>> +    orr x0, x0, x1
>> +    mrs x1, SPSel
>> +    orr x0, x0, x1
>> +    stp xzr, x0, [sp, #S_PC]
>> +    /* Get parameters to optimized_callback() */
>> +    ldr    x0, 1f
>> +    mov    x1, sp
> 
> Most of the codes here are same as save_all_base_regs macro in file
> arch/arm64/kernel/probes/kprobes_trampoline.S. May be they
> can be made common macros and kept in asm/assembler.h
> 
Sounds reasonable, will fix this next time.

Thanks,
Qi
>> +    /* Branch to optimized_callback() */
>> +    .global optprobe_template_call
>> +optprobe_template_call:
>> +    nop
>> +        /* Restore registers */
>> +    ldr x0, [sp, #S_PSTATE]
>> +    and x0, x0, #(PSR_N_BIT | PSR_Z_BIT | PSR_C_BIT | PSR_V_BIT)
>> +    msr nzcv, x0
>> +    ldp x0, x1, [sp, #S_X0]
>> +    ldp x2, x3, [sp, #S_X2]
>> +    ldp x4, x5, [sp, #S_X4]
>> +    ldp x6, x7, [sp, #S_X6]
>> +    ldp x8, x9, [sp, #S_X8]
>> +    ldp x10, x11, [sp, #S_X10]
>> +    ldp x12, x13, [sp, #S_X12]
>> +    ldp x14, x15, [sp, #S_X14]
>> +    ldp x16, x17, [sp, #S_X16]
>> +    ldp x18, x19, [sp, #S_X18]
>> +    ldp x20, x21, [sp, #S_X20]
>> +    ldp x22, x23, [sp, #S_X22]
>> +    ldp x24, x25, [sp, #S_X24]
>> +    ldp x26, x27, [sp, #S_X26]
>> +    ldp x28, x29, [sp, #S_X28]
>> +    ldr lr, [sp, #S_LR]
>> +        add sp, sp, #PT_REGS_SIZE
> 
> Same as previous comment.
> 
> BR.
> //Amit
> 
>> +    .global optprobe_template_restore_orig_insn
>> +optprobe_template_restore_orig_insn:
>> +    nop
>> +    .global optprobe_template_restore_end
>> +optprobe_template_restore_end:
>> +    nop
>> +    .global optprobe_template_end
>> +optprobe_template_end:
>> +    .global optprobe_template_val
>> +optprobe_template_val:
>> +    1:    .long 0
>> +        .long 0
>>
> .

