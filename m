Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7A33CAD4E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 21:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244248AbhGOT5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 15:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347251AbhGOTwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 15:52:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19651C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 12:34:03 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626377641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=AlYsQuWcV07ceFNksYMnBsP5kyWUBQUeoD8kaOeX8A4=;
        b=H1Slcp5vR+s/qOKCOLfC9pox8PNkKoEZX8fxv9qmyD7nwiZLomLYup9Pb9FSsmnOQ+EPaJ
        Du1FIb9sBZPE8VTu1nJNL595Me3c0MZJjKkbHZrnXnF/9WNVx8xFDvTpj33GISk1s/v7Pm
        0xjM1na3FCAQFwxtGR9n+pmqGKbPqyn1XcKlFopRInV3uT9P8psg1163D7eL1MzzQJQxF9
        w5QYbOw3ajycAn9+z/aP9ORfvcr5gmQb9+b6REqz40z5gGn1ngTCuCBm8GzwrMKDYg5iQZ
        rvR6PNLVTwDg/7QK+YkTZ146g7FBStWXWMKo7L5tx9lYhzmJU99uLYpyoeLtQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626377641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=AlYsQuWcV07ceFNksYMnBsP5kyWUBQUeoD8kaOeX8A4=;
        b=KhW3dN8MQmFGfyVll3Bd6RO29BZ6Hgev3jn4REDVIC0SszHesjcDnMLQfy1uO9iz382/CP
        tmAaxQ5nCOpMAaAg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Yue Hu <huyue2@yulong.com>, linuxppc-dev@lists.ozlabs.org,
        kexec@lists.infradead.org, Russell King <linux@armlinux.org.uk>,
        Ingo Molnar <mingo@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Mike Rapoport <rppt@kernel.org>,
        "Wolfram Sang (Renesas)" <wsa+renesas@sang-engineering.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Xiongwei Song <sxwjean@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nick Terrell <terrelln@fb.com>,
        Vipin Sharma <vipinsh@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH printk v4 0/6] printk: remove safe buffers
Date:   Thu, 15 Jul 2021 21:39:53 +0206
Message-Id: <20210715193359.25946-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is v4 of a series to remove the safe buffers. v3 can be
found here [0]. The safe buffers are no longer needed because
messages can be stored directly into the log buffer from any
context.

However, the safe buffers also provided a form of recursion
protection. For that reason, explicit recursion protection is
implemented for this series.

The safe buffers also implicitly provided serialization
between multiple CPUs executing in NMI context. This was
particularly necessary for the nmi_backtrace() output. This
serializiation is now preserved by using the printk cpulock.

With the removal of the safe buffers, there is no need for
extra NMI enter/exit tracking. So this is also removed
(which includes removing the config option CONFIG_PRINTK_NMI).

And finally, there are a few places in the kernel that need to
specify code blocks where all printk calls are to be deferred
printing. Previously the NMI tracking API was being (mis)used
for this purpose. This series introduces an official and
explicit interface for such cases. (Note that all deferred
printing will be removed anyway, once printing kthreads are
introduced.)

Changes since v3:

- Remove safe context tracking in vprintk().

- Add safe context tracking for @console_owner usage since that
  is also a component of the printing code.

- Refactor syslog_print() so that it is easier to understand
  and follow the locking logic.

- Introduce printk_deferred_enter/exit functions to be used by
  code that needs to specify code block where all printk calls
  are to be deferred printing.

John Ogness

[0] https://lore.kernel.org/lkml/20210624111148.5190-1-john.ogness@linutronix.de

John Ogness (6):
  lib/nmi_backtrace: explicitly serialize banner and regs
  printk: track/limit recursion
  printk: remove safe buffers
  printk: remove NMI tracking
  printk: convert @syslog_lock to mutex
  printk: syslog: close window between wait and read

 arch/arm/kernel/smp.c          |   4 +-
 arch/powerpc/kernel/traps.c    |   1 -
 arch/powerpc/kernel/watchdog.c |   5 -
 arch/powerpc/kexec/crash.c     |   2 +-
 include/linux/hardirq.h        |   2 -
 include/linux/printk.h         |  41 ++--
 init/Kconfig                   |   5 -
 kernel/kexec_core.c            |   1 -
 kernel/panic.c                 |   3 -
 kernel/printk/internal.h       |  25 ---
 kernel/printk/printk.c         | 268 ++++++++++++++----------
 kernel/printk/printk_safe.c    | 364 +--------------------------------
 kernel/trace/trace.c           |   4 +-
 lib/nmi_backtrace.c            |  13 +-
 14 files changed, 194 insertions(+), 544 deletions(-)


base-commit: 70333dec446292cd896cd051d2ebd6808b328949
-- 
2.20.1

