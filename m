Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFAB634ECA8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 17:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbhC3Pfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 11:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbhC3PfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 11:35:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC3EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 08:35:18 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617118514;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=YPYdY00O6y5AyCUxqpuYCSP5+y//XPdG6L9507cj5Ic=;
        b=qQDflIkAz51LrvGLUrPwJwlERwWmT6hRYLbUtz0Trgd18/qLrOCW3YJxVb2jNAurM81TyI
        3AsXxivkW9AuZRb35RUNhV/DFicFLJm/ny52MZHlxV7nYaB82D7yRtI4eJOR3/A6GZI+4W
        Oj90Fp+qLdueXya9Nqaj7zUEgUAq3I566RihuuDiupy7dG0M1LBtHXzJHIUGFj2fBotjoc
        m2sdVo64AJACocszlTWXWkB3zjWrA7HaH4WgN9u85YOkFnQ/JYc9BcjSaehTMGu0Tieka6
        Qum9ld/CWbuBmTjG8QIJS2kuF/+SwuV/YneE4CHchkQF8b8DmaCwDpcuT+u3QQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617118514;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=YPYdY00O6y5AyCUxqpuYCSP5+y//XPdG6L9507cj5Ic=;
        b=DAWOFKfBAuSGqLOlxY962SnoWviQuD0AGtEm319HtzpL33OlIzgLcrRMou9nKTPDT+oWj6
        VfRxVIoORXq20wCQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicholas Piggin <npiggin@gmail.com>,
        Alistair Popple <alistair@popple.id.au>,
        Jordan Niethe <jniethe5@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Yue Hu <huyue2@yulong.com>, Rafael Aquini <aquini@redhat.com>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        Ingo Molnar <mingo@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Leonardo Bras <leobras.c@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Will Deacon <will@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Nick Terrell <terrelln@fb.com>,
        David Howells <dhowells@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH printk v2 0/5] printk: remove safe buffers
Date:   Tue, 30 Mar 2021 17:35:07 +0200
Message-Id: <20210330153512.1182-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is v2 of a series to remove the safe buffers. v1 can be
found here [0]. The safe buffers are no longer needed because
messages can be stored directly into the log buffer from any
context.

However, the safe buffers also provided a form of recursion
protection. For that reason, explicit recursion protection is
also implemented for this series.

And finally, with the removal of the safe buffers, there is no
need for extra NMI enter/exit tracking. So this is also removed
(which includes removing config option CONFIG_PRINTK_NMI).

This series is based on the printk-rework branch of
printk/linux.git:

    commit acebb5597ff1 ("kernel/printk.c: Fixed mundane typos")

Changes since v1:

- remove the printk nmi enter/exit tracking

- remove CONFIG_PRINTK_NMI config option

- use in_nmi() to detect NMI context

- remove unused printk_safe_enter/exit macros

- after switching to the dynamic buffer, copy over NMI records
  that may have arrived during the switch window

- use local_irq_*() instead of printk_safe_*() for console
  spinning

- use separate variables rather than arrays for the per-cpu
  recursion tracking

- make @syslog_lock a mutex instead of a spin_lock

- close the wait-read window for SYSLOG_ACTION_READ

- adjust various comments and commit messages as requested

John Ogness

[0] https://lore.kernel.org/lkml/20210316233326.10778-1-john.ogness@linutronix.de

John Ogness (5):
  printk: track/limit recursion
  printk: remove safe buffers
  printk: remove NMI tracking
  printk: convert @syslog_lock to mutex
  printk: syslog: close window between wait and read

 arch/arm/kernel/smp.c          |   2 -
 arch/powerpc/kernel/traps.c    |   1 -
 arch/powerpc/kernel/watchdog.c |   5 -
 arch/powerpc/kexec/crash.c     |   3 -
 include/linux/hardirq.h        |   2 -
 include/linux/printk.h         |  22 --
 init/Kconfig                   |   5 -
 kernel/kexec_core.c            |   1 -
 kernel/panic.c                 |   3 -
 kernel/printk/internal.h       |  23 ---
 kernel/printk/printk.c         | 281 +++++++++++++++----------
 kernel/printk/printk_safe.c    | 362 +--------------------------------
 kernel/trace/trace.c           |   2 -
 lib/nmi_backtrace.c            |   6 -
 14 files changed, 171 insertions(+), 547 deletions(-)

-- 
2.20.1

