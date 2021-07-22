Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFB33D21F7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 12:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbhGVJfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 05:35:03 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:15047 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbhGVJfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 05:35:02 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GVpCW24KrzZr90;
        Thu, 22 Jul 2021 18:12:07 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 22 Jul 2021 18:15:30 +0800
Received: from [10.67.100.236] (10.67.100.236) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 22 Jul 2021 18:15:30 +0800
Subject: ping//Re: ping//Re: [PATCH -next 2/2] riscv: implemented branch
 simulate instructions
From:   chenlifu <chenlifu@huawei.com>
To:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <guoren@linux.alibaba.com>,
        <penberg@kernel.org>, <mhiramat@kernel.org>, <me@packi.ch>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20210629023455.280998-1-chenlifu@huawei.com>
 <20210629023455.280998-2-chenlifu@huawei.com>
 <0f080eb4-0b24-ef52-518c-26cb0889c008@huawei.com>
Message-ID: <8fd372bf-f904-ad2c-d471-7a806b6ed5d3@huawei.com>
Date:   Thu, 22 Jul 2021 18:15:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <0f080eb4-0b24-ef52-518c-26cb0889c008@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.100.236]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2021/7/5 10:09, chenlifu 写道:
> 
> 
> 在 2021/6/29 10:34, Chen Lifu 写道:
>> To test the kprobe-based event tracing, we prepare
>> a kernel module 'kprobe_test.ko' to add the probes.
>> The assembly codes (partially) of the module are as follows:
>> ...
>> 0000000000000000 <kprobe_test_branch>:
>> ...
>>
>> 0000000000000080 <.L7>:
>>    80:    414986bb              subw    a3,s3,s4
>>    84:    4785                    li    a5,1
>>    86:    00d7c363              blt    a5,a3,8c <.L8>
>>    8a:    2485                    addiw    s1,s1,1
>>
>> 000000000000008c <.L8>:
>>    8c:    012987bb              addw    a5,s3,s2
>>    90:    4711                    li    a4,4
>>    92:    00f75363              bge    a4,a5,98 <.L9>
>>    96:    2485                    addiw    s1,s1,1
>> ...
>>
>> 00000000000000aa <.L11>:
>>    aa:    01299363              bne    s3,s2,b0 <.L12>
>>    ae:    2485                    addiw    s1,s1,1
>>
>> 00000000000000b0 <.L12>:
>>    b0:    012a0363              beq    s4,s2,b6 <.L13>
>>    b4:    2485                    addiw    s1,s1,1
>> ...
>>
>> 00000000000000c2 <.L14>:
>>    c2:    0009861b              sext.w    a2,s3
>>    c6:    013a7363              bgeu    s4,s3,cc <.L15>
>>    ca:    2485                    addiw    s1,s1,1
>> ...
>>
>> 00000000000000d2 <.L16>:
>>    d2:    00e7e363              bltu    a5,a4,d8 <.L17>
>>    d6:    2485                    addiw    s1,s1,1
>> ...
>>
>> Test the kprobe-based event tracing in qemu-system-riscv64:
>> First, install the kprobe test module:
>> insmod /root/kprobe_test.ko
>>
>> Then, add probes as new events at the branch instructions,
>> i.e. blt, bge, bne, beq, bgeu and bltu.
>> The following errors occur due to the instructions not allowed to 
>> probe yet:
>> echo "p:blt kprobe_test:kprobe_test_branch+0x86 epc=%epc 
>> opcode=+0(%epc):x32" >> /sys/kernel/debug/tracing/kprobe_events
>> sh: write error: Invalid argument
>> echo "p:bge kprobe_test:kprobe_test_branch+0x92 epc=%epc 
>> opcode=+0(%epc):x32" >> /sys/kernel/debug/tracing/kprobe_events
>> sh: write error: Invalid argument
>> echo "p:bne kprobe_test:kprobe_test_branch+0xaa epc=%epc 
>> opcode=+0(%epc):x32" >> /sys/kernel/debug/tracing/kprobe_events
>> sh: write error: Invalid argument
>> echo "p:beq kprobe_test:kprobe_test_branch+0xb0 epc=%epc 
>> opcode=+0(%epc):x32" >> /sys/kernel/debug/tracing/kprobe_events
>> sh: write error: Invalid argument
>> echo "p:bgeu kprobe_test:kprobe_test_branch+0xc6 epc=%epc 
>> opcode=+0(%epc):x32" >> /sys/kernel/debug/tracing/kprobe_events
>> sh: write error: Invalid argument
>> echo "p:bltu kprobe_test:kprobe_test_branch+0xd2 epc=%epc 
>> opcode=+0(%epc):x32" >> /sys/kernel/debug/tracing/kprobe_events
>> sh: write error: Invalid argument
>>
>> This patch implemented the branch simulate instructions and allowed to 
>> probe them.
>> Merge this patch and perform the test again, the test results are as 
>> follows:
>> First, add probes at the branch instructions:
>> echo "p:blt kprobe_test:kprobe_test_branch+0x86 epc=%epc 
>> opcode=+0(%epc):x32" >> /sys/kernel/debug/tracing/kprobe_events
>> echo "p:bge kprobe_test:kprobe_test_branch+0x92 epc=%epc 
>> opcode=+0(%epc):x32" >> /sys/kernel/debug/tracing/kprobe_events
>> echo "p:bne kprobe_test:kprobe_test_branch+0xaa epc=%epc 
>> opcode=+0(%epc):x32" >> /sys/kernel/debug/tracing/kprobe_events
>> echo "p:beq kprobe_test:kprobe_test_branch+0xb0 epc=%epc 
>> opcode=+0(%epc):x32" >> /sys/kernel/debug/tracing/kprobe_events
>> echo "p:bgeu kprobe_test:kprobe_test_branch+0xc6 epc=%epc 
>> opcode=+0(%epc):x32" >> /sys/kernel/debug/tracing/kprobe_events
>> echo "p:bltu kprobe_test:kprobe_test_branch+0xd2 epc=%epc 
>> opcode=+0(%epc):x32" >> /sys/kernel/debug/tracing/kprobe_events
>> echo 1 > /sys/kernel/debug/tracing/events/kprobes/blt/enable
>> echo 1 > /sys/kernel/debug/tracing/events/kprobes/bge/enable
>> echo 1 > /sys/kernel/debug/tracing/events/kprobes/bne/enable
>> echo 1 > /sys/kernel/debug/tracing/events/kprobes/beq/enable
>> echo 1 > /sys/kernel/debug/tracing/events/kprobes/bgeu/enable
>> echo 1 > /sys/kernel/debug/tracing/events/kprobes/bltu/enable
>>
>> Then, do something to run to the probes.
>> After that, see the traced information:
>> cat /sys/kernel/debug/tracing/trace
>> sysctl-63      [001] d...  2505.263969: blt: 
>> (kprobe_test_branch+0x86/0x10e [kprobe_test]) epc=0xffffffff016122f8 
>> opcode=0x100073
>> sysctl-63      [001] d...  2505.263991: bge: 
>> (kprobe_test_branch+0x92/0x10e [kprobe_test]) epc=0xffffffff01612304 
>> opcode=0x100073
>> sysctl-63      [001] d...  2505.264001: bne: 
>> (kprobe_test_branch+0xaa/0x10e [kprobe_test]) epc=0xffffffff0161231c 
>> opcode=0x100073
>> sysctl-63      [001] d...  2505.264011: beq: 
>> (kprobe_test_branch+0xb0/0x10e [kprobe_test]) epc=0xffffffff01612322 
>> opcode=0x100073
>> sysctl-63      [001] d...  2505.264019: bgeu: 
>> (kprobe_test_branch+0xc6/0x10e [kprobe_test]) epc=0xffffffff01612338 
>> opcode=0x100073
>> sysctl-63      [001] d...  2505.264027: bltu: 
>> (kprobe_test_branch+0xd2/0x10e [kprobe_test]) epc=0xffffffff01612344 
>> opcode=0x100073
>>
>> Now we can see the traced information.
>> The actual address of the symbol 'kprobe_test_branch' is as follows:
>> cat /proc/kallsyms | grep kprobe_test_branch
>> ffffffff01612272 t kprobe_test_branch   [kprobe_test]
>>
>> Based on the traced information and the actual address of the symbol
>> 'kprobe_test_branch', we can also see that the branch instructions
>> have been replaced by 'ebreak(0x100073)' instructions.
>>
>> The pesudoinstructions of the branch instructions,
>> i.e. bnez, beqz, blez, bgez, bltz, bgtz, bleu, bgtu and ble
>> are allowed to probe as well.
>>
>> --------
>>
>> Signed-off-by: Chen Lifu <chenlifu@huawei.com>
>> ---
>>   arch/riscv/kernel/probes/decode-insn.c   |  3 +-
>>   arch/riscv/kernel/probes/simulate-insn.c | 78 ++++++++++++++++++++++++
>>   2 files changed, 79 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/riscv/kernel/probes/decode-insn.c 
>> b/arch/riscv/kernel/probes/decode-insn.c
>> index 5eb03fb61450..64f6183b4717 100644
>> --- a/arch/riscv/kernel/probes/decode-insn.c
>> +++ b/arch/riscv/kernel/probes/decode-insn.c
>> @@ -38,11 +38,10 @@ riscv_probe_decode_insn(probe_opcode_t *addr, 
>> struct arch_probe_insn *api)
>>       RISCV_INSN_REJECTED(c_ebreak,        insn);
>>   #endif
>> -    RISCV_INSN_REJECTED(branch,        insn);
>> -
>>       RISCV_INSN_SET_SIMULATE(jal,        insn);
>>       RISCV_INSN_SET_SIMULATE(jalr,        insn);
>>       RISCV_INSN_SET_SIMULATE(auipc,        insn);
>> +    RISCV_INSN_SET_SIMULATE(branch,        insn);
>>       return INSN_GOOD;
>>   }
>> diff --git a/arch/riscv/kernel/probes/simulate-insn.c 
>> b/arch/riscv/kernel/probes/simulate-insn.c
>> index b81719522d5c..efc989b28859 100644
>> --- a/arch/riscv/kernel/probes/simulate-insn.c
>> +++ b/arch/riscv/kernel/probes/simulate-insn.c
>> @@ -117,3 +117,81 @@ bool __kprobes simulate_auipc(u32 opcode, 
>> unsigned long addr, struct pt_regs *re
>>       return true;
>>   }
>> +
>> +#define branch_rs1_idx(opcode) \
>> +    (((opcode) >> 15) & 0x1f)
>> +
>> +#define branch_rs2_idx(opcode) \
>> +    (((opcode) >> 20) & 0x1f)
>> +
>> +#define branch_funct3(opcode) \
>> +    (((opcode) >> 12) & 0x7)
>> +
>> +#define branch_imm(opcode) \
>> +    (((((opcode) >> 8 ) & 0xf ) << 1 ) | \
>> +     ((((opcode) >> 25) & 0x3f) << 5 ) | \
>> +     ((((opcode) >> 7 ) & 0x1 ) << 11) | \
>> +     ((((opcode) >> 31) & 0x1 ) << 12))
>> +
>> +#define branch_offset(opcode) \
>> +    sign_extend32((branch_imm(opcode)), 12)
>> +
>> +#define BRANCH_BEQ    0x0
>> +#define BRANCH_BNE    0x1
>> +#define BRANCH_BLT    0x4
>> +#define BRANCH_BGE    0x5
>> +#define BRANCH_BLTU    0x6
>> +#define BRANCH_BGEU    0x7
>> +
>> +bool __kprobes simulate_branch(u32 opcode, unsigned long addr, struct 
>> pt_regs *regs)
>> +{
>> +    /*
>> +     * branch instructions:
>> +     *      31    30       25 24 20 19 15 14    12 11       8    
>> 7      6      0
>> +     * | imm[12] | imm[10:5] | rs2 | rs1 | funct3 | imm[4:1] | 
>> imm[11] | opcode |
>> +     *     1           6        5     5      3         4         
>> 1         7
>> +     *     imm[12|10:5]        rs2   rs1    000       
>> imm[4:1|11]       1100011  BEQ
>> +     *     imm[12|10:5]        rs2   rs1    001       
>> imm[4:1|11]       1100011  BNE
>> +     *     imm[12|10:5]        rs2   rs1    100       
>> imm[4:1|11]       1100011  BLT
>> +     *     imm[12|10:5]        rs2   rs1    101       
>> imm[4:1|11]       1100011  BGE
>> +     *     imm[12|10:5]        rs2   rs1    110       
>> imm[4:1|11]       1100011  BLTU
>> +     *     imm[12|10:5]        rs2   rs1    111       
>> imm[4:1|11]       1100011  BGEU
>> +     */
>> +
>> +    s32 offset;
>> +    s32 offset_tmp;
>> +    unsigned long rs1_val;
>> +    unsigned long rs2_val;
>> +
>> +    if (!rv_insn_reg_get_val(regs, branch_rs1_idx(opcode), &rs1_val) ||
>> +        !rv_insn_reg_get_val(regs, branch_rs2_idx(opcode), &rs2_val))
>> +        return false;
>> +
>> +    offset_tmp = branch_offset(opcode);
>> +    switch (branch_funct3(opcode)) {
>> +    case BRANCH_BEQ:
>> +        offset = (rs1_val == rs2_val) ? offset_tmp : 4;
>> +        break;
>> +    case BRANCH_BNE:
>> +        offset = (rs1_val != rs2_val) ? offset_tmp : 4;
>> +        break;
>> +    case BRANCH_BLT:
>> +        offset = ((long)rs1_val < (long)rs2_val) ? offset_tmp : 4;
>> +        break;
>> +    case BRANCH_BGE:
>> +        offset = ((long)rs1_val >= (long)rs2_val) ? offset_tmp : 4;
>> +        break;
>> +    case BRANCH_BLTU:
>> +        offset = (rs1_val < rs2_val) ? offset_tmp : 4;
>> +        break;
>> +    case BRANCH_BGEU:
>> +        offset = (rs1_val >= rs2_val) ? offset_tmp : 4;
>> +        break;
>> +    default:
>> +        return false;
>> +    }
>> +
>> +    instruction_pointer_set(regs, addr + offset);
>> +
>> +    return true;
>> +}
>>
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
