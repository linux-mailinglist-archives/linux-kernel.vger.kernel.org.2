Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 589AD44F39F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 15:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235861AbhKMOWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 09:22:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:42412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231672AbhKMOW3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 09:22:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AF4A1611AE;
        Sat, 13 Nov 2021 14:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636813177;
        bh=ddC1HqJMjSciGw26f4eW3+rhlPalC6zUFcFoA4LkfMs=;
        h=Date:From:To:Cc:Subject:From;
        b=ahmvuZVomfYaZYW+pq4wu48F0gQ/Dwtd3JRe+IZtjS7Bs16cTVPdIj3ho7Qn51GZV
         CQW5uysSGs+jf6SerdjbIvVQ/BGEQDAWTdEPZbygJMKQrI/MM0SETYoLUFc1+qR6bu
         g2W6TJ6JQhNlu+eLQ93BLQhjREUmn2tjlOqhtXw8JKw/YpYi6BK+jrvm+ih5ocyCPN
         yhlgunqDmWZm9+dRYfyNjaNtgP1zzVTuHRJXG7WMbSxS8EJmCJ6yZ9rLY+VhiN8g5w
         t7EknH+rNqU8YEBSYqWYhTTgZO6M3bue18hodWatXnNfuAjgfosGiZgioCAf9yxwR+
         jJ9xHhxzw9g3A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7EDF8410A2; Sat, 13 Nov 2021 11:19:33 -0300 (-03)
Date:   Sat, 13 Nov 2021 11:19:33 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     Borislav Petkov <bp@suse.de>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [FYI][PATCH 1/1] tools arch x86: Sync the msr-index.h copy with the
 kernel sources
Message-ID: <YY/Jdb6on7swsn+C@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To pick up the changes in:

  dae1bd58389615d4 ("x86/msr-index: Add MSRs for XFD")

Addressing these tools/perf build warnings:

    diff -u tools/arch/x86/include/asm/msr-index.h arch/x86/include/asm/msr-index.h
    Warning: Kernel ABI header at 'tools/arch/x86/include/asm/msr-index.h' differs from latest version at 'arch/x86/include/asm/msr-index.h'

That makes the beautification scripts to pick some new entries:

  $ diff -u tools/arch/x86/include/asm/msr-index.h arch/x86/include/asm/msr-index.h
  --- tools/arch/x86/include/asm/msr-index.h	2021-07-15 16:17:01.819817827 -0300
  +++ arch/x86/include/asm/msr-index.h	2021-11-06 15:49:33.738517311 -0300
  @@ -625,6 +625,8 @@

   #define MSR_IA32_BNDCFGS_RSVD		0x00000ffc

  +#define MSR_IA32_XFD			0x000001c4
  +#define MSR_IA32_XFD_ERR		0x000001c5
   #define MSR_IA32_XSS			0x00000da0

   #define MSR_IA32_APICBASE		0x0000001b
  $ tools/perf/trace/beauty/tracepoints/x86_msr.sh > /tmp/before
  $ cp arch/x86/include/asm/msr-index.h tools/arch/x86/include/asm/msr-index.h
  $ tools/perf/trace/beauty/tracepoints/x86_msr.sh > /tmp/after
  $ diff -u /tmp/before /tmp/after
  --- /tmp/before	2021-11-13 11:10:39.964201505 -0300
  +++ /tmp/after	2021-11-13 11:10:47.902410873 -0300
  @@ -93,6 +93,8 @@
   	[0x000001b0] = "IA32_ENERGY_PERF_BIAS",
   	[0x000001b1] = "IA32_PACKAGE_THERM_STATUS",
   	[0x000001b2] = "IA32_PACKAGE_THERM_INTERRUPT",
  +	[0x000001c4] = "IA32_XFD",
  +	[0x000001c5] = "IA32_XFD_ERR",
   	[0x000001c8] = "LBR_SELECT",
   	[0x000001c9] = "LBR_TOS",
   	[0x000001d9] = "IA32_DEBUGCTLMSR",
  $

And this gets rebuilt:

  CC       /tmp/build/perf/trace/beauty/tracepoints/x86_msr.o
  INSTALL  trace_plugins
  LD       /tmp/build/perf/trace/beauty/tracepoints/perf-in.o
  LD       /tmp/build/perf/trace/beauty/perf-in.o
  LD       /tmp/build/perf/perf-in.o
  LINK     /tmp/build/perf/perf

Now one can trace systemwide asking to see backtraces to where those
MSRs are being read/written with:

  # perf trace -e msr:*_msr/max-stack=32/ --filter="msr==IA32_XFD || msr==IA32_XFD_ERR"
  ^C#
  #

If we use -v (verbose mode) we can see what it does behind the scenes:

  # perf trace -v -e msr:*_msr/max-stack=32/ --filter="msr==IA32_XFD || msr==IA32_XFD_ERR"
  <SNIP>
  New filter for msr:read_msr: (msr==0x1c4 || msr==0x1c5) && (common_pid != 4448951 && common_pid != 8781)
  New filter for msr:write_msr: (msr==0x1c4 || msr==0x1c5) && (common_pid != 4448951 && common_pid != 8781)
  <SNIP>
  ^C#

Example with a frequent msr:

  # perf trace -v -e msr:*_msr/max-stack=32/ --filter="msr==IA32_SPEC_CTRL" --max-events 2
  Using CPUID AuthenticAMD-25-21-0
  0x48
  New filter for msr:read_msr: (msr==0x48) && (common_pid != 3738351 && common_pid != 3564)
  0x48
  New filter for msr:write_msr: (msr==0x48) && (common_pid != 3738351 && common_pid != 3564)
  mmap size 528384B
  Looking at the vmlinux_path (8 entries long)
  symsrc__init: build id mismatch for vmlinux.
  Using /proc/kcore for kernel data
  Using /proc/kallsyms for symbols
       0.000 pipewire/2479 msr:write_msr(msr: IA32_SPEC_CTRL, val: 6)
                                         do_trace_write_msr ([kernel.kallsyms])
                                         do_trace_write_msr ([kernel.kallsyms])
                                         __switch_to_xtra ([kernel.kallsyms])
                                         __switch_to ([kernel.kallsyms])
                                         __schedule ([kernel.kallsyms])
                                         schedule ([kernel.kallsyms])
                                         schedule_hrtimeout_range_clock ([kernel.kallsyms])
                                         do_epoll_wait ([kernel.kallsyms])
                                         __x64_sys_epoll_wait ([kernel.kallsyms])
                                         do_syscall_64 ([kernel.kallsyms])
                                         entry_SYSCALL_64_after_hwframe ([kernel.kallsyms])
                                         epoll_wait (/usr/lib64/libc-2.33.so)
                                         [0x76c4] (/usr/lib64/spa-0.2/support/libspa-support.so)
                                         [0x4cf0] (/usr/lib64/spa-0.2/support/libspa-support.so)
       0.027 :0/0 msr:write_msr(msr: IA32_SPEC_CTRL, val: 2)
                                         do_trace_write_msr ([kernel.kallsyms])
                                         do_trace_write_msr ([kernel.kallsyms])
                                         __switch_to_xtra ([kernel.kallsyms])
                                         __switch_to ([kernel.kallsyms])
                                         __schedule ([kernel.kallsyms])
                                         schedule_idle ([kernel.kallsyms])
                                         do_idle ([kernel.kallsyms])
                                         cpu_startup_entry ([kernel.kallsyms])
                                         start_kernel ([kernel.kallsyms])
                                         secondary_startup_64_no_verify ([kernel.kallsyms])
  #

Cc: Borislav Petkov <bp@suse.de>
Cc: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/asm/msr-index.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/arch/x86/include/asm/msr-index.h b/tools/arch/x86/include/asm/msr-index.h
index a7c413432b33d85a..01e2650b958591e0 100644
--- a/tools/arch/x86/include/asm/msr-index.h
+++ b/tools/arch/x86/include/asm/msr-index.h
@@ -625,6 +625,8 @@
 
 #define MSR_IA32_BNDCFGS_RSVD		0x00000ffc
 
+#define MSR_IA32_XFD			0x000001c4
+#define MSR_IA32_XFD_ERR		0x000001c5
 #define MSR_IA32_XSS			0x00000da0
 
 #define MSR_IA32_APICBASE		0x0000001b
-- 
2.31.1

