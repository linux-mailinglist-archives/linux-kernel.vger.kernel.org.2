Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83A333163F9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 11:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbhBJKgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 05:36:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:46640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229638AbhBJK0h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 05:26:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E742864E37;
        Wed, 10 Feb 2021 10:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612952756;
        bh=D3TucLV3OMj3W1Wdedgol6e1zETtdfVKkl7R8xnRRkY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cL1+uDJsDynIP+8HCyW46vSbu48J4+HUUWIsXmKm09ALwSeA7iHBmGNl5wSyl/M82
         vGhNUkTPen8fhrFGIE39hHeHXmwqk/ruHH8cYCigDQl05ZK/6genOafgPyit07bMaV
         20KCMH3MmPgE4Ecx9qApDiFcBX8a5DFtN3PpR7HnUgWmSh0ylrqHKbZjXQOru3argg
         FjiSXCnOLgl0jxY0/Hj8CKpcmgLE6uonk5GOnogyVNosUilh3lF/Gn3qCYVFJJadPK
         AlQH1r0dG/1ifTwuNoEKRrriD44HhzMAj+uSFQmi923tgnDTRjxPeOqrYMcjr6uqse
         F+ELFZfE8p9og==
Date:   Wed, 10 Feb 2021 19:25:49 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Jianlin Lv <Jianlin.Lv@arm.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, nathan@kernel.org,
        ndesaulniers@google.com, fche@redhat.com, irogers@google.com,
        sumanthk@linux.ibm.com, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH v2] perf probe: fix kretprobe issue caused by GCC bug
Message-Id: <20210210192549.dedff88ac7adb610529f7f5c@kernel.org>
In-Reply-To: <20210210062646.2377995-1-Jianlin.Lv@arm.com>
References: <20210210062646.2377995-1-Jianlin.Lv@arm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Feb 2021 14:26:46 +0800
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
> 
> Currently arm64 and PA-RISC may enable fpatchable-function-entry option.
> The kernel compiled with clang does not have this issue.
> 
> FIX:
> 
> This GCC issue only cause the registration failure of the kretprobe event
> which doesn't need debuginfo. So, stop using debuginfo for retprobe.
> map will be used to query the probe function address.

Looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks!

> 
> Signed-off-by: Jianlin Lv <Jianlin.Lv@arm.com>
> ---
> v2: stop using debuginfo for retprobe, and update changelog.
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
