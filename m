Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E17133E230
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 00:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbhCPXdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 19:33:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45336 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbhCPXd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 19:33:29 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615937607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=F3yikjHBX3sE+vqVOAg0c4FbXVC7h/jsk7NB+UTl4pY=;
        b=ZBpkHA3yMsvjOMDQlQDKG/f2JwzyuZ+1kB+44ZuV4SbBS3JtyxSQaVXoT2trt3YilG9rDs
        L6h8pSjhEe1rzGdGxiJmp3/4WU53keFtoCa68VJYNVnPIbT3x5cOUKKdCN951p9YrzIwJI
        rbN+scLS88zfxi97ZeQK664T7hhUXrVKfCCKA0sSpKL6al6e2jW7ewe1ZH7680qsr05ZJA
        U9NI/Wei9c18v8sEnTDwNKjUZEzd7oZ+1SICWdHGblcKh7IYZqqswcrWNoF2iWzul6IM0+
        2IRQcdXQfgCkqVvLW+4eE/Eu/Eu9QYGmhuIrgWek4uzb63fMPAU5VKCBqXLdtw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615937607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=F3yikjHBX3sE+vqVOAg0c4FbXVC7h/jsk7NB+UTl4pY=;
        b=qBoEY0L4Ynny3Z3D6ukRFXsT63ZYZeUutsYPyIJtoUFiA0tC+gFvfCvGeVj8Lgk1jz+F4a
        9SujFVU6K+engkBQ==
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
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Alistair Popple <alistair@popple.id.au>,
        Jordan Niethe <jniethe5@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>, Yue Hu <huyue2@yulong.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Rafael Aquini <aquini@redhat.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org
Subject: [PATCH next v1 0/3] printk: remove safe buffers
Date:   Wed, 17 Mar 2021 00:33:23 +0100
Message-Id: <20210316233326.10778-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here is v1 of a series to remove the safe buffers. They are no
longer needed because messages can be stored directly into the
log buffer from any context.

However, the safe buffers also provided a form of recursion
protection. For that reason, explicit recursion protection is
also implemented for this series.

This series falls in line with the printk-rework plan as
presented [0] at Linux Plumbers in Lisbon 2019.

This series is based on next-20210316.

John Ogness

[0] https://linuxplumbersconf.org/event/4/contributions/290/attachments/276/463/lpc2019_jogness_printk.pdf (slide 23)

John Ogness (3):
  printk: track/limit recursion
  printk: remove safe buffers
  printk: convert @syslog_lock to spin_lock

 arch/powerpc/kernel/traps.c    |   1 -
 arch/powerpc/kernel/watchdog.c |   5 -
 include/linux/printk.h         |  10 -
 kernel/kexec_core.c            |   1 -
 kernel/panic.c                 |   3 -
 kernel/printk/internal.h       |   2 -
 kernel/printk/printk.c         | 171 +++++++++--------
 kernel/printk/printk_safe.c    | 332 +--------------------------------
 lib/nmi_backtrace.c            |   6 -
 9 files changed, 100 insertions(+), 431 deletions(-)

-- 
2.20.1

