Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A32B444E8DC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 15:29:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235309AbhKLOcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 09:32:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:53742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235314AbhKLOc1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 09:32:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 02E1660F45;
        Fri, 12 Nov 2021 14:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636727377;
        bh=BqMcKNwytUImDzzMWif2u3ije6TBIHnqqJdsyzQVSnk=;
        h=Date:From:To:Cc:Subject:From;
        b=NajOKHu/Ed3hetUO6Q/t6LbJdbPn7UsD99Zwcovel4Uvu7wtjkuz4X8kNHY7FOZjo
         s6uZmYHOGmdAM7EICfevhWkm0K0cr7zWQvR9R0hYt33BBGReZN1Xw5siSGR6naVQgZ
         fi9Mtnj9fOqH9z7FKL6jU3PmZTS6pVmnwLFEkRhqUzw4Gx0p0tL90bErboL0pua9kw
         4Y+7KksRd+bS2otKlzo8WgYb4yPjC8had2a4a41SlpEWMAlD/3w9FgmRhZPOAqFVT5
         rS7LHdSbLbERJNxTjrj+Dj+5h6DpOSHdGnsIdspgU2cVfPcbD3ebjF379rEf0/mLgS
         PzG5aWvMeptzw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2CE5B410A1; Fri, 12 Nov 2021 11:29:33 -0300 (-03)
Date:   Fri, 12 Nov 2021 11:29:33 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@collabora.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [FYI][PATCH 1/1] tools headers UAPI: Sync files changed by new
 futex_waitv syscall
Message-ID: <YY56Tdy3ymJ8slh3@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To pick the changes in these csets:

  039c0ec9bb77446d ("futex,x86: Wire up sys_futex_waitv()")
  bf69bad38cf63d98 ("futex: Implement sys_futex_waitv()")

That add support for this new syscall in tools such as 'perf trace'.

For instance, this is now possible:

  # perf trace -e futex_waitv
  ^C#
  # perf trace -v -e futex_waitv
  Using CPUID AuthenticAMD-25-21-0
  event qualifier tracepoint filter: (common_pid != 807333 && common_pid != 3564) && (id == 449)
  mmap size 528384B
  ^C#
  # perf trace -v -e futex* --max-events 10
  Using CPUID AuthenticAMD-25-21-0
  event qualifier tracepoint filter: (common_pid != 812168 && common_pid != 3564) && (id == 202 || id == 449)
  mmap size 528384B
           ? (         ): Timer/219310  ... [continued]: futex())                                            = -1 ETIMEDOUT (Connection timed out)
       0.012 ( 0.002 ms): Timer/219310 futex(uaddr: 0x7fd0b152d3c8, op: WAKE|PRIVATE_FLAG, val: 1)           = 0
       0.024 ( 0.060 ms): Timer/219310 futex(uaddr: 0x7fd0b152d420, op: WAIT_BITSET|PRIVATE_FLAG, utime: 0x7fd0b1657840, val3: MATCH_ANY) = 0
       0.086 ( 0.001 ms): Timer/219310 futex(uaddr: 0x7fd0b152d3c8, op: WAKE|PRIVATE_FLAG, val: 1)           = 0
       0.088 (         ): Timer/219310 futex(uaddr: 0x7fd0b152d424, op: WAIT_BITSET|PRIVATE_FLAG, utime: 0x7fd0b1657840, val3: MATCH_ANY) ...
       0.075 ( 0.005 ms): Web Content/219299 futex(uaddr: 0x7fd0b152d420, op: WAKE|PRIVATE_FLAG, val: 1)     = 1
       0.169 ( 0.004 ms): Web Content/219299 futex(uaddr: 0x7fd0b152d424, op: WAKE|PRIVATE_FLAG, val: 1)     = 1
       0.088 ( 0.089 ms): Timer/219310  ... [continued]: futex())                                            = 0
       0.179 ( 0.001 ms): Timer/219310 futex(uaddr: 0x7fd0b152d3c8, op: WAKE|PRIVATE_FLAG, val: 1)           = 0
       0.181 (         ): Timer/219310 futex(uaddr: 0x7fd0b152d420, op: WAIT_BITSET|PRIVATE_FLAG, utime: 0x7fd0b1657840, val3: MATCH_ANY) ...
  #

That is the filter expression attached to the raw_syscalls:sys_{enter,exit}
tracepoints.

  $ grep futex_waitv tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
  449	common	futex_waitv		sys_futex_waitv
  $

This addresses these perf build warnings:

  Warning: Kernel ABI header at 'tools/include/uapi/asm-generic/unistd.h' differs from latest version at 'include/uapi/asm-generic/unistd.h'
  diff -u tools/include/uapi/asm-generic/unistd.h include/uapi/asm-generic/unistd.h
  Warning: Kernel ABI header at 'tools/perf/arch/x86/entry/syscalls/syscall_64.tbl' differs from latest version at 'arch/x86/entry/syscalls/syscall_64.tbl'
  diff -u tools/perf/arch/x86/entry/syscalls/syscall_64.tbl arch/x86/entry/syscalls/syscall_64.tbl

Cc: André Almeida <andrealmeid@collabora.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/asm-generic/unistd.h           | 5 ++++-
 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/asm-generic/unistd.h b/tools/include/uapi/asm-generic/unistd.h
index 1c5fb86d455aba95..4557a8b6086f4ffe 100644
--- a/tools/include/uapi/asm-generic/unistd.h
+++ b/tools/include/uapi/asm-generic/unistd.h
@@ -880,8 +880,11 @@ __SYSCALL(__NR_memfd_secret, sys_memfd_secret)
 #define __NR_process_mrelease 448
 __SYSCALL(__NR_process_mrelease, sys_process_mrelease)
 
+#define __NR_futex_waitv 449
+__SYSCALL(__NR_futex_waitv, sys_futex_waitv)
+
 #undef __NR_syscalls
-#define __NR_syscalls 449
+#define __NR_syscalls 450
 
 /*
  * 32 bit systems traditionally used different
diff --git a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
index 18b5500ea8bfd5fc..fe8f8dd157b4d49c 100644
--- a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
@@ -370,6 +370,7 @@
 446	common	landlock_restrict_self	sys_landlock_restrict_self
 447	common	memfd_secret		sys_memfd_secret
 448	common	process_mrelease	sys_process_mrelease
+449	common	futex_waitv		sys_futex_waitv
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
-- 
2.31.1

