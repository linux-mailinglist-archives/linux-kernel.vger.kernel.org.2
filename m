Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEAEC3F6D9C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 05:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237528AbhHYDND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 23:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236811AbhHYDNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 23:13:02 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6799EC061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 20:12:16 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id x9-20020a056830278900b0051b8be1192fso31131207otu.7
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 20:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uwyl1LEbZl8NmH1etx1NtKcHu409L3wd9+kEi6jB58o=;
        b=Pxma9Q/wrDG3/Bop4MDR3dft/B83gpxAMNvJ2QaFzJaVw2cCagIgH5mDk5hW660Dbm
         ViCsIT1kBwt3pyI/0Ds4p76S2iJuMFu8DLDYiN/a0l/s3Ty+jk4v/4431Fw51ABuldoz
         EtLx2BhIPKizrOOr+D9LD7Wmsn1kq/QHjyaXT0AgzaDw9dzQLFEnBI5je4ZaJlZD8rqQ
         u4nUWLIwNH+5ss49crI6Fav76KsXovua4CH+2FsEWg5puktu+qepyxd+pK3fkiFIfkaE
         BoDjcpDIk9h6yxEEbZrWOJvan+5Ynl6X4ZwaTZxEQwfBMzb+EqierB7tEW1QZKni/nt4
         n4Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uwyl1LEbZl8NmH1etx1NtKcHu409L3wd9+kEi6jB58o=;
        b=N0RlKJpSLreGPtCxzdtP8Wy9ldwrlnKj5MuiWW3JaSZDRy2EXaSYcZhvpdYU/sA+SL
         IccqQn777EQQvkj4lvtXdvlzT0V3iNM8oFJF8D0tKNjhmFQir8ul2d9vdTQpTbPpvb4p
         vdumtyP+51tyJzknSS1jmvyLTHe0vO18jBWKGdepkLOu+qx8m0wm1ySjdUi5UcuUs9zY
         XdqofXRS5JOZeFkH8OjV+3s2AbE1pgSQj4hTrdynbnLbRCHH1aAtYCiCpGDDLxpG3FbT
         ROJQVZouohzYdlX4GybdeIM6rNJI9DwdOOWUS20lDP9AuuVP0Ph91q+VHGHAxRN2E5jP
         /A8g==
X-Gm-Message-State: AOAM533HJUwx7WFwx/t2mv8Pl47xhF8AkIF173vCLFDWUaseJRIKHKMj
        CtB3Tu3UuSp+iSkulLrZ0otqeYJGwbXYXPB8Bt8=
X-Google-Smtp-Source: ABdhPJyP6pnXPYR36sZqIr4FLuqHbZv/icnmGxuDycdfnGsMWGYh20jOi5PFJcKofIGVHSAcYQrW+HKEECrmOWakeTs=
X-Received: by 2002:aca:220a:: with SMTP id b10mr5268581oic.101.1629861135614;
 Tue, 24 Aug 2021 20:12:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210818073336.59678-1-liuqi115@huawei.com> <20210818073336.59678-3-liuqi115@huawei.com>
 <20210824105001.GA96738@C02TD0UTHF1T.local> <20210825111339.dcf494abb0c27508d2d1f645@kernel.org>
In-Reply-To: <20210825111339.dcf494abb0c27508d2d1f645@kernel.org>
From:   Barry Song <21cnbao@gmail.com>
Date:   Wed, 25 Aug 2021 15:12:04 +1200
Message-ID: <CAGsJ_4ww6wLBHw++qE_29ozC50XE8qc4T5waxn78UHRHjUFunQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] arm64: kprobe: Enable OPTPROBE for arm64
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, Qi Liu <liuqi115@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
        naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        David Miller <davem@davemloft.net>,
        linux-arm-kernel@lists.infradead.org,
        Barry Song <song.bao.hua@hisilicon.com>,
        prime.zeng@hisilicon.com, robin.murphy@arm.com,
        f.fangjian@huawei.com, Linuxarm <linuxarm@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021 at 2:15 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> On Tue, 24 Aug 2021 11:50:01 +0100
> Mark Rutland <mark.rutland@arm.com> wrote:
>
> > Hi,
> >
> > I have a bunch of comments below.
> >
> > At a high-level, I'm not all that keen on adding yet another set of
> > trampolines, especially given we have constraints on how we can branch
> > to them which render this not that useful in common configurations (e.g.
> > where KASLR and module randomization is enabled).
>
> Yes, that makes kprobe jump optimization hard to implement on
> RISC architecture in general. (x86 has 32bit offset jump instruction)
> To solve this issue, something like "intermedate jump area" is needed
> for each module. (Or, overwriting multiple instructions)
>
> >
> > So importantly, do we actually need this? I don't think the sampel is
> > that compelling since we can already use ftrace to measure function
> > latencies.
>
> That depends on what you use it for, as you may know, kprobes allows
> you to put the probes on function body (and inlined function),
> on the other hand, ftrace can put only on the entry of the function.
> I guess Qi may want to use it for improving performance of BPF.
>
> (BTW, as far as I know, Jisheng Zhang once tried to implement
> kprobe on ftrace, that may be more helpful in this example.
> https://lore.kernel.org/linux-arm-kernel/20191225172625.69811b3e@xhacker.debian/T/#m23a7aa55d32d140ee6a92102534446cfd4a43007
> I will pick them up again)
>
> >
> > If we do need this, I think we need to do some more substantial rework
> > to address those branch range limitations. I know that we could permit
> > arbitrary branching if we expand the ftrace-with-regs callsites to ~6
> > instructions, but that interacts rather poorly with stacktracing and
> > will make the kernel a bit bigger.
>
> Would you mean we reuse the ftrace-with-regs callsites for kprobes?
>
> arm32 avoids this limitation partially with reserved text pages
> for trampoline in the kernel. But I think that is also a partial
> solution. It may not work with module randomization at least on
> arm64.
>
> On arm64, I think there are several way to solve it.
>
> - Add optprobe trampoline buffer for each module.
>   This is the simplest way to solve this issue, but requires some
>   pages to be added to each module (and kernel).
>
> - Add intermediate trampoline area for each module. (2-stage jump)
>   This jumps into an intermediate trampoline entry, save a partial
>   registers and jump the actual trampoline using that register.
>   This can reduce the size of trampoline buffer for each module.
>
> - Replace multiple instructions with the above intermediate jump
>   code. (single jump, but replace multiple instructions)
>   This requires to emulate multiple instructions and also the
>   kprobe must decode the instructions in the target function to
>   identify the replaced instructions are in one basic block. But
>   no need to add intermediate trampoline area (page).
>
>
>
> >
> > On Wed, Aug 18, 2021 at 03:33:36PM +0800, Qi Liu wrote:
> > > This patch introduce optprobe for ARM64. In optprobe, probed
> > > instruction is replaced by a branch instruction to detour
> > > buffer. Detour buffer contains trampoline code and a call to
> > > optimized_callback(). optimized_callback() calls opt_pre_handler()
> > > to execute kprobe handler.
> > >
> > > Performance of optprobe on Hip08 platform is test using kprobe
> > > example module[1] to analyze the latency of a kernel function,
> > > and here is the result:
> > >
> > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/samples/kprobes/kretprobe_example.c
> > >
> > > kprobe before optimized:
> > > [280709.846380] do_empty returned 0 and took 1530 ns to execute
> > > [280709.852057] do_empty returned 0 and took 550 ns to execute
> > > [280709.857631] do_empty returned 0 and took 440 ns to execute
> > > [280709.863215] do_empty returned 0 and took 380 ns to execute
> > > [280709.868787] do_empty returned 0 and took 360 ns to execute
> > > [280709.874362] do_empty returned 0 and took 340 ns to execute
> > > [280709.879936] do_empty returned 0 and took 320 ns to execute
> > > [280709.885505] do_empty returned 0 and took 300 ns to execute
> > > [280709.891075] do_empty returned 0 and took 280 ns to execute
> > > [280709.896646] do_empty returned 0 and took 290 ns to execute
> > > [280709.902220] do_empty returned 0 and took 290 ns to execute
> > > [280709.907807] do_empty returned 0 and took 290 ns to execute
> > >
> > > optprobe:
> > > [ 2965.964572] do_empty returned 0 and took 90 ns to execute
> > > [ 2965.969952] do_empty returned 0 and took 80 ns to execute
> > > [ 2965.975332] do_empty returned 0 and took 70 ns to execute
> > > [ 2965.980714] do_empty returned 0 and took 60 ns to execute
> > > [ 2965.986128] do_empty returned 0 and took 80 ns to execute
> > > [ 2965.991507] do_empty returned 0 and took 70 ns to execute
> > > [ 2965.996884] do_empty returned 0 and took 70 ns to execute
> > > [ 2966.002262] do_empty returned 0 and took 80 ns to execute
> > > [ 2966.007642] do_empty returned 0 and took 70 ns to execute
> > > [ 2966.013020] do_empty returned 0 and took 70 ns to execute
> > > [ 2966.018400] do_empty returned 0 and took 70 ns to execute
> > > [ 2966.023779] do_empty returned 0 and took 70 ns to execute
> > > [ 2966.029158] do_empty returned 0 and took 70 ns to execute
> >
> > Do we have any examples of where this latency matters in practice?
> >
> > >
> > > Signed-off-by: Qi Liu <liuqi115@huawei.com>
> > >
> > > Note:
> > > To guarantee the offset between probe point and kprobe pre_handler
> > > is smaller than 128MiB, users should set
> > > CONFIG_RANDOMIZE_MODULE_REGION_FULL=N or set nokaslr in command line, or
> > > optprobe will not work and fall back to normal kprobe.
> >
> > Hmm... I don't think that's something we want to recommend, and
> > certainly distros *should* use KASLR and
> > CONFIG_RANDOMIZE_MODULE_REGION_FULL.
> >
> > What happens with defconfig? Do we always get the fallback behaviour?
>
> Yes, in such case, it fails back to normal kprobe.

just one minor comment. as Qi pointed out before, bootargs nokaslr
will make kernel built by defconfig
use optprobe:

        nokaslr         [KNL]
                        When CONFIG_RANDOMIZE_BASE is set, this disables
                        kernel and module base offset ASLR (Address Space
                        Layout Randomization).

in lab, while security is not a concern as online, it would be a good option.

> Anyway, optprobe is a background optimization. User can not specify
> which kprobe is optimized. That is automatically done.
>
> Thank you,
>
>
> --
> Masami Hiramatsu <mhiramat@kernel.org>

Thanks
barry
