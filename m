Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51AF03D7C10
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 19:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbhG0RUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 13:20:04 -0400
Received: from foss.arm.com ([217.140.110.172]:41632 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229537AbhG0RUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 13:20:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 02D561FB;
        Tue, 27 Jul 2021 10:20:03 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4133A3F70D;
        Tue, 27 Jul 2021 10:20:01 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [patch 00/50] locking, sched: The PREEMPT-RT locking infrastructure
In-Reply-To: <20210713151054.700719949@linutronix.de>
References: <20210713151054.700719949@linutronix.de>
Date:   Tue, 27 Jul 2021 18:19:56 +0100
Message-ID: <87v94vllmr.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/07/21 17:10, Thomas Gleixner wrote:
> The series survived quite some internal testing in RT kernels and is part
> of the recent 5.13-rt1 release.
>
> For !RT kernels there is no functional change.
>
> The series is also available from git:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git rtmutex
>

FWIW I've had this (well 5.13-rt1 + some arm64 PREEMPT_RT fixes) running
over a variety of arm64 hardware + locktorture, and nothing has broken
yet.

Tested-by: Valentin Schneider <valentin.schneider@arm.com>

> Thanks,
>
>       tglx
> ---
>  a/kernel/locking/mutex-debug.h       |   29 -
>  b/include/linux/mutex.h              |  165 ++++--
>  b/include/linux/rbtree_types.h       |   34 +
>  b/include/linux/rwbase_rt.h          |   37 +
>  b/include/linux/rwlock_rt.h          |  140 +++++
>  b/include/linux/spinlock_rt.h        |  151 +++++
>  b/include/linux/spinlock_types_raw.h |   65 ++
>  b/kernel/locking/rtmutex_api.c       |  647 ++++++++++++++++++++++++
>  b/kernel/locking/rwbase_rt.c         |  263 +++++++++
>  b/kernel/locking/spinlock_rt.c       |  257 +++++++++
>  include/linux/debug_locks.h          |    3
>  include/linux/preempt.h              |    4
>  include/linux/rbtree.h               |   30 -
>  include/linux/rtmutex.h              |    4
>  include/linux/rwlock_types.h         |   39 +
>  include/linux/rwsem.h                |   58 ++
>  include/linux/sched.h                |   77 ++
>  include/linux/sched/wake_q.h         |    7
>  include/linux/spinlock.h             |   15
>  include/linux/spinlock_api_smp.h     |    3
>  include/linux/spinlock_types.h       |   45 +
>  include/linux/ww_mutex.h             |   16
>  kernel/Kconfig.locks                 |    2
>  kernel/futex.c                       |  466 ++++++++++++-----
>  kernel/locking/Makefile              |    3
>  kernel/locking/mutex-debug.c         |   25
>  kernel/locking/mutex.c               |  139 ++---
>  kernel/locking/mutex.h               |   35 +
>  kernel/locking/rtmutex.c             |  930 ++++++++++++-----------------------
>  kernel/locking/rtmutex_common.h      |  110 ++--
>  kernel/locking/rwsem.c               |  108 ++++
>  kernel/locking/spinlock.c            |    7
>  kernel/locking/spinlock_debug.c      |    5
>  kernel/sched/core.c                  |  111 +++-
>  lib/test_lockup.c                    |    8
>  35 files changed, 3031 insertions(+), 1007 deletions(-)
