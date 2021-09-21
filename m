Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34C04413ACF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 21:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234543AbhIUTeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 15:34:20 -0400
Received: from shells.gnugeneration.com ([66.240.222.126]:54162 "EHLO
        shells.gnugeneration.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232667AbhIUTeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 15:34:18 -0400
Received: by shells.gnugeneration.com (Postfix, from userid 1000)
        id 6FAD31A56019; Tue, 21 Sep 2021 12:32:49 -0700 (PDT)
Date:   Tue, 21 Sep 2021 12:32:49 -0700
From:   Vito Caputo <vcaputo@pengaru.com>
To:     jpoimboe@redhat.com
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Subject: CONFIG_ORC_UNWINDER=y breaks get_wchan()?
Message-ID: <20210921193249.el476vlhg5k6lfcq@shells.gnugeneration.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Josh (and CC:lkml),

I've recently transitioned to an Arch system which has
CONFIG_ORC_UNWINDER=y in the default kernel.  My window manager
integrates process monitoring showing the wchans of processes, making
it very apparent when wchan breaks.

Glancing at the kernel code to see what's involved in get_wchan() for
x86, it looks to assume there are frame pointers in the stack.  I
don't see any mention of ORC_UNWINDER in the get_wchan() code which
seems like an oversight when ORC_UNWINDER=y gets rid of them.

I had originally assumed this was just a Kconfig problem and asked
lkml about it (hearing crickets back) [0], but have since learned of
ORC_UNWINDER's existence via the Arch kernel maintainer.

Is this an oversight of the ORC_UNWINDER implementation?  It's
arguably a regression to completely break wchans for tools like `ps -o
wchan` and `top`, or my window manager and its separate monitoring
utility.  Presumably there are other tools out there sampling wchans
for monitoring as well, there's also an internal use of get_chan() in
kernel/sched/fair.c for sleep profiling.

I've occasionally seen when monitoring at a high sample rate (60hz) on
something churny like a parallel kernel or systemd build, there's a
spurious non-zero sample coming out of /proc/[pid]/wchan containing a
hexadecimal address like 0xffffa9ebc181bcf8.  This all smells broken,
is get_wchan() occasionally spitting out random junk here kallsyms
can't resolve, because get_chan() is completely ignorant of
ORC_UNWINDER's effects?

My time to spend on this currently is very limited, but I'd like to at
least get the relevant parties aware if they're not already...  Maybe
I should just file something in bugzilla.

Thanks,
Vito Caputo


[0] https://lore.kernel.org/lkml/20210914012612.vwlowt5wsojmyfzr@shells.gnugeneration.com/
