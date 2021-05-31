Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CAA5396714
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 19:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbhEaRbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 13:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232947AbhEaRbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 13:31:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B529DC08EB1D
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 09:20:55 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622478052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=fUC13kWEybGaCsw6cPSUNcq2LJAUz98wtI79y2iUjBE=;
        b=2FtLGLo37JE+x4lXkFi35t5jyAJJBUT2W1mGxVtNLjxF2Vv0CYBSrjkKe5NnPo0sc4MZ8S
        Kocd5TELMIX6HDWl/BQvXjQ37ifBvNX469dZTeCszZRLy/8pp1javTSW4zf9RyfZG6/HVj
        E+x+1VfMum2up4dJll8lAoy3Xi4T7eMFSzT3LrobrnhQCOg6K6MhzUZAfbpX4npvaMAQDg
        SLWGtpziMzUvJgHKLm2B5IBJ3r3cPUpt0lGQsn10Azk0jatsKkRFLEt4d5eJ5GKbfYmG9X
        KAOwuUfqUzhWbJ5E09+CC5REpKLJ6xIYYuJZtp5U+yId6G9HZKVgRleyMXYUvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622478052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=fUC13kWEybGaCsw6cPSUNcq2LJAUz98wtI79y2iUjBE=;
        b=881xKfH5LKrQzX1ZtRMV+mv3r4bgDOKBscw/iF0+yOUL0Fb0Wp4H120RxaFRERhhFdJmMe
        j0BirbMNreolRvCw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH next v1 0/2] introduce printk cpu lock
Date:   Mon, 31 May 2021 18:20:49 +0200
Message-Id: <20210531162051.2325-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While working on removing the safe buffers for printk [0] we
stumbled on a cpu-reentrant spinning lock used by dump_stack(). This
type of lock (dubbed a cpu lock) will cause deadlock risks once we
introduce atomic consoles because atomic consoles also need such a
lock.

Although we are not yet ready to introduce atomic consoles, this is
an appropriate time to provide an official cpu lock to be used for
all things relating to printk (including the atomic consoles, once
they are introduced).

This series also extends the new printk cpu lock to cover
show_regs().

This series is against next-20210528.

John Ogness

[0] https://lore.kernel.org/lkml/YGW63%2FelFr%2FgYW1u@alley

John Ogness (2):
  dump_stack: move cpu lock to printk.c
  nmi_backtrace: use the printk cpu lock for show_regs()

 include/linux/printk.h | 13 ++++++
 kernel/printk/printk.c | 92 ++++++++++++++++++++++++++++++++++++++++++
 lib/dump_stack.c       | 43 ++------------------
 lib/nmi_backtrace.c    |  4 ++
 4 files changed, 112 insertions(+), 40 deletions(-)

-- 
2.20.1

