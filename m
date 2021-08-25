Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEBE33F6D58
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 04:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236920AbhHYCOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 22:14:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:50508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235237AbhHYCO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 22:14:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 59A816127B;
        Wed, 25 Aug 2021 02:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629857623;
        bh=l6/Y66e3RvYMixih7o1WXBg+niHkHO2/y6lJMdVWuS8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XcEOceuQ/qyFU10Df0tBVh5Xk02N6koRTtAOVC49D1ycuj2oabGtHxcWyQ3MI/iJG
         itym2L6qPyJrWse38qB6Hi2v20TTcD0KFbCtcXP9wH/EcoI+5lGNq7kKU3R5+8TFBn
         U0A3qZj0JwFhBD5uvFW1C+nJSXnso/M9vUe8gMN6hfc0urkmCtA+90YFJw3zxvaX4o
         gOG4EBm1urRwExvLn0mandXEIJMlzzxJHwYqRLEnkiZy6FFiOmrdBc8lOlCnYqle9t
         Ui5iSmkJzMjGlfwb77wHenSGpwoLK69Nt4Xbs1TjNC18w2WaAoU1oAo2GtU78ZpbBX
         +nVB+ZC2UWfYg==
Date:   Wed, 25 Aug 2021 11:13:39 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Qi Liu <liuqi115@huawei.com>, catalin.marinas@arm.com,
        will@kernel.org, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, davem@davemloft.net,
        mhiramat@kernel.org, linux-arm-kernel@lists.infradead.org,
        song.bao.hua@hisilicon.com, prime.zeng@hisilicon.com,
        robin.murphy@arm.com, f.fangjian@huawei.com, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] arm64: kprobe: Enable OPTPROBE for arm64
Message-Id: <20210825111339.dcf494abb0c27508d2d1f645@kernel.org>
In-Reply-To: <20210824105001.GA96738@C02TD0UTHF1T.local>
References: <20210818073336.59678-1-liuqi115@huawei.com>
        <20210818073336.59678-3-liuqi115@huawei.com>
        <20210824105001.GA96738@C02TD0UTHF1T.local>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Aug 2021 11:50:01 +0100
Mark Rutland <mark.rutland@arm.com> wrote:

> Hi,
> 
> I have a bunch of comments below.
> 
> At a high-level, I'm not all that keen on adding yet another set of
> trampolines, especially given we have constraints on how we can branch
> to them which render this not that useful in common configurations (e.g.
> where KASLR and module randomization is enabled).

Yes, that makes kprobe jump optimization hard to implement on
RISC architecture in general. (x86 has 32bit offset jump instruction)
To solve this issue, something like "intermedate jump area" is needed
for each module. (Or, overwriting multiple instructions)

> 
> So importantly, do we actually need this? I don't think the sampel is
> that compelling since we can already use ftrace to measure function
> latencies.

That depends on what you use it for, as you may know, kprobes allows
you to put the probes on function body (and inlined function),
on the other hand, ftrace can put only on the entry of the function.
I guess Qi may want to use it for improving performance of BPF.

(BTW, as far as I know, Jisheng Zhang once tried to implement
kprobe on ftrace, that may be more helpful in this example.
https://lore.kernel.org/linux-arm-kernel/20191225172625.69811b3e@xhacker.debian/T/#m23a7aa55d32d140ee6a92102534446cfd4a43007
I will pick them up again)

> 
> If we do need this, I think we need to do some more substantial rework
> to address those branch range limitations. I know that we could permit
> arbitrary branching if we expand the ftrace-with-regs callsites to ~6
> instructions, but that interacts rather poorly with stacktracing and
> will make the kernel a bit bigger.

Would you mean we reuse the ftrace-with-regs callsites for kprobes?

arm32 avoids this limitation partially with reserved text pages
for trampoline in the kernel. But I think that is also a partial
solution. It may not work with module randomization at least on
arm64.

On arm64, I think there are several way to solve it.

- Add optprobe trampoline buffer for each module.
  This is the simplest way to solve this issue, but requires some
  pages to be added to each module (and kernel).

- Add intermediate trampoline area for each module. (2-stage jump)
  This jumps into an intermediate trampoline entry, save a partial
  registers and jump the actual trampoline using that register.
  This can reduce the size of trampoline buffer for each module.

- Replace multiple instructions with the above intermediate jump
  code. (single jump, but replace multiple instructions)
  This requires to emulate multiple instructions and also the
  kprobe must decode the instructions in the target function to
  identify the replaced instructions are in one basic block. But
  no need to add intermediate trampoline area (page).



> 
> On Wed, Aug 18, 2021 at 03:33:36PM +0800, Qi Liu wrote:
> > This patch introduce optprobe for ARM64. In optprobe, probed
> > instruction is replaced by a branch instruction to detour
> > buffer. Detour buffer contains trampoline code and a call to
> > optimized_callback(). optimized_callback() calls opt_pre_handler()
> > to execute kprobe handler.
> > 
> > Performance of optprobe on Hip08 platform is test using kprobe
> > example module[1] to analyze the latency of a kernel function,
> > and here is the result:
> > 
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/samples/kprobes/kretprobe_example.c
> > 
> > kprobe before optimized:
> > [280709.846380] do_empty returned 0 and took 1530 ns to execute
> > [280709.852057] do_empty returned 0 and took 550 ns to execute
> > [280709.857631] do_empty returned 0 and took 440 ns to execute
> > [280709.863215] do_empty returned 0 and took 380 ns to execute
> > [280709.868787] do_empty returned 0 and took 360 ns to execute
> > [280709.874362] do_empty returned 0 and took 340 ns to execute
> > [280709.879936] do_empty returned 0 and took 320 ns to execute
> > [280709.885505] do_empty returned 0 and took 300 ns to execute
> > [280709.891075] do_empty returned 0 and took 280 ns to execute
> > [280709.896646] do_empty returned 0 and took 290 ns to execute
> > [280709.902220] do_empty returned 0 and took 290 ns to execute
> > [280709.907807] do_empty returned 0 and took 290 ns to execute
> > 
> > optprobe:
> > [ 2965.964572] do_empty returned 0 and took 90 ns to execute
> > [ 2965.969952] do_empty returned 0 and took 80 ns to execute
> > [ 2965.975332] do_empty returned 0 and took 70 ns to execute
> > [ 2965.980714] do_empty returned 0 and took 60 ns to execute
> > [ 2965.986128] do_empty returned 0 and took 80 ns to execute
> > [ 2965.991507] do_empty returned 0 and took 70 ns to execute
> > [ 2965.996884] do_empty returned 0 and took 70 ns to execute
> > [ 2966.002262] do_empty returned 0 and took 80 ns to execute
> > [ 2966.007642] do_empty returned 0 and took 70 ns to execute
> > [ 2966.013020] do_empty returned 0 and took 70 ns to execute
> > [ 2966.018400] do_empty returned 0 and took 70 ns to execute
> > [ 2966.023779] do_empty returned 0 and took 70 ns to execute
> > [ 2966.029158] do_empty returned 0 and took 70 ns to execute
> 
> Do we have any examples of where this latency matters in practice?
> 
> > 
> > Signed-off-by: Qi Liu <liuqi115@huawei.com>
> > 
> > Note:
> > To guarantee the offset between probe point and kprobe pre_handler
> > is smaller than 128MiB, users should set
> > CONFIG_RANDOMIZE_MODULE_REGION_FULL=N or set nokaslr in command line, or
> > optprobe will not work and fall back to normal kprobe.
> 
> Hmm... I don't think that's something we want to recommend, and
> certainly distros *should* use KASLR and
> CONFIG_RANDOMIZE_MODULE_REGION_FULL.
> 
> What happens with defconfig? Do we always get the fallback behaviour?

Yes, in such case, it fails back to normal kprobe.
Anyway, optprobe is a background optimization. User can not specify
which kprobe is optimized. That is automatically done.

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
