Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9423F3219E9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 15:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbhBVONH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 09:13:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:58480 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231665AbhBVNgA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 08:36:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614000909; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=V1WRyjqV79KiGzT1YBIWTW4kj+NRdp/qN01PN1USCBw=;
        b=KSSw7dTH9Fzxvmuhb+kyifSCFss5RNNoUkwVthMMSKj4ryHFlDbjYx2rHSptck3hwAQU8v
        e6rUdwCgoJLTUY7z2pgmQcQfax7aYcZaXhSRavAFu4oQnT3/OQOIYI9x8vBXzD8qbWMQPK
        4psPc+8sgRUZpke1lYjlQ5Nnvig97dM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 402BAAD2B;
        Mon, 22 Feb 2021 13:35:09 +0000 (UTC)
Date:   Mon, 22 Feb 2021 14:35:08 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] printk for 5.12
Message-ID: <YDOy7NcXzfCJcPXw@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170912 (1.9.0)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest printk changes from

  git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-5.12

==============================

- New "no_hash_pointers" kernel parameter causes that %p shows raw
  pointer values instead of hashed ones. It is intended only for
  debugging purposes. Misuse is prevented by a fat warning message
  that is inspired by trace_printk().

- Prevent a possible deadlock when flushing printk_safe buffers during
  panic().

- Fix performance regression caused by the lockless printk ringbuffer.
  It was visible with huge log buffer and long messages.

- Documentation fix-up.

----------------------------------------------------------------
John Ogness (1):
      printk: avoid prb_first_valid_seq() where possible

Lukas Bulwahn (1):
      printk: rectify kernel-doc for prb_rec_init_wr()

Muchun Song (1):
      printk: fix deadlock when kernel panic

Petr Mladek (2):
      Merge branch 'for-5.12-no_hash_pointers' into for-linus
      Merge branch 'printk-rework' into for-linus

Timur Tabi (3):
      lib: use KSTM_MODULE_GLOBALS macro in kselftest drivers
      kselftest: add support for skipped tests
      lib/vsprintf: no_hash_pointers prints all addresses as unhashed

 Documentation/admin-guide/kernel-parameters.txt | 15 +++++++++++
 kernel/printk/printk.c                          | 28 ++++++++++++-------
 kernel/printk/printk_ringbuffer.h               |  2 +-
 kernel/printk/printk_safe.c                     | 16 ++++++++---
 lib/test_bitmap.c                               |  3 +--
 lib/test_printf.c                               | 12 +++++++--
 lib/vsprintf.c                                  | 36 +++++++++++++++++++++++--
 tools/testing/selftests/kselftest_module.h      | 18 ++++++++-----
 8 files changed, 103 insertions(+), 27 deletions(-)
