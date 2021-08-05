Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1DBF3E19C7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 18:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234221AbhHEQoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 12:44:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:58570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234005AbhHEQox (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 12:44:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 30F556104F;
        Thu,  5 Aug 2021 16:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628181878;
        bh=nFjvgMYAv49NsQsV9W8NgpEZABX5oyK/mjriTSIbQAk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=s5+69wAWU4XY9ToPTxPVWn0HuN5qJz2K0sfq4v3q8EfD/Tx43RMOD74d7/NH5im81
         W77GtUkMZLrrLRjKo8NGO3Mwp+bt1DAQ8Up3zlTbJ0nat4Q8hA30uN1mfdYlssE5bs
         FMTiOQ6w2VjHxK9Q0GqN3B7qkO5ZpYpHMXSmZ1ImtdbsWGtddABkJQ5qAufEzY6Qpb
         F/FPj6v+4M8qOxtxGirNcDiItehfCSmca5Nj49Ssvlmuoh+kUWmkTL44ggahmLkSra
         45KXaquvZ0gIEmU0oIkFlJUerasqCNyBhI6BtGYHoersIIkWIv2MJ58ZclGG2LmBMf
         SwCg/Y0QjXc5A==
Date:   Fri, 6 Aug 2021 01:44:35 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     "liuqi (BA)" <liuqi115@huawei.com>
Cc:     Linuxarm <linuxarm@huawei.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <naveen.n.rao@linux.ibm.com>,
        <anil.s.keshavamurthy@intel.com>, <davem@davemloft.net>,
        <linux-arm-kernel@lists.infradead.org>,
        <song.bao.hua@hisilicon.com>, <prime.zeng@hisilicon.com>,
        <robin.murphy@arm.com>, <f.fangjian@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] arm64: kprobe: Enable OPTPROBE for arm64
Message-Id: <20210806014435.a1b6d7900e0e72599a8e325f@kernel.org>
In-Reply-To: <d3e0c9ee-19b5-8042-d251-05348e8ac49e@huawei.com>
References: <20210804060209.95817-1-liuqi115@huawei.com>
        <20210805105401.4acd3217c566b4e3933f355c@kernel.org>
        <d3e0c9ee-19b5-8042-d251-05348e8ac49e@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Aug 2021 17:25:17 +0800
"liuqi (BA)" <liuqi115@huawei.com> wrote:

> 
> Hi Masami,
> 
> On 2021/8/5 9:54, Masami Hiramatsu wrote:
> > On Wed, 4 Aug 2021 14:02:09 +0800
> > Qi Liu <liuqi115@huawei.com> wrote:
> > 
> >> This patch introduce optprobe for ARM64. In optprobe, probed
> >> instruction is replaced by a branch instruction to detour
> >> buffer. Detour buffer contains trampoline code and a call to
> >> optimized_callback(). optimized_callback() calls opt_pre_handler()
> >> to execute kprobe handler.
> >>
> >> Limitations:
> >> - We only support !CONFIG_RANDOMIZE_MODULE_REGION_FULL case to
> >> guarantee the offset between probe point and kprobe pre_handler
> >> is not larger than 128MiB.
> >>
> >> Performance of optprobe on Hip08 platform is test using kprobe
> >> example module[1] to analyze the latency of a kernel function,
> >> and here is the result:
> >>
> >> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/samples/kprobes/kretprobe_example.c
> >>
> >> kprobe before optimized:
> >> [280709.846380] do_empty returned 0 and took 1530 ns to execute
> >> [280709.852057] do_empty returned 0 and took 550 ns to execute
> >> [280709.857631] do_empty returned 0 and took 440 ns to execute
> >> [280709.863215] do_empty returned 0 and took 380 ns to execute
> >> [280709.868787] do_empty returned 0 and took 360 ns to execute
> >> [280709.874362] do_empty returned 0 and took 340 ns to execute
> >> [280709.879936] do_empty returned 0 and took 320 ns to execute
> >> [280709.885505] do_empty returned 0 and took 300 ns to execute
> >> [280709.891075] do_empty returned 0 and took 280 ns to execute
> >> [280709.896646] do_empty returned 0 and took 290 ns to execute
> >> [280709.902220] do_empty returned 0 and took 290 ns to execute
> >> [280709.907807] do_empty returned 0 and took 290 ns to execute
> >>
> >> optprobe:
> >> [ 2965.964572] do_empty returned 0 and took 90 ns to execute
> >> [ 2965.969952] do_empty returned 0 and took 80 ns to execute
> >> [ 2965.975332] do_empty returned 0 and took 70 ns to execute
> >> [ 2965.980714] do_empty returned 0 and took 60 ns to execute
> >> [ 2965.986128] do_empty returned 0 and took 80 ns to execute
> >> [ 2965.991507] do_empty returned 0 and took 70 ns to execute
> >> [ 2965.996884] do_empty returned 0 and took 70 ns to execute
> >> [ 2966.002262] do_empty returned 0 and took 80 ns to execute
> >> [ 2966.007642] do_empty returned 0 and took 70 ns to execute
> >> [ 2966.013020] do_empty returned 0 and took 70 ns to execute
> >> [ 2966.018400] do_empty returned 0 and took 70 ns to execute
> >> [ 2966.023779] do_empty returned 0 and took 70 ns to execute
> >> [ 2966.029158] do_empty returned 0 and took 70 ns to execute
> >>
> >> Signed-off-by: Qi Liu <liuqi115@huawei.com>
> >>
> >> ---
> >>
> >> Changes since V1:
> >> - Address the comments from Masami, checks for all branch instructions, and
> >> use aarch64_insn_patch_text_nosync() instead of aarch64_insn_patch_text()
> >> in each probe.
> > 
> > Is it safe for the multicore system? If it is safe because it modifies
> > just one instruction (modifying 32bit in atomic), I understand it.
> 
> Seems raw_spin_lock_irqsave is used in aarch64_insn_patch_text_nosync() 
> and spinlock could support a protection in multicore system.

No, that is not what I meant. stop_machine() will ensure that the all other
cores parking in the safe area, so the target instruction will never be
executed while modifying the code.
Even if you use the spinlock, other cores don't stop unless it tries
to lock the same spinlock. And they are possible to execute the instruction
which you are modifying.

> > BTW, anyway, you should use _nosync() variant in arch_prepare_optimized_kprobe()
> > too, beacause the optprobe insn buffer is not touched until the probed instruction
> > is optimized by br.
> > 
> Yes, sounds resonable.
> > [...]
> >> +int arch_prepare_optimized_kprobe(struct optimized_kprobe *op, struct kprobe *orig)
> >> +{
> >> +	kprobe_opcode_t *code;
> >> +	u32 insn;
> >> +	int ret, i;
> >> +	void *addrs[TMPL_END_IDX];
> >> +	void *addr;
> >> +
> >> +	code = get_optinsn_slot();
> >> +	if (!code)
> >> +		return -ENOMEM;
> >> +
> >> +	if (!is_offset_in_range((unsigned long)code,
> >> +				(unsigned long)orig->addr + 8))
> >> +		goto error;
> >> +
> >> +	if (!is_offset_in_range((unsigned long)code + TMPL_CALL_BACK,
> >> +				(unsigned long)optimized_callback))
> >> +		goto error;
> >> +
> >> +	if (!is_offset_in_range((unsigned long)&code[TMPL_RESTORE_END],
> >> +				(unsigned long)op->kp.addr + 4))
> >> +		goto error;
> >> +
> >> +	/* Setup template */
> >> +	for (i = 0; i < TMPL_END_IDX; i++)
> >> +		addrs[i] = code + i;
> >> +
> >> +	ret = aarch64_insn_patch_text(addrs, optprobe_template_entry,
> >> +				      TMPL_END_IDX);
> > 
> > You should use aarch64_insn_patch_text_nosync() here (and all the
> > aarch64_insn_patch_text() in this function too), because the insn
> > buffer must not executed until the probe point is optimized.
> > 
> aarch64_insn_patch_text() could patch multi instructions to code[] each 
> time and aarch64_insn_patch_text_nosync() could only patch one 
> instruction each time,

Ah, right. 

> so maybe aarch64_insn_patch_text() is better here.
> 
> I'll replace other aarch64_insn_patch_text() in this function.

Could you see x86 optprobe code what it does?
I prepare another writable buffer and build the trampoline code
on it. Finally patch the code on the insn buffer at once.
You can do the same thing here.

Thank you,

> 
> Thanks,
> Qi
> 
> >> +	if (ret < 0)
> >> +		goto error;
> >> +
> >> +	/* Set probe information */
> >> +	addr = code + TMPL_VAL_IDX;
> >> +	insn =  (unsigned long long)op & 0xffffffff;
> >> +	aarch64_insn_patch_text(&addr, &insn, 1);
> >> +
> >> +	addr = addr + 4;
> >> +	insn = ((unsigned long long)op & GENMASK_ULL(63, 32)) >> 32;
> >> +	aarch64_insn_patch_text(&addr, &insn, 1);
> >> +
> >> +	addr = code + TMPL_CALL_BACK;
> >> +	insn =  aarch64_insn_gen_branch_imm((unsigned long)addr,
> >> +				(unsigned long)optimized_callback,
> >> +				AARCH64_INSN_BRANCH_LINK);
> >> +	aarch64_insn_patch_text(&addr, &insn, 1);
> >> +
> >> +	/* The original probed instruction */
> >> +	addr = code + TMPL_RESTORE_ORIGN_INSN;
> >> +	insn =  orig->opcode;
> >> +	aarch64_insn_patch_text(&addr, &insn, 1);
> >> +
> >> +	/* Jump back to next instruction */
> >> +	addr = code + TMPL_RESTORE_END;
> >> +	insn = aarch64_insn_gen_branch_imm(
> >> +				(unsigned long)(&code[TMPL_RESTORE_END]),
> >> +				(unsigned long)(op->kp.addr) + 4,
> >> +				AARCH64_INSN_BRANCH_NOLINK);
> >> +	aarch64_insn_patch_text(&addr, &insn, 1);
> >> +
> >> +	flush_icache_range((unsigned long)code,
> >> +			   (unsigned long)(&code[TMPL_END_IDX]));
> >> +	/* Set op->optinsn.insn means prepared. */
> >> +	op->optinsn.insn = code;
> >> +
> >> +	return 0;
> > 
> > Thank you,
> > 
> > 
> > 
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
