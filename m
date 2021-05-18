Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 999A138805B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 21:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345973AbhERTPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 15:15:11 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40973 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241036AbhERTPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 15:15:04 -0400
Received: from tazenda.hos.anvin.org ([IPv6:2601:646:8602:8be0:7285:c2ff:fefb:fd4])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 14IJDDRm4008171
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 18 May 2021 12:13:22 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 14IJDDRm4008171
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021042801; t=1621365210;
        bh=IkUrDnceIqhS7bpGhoBC0Vs+gxODxl4zuCvI4QlIfko=;
        h=From:To:Cc:Subject:Date:From;
        b=Uq6AZPtPn1+A9SCuD4XC8s2nlmNeuPV/t/+tB+E3gZ8UwFVaR8ZytsNLtp70csful
         UxkJP28s6nGUBXaQbYOUl60VDXb0X6CouCdeNM8Q4CQYKFWZ8wjTnlT/aHEzs0s8R+
         Ps/ad2hon/XSawDBMzpTUGoqvWxsrEZxD3xogpyNahXxsg+JJAsXO9Fnac4jlcJN/o
         MIOFwN+uo4Rm2l/zgBGOiHo9boeMnoAwgLfYW6U1lXlmvio69H43DsqLZlQG94TmP3
         SrW7NjYI0PqAAPqxTaiNcBrZh1wQ+wSHV46JRBOsiUQCCOoaXjUUvQi1L9ftPUJWay
         FFoQIvKgD6daQ==
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 0/6] x86/syscall: use int for x86-64 system calls
Date:   Tue, 18 May 2021 12:12:57 -0700
Message-Id: <20210518191303.4135296-1-hpa@zytor.com>
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
syscall_numbering_64 kernel selftest fails if run under ptrace for
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

4. Updates and extends the syscall_numbering_64 selftest, including
   testing the system call numbering when running under ptrace.
   
Changes from v3:

* Reorganize the patchset to have the selftest change first.
* Add tests running under ptrace to selftest.

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
 arch/x86/entry/common.c                         |  93 +++--
 arch/x86/entry/entry_64.S                       |   2 +-
 arch/x86/include/asm/syscall.h                  |   2 +-
 tools/testing/selftests/x86/syscall_numbering.c | 488 +++++++++++++++++++++---
 4 files changed, 508 insertions(+), 77 deletions(-)
