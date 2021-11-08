Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 496D5447F32
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 13:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239362AbhKHMDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 07:03:15 -0500
Received: from foss.arm.com ([217.140.110.172]:49508 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237972AbhKHMDL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 07:03:11 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B2442B;
        Mon,  8 Nov 2021 04:00:27 -0800 (PST)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 596BD3F7F5;
        Mon,  8 Nov 2021 04:00:26 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH] sched: Tweak default dynamic preempt mode selection
In-Reply-To: <202111061341.QdauxAuH-lkp@intel.com>
References: <20211105104035.3112162-1-valentin.schneider@arm.com> <202111061341.QdauxAuH-lkp@intel.com>
Date:   Mon, 08 Nov 2021 12:00:17 +0000
Message-ID: <878rxyeu26.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/11/21 13:05, kernel test robot wrote:
>    kernel/sched/core.c:3439:6: error: no previous prototype for function 'sched_set_stop_task' [-Werror,-Wmissing-prototypes]
>    void sched_set_stop_task(int cpu, struct task_struct *stop)
>         ^
>    kernel/sched/core.c:3439:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    void sched_set_stop_task(int cpu, struct task_struct *stop)
>    ^
>    static
>>> kernel/sched/core.c:6576:2: error: use of undeclared identifier '__SCT__preempt_schedule'
>            static_call_update(preempt_schedule, __preempt_schedule_func);
>            ^

Doh, I broke the

  PREEMPT_DYNAMIC
    select PREEMPT

thing - the above happens with PREEMPT_DYNAMIC && !PREEMPT. Lemme fix.
