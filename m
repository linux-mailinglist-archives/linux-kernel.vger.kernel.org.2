Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D72FC45FE8A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 13:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351030AbhK0M2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 07:28:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237599AbhK0M0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 07:26:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A74AC06175C
        for <linux-kernel@vger.kernel.org>; Sat, 27 Nov 2021 04:23:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D08460B70
        for <linux-kernel@vger.kernel.org>; Sat, 27 Nov 2021 12:23:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7AD2C53FAD;
        Sat, 27 Nov 2021 12:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638015788;
        bh=szy6wuxs7xhFGeL6Y/Zdaeh7n4KYS099yLHSiWljwlw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XgxPeLyrfpGVjeKw1SR5UvRfDO7Cg9IiHaP2RdUqi1UgAYcuBRMC5Fpg705VqKUQU
         pSSL/tzJIAhB6k5kLoom7E2JBGpbnR8hubvFifEwAxdhpspNNfAkff6qw8AZ5MSjJq
         W2WJ4XMiMGzG7zgiNToE97KvxKPPIOaDzrqjDjjcXp1JZu3HRRh1dAvsMaoKCWcAgW
         xLGjBucFSkdmRgzkuApziHH0o8QvgLmqdm4Pr6yUUVd9JJDIn+FK8+QA4FOp2AyzvD
         YC13cANrLCmCAZpgFBBSRWUZXLF1iRPBmfqwzGXv0KRxsv2lh74xQCfRaAIeJEVhKg
         aaKSe3d9si/aw==
Date:   Sat, 27 Nov 2021 21:23:02 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     "liuqi (BA)" <liuqi115@huawei.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <naveen.n.rao@linux.ibm.com>,
        <anil.s.keshavamurthy@intel.com>, <davem@davemloft.net>,
        <linux-arm-kernel@lists.infradead.org>,
        <song.bao.hua@hisilicon.com>, <prime.zeng@hisilicon.com>,
        <robin.murphy@arm.com>, <f.fangjian@huawei.com>,
        <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] arm64: kprobe: Enable OPTPROBE for arm64
Message-Id: <20211127212302.f71345c34e5a62e5e779adb2@kernel.org>
In-Reply-To: <aebcfbcb-eded-ff48-9d1f-2a93539575ca@huawei.com>
References: <20210818073336.59678-1-liuqi115@huawei.com>
        <20210818073336.59678-3-liuqi115@huawei.com>
        <20210824105001.GA96738@C02TD0UTHF1T.local>
        <aebcfbcb-eded-ff48-9d1f-2a93539575ca@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Nov 2021 18:31:06 +0800
"liuqi (BA)" <liuqi115@huawei.com> wrote:

> 
> 
> On 2021/8/24 18:50, Mark Rutland wrote:
> >> diff --git a/arch/arm64/kernel/probes/optprobe_trampoline.S b/arch/arm64/kernel/probes/optprobe_trampoline.S
> >> new file mode 100644
> >> index 000000000000..24d713d400cd
> >> --- /dev/null
> >> +++ b/arch/arm64/kernel/probes/optprobe_trampoline.S
> >> @@ -0,0 +1,37 @@
> >> +/* SPDX-License-Identifier: GPL-2.0 */
> >> +/*
> >> + * trampoline entry and return code for optprobes.
> >> + */
> >> +
> >> +#include <linux/linkage.h>
> >> +#include <asm/asm-offsets.h>
> >> +#include <asm/assembler.h>
> >> +
> >> +	.global optprobe_template_entry
> >> +optprobe_template_entry:
> > Please use SYM_*(); see arch/arm64/kernel/entry-ftrace.S for examples of
> > how to use that for trampolines.
> > 
> > This should be:
> > 
> > SYM_CODE_START(optprobe_template)
> > 
> Hi all,
> 
> I meet a problem when I use SYM_CODE_START(optprobe_template) to replace 
> optprobe_template_entry.
> 
> If SYM_CODE_START is used, all optprobe will share one trampoline space. 
> Under this circumstances, if user register two optprobes, trampoline 
> will be overwritten by the newer one, and this will cause kernel panic 
> when the old optprobe is trigger.

Hm, this is curious, because the template should be copied to the
trampoline buffer for each optprobe and be modified.

> 
> Using optprobe_template_entry will not have this problem, as each 
> optprobe has its own trampoline space (alloced in get_opinsn_slot()).

Yes, it is designed to do so.

Thank you,

> 
> So how to reuse SYM_CODE_START  in this situation, does anyone has a 
> good idea?
> 
> Thanks,
> Qi
> > ... and note the matching end below.
> > 
> >> +	sub sp, sp, #PT_REGS_SIZE
> >> +	save_all_base_regs
> >> +	/* Get parameters to optimized_callback() */
> >> +	ldr	x0, 1f
> >> +	mov	x1, sp
> >> +	/* Branch to optimized_callback() */
> >> +	.global optprobe_template_call
> >> +optprobe_template_call:
> > SYM_INNER_LABEL(optprobe_template_call, SYM_L_GLOBAL)
> > 
> > ...and likewise for all the other labels.
> > 
> >> +	nop
> >> +	restore_all_base_regs
> >> +	ldr lr, [sp, #S_LR]
> >> +        add sp, sp, #PT_REGS_SIZE
> >> +	.global optprobe_template_restore_orig_insn
> >> +optprobe_template_restore_orig_insn:
> >> +	nop
> >> +	.global optprobe_template_restore_end
> >> +optprobe_template_restore_end:
> >> +	nop
> >> +	.global optprobe_template_end
> >> +optprobe_template_end:
> >> +	.global optprobe_template_val
> >> +optprobe_template_val:
> >> +	1:	.long 0
> >> +		.long 0
> >> +	.global optprobe_template_max_length
> >> +optprobe_template_max_length:
> > SYM_INNER_LABEL(optprobe_template_end, SYM_L_GLOBAL)
> > SYM_CODE_END(optprobe_template)
> > 
> > Thanks,
> > Mark.
> > 
> >> -- 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
