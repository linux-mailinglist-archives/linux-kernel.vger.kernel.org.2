Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 310F03076CE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 14:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbhA1NLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 08:11:40 -0500
Received: from foss.arm.com ([217.140.110.172]:58672 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229684AbhA1NLh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 08:11:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 60D4231B;
        Thu, 28 Jan 2021 05:10:51 -0800 (PST)
Received: from e125579.fritz.box (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F16853F719;
        Thu, 28 Jan 2021 05:10:48 -0800 (PST)
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jeremy Kerr <jk@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Hillf Danton <hdanton@sina.com>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/3] sched: Task priority related cleanups
Date:   Thu, 28 Jan 2021 14:10:37 +0100
Message-Id: <20210128131040.296856-1-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(1) Removing MAX_USER_RT_PRIO was already discussed here in April 2020:

    https://lkml.kernel.org/r/20200423094403.6f1d2b8d@gandalf.local.home

(2) USER_PRIO() and related macros are not used anymore except in one
    case for powerpc where MAX_USER_PRIO can be replaced by NICE_WIDTH.
    Set_load_weight(), task_prio(), cpu_weight_nice_write_s64(),
    __update_max_tr() don't use USER_PRIO() but priority - MAX_RT_PRIO.

(3) The function header of task_prio() needs an update. It looks
    ancient since it mentions a prio space [-16 ... 15] for mormal
    tasks. I can't figure out why this range is mentioned here? Maybe
    the influence of the 'sleep-bonus interactivity' feature which was
    removed by commit f3479f10c5d6 ("sched: remove the sleep-bonus
    interactivity code")? 

Dietmar Eggemann (3):
  sched: Remove MAX_USER_RT_PRIO
  sched: Remove USER_PRIO, TASK_USER_PRIO and MAX_USER_PRIO
  sched/core: Update task_prio() function header

 arch/powerpc/platforms/cell/spufs/sched.c |  2 +-
 include/linux/sched/prio.h                | 18 +-----------------
 kernel/sched/core.c                       | 15 +++++++++------
 kernel/sched/sched.h                      |  2 +-
 4 files changed, 12 insertions(+), 25 deletions(-)

-- 
2.25.1

