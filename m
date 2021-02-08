Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A371331327C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 13:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbhBHMhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 07:37:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:48172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233048AbhBHMdc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 07:33:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7494A64E37;
        Mon,  8 Feb 2021 12:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612787570;
        bh=rSrZQkTuBMLZezqNWHNFvCqzesdYFYYU3mlUmJ4XymU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hFWxnV/QCPxAZRiiENXRyc+rrZx475fBROJFaUdaQs3PbCeUfTtTKzGDPncQAjC5X
         EiaDUWVNL8RfEIglnu7UkzX32KtQGyXvGcQh4A/C8BpGxhF41JAldnWyGwknprHtQf
         Z8mhvI12PaLgyMLN47e/1lPmgq4/UKzL2W7LIxKutrk+9g1W0Gfd6ZHtnC7pFjGbCG
         oelonkzv8+KZtJs1jQGMT3aGrC+FUv6TC/qGQ+M5r5vCxCf5HW4PHrxJutjgo8zyae
         zr19ftT9D6s8Xp/i1xfy4QNQzlZdfNRb0gAPrkJH2SaVvAxjJ1pEL6jQa9soHjyKrh
         7Eu9HGQdEpFxA==
Date:   Mon, 8 Feb 2021 21:32:45 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Jianlin Lv <Jianlin.Lv@arm.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, natechancellor@gmail.com,
        ndesaulniers@google.com, fche@redhat.com, irogers@google.com,
        sumanthk@linux.ibm.com, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] perf probe: fix kretprobe issue caused by GCC bug
Message-Id: <20210208213245.c302a2263a0816d705af974c@kernel.org>
In-Reply-To: <20210205093558.3057814-1-Jianlin.Lv@arm.com>
References: <20210205093558.3057814-1-Jianlin.Lv@arm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jianlin,

On Fri,  5 Feb 2021 17:35:58 +0800
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

Oh, I had faced similar bug for fentry.
3d918a12a1b3 ("perf probe: Find fentry mcount fuzzed parameter location")
GCC dwarf generator tends to skip this kind of function entry information...

> 
> This issue is found on arm64, -fpatchable-function-entry=2 is enabled when
> CONFIG_DYNAMIC_FTRACE_WITH_REGS=y;
> Just as objdump displayed the assembler contents of kernel_clone,
> GCC generate 2 NOPs  at the beginning of each function.
> 
> kprobe_on_func_entry detects that (_text+599624) is not the entry address
> of the function, which leads to the failure of adding kretprobe event.
> 
> ---
> kprobe_on_func_entry
> ->_kprobe_addr
> ->kallsyms_lookup_size_offset
> ->arch_kprobe_on_func_entry		// FALSE
> ---
> 
> The cause of the issue is that the first instruction in the compile unit
> indicated by DW_AT_low_pc does not include NOPs.
> This issue exists in all gcc versions that support
> -fpatchable-function-entry option.
> 
> I have reported it to the GCC community:
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=98776

Thanks for reporting it!

> Currently arm64 and PA-RISC may enable fpatchable-function-entry option.
> The kernel compiled with clang does not have this issue.
> 
> FIX:
> 
> The result of my investigation is that this GCC issue will only cause the
> registration failure of the kretprobe event;
> Other functions of perf probe will not be affected, such as line probe,
> local variable probe, uprobe, etc.

Hmm, it can affects the perf probe with local variables with ftrace
infrastructure.

Now the debuginfo (dwarf_entrypc(DIE)) will return the actual symbol address
+offset (offset depends on -fpatchable-function-entry). In this case,
if perf-probe put a probe on a function entry, it will be a bit shifted.
So, the probe always uses SW break instead of ftrace...Ah, ok...I recalled.
Before discussing it, I need to restart the kprobe on ftrace for arm64.
It has been discussed last year, but stopped.

> A workaround solution is to traverse all the compilation units in
> debuginfo for the retprobe event and check whether the DW_AT_producer
> attribute valaue of each CUs contains substrings: "GNU" and
> "-fpatchable-function-entry". If these two substrings are included,
> then debuginfo will not be used to convert perf_probe_event.
> Instead, map will be used to query the probe function address.

Hmm, actually, the return probe doesn't need debuginfo since it has
no information of the local variables when the function returns (of course
usually all local variables are gone at that point). In that case you can
just stop using debuginfo for return probe.
(for the future work, it should support recording the contents of
 "pointer passing" arguments at return probe, but currently it is not
 supported yet. So this must be done in another series.)

e.g.
$ ./perf probe -D "eventfd_signal%return ctx->count"
Semantic error :You can't specify local variable for kretprobe.

So, this should work.

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 8eae2afff71a..10c88885dcd4 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -894,6 +894,9 @@ static int try_to_find_probe_trace_events(struct perf_probe_event *pev,
 	struct debuginfo *dinfo;
 	int ntevs, ret = 0;
 
+	if (pev->point.retprobe)
+		return 0;
+
 	dinfo = open_debuginfo(pev->target, pev->nsi, !need_dwarf);
 	if (!dinfo) {
 		if (need_dwarf)

Thank you,


> 
> -grecord-gcc-switches causes the command-line options used to invoke the
> compiler to be appended to the DW_AT_producer attribute in DWARF debugging
> information.It is enabled by default.
> 
> A potential defect is that if -gno-record-gcc-switches option is enabled,
> the command-line options will not be recorded in debuginfo. This workaround
> solution will fail.
> Assume that this situation may not happen for kernel compilation.
> 
> Signed-off-by: Jianlin Lv <Jianlin.Lv@arm.com>
> ---
>  tools/perf/util/probe-event.c | 60 +++++++++++++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
> 
> diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> index 8eae2afff71a..c0c1bcc59250 100644
> --- a/tools/perf/util/probe-event.c
> +++ b/tools/perf/util/probe-event.c
> @@ -885,6 +885,60 @@ static int post_process_probe_trace_events(struct perf_probe_event *pev,
>  	return ret;
>  }
>  
> +/*
> + * Perf failed to add kretprobe event with debuginfo of vmlinux which is
> + * compiled by gcc with -fpatchable-function-entry option enabled.
> + * The same issue with kernel module. Refer to gcc issue: #98776
> + * This issue only cause the registration failure of kretprobe event,
> + * and it doesn't affect other perf probe functions.
> + * This workaround solution use map to query the probe function address
> + * for retprobe event.
> + * A potential defect is that if -gno-record-gcc-switches option is enabled,
> + * the command-line options will not be recorded in debuginfo. This workaround
> + * solution will fail.
> + */
> +static bool retprobe_gcc_fpatchable_issue_workaround(struct debuginfo *dbg,
> +		struct perf_probe_event *pev)
> +{
> +	Dwarf_Off off = 0, noff = 0;
> +	size_t cuhl;
> +	Dwarf_Die cu_die;
> +	const char *producer = NULL;
> +	Dwarf_Attribute attr;
> +
> +	if (!pev->point.retprobe)
> +		return false;
> +
> +	/* Loop on CUs (Compilation Unit) */
> +	while (!dwarf_nextcu(dbg->dbg, off, &noff, &cuhl, NULL, NULL, NULL)) {
> +		/* Get the DIE(Debugging Information Entry) of this CU */
> +		if (dwarf_offdie(dbg->dbg, off + cuhl, &cu_die) == NULL) {
> +			off = noff;
> +			continue;
> +		}
> +
> +		/* Get information about the compiler that produced CUs */
> +		if (dwarf_hasattr(&cu_die, DW_AT_producer)
> +			&& dwarf_attr(&cu_die, DW_AT_producer, &attr)) {
> +			producer = dwarf_formstring(&attr);
> +			if (producer == NULL) {
> +				off = noff;
> +				continue;
> +			}
> +			/* Check that CU is compiled by GCC with
> +			 * fpatchable-function-entry option enabled
> +			 */
> +			if (strstr(producer, "GNU") &&
> +				strstr(producer, "-fpatchable-function-entry")) {
> +				pr_debug("Workaround for gcc issue, find probe function addresses from map.\n");
> +				return true;
> +			}
> +		}
> +		off = noff;
> +	}
> +	return false;
> +}
> +
>  /* Try to find perf_probe_event with debuginfo */
>  static int try_to_find_probe_trace_events(struct perf_probe_event *pev,
>  					  struct probe_trace_event **tevs)
> @@ -902,6 +956,12 @@ static int try_to_find_probe_trace_events(struct perf_probe_event *pev,
>  		return 0;
>  	}
>  
> +	/* workaround for gcc #98776 issue */
> +	if (retprobe_gcc_fpatchable_issue_workaround(dinfo, pev) && !need_dwarf) {
> +		debuginfo__delete(dinfo);
> +		return 0;
> +	}
> +
>  	pr_debug("Try to find probe point from debuginfo.\n");
>  	/* Searching trace events corresponding to a probe event */
>  	ntevs = debuginfo__find_trace_events(dinfo, pev, tevs);
> -- 
> 2.25.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
