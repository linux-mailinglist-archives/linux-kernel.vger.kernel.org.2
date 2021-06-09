Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9D8D3A1498
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 14:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbhFIMkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 08:40:16 -0400
Received: from foss.arm.com ([217.140.110.172]:59402 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231281AbhFIMkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 08:40:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D4253D6E;
        Wed,  9 Jun 2021 05:38:18 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.7.102])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 733653F73D;
        Wed,  9 Jun 2021 05:38:17 -0700 (PDT)
Date:   Wed, 9 Jun 2021 13:38:10 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Marco Elver <elver@google.com>
Cc:     paulmck@kernel.org, boqun.feng@gmail.com, will@kernel.org,
        glider@google.com, dvyukov@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] kcsan: Introduce CONFIG_KCSAN_PERMISSIVE
Message-ID: <20210609123810.GA37375@C02TD0UTHF1T.local>
References: <20210607125653.1388091-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210607125653.1388091-1-elver@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marco,

On Mon, Jun 07, 2021 at 02:56:46PM +0200, Marco Elver wrote:
> While investigating a number of data races, we've encountered data-racy
> accesses on flags variables to be very common. The typical pattern is a
> reader masking all but one bit, and the writer setting/clearing only 1
> bit (current->flags being a frequently encountered case; mm/sl[au]b.c
> disables KCSAN for this reason currently).

As a heads up, I just sent out the series I promised for
thread_info::flags, at:

  https://lore.kernel.org/lkml/20210609122001.18277-1-mark.rutland@arm.com/T/#t

... which I think is complementary to this (IIUC it should help with the
multi-bit cases you mention below), and may help to make the checks more
stringent in future.

FWIW, for this series:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.

> Since these types of "trivial" data races are common (assuming they're
> intentional and hard to miscompile!), having the option to filter them
> (like we currently do for other types of data races) will avoid forcing
> everyone to mark them, and deliberately left to preference at this time.
> 
> The primary motivation is to move closer towards more easily filtering
> interesting data races (like [1], [2], [3]) on CI systems (e.g. syzbot),
> without the churn to mark all such "trivial" data races.
> [1] https://lkml.kernel.org/r/20210527092547.2656514-1-elver@google.com
> [2] https://lkml.kernel.org/r/20210527104711.2671610-1-elver@google.com
> [3] https://lkml.kernel.org/r/20210209112701.3341724-1-elver@google.com
> 
> Notably, the need for further built-in filtering has become clearer as
> we notice some other CI systems (without active moderation) trying to
> employ KCSAN, but usually have to turn it down quickly because their
> reports are quickly met with negative feedback:
> https://lkml.kernel.org/r/YHSPfiJ/h/f3ky5n@elver.google.com
> 
> The rules are implemented and guarded by a new option
> CONFIG_KCSAN_PERMISSIVE. With it, we will ignore data races with only
> 1-bit value changes. Please see more details in in patch 7/7.
> 
> The rest of the patches are cleanups and improving configuration.
> 
> I ran some experiments to see what data races we're left with. With
> CONFIG_KCSAN_PERMISSIVE=y paired with syzbot's current KCSAN config
> (minimal kernel, most permissive KCSAN options), we're "just" about ~100
> reports away to a pretty silent KCSAN kernel:
> 
>   https://github.com/google/ktsan/tree/kcsan-permissive-with-dataraces
>   [ !!Disclaimer!! None of the commits are usable patches nor guaranteed
>     to be correct -- they merely resolve a data race so it wouldn't be
>     shown again and then moved on. Expect that simply marking is not
>     enough for some! ]
> 
> Most of the data races look interesting enough, and only few already had
> a comment nearby explaining what's happening.
> 
> All data races on current->flags, and most other flags are absent
> (unlike before). Those that were reported all had value changes with >1
> bit. A limitation is that few data races are still reported where the
> reader is only interested in 1 bit but the writer changed more than 1
> bit. A complete approach would require compiler changes in addition to
> the changes in this series -- but since that would further reduce the
> data races reported, the simpler and conservative approach is to stick
> to the value-change based rules for now.
> 
> Marco Elver (7):
>   kcsan: Improve some Kconfig comments
>   kcsan: Remove CONFIG_KCSAN_DEBUG
>   kcsan: Introduce CONFIG_KCSAN_STRICT
>   kcsan: Reduce get_ctx() uses in kcsan_found_watchpoint()
>   kcsan: Rework atomic.h into permissive.h
>   kcsan: Print if strict or non-strict during init
>   kcsan: permissive: Ignore data-racy 1-bit value changes
> 
>  Documentation/dev-tools/kcsan.rst | 12 ++++
>  kernel/kcsan/atomic.h             | 23 --------
>  kernel/kcsan/core.c               | 77 ++++++++++++++++---------
>  kernel/kcsan/kcsan_test.c         | 32 +++++++++++
>  kernel/kcsan/permissive.h         | 94 +++++++++++++++++++++++++++++++
>  lib/Kconfig.kcsan                 | 39 +++++++++----
>  6 files changed, 215 insertions(+), 62 deletions(-)
>  delete mode 100644 kernel/kcsan/atomic.h
>  create mode 100644 kernel/kcsan/permissive.h
> 
> -- 
> 2.32.0.rc1.229.g3e70b5a671-goog
> 
