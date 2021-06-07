Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6C9A39E7F8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 22:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbhFGUEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 16:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbhFGUE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 16:04:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AABFC061787
        for <linux-kernel@vger.kernel.org>; Mon,  7 Jun 2021 13:02:36 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623096154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=c9tymm+MboP2ZjDf8BlXGiX+2IujH2zV4dZVAblW4EM=;
        b=lnzvmxJCvsHGEMXBE2mTJbIba9Rvqp0zl0Z+zCjF5Uujfo70eyio//Y/15S1OaQw1H3DcE
        Snf4sX16jP+za2QxVYHrb6httUu+zpP5057tr0qBN/YLN7AT09H7frF8xfCg9kZOaKyGbz
        rI7sRqU4+PYoAWS1mmDFhf4JrGiBUcCtM2yhA2fv/8fdQyiHVHn/uebRfZsexvicpg9dnK
        2GXocE6A8uE0b9YVaAKWrqqwGKD4eiuaX12UAM/aQzEVIAq9ccU5RIwFYPuhZ53ZUnfBG1
        aS9fnKiiojS9C5SR5TUnt+H0iCaJaLngUCDjc26HgB4/NwtLyIFTuE3xs/KG9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623096154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=c9tymm+MboP2ZjDf8BlXGiX+2IujH2zV4dZVAblW4EM=;
        b=u91fdmD/SE8oTleNOfFhlKSI8tLCV7eNWLdJ56arWRRzqzZ8xvCA+60SCFprnxupOkf6kV
        uvgP6g/MUzJ6TODA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH next v2 0/2] introduce printk cpu lock
Date:   Mon,  7 Jun 2021 22:02:30 +0200
Message-Id: <20210607200232.22211-1-john.ogness@linutronix.de>
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

This series is against next-20210607.

v1 can be found here [1].

Changes since v1:

- Keep cpu lock functionality even if !CONFIG_PRINTK. Only make it a
  NOP for !CONFIG_SMP.

- Rename the lock/unlock functions to reflect irq disabling/enabling.

- Change first argument of lock/unlock functions to bool. There is
  no need to track the previous @printk_cpulock_owner value.

- Change the series to first move over the cpu lock implementation,
  then fix ordering in a separate patch.

- Preserve the style from the dump_stack() cpu lock (i.e. goto-retry
  instead of for-loop and cmpxchg() instead of try_cmpxchg()).

- Drop the patch that adds serialization to show_regs().

- Fix various typos in comments.

John Ogness

[0] https://lore.kernel.org/lkml/YGW63%2FelFr%2FgYW1u@alley
[1] https://lore.kernel.org/lkml/20210531162051.2325-1-john.ogness@linutronix.de

John Ogness (2):
  dump_stack: move cpu lock to printk.c
  printk: fix cpu lock ordering

 include/linux/printk.h |  13 ++++++
 kernel/printk/printk.c | 101 +++++++++++++++++++++++++++++++++++++++++
 lib/dump_stack.c       |  41 ++---------------
 3 files changed, 118 insertions(+), 37 deletions(-)

-- 
2.20.1

