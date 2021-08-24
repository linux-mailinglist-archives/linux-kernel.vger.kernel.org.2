Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB1F3F5D53
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 13:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236813AbhHXLvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 07:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234787AbhHXLvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 07:51:05 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BCA7C061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 04:50:21 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id d11so43675639eja.8
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 04:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aPOK4hYPEQlsB4E9tsLxa9pHfmjZWvkYyLNBn0YcO2M=;
        b=ANrWX1O1fiBUlp7vTv0SjcNHNJYHsrGDKX2nHz9HPI+mW0SUSLhg/3M/6CQIgNEqEV
         PthBsHNj/meod3+I+pEJspyjwdAFD6Px5Ke98Rr2B8SULvRNWMRe8RWdJFjs1u6L9guL
         tLJKo7y6LDM8gimyDou0hrce72N7PM2CKjkv8NT8aelFfOLoA75sUR/aRcVnr7WxRVps
         wvNYWayXVot5fPpyf+nUAiq3BJ21YM9+llQavpdFKUNTgkwiVfTMWhZFQol+lFewEbub
         IDyafc80H9HbSVBZoWSECcx16Br5c2RCO8sawtVHdPP4af6VzkQ6LOkc8ePoHyoOZQB9
         vQDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aPOK4hYPEQlsB4E9tsLxa9pHfmjZWvkYyLNBn0YcO2M=;
        b=PLzSOU+8FtCeEo3dt735+Rj3PxgpVF402ydcL6X0Cj9Pqz5NJpjTtrBDG2/4q9FSbu
         aroRSY6JfZNowAsEMRqR1PaJq4WkKkXbbyx37EXp/XOKuGoA7a5YUqYSd/Y2+gcFNgEc
         T8UqSvzQ+WxurtTZ3jGttczrunIloTRKxopB3K/nta/0Km3/TOdpJu5u9en/oomvX7kp
         +x6khYKWQXyv4hd25NwImdNwbL7ylkn/U3lQyoTB1iNXH0nf7Ml2XeKyLO7u5vgdMFAk
         QZYZeYCI/nwc3XC80Cg7gP2MjLqyepUl9LUmFXvUnnHC3I3opvfeQpEVTA8VHbQx+i4r
         v6qg==
X-Gm-Message-State: AOAM531I7cbMULXVvtFY8fOH8ayq/yfAPWGsXcPBNdTZdpPc+XuNkfFT
        RoDk0YfnvXASNwBDhvI902LiRhK45es3fyeAMO4=
X-Google-Smtp-Source: ABdhPJxDOAn/6jn2D8P+8YwI/N8jLQHyHoO2fDsuGZWAcD3ItiglJUaoR+mKmes4lcdc2wgAvcjFfU9D3UFrObqU1dY=
X-Received: by 2002:a17:906:5a66:: with SMTP id my38mr10884140ejc.36.1629805819958;
 Tue, 24 Aug 2021 04:50:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210818073336.59678-1-liuqi115@huawei.com> <20210818073336.59678-3-liuqi115@huawei.com>
 <20210824105001.GA96738@C02TD0UTHF1T.local>
In-Reply-To: <20210824105001.GA96738@C02TD0UTHF1T.local>
From:   Barry Song <21cnbao@gmail.com>
Date:   Tue, 24 Aug 2021 23:50:08 +1200
Message-ID: <CAGsJ_4wU3g5i4PPo+cw3ZyGyswnFp7p7vERaq_aUuhmCCyvqmg@mail.gmail.com>
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

On Tue, Aug 24, 2021 at 10:51 PM Mark Rutland <mark.rutland@arm.com> wrote:
>
> Hi,
>
> I have a bunch of comments below.
>
> At a high-level, I'm not all that keen on adding yet another set of
> trampolines, especially given we have constraints on how we can branch
> to them which render this not that useful in common configurations (e.g.
> where KASLR and module randomization is enabled).
>
> So importantly, do we actually need this? I don't think the sampel is
> that compelling since we can already use ftrace to measure function
> latencies.

Hopefully I can help answer some general questions. for code details,
I'll still rely on liuqi.

As far as I know, the functionality of ftrace is very limited. kprobe,
on the other hand, can do a lot of
things, for example, hooking some ebpf code.
Tons of userspace tools depend on kprobe, eg. ebpf/bcc which is widely
used nowadays:
https://github.com/iovisor/bcc

Function latency is really a very small part of what kprobe can do.
kprobe can do much much
more. For example, while doing disksnoop by kprobe, we are easily
collecting the request struct,
and get the layout of each IO request. without kprobe, we will
probably need to add tracepoints
here and there in kernel code to achieve the same goal.

I believe Masami and kprobe maintainers can answer this question better than me.

>
> If we do need this, I think we need to do some more substantial rework
> to address those branch range limitations. I know that we could permit
> arbitrary branching if we expand the ftrace-with-regs callsites to ~6
> instructions, but that interacts rather poorly with stacktracing and
> will make the kernel a bit bigger.

This patch is probably the first step towards a faster kprobe on ARM64.
I assume PLT or some similar tech will help break the limitation next
step.

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

While doing performance analysis or debugging performance issues  in
lab, the big latency of the current kprobe
can significantly impact the real result.

And it is particularly important when we want to do some online
diagnostics where machines are running on the cloud.
we need to minimally affect the real system while watching the system.

For example, https://gitee.com/xiebaoyou/diagnosis_tools is an
open-source tool which is used by alibaba, it uses
kprobe a lot to detect various problems running on aloud.

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

For this stage, with no_kaslr cmdline for defconfig, we are always
going to optprobe. otherwise, it
always goes to the fallback behaviour. So for this stage, it is
probably only useful in lab while people
are debugging problems. but this is still a widely useful scenario.
>

Thanks
Barry
