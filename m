Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C84983AB043
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 11:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbhFQJxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 05:53:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47682 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231873AbhFQJxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 05:53:01 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623923452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=WTnw3zMyd8z+pIa0tw6p23b8itwiBN3kbhbrx5ETz5o=;
        b=fvujx/l7221PjikdVNLT0v4IE80gasws/MTw1YEq23CeKQh9mPERZ5fyEtzc8X+Rrnm7JE
        3RFoezoJDT0xd9fuCfMQXGOyoZUn1vnGjHLCFy5A/WAuhmXPUtpLA61fT7RbjZy19IWDEu
        gsItRcgY06azwCY0CnIJ43K6s4QO1SgMkPHoVvcCy5zF/hIV6oLhMeYmiWXPncIzevHve5
        MzhwDjAOy9QcaEmQh7m1gzUgm2IIcOQGZu59hhalKfQnwE0ztVtuALubY1AVogd1HQuI4R
        g8fGTnfYoYX2sWKvpDBaWi+gUK8ncI6Pa1et5MGHasjmyncpmvIakYaLvMOvGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623923452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=WTnw3zMyd8z+pIa0tw6p23b8itwiBN3kbhbrx5ETz5o=;
        b=XuWDgIqPLvk4AmbkJeJAajGOjiOkd3dg5tmrAwoJu3W+ouoRqe+Hkj22KSTpjESb8gPsri
        96yCp9Av3LiNtFDQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH next v4 0/2] introduce printk cpu lock
Date:   Thu, 17 Jun 2021 11:56:49 +0206
Message-Id: <20210617095051.4808-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

While working on removing the safe buffers for printk [0] we
stumbled on a cpu-reentrant spinning lock used by dump_stack(). This
type of lock (dubbed a cpu lock) will cause deadlock risks once we
introduce atomic consoles because atomic consoles also need such a
lock.

Although we are not yet ready to introduce atomic consoles, this is
an appropriate time to provide an official cpu lock to be used for
all things relating to printk (including the atomic consoles, once
they are introduced).

An example of cpu lock usage for atomic consoles can be found in the
PREEMPT_RT tree, such as the serial8250 implementation [1] of an
atomic console. (In PREEMPT_RT the printk cpu lock function was
named console_atomic_lock/_unlock.)

This series is against next-20210616.

v3 can be found here [2].

Changes since v3:

- Change @printk_cpulock_nested from a boolean to an atomic counter
  in order to track multiple levels of nesting.

- Correctly move over the original dump_stack() semantics by using
  atomic_set() to unlock.

- Move commit message note about disabling interrupts to the first
  patch.

John Ogness

[0] https://lore.kernel.org/lkml/YGW63%2FelFr%2FgYW1u@alley
[1] https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/commit/drivers/tty/serial?h=v5.12-rc3-rt3&id=1aaca59df62710647243a3574fc27d93c2bd0e6c
[2] https://lore.kernel.org/lkml/20210615174947.32057-1-john.ogness@linutronix.de

John Ogness (2):
  lib/dump_stack: move cpu lock to printk.c
  printk: fix cpu lock ordering

 include/linux/printk.h |  41 +++++++++++++++
 kernel/printk/printk.c | 116 +++++++++++++++++++++++++++++++++++++++++
 lib/dump_stack.c       |  38 +-------------
 3 files changed, 159 insertions(+), 36 deletions(-)

-- 
2.20.1

