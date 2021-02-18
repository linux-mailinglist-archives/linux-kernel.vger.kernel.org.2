Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77B6631E830
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 10:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbhBRJaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 04:30:23 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:50494 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbhBRITU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 03:19:20 -0500
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613636298;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=jO4WR9/CiJ81TRqNAtzuj+VEs3EgYhRwLOOkArfSxnY=;
        b=OGIELBIYgxGpEt96aki9KGx/GOEN/db+NO156sjIvtFbMuCfBnffpaOZA0+pG4B5wCwxRb
        leYtKWq4pZ9Tcin9Fv3/IudQJo13udsIIqx6V0KcWp+5VbwMsGFSPl/4q3BwazONTVXUgs
        Kb18dLnqlqqXqmqajCPSRV2ukl169wkJW6yqa7N9toNRM8EL9qPL3481m2UzzmIx8jeH8U
        Lj5f5/k3nij76JdRTM0ZzGLNQiUhbsGobQ3Xv1jbXXBtgU4Wsyw/wi+su5SIZtdQHkjY9q
        hUAiXLe9PpIm44olbfZeLgjs4vdkwKkaMDjs8LwQVVaOOG3Et6mxnY3DFnA88A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613636298;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=jO4WR9/CiJ81TRqNAtzuj+VEs3EgYhRwLOOkArfSxnY=;
        b=1+eCl6in2pl0FoBTBLb5gRPu+bf1E4E+Oki+l1SUNMJT9SzJjRWgd4uo61O21vHSwDk2+R
        +QLaWLS6nltmXKCA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk-rework 00/14] printk: remove logbuf_lock
Date:   Thu, 18 Feb 2021 09:18:03 +0100
Message-Id: <20210218081817.28849-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here is v2 of a series to remove @logbuf_lock, exposing the
ringbuffer locklessly to both readers and writers. v1 is here [0].

Since @logbuf_lock was protecting much more than just the
ringbuffer, this series clarifies and cleans up the various
protections using comments, lockless accessors, atomic types, and a
new finer-grained @syslog_log.

Changes since v1:

- handle the syslog_print_all() size calculation issue in a separate
  patch (patch 1)

- use a local printk_info for find_first_fitting_seq()

- define CONSOLE_LOG_MAX in printk.c instead of printk.h since it is
  not used outside of printk.c

- increase CONSOLE_LOG_MAX to 4096 to support long multi-line
  records

- add a wrapper function read_syslog_seq_irq() for getting a
  consistent @syslog_seq value (only used in do_syslog())

- drop the "hv: synchronize kmsg_dumper" patch

- in "remove logbuf_lock" only change to safe buffer usage

- fixup safe buffer usage and redundance in separate patches
  (patches 13 and 14)

- update comments and commit messages as requested

John Ogness

[0] https://lkml.kernel.org/r/20210126211551.26536-1-john.ogness@linutronix.de

John Ogness (14):
  printk: limit second loop of syslog_print_all
  printk: kmsg_dump: remove unused fields
  printk: refactor kmsg_dump_get_buffer()
  printk: consolidate kmsg_dump_get_buffer/syslog_print_all code
  printk: introduce CONSOLE_LOG_MAX for improved multi-line support
  printk: use seqcount_latch for clear_seq
  printk: use atomic64_t for devkmsg_user.seq
  printk: add syslog_lock
  printk: introduce a kmsg_dump iterator
  um: synchronize kmsg_dumper
  printk: remove logbuf_lock
  printk: kmsg_dump: remove _nolock() variants
  printk: kmsg_dump: use kmsg_dump_rewind
  printk: console: remove unnecessary safe buffer usage

 arch/powerpc/kernel/nvram_64.c             |  12 +-
 arch/powerpc/platforms/powernv/opal-kmsg.c |   3 +-
 arch/powerpc/xmon/xmon.c                   |   6 +-
 arch/um/kernel/kmsg_dump.c                 |  13 +-
 drivers/hv/vmbus_drv.c                     |   5 +-
 drivers/mtd/mtdoops.c                      |   5 +-
 fs/pstore/platform.c                       |   5 +-
 include/linux/kmsg_dump.h                  |  52 +--
 kernel/debug/kdb/kdb_main.c                |  10 +-
 kernel/printk/internal.h                   |   4 +-
 kernel/printk/printk.c                     | 454 +++++++++++----------
 kernel/printk/printk_safe.c                |  29 +-
 12 files changed, 298 insertions(+), 300 deletions(-)

-- 
2.20.1

