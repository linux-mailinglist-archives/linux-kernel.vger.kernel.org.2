Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94925456ED0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 13:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234943AbhKSMbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 07:31:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:60504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232080AbhKSMbU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 07:31:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2FC4161547;
        Fri, 19 Nov 2021 12:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637324898;
        bh=agA9Tn8VqlHvqDZ4drpTtsqO3v8HrYj082J9JIrbzG0=;
        h=Date:From:To:Cc:Subject:From;
        b=BTUzC9WE9NwBcXPs3sQIJ2ZCHYmqnhpzHjGqzm3gFlKzFPM7WndkGhfkeOSc1mVGR
         jlT0ozqgm9tsOu3Q86xdNVWJS55wcXgDTALinCq1kjD8G/XLz4SOsKlFU00C2ytR9H
         3Qg4r6K2BLHMzPgXrh/i+iE6IpLcStJvYsiLc2cDeAXPLm+5rySSeaLGWV6twRjezR
         c7sp71EEW1vx23kqumS2fLNw5niKKxzgVSN5uHcQC1p2G9GP/eLM5kf/uoMfIkkpzp
         nZKiPbFJxx/8Qrun97CRd5D76FtAJMzJxh2f6iss+DrF3ramLfMMgAovyNEyqd8OtW
         0nthe6jGmTK4w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4735F40002; Fri, 19 Nov 2021 09:28:15 -0300 (-03)
Date:   Fri, 19 Nov 2021 09:28:15 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 'perf stat --bpf-counters test' failures
Message-ID: <YZeYX305gA0ut9N8@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


After I updated to fedora 35 I started seeing the errors below,
it may well not be related to that, maybe something on libbpf, haven't
investigated, have you seen this?

⬢[acme@toolbox perf]$ perf -vv
perf version 5.16.rc1.gfa2b5229b222
                 dwarf: [ on  ]  # HAVE_DWARF_SUPPORT
    dwarf_getlocations: [ on  ]  # HAVE_DWARF_GETLOCATIONS_SUPPORT
                 glibc: [ on  ]  # HAVE_GLIBC_SUPPORT
         syscall_table: [ on  ]  # HAVE_SYSCALL_TABLE_SUPPORT
                libbfd: [ on  ]  # HAVE_LIBBFD_SUPPORT
                libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
               libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
               libperl: [ on  ]  # HAVE_LIBPERL_SUPPORT
             libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
              libslang: [ on  ]  # HAVE_SLANG_SUPPORT
             libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
             libunwind: [ on  ]  # HAVE_LIBUNWIND_SUPPORT
    libdw-dwarf-unwind: [ on  ]  # HAVE_DWARF_SUPPORT
                  zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
                  lzma: [ on  ]  # HAVE_LZMA_SUPPORT
             get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT
                   bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
                   aio: [ on  ]  # HAVE_AIO_SUPPORT
                  zstd: [ on  ]  # HAVE_ZSTD_SUPPORT
               libpfm4: [ OFF ]  # HAVE_LIBPFM
⬢[acme@toolbox perf]$

This is with what I have now in my perf/urgent branch, the csets there
aren't related:

⬢[acme@toolbox perf]$ git log --oneline torvalds/master..
b194c9cd09dd98af (HEAD -> perf/urgent, quaco/perf/urgent, acme/tmp.perf/urgent, acme/perf/urgent) perf evsel: Fix memory leaks relating to unit
d9fc706108c15f8b perf report: Fix memory leaks around perf_tip()
0ca1f534a776cc7d perf hist: Fix memory leak of a perf_hpp_fmt
8b8dcc3720d57d88 tools headers UAPI: Sync MIPS syscall table file changed by new futex_waitv syscall
e8c04ea0fef5731d tools build: Fix removal of feature-sync-compare-and-swap feature detection
9e1a8d9f683260d5 perf inject: Fix ARM SPE handling
92723ea0f11d9249 perf bench: Fix two memory leaks detected with ASan
cb5a63feae2d963c perf test sample-parsing: Fix branch_stack entry endianness check
162b944598344fd7 tools headers UAPI: Sync x86's asm/kvm.h with the kernel sources
db4b284029099224 perf sort: Fix the 'p_stage_cyc' sort key behavior
4d03c75363eeca86 perf sort: Fix the 'ins_lat' sort key behavior
784e8adda4cdb3e2 perf sort: Fix the 'weight' sort key behavior
70f9c9b2df1dd12c perf tools: Set COMPAT_NEED_REALLOCARRAY for CONFIG_AUXTRACE=1
ccb05590c4325ce5 perf tests wp: Remove unused functions on s390
346e91998cba46b6 tools headers UAPI: Sync linux/kvm.h with the kernel sources
b075c1d81e7d0e96 tools headers cpufeatures: Sync with the kernel sources
⬢[acme@toolbox perf]$

- Arnaldo

[acme@quaco perf]$ uname -a
Linux quaco 5.14.17-301.fc35.x86_64 #1 SMP Mon Nov 8 13:57:43 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux

91: perf stat --bpf-counters test                                   :RRRRRRRRRRRRR FAILED!
92: Check Arm CoreSight trace data recording and synthesized samples: Skip
93: Check Arm SPE trace data recording and synthesized samples      : Skip
94: Check open filename arg using perf trace + vfs_getname          : Ok
[root@quaco ~]# perf test 91
91: perf stat --bpf-counters test                                   :RRRRRRRRRRRRR FAILED!
[root@quaco ~]# perf test 91
91: perf stat --bpf-counters test                                   :RRRRRRRRRRRRR FAILED!
[root@quaco ~]# perf test 91
91: perf stat --bpf-counters test                                   :RRRRRRRRRRRR FAILED!
[root@quaco ~]# perf test 91
91: perf stat --bpf-counters test                                   :RRRRRRRRRRRRRRRRRR Ok
[root@quaco ~]# perf test 91
91: perf stat --bpf-counters test                                   :RRRRRRRRR FAILED!
[root@quaco ~]# perf test 91
91: perf stat --bpf-counters test                                   :RRRRRRRRRRR Ok
[root@quaco ~]# perf test 91
91: perf stat --bpf-counters test                                   :RRRRRRRRRRRRRRR Ok
[root@quaco ~]# uname -a
Linux quaco 5.14.17-301.fc35.x86_64 #1 SMP Mon Nov 8 13:57:43 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
[root@quaco ~]# set -o vi
[root@quaco ~]# perf test -v 91
91: perf stat --bpf-counters test                                   :
--- start ---
test child forked, pid 30079
RRRRRRRRRRRRRRRRRThe difference between 31599305 and 36265639 are greater than 10%.
test child finished with -1
---- end ----
perf stat --bpf-counters test: FAILED!
[root@quaco ~]# perf test -v 91
91: perf stat --bpf-counters test                                   :
--- start ---
test child forked, pid 30170
RRRRRRRRRRRRRRRRRRRRRRRRThe difference between 33311934 and 36973889 are greater than 10%.
test child finished with -1
---- end ----
perf stat --bpf-counters test: FAILED!
[root@quaco ~]# perf test -v 91
91: perf stat --bpf-counters test                                   :
--- start ---
test child forked, pid 30257
RRRRRRRRRRRRRRRRRThe difference between 31420157 and 36680527 are greater than 10%.
test child finished with -1
---- end ----
perf stat --bpf-counters test: FAILED!
[root@quaco ~]# perf test -v 91
91: perf stat --bpf-counters test                                   :
--- start ---
test child forked, pid 30341
RRRRRRRRRRRRRRRRRRRThe difference between 32451720 and 36750342 are greater than 10%.
test child finished with -1
---- end ----
perf stat --bpf-counters test: FAILED!
[root@quaco ~]# perf test -v 91
91: perf stat --bpf-counters test                                   :
--- start ---
test child forked, pid 30433
RRRRRRRRRRRRRRRRRRtest child finished with 0
---- end ----
perf stat --bpf-counters test: Ok
[root@quaco ~]#
