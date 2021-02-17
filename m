Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C395E31E325
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 00:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbhBQXkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 18:40:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbhBQXk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 18:40:28 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A994DC061574
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 15:39:47 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id e7so1175503lft.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 15:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=teFskEaebZ19i1Z7EB6SGi++FZfsO3CkwFyMngYGBik=;
        b=Q/oHA+0JXQG2oMxwDTIgv1f2fkKj3+iR/v6AikL5rvhMinWcbwKxsE2fTTsIXmhiki
         MU4vHr6lvRGPhAIMeunRNeHEpVkWOsQDLg1envVftUuoQ6T+O90FAZ1jCy3Fcc0uaZhx
         EM/y9Y4J69bHFHIlIBSn1II5dNCHpgXBKyXJaT8sI0V+2/dy8WC75suqvg7qK2jtCgcK
         h89anmmL32UhYPRRGopkj2JTxJAbqSuvy2uJKiSt00DpPy4bc/NVI+eyFuwTVzQo6Wgb
         p3q24TmA42XYlPkLvOnz3DBy3wzCKW+p+bRbQ5acFG7t4lEyeWKBWgmp+3cRu7374yJf
         SRww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=teFskEaebZ19i1Z7EB6SGi++FZfsO3CkwFyMngYGBik=;
        b=pMJe3BXWSR5UJDpQyORo4Os0D27Qqtqem5lUL61L0qIMFTcaQ2BpedE5qu1GwlFsF5
         NogsFlyxgQQlcLiRSgPLhKpb9oh9+mnlt9QA5kPeJNOJUNLlTDKG11L5wiWV9ZILuHN0
         RTGLUyUvV8UUkVlYW3evfAyYSWzb9cPtdgTQhIL+c9x+46gtrP7/3aOdwEAa9HnZCnsa
         vI++zF2zZzpYrWvQcK+2wkgkDDw4TQXGbYB2tmcUrrFm+/Oot4mHCLE2/B8bpSogjlsC
         6K3ikEQM2jZKXhXJ/Rf5knopQnAsJhN2sX9tQNfIQ81WL7odAMWMeCBiUTGqsrhVeFIQ
         XuWg==
X-Gm-Message-State: AOAM532NqrnqspzBhzVeD4FXl4Pl0kC/y7KUip3nlxpT8Wv8Qv+jU/+C
        ZiXGugeyvgb/ELc+IpAl9zOMFPSCK/4EFGCK55IWtg==
X-Google-Smtp-Source: ABdhPJxy7vG5btl4qfyUgC9hBBPxcc46pL/xa/xEP7H/dHYQrpvWRhp8PqVJZaIUvSTFeBmwIZaP/Cr5t476S1PFm80=
X-Received: by 2002:a05:6512:12c1:: with SMTP id p1mr835669lfg.374.1613605185945;
 Wed, 17 Feb 2021 15:39:45 -0800 (PST)
MIME-Version: 1.0
References: <20210216103026.323157-1-Jianlin.Lv@arm.com>
In-Reply-To: <20210216103026.323157-1-Jianlin.Lv@arm.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 17 Feb 2021 15:39:35 -0800
Message-ID: <CAKwvOd=yYx=c=5TR6BY3nPUTQpn5tvSuD7X-KwZyGq5gTwA73g@mail.gmail.com>
Subject: Re: [PATCH v3] perf probe: fix kretprobe issue caused by GCC bug
To:     Jianlin Lv <Jianlin.Lv@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, fche@redhat.com,
        Ian Rogers <irogers@google.com>, sumanthk@linux.ibm.com,
        iecedge@gmail.com, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 16, 2021 at 2:30 AM Jianlin Lv <Jianlin.Lv@arm.com> wrote:
>
> Perf failed to add kretprobe event with debuginfo of vmlinux which is
> compiled by gcc with -fpatchable-function-entry option enabled.
> The same issue with kernel module.
>
> Issue:
>
>   # perf probe  -v 'kernel_clone%return $retval'
>   ......
>   Writing event: r:probe/kernel_clone__return _text+599624 $retval
>   Failed to write event: Invalid argument
>     Error: Failed to add events. Reason: Invalid argument (Code: -22)
>
>   # cat /sys/kernel/debug/tracing/error_log
>   [156.75] trace_kprobe: error: Retprobe address must be an function entry
>   Command: r:probe/kernel_clone__return _text+599624 $retval
>                                         ^
>
>   # llvm-dwarfdump  vmlinux |grep  -A 10  -w 0x00df2c2b
>   0x00df2c2b:   DW_TAG_subprogram
>                 DW_AT_external  (true)
>                 DW_AT_name      ("kernel_clone")
>                 DW_AT_decl_file ("/home/code/linux-next/kernel/fork.c")
>                 DW_AT_decl_line (2423)
>                 DW_AT_decl_column       (0x07)
>                 DW_AT_prototyped        (true)
>                 DW_AT_type      (0x00dcd492 "pid_t")
>                 DW_AT_low_pc    (0xffff800010092648)
>                 DW_AT_high_pc   (0xffff800010092b9c)
>                 DW_AT_frame_base        (DW_OP_call_frame_cfa)
>
>   # cat /proc/kallsyms |grep kernel_clone
>   ffff800010092640 T kernel_clone
>   # readelf -s vmlinux |grep -i kernel_clone
>   183173: ffff800010092640  1372 FUNC    GLOBAL DEFAULT    2 kernel_clone
>
>   # objdump -d vmlinux |grep -A 10  -w \<kernel_clone\>:
>   ffff800010092640 <kernel_clone>:
>   ffff800010092640:       d503201f        nop
>   ffff800010092644:       d503201f        nop
>   ffff800010092648:       d503233f        paciasp
>   ffff80001009264c:       a9b87bfd        stp     x29, x30, [sp, #-128]!
>   ffff800010092650:       910003fd        mov     x29, sp
>   ffff800010092654:       a90153f3        stp     x19, x20, [sp, #16]
>
> The entry address of kernel_clone converted by debuginfo is _text+599624
> (0x92648), which is consistent with the value of DW_AT_low_pc attribute.
> But the symbolic address of kernel_clone from /proc/kallsyms is
> ffff800010092640.
>
> This issue is found on arm64, -fpatchable-function-entry=2 is enabled when
> CONFIG_DYNAMIC_FTRACE_WITH_REGS=y;
> Just as objdump displayed the assembler contents of kernel_clone,
> GCC generate 2 NOPs  at the beginning of each function.
>
> kprobe_on_func_entry detects that (_text+599624) is not the entry address
> of the function, which leads to the failure of adding kretprobe event.
>
> kprobe_on_func_entry
> ->_kprobe_addr
> ->kallsyms_lookup_size_offset
> ->arch_kprobe_on_func_entry             // FALSE
>
> The cause of the issue is that the first instruction in the compile unit
> indicated by DW_AT_low_pc does not include NOPs.
> This issue exists in all gcc versions that support
> -fpatchable-function-entry option.
>
> I have reported it to the GCC community:
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=98776
>
> Currently arm64 and PA-RISC may enable fpatchable-function-entry option.
> The kernel compiled with clang does not have this issue.

Thank you for taking the time to check and verify with Clang. I appreciate it!

>
> FIX:
>
> This GCC issue only cause the registration failure of the kretprobe event
> which doesn't need debuginfo. So, stop using debuginfo for retprobe.
> map will be used to query the probe function address.
>
> Signed-off-by: Jianlin Lv <Jianlin.Lv@arm.com>
> ---
> v2: stop using debuginfo for retprobe, and update changelog.
> v3: Update changelog, fixed misuse of --- marker.
> ---
>  tools/perf/util/probe-event.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> index 8eae2afff71a..a59d3268adb0 100644
> --- a/tools/perf/util/probe-event.c
> +++ b/tools/perf/util/probe-event.c
> @@ -894,6 +894,16 @@ static int try_to_find_probe_trace_events(struct perf_probe_event *pev,
>         struct debuginfo *dinfo;
>         int ntevs, ret = 0;
>
> +       /* Workaround for gcc #98776 issue.
> +        * Perf failed to add kretprobe event with debuginfo of vmlinux which is
> +        * compiled by gcc with -fpatchable-function-entry option enabled. The
> +        * same issue with kernel module. The retprobe doesn`t need debuginfo.
> +        * This workaround solution use map to query the probe function address
> +        * for retprobe event.
> +        */
> +       if (pev->point.retprobe)
> +               return 0;
> +
>         dinfo = open_debuginfo(pev->target, pev->nsi, !need_dwarf);
>         if (!dinfo) {
>                 if (need_dwarf)
> --
> 2.25.1
>


-- 
Thanks,
~Nick Desaulniers
