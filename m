Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6EA3814D9
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 03:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234693AbhEOBMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 21:12:05 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44069 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230092AbhEOBME (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 21:12:04 -0400
Received: from tazenda.hos.anvin.org ([IPv6:2601:646:8602:8be0:7285:c2ff:fefb:fd4])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 14F1ANfd3208415
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 14 May 2021 18:10:32 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 14F1ANfd3208415
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021042801; t=1621041033;
        bh=iomNqm/SwKflybdT1ySu4OzxSInNQ/MSJb2jPJz2RJQ=;
        h=From:To:Cc:Subject:Date:From;
        b=Lm/mFmVy9UzGqx0RcUy87d2rWdjiww7dG6She8Aph6J/S3gYBN9RfuVWzM0GVn6jj
         O02PrQ9O7HD5udfQfo19oB1KQw9L1z0VHM4dLvaUsam52ThgnOuIEn0F2SgqvD4FyG
         mGOBLwM1+vLyjSIMkv2viYgp7lEuXCy1GVyViIfJDGnhQGGALhKopmacguEQyH4k2a
         2/QlE+X+g8LNy6GnCH4Kfrfc+ENhazgQUB+nN+hle+jRwIvtfucDGyt6W+BCiaW04P
         poKI458l1j7sTYYiDJRaE+/7vnOxUKxQbaNS/ipcpg/XjM5O8ZdTkqWNTTdi3WoGH4
         RE8ITBM5pL9ZQ==
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RFC v3 PATCH 0/4] x86/syscall: use int for x86-64 system calls
Date:   Fri, 14 May 2021 18:10:11 -0700
Message-Id: <20210515011015.2707542-1-hpa@zytor.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "H. Peter Anvin (Intel)" <hpa@zytor.com>

This patchset addresses several inconsistencies in the handling of
system call numbers in x86-64 (and x32).

Right now, *some* code will treat e.g. 0x00000001_00000001 as a system
call and some will not. Some of the code, notably in ptrace and
seccomp, will treat 0x00000001_ffffffff as a system call and some will
not.

Furthermore, right now, e.g. 335 for x86-64 will force the exit code
to be set to -ENOSYS even if poked by ptrace, but 548 will not,
because there is an observable difference between an out of range
system call and a system call number that falls outside the range of
the tables.

Both of these issues are visible to the user; for example the
syscall_numbering_64 kernel selftest fails if run under strace for
this reason (system calls succeed with the high bits set, whereas they
fail when not being traced.)

The architecture independent code in Linux expects "int" for the
system call number, per the API documented, but not implemented, in
<asm-generic/syscalls.h>: system call numbers are expected to be
"int", with -1 as the only non-system-call sentinel.

Treating the same data in multiple ways in different context is at the
very best confusing, but it also has the potential to cause security
problems (no such security problems are known at this time, however.)

This is an ABI change, but it is in fact a return to the original
x86-64 ABI: the original assembly entry code would zero-extend the
system call number passed and only the bottom 32 bits were examined.

1. Consistently treat the system call number as a signed int. This is
   what syscall_get_nr() already does, and therefore what all
   architecture-independent code (e.g. seccomp) already expects.

2. As per the defined semantics of syscall_get_nr(), only the value -1
   is defined as a non-system call, so comparing >= 0 is
   incorrect. Change to != -1.

3. Call sys_ni_syscall() for system calls which are out of range
   except for -1, which is used by ptrace and seccomp as a "skip
   system call" marker) just as for system call numbers that
   correspond to holes in the table.

4. Updates and extends the syscall_numbering_64 selftest.


Changes from v2:

* Factor out and split what was a single patch in the v2 patchset; the
  rest of the patches have already been applied.
* Fix the syscall_numbering_64 selftest to match the definition
  changes, make its output more informative, and extend it to more
  tests. Avoid using the glibc syscall() wrapper to make sure we test
  what we think we are testing.
* Better documentation of the changes.

Changes from v1:

* Only -1 should be a non-system call per the cross-architectural
  definition of sys_ni_syscall().
* Fix/improve patch descriptions.

--- 
 arch/x86/entry/common.c                         |  93 +++++---
 arch/x86/entry/entry_64.S                       |   2 +-
 arch/x86/include/asm/syscall.h                  |   2 +-
 tools/testing/selftests/x86/syscall_numbering.c | 274 +++++++++++++++++++-----
 4 files changed, 291 insertions(+), 80 deletions(-)
