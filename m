Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96FFC31D9A5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 13:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232713AbhBQMl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 07:41:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:54094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232663AbhBQMlu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 07:41:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 855CC64E42;
        Wed, 17 Feb 2021 12:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613565669;
        bh=pk2DzGEAD1eovee2oFpVglKFrPVDtINUHjBP2+2ZhdM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FebzngLcpSFbOy68kRsF9MmFmSVvoTs+3+fXZ6absW5W/FOdEB0/im9NWtv4an18+
         smkVseWnfKx4/oKylooBezQUCBJtPTpG7NSsacvZM7K0dTVfcZjNEsFKbe7mcT5IZs
         LLrLgllBjGT44MkYKDmD/+r9TgnOpim9jrAwRa3JLIeXfPZEMkIbA81i5kneOsx0I8
         fBz5ragq5N0r123fUYd+/8P7iG7Y3wKNTDZDzFhVO9OlLyAy0qw+Z2XHdVfSF7j+jL
         Tzngai51diiN+1yVUgvLTb7Y9dUJXlD5LSjPdi/lRnXHnzcQJjP52T6jlc29RERWsN
         CQ2+RBfKKLllg==
Date:   Wed, 17 Feb 2021 21:40:58 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Jianlin Lv <Jianlin.Lv@arm.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, nathan@kernel.org,
        ndesaulniers@google.com, fche@redhat.com, irogers@google.com,
        sumanthk@linux.ibm.com, iecedge@gmail.com,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH v3] perf probe: fix kretprobe issue caused by GCC bug
Message-Id: <20210217214058.0307cf0ac87f4feb58ab5e4d@kernel.org>
In-Reply-To: <20210216103026.323157-1-Jianlin.Lv@arm.com>
References: <20210216103026.323157-1-Jianlin.Lv@arm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Feb 2021 18:30:26 +0800
Jianlin Lv <Jianlin.Lv@arm.com> wrote:

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
> ->arch_kprobe_on_func_entry		// FALSE
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
> 
> FIX:
> 
> This GCC issue only cause the registration failure of the kretprobe event
> which doesn't need debuginfo. So, stop using debuginfo for retprobe.
> map will be used to query the probe function address.
> 
> Signed-off-by: Jianlin Lv <Jianlin.Lv@arm.com>

Looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you!

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
>  	struct debuginfo *dinfo;
>  	int ntevs, ret = 0;
>  
> +	/* Workaround for gcc #98776 issue.
> +	 * Perf failed to add kretprobe event with debuginfo of vmlinux which is
> +	 * compiled by gcc with -fpatchable-function-entry option enabled. The
> +	 * same issue with kernel module. The retprobe doesn`t need debuginfo.
> +	 * This workaround solution use map to query the probe function address
> +	 * for retprobe event.
> +	 */
> +	if (pev->point.retprobe)
> +		return 0;
> +
>  	dinfo = open_debuginfo(pev->target, pev->nsi, !need_dwarf);
>  	if (!dinfo) {
>  		if (need_dwarf)
> -- 
> 2.25.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
