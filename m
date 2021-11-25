Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9373D45E1CB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 21:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357051AbhKYUru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 15:47:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:48324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237436AbhKYUpt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 15:45:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B342B6104F;
        Thu, 25 Nov 2021 20:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637872957;
        bh=amR8tb2SzcBDz8KxsW8hK2Vsnwqpnwq5zTmXgdQLQMc=;
        h=Date:From:To:Cc:Subject:From;
        b=PMg013MclxOrO0oPRBTgymV3fYnPG8IhfzcGwl+0saRahwX2HYXuUQJwBxvGpD14G
         NdDXHB6bWbbhQKoCzGbq2sqIGYTE9UxDjCem5QReAK74X0pXACRCd81dhLh7TjwciI
         6YuuPC/OcqAfFVnldTquP2O+jSrS2ZaDMW6Gom7LFxlWy08P5SwTU3VivQrlFzDAcD
         CPPNk0Ab/wUAwCCsqvAhWdOsNdK5xOD017seR2KM+d9GSsdkMKUf3nVQjJfj1StQNv
         Tp0P4FGGoWKCjKra8JLZ5J1TmgkdN9Na3hE3HSfnvrA7e0IqowKnVzXKBdMY5CBHLg
         xF1Fet1c1Mr/A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 18B0540002; Thu, 25 Nov 2021 17:42:33 -0300 (-03)
Date:   Thu, 25 Nov 2021 17:42:33 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@collabora.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [FYI][PATCH 1/1] tools headers UAPI: Sync powerpc syscall table file
 changed by new futex_waitv syscall
Message-ID: <YZ/1OU9mJuyS2HMa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To pick the changes in this cset:

  a0eb2da92b715d0c ("futex: Wireup futex_waitv syscall")

That add support for this new syscall in tools such as 'perf trace'.

For instance, this is now possible (adapted from the x86_64 test output):

  # perf trace -e futex_waitv
  ^C#
  # perf trace -v -e futex_waitv
  event qualifier tracepoint filter: (common_pid != 807333 && common_pid != 3564) && (id == 449)
  ^C#
  # perf trace -v -e futex* --max-events 10
  event qualifier tracepoint filter: (common_pid != 812168 && common_pid != 3564) && (id == 221 || id == 449)
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

  $ grep futex tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
  221	32	futex				sys_futex_time32
  221	64	futex				sys_futex
  221	spu	futex				sys_futex
  422	32	futex_time64			sys_futex			sys_futex
  449	common  futex_waitv                     sys_futex_waitv
  $

This addresses this perf build warnings:

  Warning: Kernel ABI header at 'tools/perf/arch/s390/entry/syscalls/syscall.tbl' differs from latest version at 'arch/s390/kernel/syscalls/syscall.tbl'
  diff -u tools/perf/arch/s390/entry/syscalls/syscall.tbl arch/s390/kernel/syscalls/syscall.tbl

Cc: Andr� Almeida <andrealmeid@collabora.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/powerpc/entry/syscalls/syscall.tbl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
index 7bef917cc84e6499..15109af9d0754d5f 100644
--- a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
@@ -528,3 +528,4 @@
 446	common	landlock_restrict_self		sys_landlock_restrict_self
 # 447 reserved for memfd_secret
 448	common	process_mrelease		sys_process_mrelease
+449	common  futex_waitv                     sys_futex_waitv
-- 
2.31.1

