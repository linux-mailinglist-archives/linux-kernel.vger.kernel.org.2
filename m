Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3AAE413934
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 19:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbhIURx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 13:53:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:59592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231153AbhIURxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 13:53:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9B9BF60F6B;
        Tue, 21 Sep 2021 17:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1632246716;
        bh=pwvK+ahMREGGQzGaiM5/q6mz0KnvrF5UKb1ZkCF9P3E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=r73YLvfDHRUTeOKgJ6aT3t5bfX8XmG8wkcnKbQY2O2MvwWUR8xn+vLivXyRKxPdtj
         ggI/Zpb44arEE65ZMFAaugbbD3odV00+vEUuAVvkXOtjX0sxMfeNZezpT0ze8rp7m+
         hgwaECfL1jKtaHvrKpPx7qMHiPWvTegQALrzsf+M=
Date:   Tue, 21 Sep 2021 10:51:55 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     frederic@kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, tglx@linutronix.de, cl@linux.com,
        peterz@infradead.org, juri.lelli@redhat.com, mingo@redhat.com,
        mtosatti@redhat.com, nilal@redhat.com, mgorman@suse.de,
        ppandit@redhat.com, williams@redhat.com, bigeasy@linutronix.de,
        anna-maria@linutronix.de, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 0/6] mm: Remote LRU per-cpu pagevec cache/per-cpu page
 list drain support
Message-Id: <20210921105155.73961c904b1f3bb5a40912c6@linux-foundation.org>
In-Reply-To: <20210921161323.607817-1-nsaenzju@redhat.com>
References: <20210921161323.607817-1-nsaenzju@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Sep 2021 18:13:18 +0200 Nicolas Saenz Julienne <nsaenzju@redhat.com> wrote:

> This series introduces an alternative locking scheme around mm/swap.c's per-cpu
> LRU pagevec caches and mm/page_alloc.c's per-cpu page lists which will allow
> for remote CPUs to drain them. Currently, only a local CPU is permitted to
> change its per-cpu lists, and it's expected to do so, on-demand, whenever a
> process demands it (by means of queueing an drain task on the local CPU). Most
> systems will handle this promptly, but it'll cause problems for NOHZ_FULL CPUs
> that can't take any sort of interruption without breaking their functional
> guarantees (latency, bandwidth, etc...). Having a way for these processes to
> remotely drain the lists themselves will make co-existing with isolated CPUs
> possible, at the cost of more constraining locks.
> 
> Fortunately for non-NOHZ_FULL users, the alternative locking scheme and remote
> drain code are conditional to a static key which is disabled by default. This
> guarantees minimal functional or performance regressions. The feature will only
> be enabled if NOHZ_FULL's initialization process was successful.

That all looks pretty straightforward.  Obvious problems are:

- Very little test coverage for the spinlocked code paths.  Virtually
  all test setups will be using local_lock() and the code path you care
  about will go untested.

  I hope that whoever does test the spinlock version will be running
  full debug kernels, including lockdep.  Because adding a spinlock
  where the rest of the code expects local_lock might introduce
  problems.

  A fix for all of this would be to enable the spin_lock code paths
  to be tested more widely.  Perhaps you could add a boot-time kernel
  parameter (or, not as good, a Kconfig thing) which forces the use of
  the spinlock code even on non-NOHZ_FULL systems.

  Or perhaps this debug/testing mode _should_ be enabled by Kconfig,
  so kernel fuzzers sometimes turn it on.

  Please have a think about all of this?

- Maintainability.  Few other MM developers will think about this new
  spinlocked mode much, and they are unlikely to runtime test the
  spinlock mode.  Adding the force-spinlocks-mode-on knob will help
  with this.


