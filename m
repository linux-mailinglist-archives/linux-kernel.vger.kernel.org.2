Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF13A3A8816
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 19:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbhFORvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 13:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbhFORvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 13:51:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2103C061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 10:49:49 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623779388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=X5cLjfwjyHhYtRj2Alon2mDrmjPlk8v2cBI/wF9DoL8=;
        b=npimFlfDowOWje+JkXoh+opaJcUhCl7Qzu4F1klU4a3MVgdMxfLBaU6acaVypOWz67VZgm
        0YY7q1DXtXqP3f6VULlnG5qL0eTH4SRT8ie3Tm5TGMq1CMjg5q0KBGR00nEXLOySxRbEdt
        6r09kPwyJhz5lWtox7h7dUtBsRUAzTaUQH26D9QqHqC3tleBeG7sbeMMQR9OWvJc5iN0MS
        7GR1RhtQufPuCbx1eNpLC8DGa/LH1PrFsQL0JrsB4SmZw4+Mv7ko+RVT1R581Y0YTyjWS4
        KHvPFjwRoqsHz8wMNUJCeNVdqO6b18DEl4astT3rfjvVjP3WheTov6b7FQmARw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623779388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=X5cLjfwjyHhYtRj2Alon2mDrmjPlk8v2cBI/wF9DoL8=;
        b=imnqL77jLmvhcPtWmbAsrRpQOq+zXB5XoDr7xTTKFo0TShoHnOw/cbNPWao+76O3p5BobR
        4qHRzmdIwIm3LrAQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH next v3 0/2] introduce printk cpu lock
Date:   Tue, 15 Jun 2021 19:55:45 +0206
Message-Id: <20210615174947.32057-1-john.ogness@linutronix.de>
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

This series is against next-20210615.

v2 can be found here [1].

Changes since v2:

- Remove @lock_flag argument from lock/unlock functions. Since there
  is only 1 global printk cpu lock, the @lock_flag can be a static
  global variable inside printk.c. Also, that flag is renamed to
  @printk_cpulock_nested.

- Use typical irqsave/irqrestore calling conventions. This means
  changing the lock/unlock functions to macros and set the irq flags
  within those macros, rather than passing the irq flags as a
  function argument.

- Split the lock function into 2 functions: trylock and wait. This
  simplifies the macro implementation. Later, for atomic consoles,
  this will be useful because atomic consoles will implement the
  waiting component differently.

- Fix a "used uninitialized" warning for !CONFIG_SMP, reported by
  the kbuild robot.

- Extend memory barrier comments to cover both "previous to current"
  and "current to next" guarantees.

John Ogness

[0] https://lore.kernel.org/lkml/YGW63%2FelFr%2FgYW1u@alley
[1] https://lore.kernel.org/lkml/20210607200232.22211-1-john.ogness@linutronix.de

John Ogness (2):
  dump_stack: move cpu lock to printk.c
  printk: fix cpu lock ordering

 include/linux/printk.h |  41 +++++++++++++++
 kernel/printk/printk.c | 114 +++++++++++++++++++++++++++++++++++++++++
 lib/dump_stack.c       |  38 +-------------
 3 files changed, 157 insertions(+), 36 deletions(-)

--
2.20.1

