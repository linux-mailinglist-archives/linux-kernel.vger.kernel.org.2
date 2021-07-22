Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D695C3D2B1C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 19:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbhGVQq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 12:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbhGVQq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 12:46:26 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E52C061575
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 10:27:01 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id b2so5334368plx.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 10:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=TOWH02qjc77Xd7z81JLx4HL1UgCCUE8E3VxL2ZDH10A=;
        b=t8OJgEQZtgTCfwbdGyrHlRTDkRw1saAVFWKuPC/C8zLE7iS02OyqryL3omqbO9fqrN
         V9XM0wc52FkRRi0GdFxdTRFooePjhHeAyMWMW4U96NVyEZjnKZPR2vjxxJWOhqcLup+/
         63hgPGdxq4t2MSTAODblcUIc7JuDR6u0byJ4rxy/anunneel22elHKNnFA7ij7wXZprM
         M7IdVNkH1FlTQ0ExvLKmCXXGV5aNEewuSohq7OdwsX4BaqDdAJo6RbyZPyCbTW6kajOb
         E9JYUbyN2XqmdbgfXj+JxzxdKXlBZ69MOjE0oL8+1bXSOOvQhD4lxeF1ubv9/M4Xyem9
         ofXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=TOWH02qjc77Xd7z81JLx4HL1UgCCUE8E3VxL2ZDH10A=;
        b=dbokuhou4WpwyXu2kgPB07h6J8McX5N+kOAOln6L3uVP2kf43fMkVgPu116GZ+3sdx
         crdo1S+D7YbHxEHxK9XU0FiL3Udx6y6Dmtp9k8fVHZlM53c+J5AX1+Liga+OccdJEkF8
         DfopSgOYStc4j1O4tDhAnayPyJlnlKY/PQllQdxj3Lp7ACEdphrwvckjDEGHG+Z6Z0zt
         qYCgMPo1DetE7HzPaTpMp8Gx/MBPAZOB7p9icswwcHj8NYrghfUpqK6qcfG2RRXmTCoR
         dU79lZVXipJETpNUO7kFh8ivZ/kZTk+hg68J1ARoYx3p8Cc2S6Ii36mpsJFe1qEP82uP
         ootg==
X-Gm-Message-State: AOAM530l+DA+GY1jz533q5chhlOfQSYnkZdFJCzlQNL0Ata2JTBih+R0
        7+kM9gsW/0Lw+2WXmbPjAgDPyQ==
X-Google-Smtp-Source: ABdhPJx3zydz+GFRy8ZokYCyu76kOZ+rPujojki6m4FvqsyUDl/yfWpZxtJVWLNTDJugitA/vWBAyA==
X-Received: by 2002:a65:6a0d:: with SMTP id m13mr1018088pgu.356.1626974820669;
        Thu, 22 Jul 2021 10:27:00 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id n32sm30611132pfv.59.2021.07.22.10.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 10:26:59 -0700 (PDT)
Date:   Thu, 22 Jul 2021 10:26:59 -0700 (PDT)
X-Google-Original-Date: Wed, 21 Jul 2021 23:23:49 PDT (-0700)
Subject:     Re: [PATCH -next 1/2] riscv: implemented auipc simulate instruction
In-Reply-To: <20210629023455.280998-1-chenlifu@huawei.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        guoren@linux.alibaba.com, chenlifu@huawei.com, penberg@kernel.org,
        mhiramat@kernel.org, me@packi.ch, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     chenlifu@huawei.com
Message-ID: <mhng-65ffe489-280a-4ebd-94e3-745f7114218d@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jun 2021 19:34:54 PDT (-0700), chenlifu@huawei.com wrote:
> To test the kprobe-based event tracing, we prepare
> a kernel module 'kprobe_test.ko' to add the probes.
> The assembly codes (partially) of the module are as follows:
> ...
> 0000000000000000 <kprobe_test_branch>:
> ...
> 0000000000000038 <.LVL1>:
>   38:	00000597          	auipc	a1,0x0
>   3c:	00058593          	mv	a1,a1
> ...
>
> Test the kprobe-based event tracing in qemu-system-riscv64:
> First, install the kprobe test module:
> insmod /root/kprobe_test.ko
>
> Then, add a probe as a new event at an 'auipc' instruction,
> the following error occurs due to the instruction not allowed to probe yet:
> echo "p:auipc kprobe_test:kprobe_test_branch+0x38 epc=%epc opcode=+0(%epc):x32" >> /sys/kernel/debug/tracing/kprobe_events
> sh: write error: Invalid argument
>
> This patch implemented the 'auipc' simulate instruction and allowed to probe it.
> Merge this patch and perform the test again, the test results are as follows:
> First, add a probe at the 'auipc' instruction:
> echo "p:auipc kprobe_test:kprobe_test_branch+0x38 epc=%epc opcode=+0(%epc):x32" >> /sys/kernel/debug/tracing/kprobe_events
> echo 1 > /sys/kernel/debug/tracing/events/kprobes/auipc/enable
>
> Then, do something to run to the probe.
> After that, see the traced information:
> cat /sys/kernel/debug/tracing/trace
> sysctl-58      [001] d...   179.126350: auipc: (kprobe_test_branch+0x38/0x10e [kprobe_test]) epc=0xffffffff016122aa opcode=0x100073
>
> Now we can see the traced information.
> The actual address of the symbol 'kprobe_test_branch' is as follows:
> cat /proc/kallsyms | grep kprobe_test_branch
> ffffffff01612272 t kprobe_test_branch   [kprobe_test]
>
> Based on the traced information and the actual address of the symbol
> 'kprobe_test_branch', we can also see that the 'auipc' instruction
> has been replaced by 'ebreak(0x100073)' instruction.
>
> --------
>
> Signed-off-by: Chen Lifu <chenlifu@huawei.com>
> ---
>  arch/riscv/kernel/probes/decode-insn.c   |  2 +-
>  arch/riscv/kernel/probes/simulate-insn.c | 34 ++++++++++++++++++++++++
>  2 files changed, 35 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/probes/decode-insn.c b/arch/riscv/kernel/probes/decode-insn.c
> index 0ed043acc882..5eb03fb61450 100644
> --- a/arch/riscv/kernel/probes/decode-insn.c
> +++ b/arch/riscv/kernel/probes/decode-insn.c
> @@ -38,11 +38,11 @@ riscv_probe_decode_insn(probe_opcode_t *addr, struct arch_probe_insn *api)
>  	RISCV_INSN_REJECTED(c_ebreak,		insn);
>  #endif
>
> -	RISCV_INSN_REJECTED(auipc,		insn);
>  	RISCV_INSN_REJECTED(branch,		insn);
>
>  	RISCV_INSN_SET_SIMULATE(jal,		insn);
>  	RISCV_INSN_SET_SIMULATE(jalr,		insn);
> +	RISCV_INSN_SET_SIMULATE(auipc,		insn);
>
>  	return INSN_GOOD;
>  }
> diff --git a/arch/riscv/kernel/probes/simulate-insn.c b/arch/riscv/kernel/probes/simulate-insn.c
> index 2519ce26377d..b81719522d5c 100644
> --- a/arch/riscv/kernel/probes/simulate-insn.c
> +++ b/arch/riscv/kernel/probes/simulate-insn.c
> @@ -83,3 +83,37 @@ bool __kprobes simulate_jalr(u32 opcode, unsigned long addr, struct pt_regs *reg
>
>  	return ret;
>  }
> +
> +#define auipc_rd_idx(opcode) \
> +	((opcode >> 7) & 0x1f)
> +
> +#define auipc_imm(opcode) \
> +	((((opcode) >> 12) & 0xfffff) << 12)
> +
> +#if __riscv_xlen == 64
> +#define auipc_offset(opcode)	sign_extend64(auipc_imm(opcode), 31)
> +#elif __riscv_xlen == 32
> +#define auipc_offset(opcode)	auipc_imm(opcode)
> +#else
> +#error "Unexpected __riscv_xlen"
> +#endif
> +
> +bool __kprobes simulate_auipc(u32 opcode, unsigned long addr, struct pt_regs *regs)
> +{
> +	/*
> +	 * auipc instruction:
> +	 *  31        12 11 7 6      0
> +	 * | imm[31:12] | rd | opcode |
> +	 *        20       5     7
> +	 */
> +
> +	u32 rd_idx = auipc_rd_idx(opcode);
> +	unsigned long rd_val = addr + auipc_offset(opcode);
> +
> +	if (!rv_insn_reg_set_val(regs, rd_idx, rd_val))
> +		return false;
> +
> +	instruction_pointer_set(regs, addr + 4);
> +
> +	return true;
> +}

Thanks.  These are on for-next, with the checkpatch errors fixed and the 
commit messages mostly removed -- it was all pretty awkwardly phrased so 
I didn't want to clean it up.
