Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D990455819
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 10:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245191AbhKRJgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 04:36:51 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:57588 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245184AbhKRJgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 04:36:25 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A858D1FD37;
        Thu, 18 Nov 2021 09:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637228004; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=QkMP0XJVHOjNntICpQkXhmuOCsl4mz6wKLlg1Iyhhrk=;
        b=fgzzaACq9B6GuE5dxzbRCWvsWhGRRHuOVo+I+3i3CPpQsFhQ8Xid6gb5XY3dNf8P5tPOuX
        oN+lqAVXjFIF5PNmwPfVOrWs5jyP7mQAczW2bPowXNTev53V8kWlFdBVNsMbfoHTT7n42k
        qVekrhZHKA2nq8w0YMBU3ntinIpnJmw=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 3CDF9A3B87;
        Thu, 18 Nov 2021 09:33:24 +0000 (UTC)
Date:   Thu, 18 Nov 2021 10:33:24 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] printk for 5.16 fixup
Message-ID: <YZYd5N29dc6KRhye@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull a printk two fixes from

  git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-5.16-fixup

=================================

- Try to flush backtraces from other CPUs also on the local one.
  It was a regression caused by printk_safe buffers removal.

- Remove header dependency warning.

----------------------------------------------------------------
Andy Shevchenko (1):
      printk: Remove printk.h inclusion in percpu.h

Nicholas Piggin (1):
      printk: restore flushing of NMI buffers on remote CPUs after NMI backtraces

Petr Mladek (1):
      Merge branch 'rework/printk_safe-removal' into for-linus

 arch/powerpc/kernel/watchdog.c | 6 ++++++
 include/linux/percpu.h         | 1 -
 include/linux/printk.h         | 4 ++++
 kernel/printk/printk.c         | 5 +++++
 lib/nmi_backtrace.c            | 6 ++++++
 5 files changed, 21 insertions(+), 1 deletion(-)
