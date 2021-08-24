Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A36CD3F5E25
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 14:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237310AbhHXMnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 08:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237196AbhHXMnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 08:43:49 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7E2C061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 05:43:05 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id d11so44001480eja.8
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 05:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5QnGC0MN22aUDhl70hFzCi9D+TfJ1txOWLCie09Ants=;
        b=B4AwHkISIbRhaZumnOrOdv+xi2NEJP6SwtQxFuD5RvO0dmrkf8wETPwpuSGUY/9ALe
         JUe+qDb4Ig66wdIljuqG0P8FecQkKOsfdStGel70GI7mg6R2y91D7NEjQ3xsOLA+vrtA
         HVcWMqL+RvTBILshyyjtJIPZq06lnaBPjNnD9haw8OAhBMYHERtHtm1nCXi5RYZ0JhQj
         fwny5L8uFdUevVHdDp8b/LhdhDyeKAQ95WXac4W8kknVcNdX5zEgNAvrZ1vLJa95BEhw
         l7CQpfHgSbcyXNhWZiW2KGXH6wzBkuKU8UB6RF59Y2/ew4464j+f9rwUVYZ2ZWm+oiaz
         sCSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5QnGC0MN22aUDhl70hFzCi9D+TfJ1txOWLCie09Ants=;
        b=C1eYq2gnmdB1BG3xjrax7W/iH9vT/qkVUzeC0CH6VSx1fZZfuzWovmqG8NSjEeAcK2
         drFHDvKiUUH9GkYzJjYukP0KdGoRLD2NG5BOIjsga/zkvjkIoZM7xG7uRIKBXkdN2anI
         WGuCK+vyBAd+GMywAhbpjdWiXC00j4yb7hE2Iih7Y2DhcA8lrAu9qxDigfABjbo3iY8W
         huJkqX9VqC450kfkcangkCafxJkrdr1xL/HaM889XeSWv7iJx+K9z2uef7Jg2vlb9+zi
         qIlJjGhzTiz/CbciNnNTelqdZOyrdY/zGxgoPbf+Z2k6sBtVEn/D7Yv36OxeMaHLt5mE
         lRMg==
X-Gm-Message-State: AOAM533CVaj7VPMeADrH8lu15X9evlTodc1i0GGvrLDiRg4a3R3LAizo
        QNdNIzdnB+f4STHQywqajI4BlO0ydKbG3AX+OQA=
X-Google-Smtp-Source: ABdhPJzmR3uNN+bYt84drEC7Xnooa+Aa+U1mm0KuoMMvSqM0yZor+SQjDcADt6gGq3/HdCfpQnetpW1Cxb2mfMDllmc=
X-Received: by 2002:a17:906:f1ca:: with SMTP id gx10mr41264669ejb.387.1629808984017;
 Tue, 24 Aug 2021 05:43:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210818073336.59678-1-liuqi115@huawei.com> <20210818073336.59678-3-liuqi115@huawei.com>
 <20210824105001.GA96738@C02TD0UTHF1T.local> <CAGsJ_4wU3g5i4PPo+cw3ZyGyswnFp7p7vERaq_aUuhmCCyvqmg@mail.gmail.com>
 <20210824121145.GD96738@C02TD0UTHF1T.local>
In-Reply-To: <20210824121145.GD96738@C02TD0UTHF1T.local>
From:   Barry Song <21cnbao@gmail.com>
Date:   Wed, 25 Aug 2021 00:42:52 +1200
Message-ID: <CAGsJ_4zD5E3hM4GU=d2LdhAueXMW0QWcKXyCfAORokbE6aG1OA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] arm64: kprobe: Enable OPTPROBE for arm64
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Qi Liu <liuqi115@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
        naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        David Miller <davem@davemloft.net>, mhiramat@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Barry Song <song.bao.hua@hisilicon.com>,
        prime.zeng@hisilicon.com, robin.murphy@arm.com,
        f.fangjian@huawei.com, Linuxarm <linuxarm@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021 at 12:11 AM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Tue, Aug 24, 2021 at 11:50:08PM +1200, Barry Song wrote:
> > On Tue, Aug 24, 2021 at 10:51 PM Mark Rutland <mark.rutland@arm.com> wrote:
> > >
> > > Hi,
> > >
> > > I have a bunch of comments below.
> > >
> > > At a high-level, I'm not all that keen on adding yet another set of
> > > trampolines, especially given we have constraints on how we can branch
> > > to them which render this not that useful in common configurations (e.g.
> > > where KASLR and module randomization is enabled).
> > >
> > > So importantly, do we actually need this? I don't think the sampel is
> > > that compelling since we can already use ftrace to measure function
> > > latencies.
> >
> > Hopefully I can help answer some general questions. for code details,
> > I'll still rely on liuqi.
> >
> > As far as I know, the functionality of ftrace is very limited. kprobe,
> > on the other hand, can do a lot of
> > things, for example, hooking some ebpf code.
> > Tons of userspace tools depend on kprobe, eg. ebpf/bcc which is widely
> > used nowadays:
> > https://github.com/iovisor/bcc
> >
> > Function latency is really a very small part of what kprobe can do.
>
> I appreciate that, but *functionally* we can already do the other bits
> with the existing kprobes code, so the question for this series is where
> the latency/overhead matters in practice.
>
> > kprobe can do much much more. For example, while doing disksnoop by
> > kprobe, we are easily collecting the request struct, and get the
> > layout of each IO request. without kprobe, we will probably need to
> > add tracepoints here and there in kernel code to achieve the same
> > goal.
> >
> > I believe Masami and kprobe maintainers can answer this question better than me.
> >
> > > If we do need this, I think we need to do some more substantial rework
> > > to address those branch range limitations. I know that we could permit
> > > arbitrary branching if we expand the ftrace-with-regs callsites to ~6
> > > instructions, but that interacts rather poorly with stacktracing and
> > > will make the kernel a bit bigger.
> >
> > This patch is probably the first step towards a faster kprobe on ARM64.
> > I assume PLT or some similar tech will help break the limitation next
> > step.
>
> I have ideas about how we can make that work (basically an inline PLT
> next to the function), but the implementation is *very* different, and
> my thinking is that either:
>
> * The latency/overhead is a real concern generally, and this needs to
>   work in the majority of cases (e.g. where KASLR and module
>   randomization are on). If so, I think we should implement the more
>   invasive but complete solution in one go rather than implementing
>   something we know we're going to have to throw away.

For an online scenario, I do think we should have a complete implementation
to make it more useful as we can't force users to use nokaslr. in this
thread V1:
https://lore.kernel.org/lkml/6a97dff6c33c4b84887223de2502bd3d@hisilicon.com/
I actually also posted some similar ideas with you regarding using PLT to break
the limitation.

>
> * The latency is not that much of a concern, or is only a concern ina
>   few niche cases. If so, it's not clear to me whether this is
>   worthwhile as-is.
>
> > > On Wed, Aug 18, 2021 at 03:33:36PM +0800, Qi Liu wrote:
> > > > This patch introduce optprobe for ARM64. In optprobe, probed
> > > > instruction is replaced by a branch instruction to detour
> > > > buffer. Detour buffer contains trampoline code and a call to
> > > > optimized_callback(). optimized_callback() calls opt_pre_handler()
> > > > to execute kprobe handler.
> > > >
> > > > Performance of optprobe on Hip08 platform is test using kprobe
> > > > example module[1] to analyze the latency of a kernel function,
> > > > and here is the result:
> > > >
> > > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/samples/kprobes/kretprobe_example.c
> > > >
> > > > kprobe before optimized:
> > > > [280709.846380] do_empty returned 0 and took 1530 ns to execute
> > > > [280709.852057] do_empty returned 0 and took 550 ns to execute
> > > > [280709.857631] do_empty returned 0 and took 440 ns to execute
> > > > [280709.863215] do_empty returned 0 and took 380 ns to execute
> > > > [280709.868787] do_empty returned 0 and took 360 ns to execute
> > > > [280709.874362] do_empty returned 0 and took 340 ns to execute
> > > > [280709.879936] do_empty returned 0 and took 320 ns to execute
> > > > [280709.885505] do_empty returned 0 and took 300 ns to execute
> > > > [280709.891075] do_empty returned 0 and took 280 ns to execute
> > > > [280709.896646] do_empty returned 0 and took 290 ns to execute
> > > > [280709.902220] do_empty returned 0 and took 290 ns to execute
> > > > [280709.907807] do_empty returned 0 and took 290 ns to execute
> > > >
> > > > optprobe:
> > > > [ 2965.964572] do_empty returned 0 and took 90 ns to execute
> > > > [ 2965.969952] do_empty returned 0 and took 80 ns to execute
> > > > [ 2965.975332] do_empty returned 0 and took 70 ns to execute
> > > > [ 2965.980714] do_empty returned 0 and took 60 ns to execute
> > > > [ 2965.986128] do_empty returned 0 and took 80 ns to execute
> > > > [ 2965.991507] do_empty returned 0 and took 70 ns to execute
> > > > [ 2965.996884] do_empty returned 0 and took 70 ns to execute
> > > > [ 2966.002262] do_empty returned 0 and took 80 ns to execute
> > > > [ 2966.007642] do_empty returned 0 and took 70 ns to execute
> > > > [ 2966.013020] do_empty returned 0 and took 70 ns to execute
> > > > [ 2966.018400] do_empty returned 0 and took 70 ns to execute
> > > > [ 2966.023779] do_empty returned 0 and took 70 ns to execute
> > > > [ 2966.029158] do_empty returned 0 and took 70 ns to execute
> > >
> > > Do we have any examples of where this latency matters in practice?
> >
> > While doing performance analysis or debugging performance issues  in
> > lab, the big latency of the current kprobe
> > can significantly impact the real result.
> >
> > And it is particularly important when we want to do some online
> > diagnostics where machines are running on the cloud.
> > we need to minimally affect the real system while watching the system.
> >
> > For example, https://gitee.com/xiebaoyou/diagnosis_tools is an
> > open-source tool which is used by alibaba, it uses
> > kprobe a lot to detect various problems running on aloud.
>
> Ok. It would be good to mention something like this in the commit
> message. If it's possible to get an estimate of the overhead reduction,
> that would be great.

I believe liuqi's commit log has estimated the overhead reduction.
The below is exactly the overhead of kprobe before and after the patch.
not only does it decrease the overhead,  it also makes the
standard deviation more even.

i believe liuqi's estimation doesn't open cpufreq, if cpufreq is open,
un-optimized kprobe
latency can be much much bigger and have much much bigger stdev.

kprobe before optimized:
[280709.846380] do_empty returned 0 and took 1530 ns to execute
[280709.852057] do_empty returned 0 and took 550 ns to execute
[280709.857631] do_empty returned 0 and took 440 ns to execute
[280709.863215] do_empty returned 0 and took 380 ns to execute
[280709.868787] do_empty returned 0 and took 360 ns to execute
[280709.874362] do_empty returned 0 and took 340 ns to execute
[280709.879936] do_empty returned 0 and took 320 ns to execute
[280709.885505] do_empty returned 0 and took 300 ns to execute
[280709.891075] do_empty returned 0 and took 280 ns to execute
[280709.896646] do_empty returned 0 and took 290 ns to execute
[280709.902220] do_empty returned 0 and took 290 ns to execute
[280709.907807] do_empty returned 0 and took 290 ns to execute

optprobe:
[ 2965.964572] do_empty returned 0 and took 90 ns to execute
[ 2965.969952] do_empty returned 0 and took 80 ns to execute
[ 2965.975332] do_empty returned 0 and took 70 ns to execute
[ 2965.980714] do_empty returned 0 and took 60 ns to execute
[ 2965.986128] do_empty returned 0 and took 80 ns to execute
[ 2965.991507] do_empty returned 0 and took 70 ns to execute
[ 2965.996884] do_empty returned 0 and took 70 ns to execute
[ 2966.002262] do_empty returned 0 and took 80 ns to execute
[ 2966.007642] do_empty returned 0 and took 70 ns to execute
[ 2966.013020] do_empty returned 0 and took 70 ns to execute
[ 2966.018400] do_empty returned 0 and took 70 ns to execute
[ 2966.023779] do_empty returned 0 and took 70 ns to execute
[ 2966.029158] do_empty returned 0 and took 70 ns to execute

>
> > > > Signed-off-by: Qi Liu <liuqi115@huawei.com>
> > > >
> > > > Note:
> > > > To guarantee the offset between probe point and kprobe pre_handler
> > > > is smaller than 128MiB, users should set
> > > > CONFIG_RANDOMIZE_MODULE_REGION_FULL=N or set nokaslr in command line, or
> > > > optprobe will not work and fall back to normal kprobe.
> > >
> > > Hmm... I don't think that's something we want to recommend, and
> > > certainly distros *should* use KASLR and
> > > CONFIG_RANDOMIZE_MODULE_REGION_FULL.
> > >
> > > What happens with defconfig? Do we always get the fallback behaviour?
> >
> > For this stage, with no_kaslr cmdline for defconfig, we are always
> > going to optprobe. otherwise, it always goes to the fallback
> > behaviour. So for this stage, it is probably only useful in lab while
> > people are debugging problems. but this is still a widely useful
> > scenario.
>
> If it's only going to be used for lab debugging, why is the existing
> kprobes logic not sufficient?

My understanding is the lab needs to emulate the real scenario while
it is not a real
online system. The huge latency of the existing un-optimized kprobe
make all the data
from ebpf/bcc tools seriously distorted.


>
> Thanks,
> Mark.

Thanks
barry
