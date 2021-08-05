Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0993E0C31
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 03:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238021AbhHEByT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 21:54:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:42562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231771AbhHEByR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 21:54:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 900DA60E8D;
        Thu,  5 Aug 2021 01:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628128444;
        bh=EflziLK5J7hb6yFpmywsTa0MRmkbjdSW5CkBDkwVI5I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tQ7AT61f977/v5yXPGjbyRrFaTCE7b43r0jooiF1h8JwAUXv1U9g/oGdmxB5tFkDo
         1xaK9laAci97J/mjZtdp2Fek2mzJaOri+pVOOOJm03UO/alohnNgxis6cgF6ridMMd
         07laeAFoYJYNAa4pd0JL+gSt2lh/iEXbbVb3AuORkVDbWjIJJYtrLgmPQgL1xDOW44
         0j81oZMoH96LQEQpimOhVozWQEqzzV8vHVImNEipGiGK9OQfx3US2dQCQBPTc61aV1
         b6vXxJSOrCWotWrolog+WG8RbN2WkmrR9xiegTtG1D5U/8A/d4iFPuCn2bTippkmG1
         zdRIVjSv6yPig==
Date:   Thu, 5 Aug 2021 10:54:01 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Qi Liu <liuqi115@huawei.com>
Cc:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <naveen.n.rao@linux.ibm.com>, <anil.s.keshavamurthy@intel.com>,
        <davem@davemloft.net>, <linux-arm-kernel@lists.infradead.org>,
        <song.bao.hua@hisilicon.com>, <prime.zeng@hisilicon.com>,
        <robin.murphy@arm.com>, <f.fangjian@huawei.com>,
        <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] arm64: kprobe: Enable OPTPROBE for arm64
Message-Id: <20210805105401.4acd3217c566b4e3933f355c@kernel.org>
In-Reply-To: <20210804060209.95817-1-liuqi115@huawei.com>
References: <20210804060209.95817-1-liuqi115@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Aug 2021 14:02:09 +0800
Qi Liu <liuqi115@huawei.com> wrote:

> This patch introduce optprobe for ARM64. In optprobe, probed
> instruction is replaced by a branch instruction to detour
> buffer. Detour buffer contains trampoline code and a call to
> optimized_callback(). optimized_callback() calls opt_pre_handler()
> to execute kprobe handler.
> 
> Limitations:
> - We only support !CONFIG_RANDOMIZE_MODULE_REGION_FULL case to
> guarantee the offset between probe point and kprobe pre_handler
> is not larger than 128MiB.
> 
> Performance of optprobe on Hip08 platform is test using kprobe
> example module[1] to analyze the latency of a kernel function,
> and here is the result:
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/samples/kprobes/kretprobe_example.c
> 
> kprobe before optimized:
> [280709.846380] do_empty returned 0 and took 1530 ns to execute
> [280709.852057] do_empty returned 0 and took 550 ns to execute
> [280709.857631] do_empty returned 0 and took 440 ns to execute
> [280709.863215] do_empty returned 0 and took 380 ns to execute
> [280709.868787] do_empty returned 0 and took 360 ns to execute
> [280709.874362] do_empty returned 0 and took 340 ns to execute
> [280709.879936] do_empty returned 0 and took 320 ns to execute
> [280709.885505] do_empty returned 0 and took 300 ns to execute
> [280709.891075] do_empty returned 0 and took 280 ns to execute
> [280709.896646] do_empty returned 0 and took 290 ns to execute
> [280709.902220] do_empty returned 0 and took 290 ns to execute
> [280709.907807] do_empty returned 0 and took 290 ns to execute
> 
> optprobe:
> [ 2965.964572] do_empty returned 0 and took 90 ns to execute
> [ 2965.969952] do_empty returned 0 and took 80 ns to execute
> [ 2965.975332] do_empty returned 0 and took 70 ns to execute
> [ 2965.980714] do_empty returned 0 and took 60 ns to execute
> [ 2965.986128] do_empty returned 0 and took 80 ns to execute
> [ 2965.991507] do_empty returned 0 and took 70 ns to execute
> [ 2965.996884] do_empty returned 0 and took 70 ns to execute
> [ 2966.002262] do_empty returned 0 and took 80 ns to execute
> [ 2966.007642] do_empty returned 0 and took 70 ns to execute
> [ 2966.013020] do_empty returned 0 and took 70 ns to execute
> [ 2966.018400] do_empty returned 0 and took 70 ns to execute
> [ 2966.023779] do_empty returned 0 and took 70 ns to execute
> [ 2966.029158] do_empty returned 0 and took 70 ns to execute
> 
> Signed-off-by: Qi Liu <liuqi115@huawei.com>
> 
> ---
> 
> Changes since V1:
> - Address the comments from Masami, checks for all branch instructions, and
> use aarch64_insn_patch_text_nosync() instead of aarch64_insn_patch_text()
> in each probe.

Is it safe for the multicore system? If it is safe because it modifies
just one instruction (modifying 32bit in atomic), I understand it.
BTW, anyway, you should use _nosync() variant in arch_prepare_optimized_kprobe()
too, beacause the optprobe insn buffer is not touched until the probed instruction
is optimized by br.

[...]
> +int arch_prepare_optimized_kprobe(struct optimized_kprobe *op, struct kprobe *orig)
> +{
> +	kprobe_opcode_t *code;
> +	u32 insn;
> +	int ret, i;
> +	void *addrs[TMPL_END_IDX];
> +	void *addr;
> +
> +	code = get_optinsn_slot();
> +	if (!code)
> +		return -ENOMEM;
> +
> +	if (!is_offset_in_range((unsigned long)code,
> +				(unsigned long)orig->addr + 8))
> +		goto error;
> +
> +	if (!is_offset_in_range((unsigned long)code + TMPL_CALL_BACK,
> +				(unsigned long)optimized_callback))
> +		goto error;
> +
> +	if (!is_offset_in_range((unsigned long)&code[TMPL_RESTORE_END],
> +				(unsigned long)op->kp.addr + 4))
> +		goto error;
> +
> +	/* Setup template */
> +	for (i = 0; i < TMPL_END_IDX; i++)
> +		addrs[i] = code + i;
> +
> +	ret = aarch64_insn_patch_text(addrs, optprobe_template_entry,
> +				      TMPL_END_IDX);

You should use aarch64_insn_patch_text_nosync() here (and all the
aarch64_insn_patch_text() in this function too), because the insn
buffer must not executed until the probe point is optimized.

> +	if (ret < 0)
> +		goto error;
> +
> +	/* Set probe information */
> +	addr = code + TMPL_VAL_IDX;
> +	insn =  (unsigned long long)op & 0xffffffff;
> +	aarch64_insn_patch_text(&addr, &insn, 1);
> +
> +	addr = addr + 4;
> +	insn = ((unsigned long long)op & GENMASK_ULL(63, 32)) >> 32;
> +	aarch64_insn_patch_text(&addr, &insn, 1);
> +
> +	addr = code + TMPL_CALL_BACK;
> +	insn =  aarch64_insn_gen_branch_imm((unsigned long)addr,
> +				(unsigned long)optimized_callback,
> +				AARCH64_INSN_BRANCH_LINK);
> +	aarch64_insn_patch_text(&addr, &insn, 1);
> +
> +	/* The original probed instruction */
> +	addr = code + TMPL_RESTORE_ORIGN_INSN;
> +	insn =  orig->opcode;
> +	aarch64_insn_patch_text(&addr, &insn, 1);
> +
> +	/* Jump back to next instruction */
> +	addr = code + TMPL_RESTORE_END;
> +	insn = aarch64_insn_gen_branch_imm(
> +				(unsigned long)(&code[TMPL_RESTORE_END]),
> +				(unsigned long)(op->kp.addr) + 4,
> +				AARCH64_INSN_BRANCH_NOLINK);
> +	aarch64_insn_patch_text(&addr, &insn, 1);
> +
> +	flush_icache_range((unsigned long)code,
> +			   (unsigned long)(&code[TMPL_END_IDX]));
> +	/* Set op->optinsn.insn means prepared. */
> +	op->optinsn.insn = code;
> +
> +	return 0;

Thank you,



-- 
Masami Hiramatsu <mhiramat@kernel.org>
