Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51B48379654
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 19:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233159AbhEJRrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 13:47:13 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38811 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232943AbhEJRqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 13:46:45 -0400
Received: from tazenda.hos.anvin.org ([IPv6:2601:646:8602:8be0:7285:c2ff:fefb:fd4])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 14AHjGkA2449170
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 10 May 2021 10:45:25 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 14AHjGkA2449170
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021042801; t=1620668726;
        bh=ySA6dgUNhjeCqg7PzMzFnUh+og6c9bflJRjpoTNwYY8=;
        h=From:To:Cc:Subject:Date:From;
        b=gcVhW3dbTMACvWXtQYvIyeTyaEWGjl/4IVMqp5ThKGUlZ1OIm7sprC1kWAuJxli6q
         0ZKJZp+D3yVbvN9mCeppKaOHpCAHkVl6pv9qC1KT/uYKqWUyqjSSAsXjjbkv0iw/XR
         gISesil9GzdQcqreHqJyiwZJ4r9Bd6Gb6mkf4/j8jPBI6xtrGGqJElCsnP9BdJwc4S
         k0psSqfYkqc+KeIR3XZS1y3QO56jIsm9tYCxTTRRy+tY2/ciDEQWMIT3W6mgDxsRrm
         bDWTIVibhZmcZLLwijQVc+4QNdsS9w2Z5gErLqV5E0MS3T4Un0dPd6UEarxGrcScOq
         TBLRVkl8asF8Q==
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 0/6] x86/entry: cleanups and consistent syscall number handling
Date:   Mon, 10 May 2021 10:45:03 -0700
Message-Id: <20210510174509.3039991-1-hpa@zytor.com>
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

5. Call sys_ni_syscall() for system calls which are out of range but
   still positive (negative system calls are used by ptrace and
   seccomp as a "skip system call" marker) just as for system call
   numbers that correspond to holes in the table.

6. In <entry/calling.h>, factor the PUSH_AND_CLEAR_REGS macro into
   separate PUSH_REGS and CLEAR_REGS macros which can be used
   separately if desired. This will be used by the FRED entry code at
   a later date.

--- 
 arch/x86/entry/calling.h       | 45 ++++++--------------------
 arch/x86/entry/common.c        | 71 ++++++++++++++++++++++++++++--------------
 arch/x86/entry/entry_64.S      |  4 +--
 arch/x86/include/asm/syscall.h | 13 ++++----
 arch/x86/kernel/cpu/common.c   | 12 +++++--
 arch/x86/kernel/head_64.S      |  6 ++--
 6 files changed, 77 insertions(+), 74 deletions(-)
