Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4FFC38988C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 23:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhESVX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 17:23:59 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56007 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229507AbhESVXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 17:23:42 -0400
Received: from tazenda.hos.anvin.org ([IPv6:2601:646:8602:8be0:7285:c2ff:fefb:fd4])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 14JLM1EY4187848
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 19 May 2021 14:22:09 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 14JLM1EY4187848
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021042801; t=1621459329;
        bh=4l002lPeCJxA24U0l1PAxB3iiW8KL6MbuNYo96oS06U=;
        h=From:To:Cc:Subject:Date:From;
        b=E7fjQBbdcDLparjPAaQZFIiHe3hrjihNTfy140oXw0V68xvYqpynwWIR0ClMvgcXv
         RZC9A5n2HCmy9wUa79W6owanU2zd0MQwynfILDywvAbCvtrJgA0ScODRoMTTcL6lrZ
         QLJ71Nt4C9XtWnIMX+FRs5wvO9zl7ceatqwq9KT0mbF1IiDnqnJxJH/zJObwKUKI6x
         WfoF6zK+zRG4EblOmBtjrBqP08l/cQmJ/0F/EnKYKF+MRPToUREaeFA5gQssKidMCO
         Ez372hOKVAd03TGjBvlRDRTxdvLnqWnsRBHoLRGDjMUc3YNdXIzQcMPVSOcaGrCivA
         g4RPY/kiVlG7g==
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/8] x86/irq: trap and interrupt cleanups
Date:   Wed, 19 May 2021 14:21:46 -0700
Message-Id: <20210519212154.511983-1-hpa@zytor.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "H. Peter Anvin (Intel)" <hpa@zytor.com>

A collection of trap/interrupt-related patches, almost all
cleanups. It does remove a modest amount of code (39 lines.) The only
patches that should have any possible effect at all are:

7/8 - x86/irq: WARN_ONCE() if irq_move_cleanup is called on a pending interrupt

	This condition is believed to be impossible after many
	improvements to the IRQ vector allocation code since this
	function was written. Per discussion with tglx, add a
	WARN_ONCE() if this happens as a first step towards excising
	this hack.

8/8 - x86/irq: merge and functonalize common code in DECLARE/DEFINE_IDTENTRY_*

	This patch reverses kvm_set_cpu_l1tf_flush_l1d() and
	__irq_enter_raw() in DEFINE_IDTENTRY_SYSVEC_SIMPLE() in order
	to be able to unify the code with DEFINE_IDTENTRY_SYSVEC().

	This replaces a lot of macros with inline functions, which
	required some amount of adjusting types in various places,
	they should have no effect.
	
	The reason for unification is mainly to avoid the possibility
	of inadvertent divergence rather than the rather modest amount
	of code, but it does remove 25 lines of code.

Changes from v2:

* 5/8: Use an on-stack rather than a static variable.
* 7/8: Correct the sequence of needed changes in the patch description.

--- 
 1/8 x86/traps: add X86_NR_HW_TRAPS to <asm/trapnr.h>
 2/8 x86/irqvector: add NR_EXTERNAL_VECTORS and NR_SYSTEM_VECTORS
 3/8 x86/irq: remove unused vectors from <asm/irq_vectors.h>
 4/8 x86/idt: remove address argument to idt_invalidate()
 5/8 x86/desc: add native_[ig]dt_invalidate() to <asm/desc.h>
 6/8 x86/kexec: set_[gi]dt() -> native_[gi]dt_invalidate() in machine_kexec_*.c
 7/8 x86/irq: WARN_ONCE() if irq_move_cleanup is called on a pending interrupt
 8/8 x86/irq: merge and functionalize common code in DECLARE/DEFINE_IDTENTRY_*

 arch/x86/entry/common.c                  |   5 +-
 arch/x86/include/asm/desc.h              |  17 ++-
 arch/x86/include/asm/idtentry.h          | 174 +++++++++++++++----------------
 arch/x86/include/asm/irq_stack.h         |  73 +++++--------
 arch/x86/include/asm/irq_vectors.h       |   7 +-
 arch/x86/include/asm/trapnr.h            |   1 +
 arch/x86/kernel/apic/apic.c              |   2 +-
 arch/x86/kernel/apic/vector.c            |   5 +
 arch/x86/kernel/idt.c                    |   5 +-
 arch/x86/kernel/irq.c                    |   1 +
 arch/x86/kernel/machine_kexec_32.c       |  15 +--
 arch/x86/kernel/machine_kexec_64.c       |  33 +-----
 arch/x86/kernel/reboot.c                 |   2 +-
 arch/x86/kernel/sev-es.c                 |   6 +-
 arch/x86/kernel/traps.c                  |   2 +-
 tools/arch/x86/include/asm/irq_vectors.h |   7 +-
 16 files changed, 158 insertions(+), 197 deletions(-)
 arch/x86/entry/common.c                  |   5 +-
 arch/x86/include/asm/desc.h              |  22 +++-
 arch/x86/include/asm/idtentry.h          | 174 +++++++++++++++----------------
 arch/x86/include/asm/irq_stack.h         |  73 +++++--------
 arch/x86/include/asm/irq_vectors.h       |   7 +-
 arch/x86/include/asm/trapnr.h            |   1 +
 arch/x86/kernel/apic/apic.c              |   2 +-
 arch/x86/kernel/apic/vector.c            |   5 +
 arch/x86/kernel/idt.c                    |   5 +-
 arch/x86/kernel/irq.c                    |   1 +
 arch/x86/kernel/machine_kexec_32.c       |  15 +--
 arch/x86/kernel/machine_kexec_64.c       |  33 +-----
 arch/x86/kernel/reboot.c                 |   2 +-
 arch/x86/kernel/sev-es.c                 |   6 +-
 arch/x86/kernel/traps.c                  |   2 +-
 tools/arch/x86/include/asm/irq_vectors.h |   7 +-
 16 files changed, 163 insertions(+), 197 deletions(-)
