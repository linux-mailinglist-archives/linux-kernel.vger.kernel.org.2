Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44397379738
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 20:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233325AbhEJSzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 14:55:02 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45441 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232977AbhEJSyr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 14:54:47 -0400
Received: from tazenda.hos.anvin.org ([IPv6:2601:646:8602:8be0:7285:c2ff:fefb:fd4])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 14AIrNlc2459085
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 10 May 2021 11:53:29 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 14AIrNlc2459085
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021042801; t=1620672810;
        bh=QkaTTiwvtH2PVWgSD8V19SdiOHceCecPmtWF6NhrBQU=;
        h=From:To:Cc:Subject:Date:From;
        b=HGmFFKvPiD3EIBGL4wW0O6x1YTbmLxP75Ggbe42U/gH3DKA70Q0O8XR/EhDEHuJhq
         FAf+dkwWcqCdIglniUZg32hvekZBjhvhR75AqPi+nG15oaJ6sZ+yo2bjpmEnYUAASw
         MSwKzaUMwB8VasQDXdIY/lES0Qw38jo6Yry/rRp6Lo5GLMb1mEj81oVLpbXt2BsXnn
         SXYL+iI5LSxbCEulAD+RXW8LWnRhvWFb/rC5dIlLaEBAf5LhQa0cLUoW3fc9Wciy2B
         XngH0oJdq4ZhWCNQviWvIomGn+FVTaNdhvRokJSZtRNU9+ySgW73OxWQAWcsEgTjt0
         GkQ62Se9dmJHA==
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RFC v2 PATCH 0/6] x86/entry: cleanups and consistent syscall number handling
Date:   Mon, 10 May 2021 11:53:09 -0700
Message-Id: <20210510185316.3307264-1-hpa@zytor.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "H. Peter Anvin (Intel)" <hpa@zytor.com>

This patchset:

1. Cleans up some duplications between <entry/calling.h> and <asm/ptrace-abi.h>.

2. Swaps the arguments to do_syscall_64() for consistency *and* speed.

3. Adds the maximum number of flags to MSR_SYSCALL_MASK; the previous
   is more of a minimum. The more flags that are masked, the less the
   likelihood of a control leak into the kernel.

4. Consistently treat the system call number as a signed int. This is
   what syscall_get_nr() already does, and therefore what all
   architecture-independent code (e.g. seccomp) already expects.

5. As per the defined semantics of syscall_get_nr(), only the value -1
   is defined as a non-system call, so comparing >= 0 is
   incorrect. Change to != -1.

6. Call sys_ni_syscall() for system calls which are out of range
   except for -1, which is used by ptrace and seccomp as a "skip
   system call" marker) just as for system call numbers that
   correspond to holes in the table.

7. In <entry/calling.h>, factor the PUSH_AND_CLEAR_REGS macro into
   separate PUSH_REGS and CLEAR_REGS macros which can be used
   separately if desired. This will be used by the FRED entry code at
   a later date.

Changes from v1:

* Only -1 should be a non-system call per the cross-architectural
  definition of sys_ni_syscall().
* Fix/improve patch descriptions.

--- 
 arch/x86/entry/calling.h       | 45 ++++++--------------------
 arch/x86/entry/common.c        | 71 ++++++++++++++++++++++++++++--------------
 arch/x86/entry/entry_64.S      |  4 +--
 arch/x86/include/asm/syscall.h | 13 ++++----
 arch/x86/kernel/cpu/common.c   | 12 +++++--
 arch/x86/kernel/head_64.S      |  6 ++--
 6 files changed, 77 insertions(+), 74 deletions(-)
