Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51EDB3FB388
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 12:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236282AbhH3KCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 06:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbhH3KCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 06:02:32 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7311FC061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 03:01:38 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id u14so29790388ejf.13
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 03:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=rL/KWoHVIOkxu32E107ymMHJoAMuK7HzP7/sGiSlvcw=;
        b=eGfp7h265z5rg7qEzQDdQzxrp3Nly6ZRQoWgwkY4+7apQNZbvOfWe0/lms1BrG3xTC
         s2XiNB0I5VcdtXfA769ePvt2vHgSRfWE6uJ2ML7bazEx8dM91q7BErht9sgTCfbWLnPn
         8vpDYabT2TeEE+SnI5mPPuwTj3MoCHLLCVuC1z/NA+a9PzoqNQ037mnRDZg78or9T6D0
         XeBU3XaG6UWBVZkHz27IxJdukbZpnCScztwpmRc2pchvdeuJZyBH6d4WvV/xAskbf508
         EfHWNITcOLDgJt0MRTrsa170Br9qTeI0vo9DKp9OSUbURPayJsf0ZUNgo9m67mHGatKM
         yj8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:content-transfer-encoding;
        bh=rL/KWoHVIOkxu32E107ymMHJoAMuK7HzP7/sGiSlvcw=;
        b=uVq4n7LXSfonbaTjE12RNRK2m1j433WAHW9P0gqktt6/WwY39HcX8Fa/HQCFoS1wab
         GfirCupaHTCuDHp+CqAItd7EMKgvcut7uDdFuv2y3piUPjTfdo8K922rmNW510V//chF
         ohBnP0kgZX0aX2pawwktSb09zEzm+uDNaSKrlH11UBrhJaxAo8pPT5VpgPEZe0P7Xx8P
         NgDwYXPbtyKLy58oMWUHlibXM4li1mRsa/GYutjgi5RRQIESEyO0uAcSoO2TXRO4D6Y0
         uthCqfR7B+bh1NW+Ba1NXvNppWNnJ3uZJ71sun7SEXYMgcFiodZXQU9tvOiROML34HQO
         4ltg==
X-Gm-Message-State: AOAM531phglineQqeHV65arGxHZnwts7hATSyxxvqhbMH+wBexpRzIJA
        5sMtvqPHLDsnxodEDGw/jgVpbzHSGwU=
X-Google-Smtp-Source: ABdhPJyGO+OiBV/EGr9sAYLKgklcOFY8KmXcxw3Q9jST61EHv8B3PluI6XM+pc/qtQEmKUPbDqLhUA==
X-Received: by 2002:a17:906:a195:: with SMTP id s21mr24310026ejy.181.1630317696660;
        Mon, 30 Aug 2021 03:01:36 -0700 (PDT)
Received: from gmail.com (0526ECFD.dsl.pool.telekom.hu. [5.38.236.253])
        by smtp.gmail.com with ESMTPSA id cr9sm7338965edb.17.2021.08.30.03.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 03:01:36 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 30 Aug 2021 12:01:34 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>
Subject: [GIT PULL] scheduler changes for v5.15
Message-ID: <YSysfvjjG6UboKMD@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest sched/core git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-2021-08-30

   # HEAD: b542e383d8c005f06a131e2b40d5889b812f19c6 eventfd: Make signal recursion protection a task bit

Scheduler changes for v5.15 are:

- The biggest change in this cycle is scheduler support for asymmetric
  scheduling affinity, to support the execution of legacy 32-bit tasks on
  AArch32 systems that also have 64-bit-only CPUs.

  Architectures can fill in this functionality by defining their
  own task_cpu_possible_mask(p). When this is done, the scheduler will
  make sure the task will only be scheduled on CPUs that support it.

  (The actual arm64 specific changes are not part of this tree.)

  For other architectures there will be no change in functionality.

- Add cgroup SCHED_IDLE support

- Increase node-distance flexibility & delay determining it until a CPU
  is brought online. (This enables platforms where node distance isn't
  final until the CPU is only.)

- Deadline scheduler enhancements & fixes

- Misc fixes & cleanups.

 Thanks,

	Ingo

------------------>
Dietmar Eggemann (1):
      sched/deadline: Fix missing clock update in migrate_task_rq_dl()

Hailong Liu (1):
      sched/sysctl: Move extern sysctl declarations to sched.h

Ingo Molnar (1):
      sched/fair: Mark tg_is_idle() an inline in the !CONFIG_FAIR_GROUP_SCHED case

Josh Don (1):
      sched: Cgroup SCHED_IDLE support

Julian Wiedmann (1):
      wait: use LIST_HEAD_INIT() to initialize wait_queue_head

Mel Gorman (2):
      sched/fair: Use prev instead of new target as recent_used_cpu
      sched/fair: Avoid a second scan of target in select_idle_cpu

Mika Penttilä (1):
      sched/numa: Fix is_core_idle()

Quentin Perret (4):
      sched/deadline: Fix reset_on_fork reporting of DL tasks
      sched: Don't report SCHED_FLAG_SUGOV in sched_getattr()
      sched: Fix UCLAMP_FLAG_IDLE setting
      sched: Skip priority checks with SCHED_FLAG_KEEP_PARAMS

Sebastian Andrzej Siewior (1):
      sched: Replace deprecated CPU-hotplug functions.

Thomas Gleixner (1):
      eventfd: Make signal recursion protection a task bit

Valentin Schneider (2):
      sched/debug: Don't update sched_domain debug directories before sched_debug_init()
      sched/topology: Skip updating masks for non-online nodes

Wang Hui (1):
      sched: remove redundant on_rq status change

Will Deacon (9):
      sched: Introduce task_cpu_possible_mask() to limit fallback rq selection
      cpuset: Don't use the cpu_possible_mask as a last resort for cgroup v1
      cpuset: Honour task_cpu_possible_mask() in guarantee_online_cpus()
      cpuset: Cleanup cpuset_cpus_allowed_fallback() use in select_fallback_rq()
      sched: Reject CPU affinity changes based on task_cpu_possible_mask()
      sched: Introduce task_struct::user_cpus_ptr to track requested affinity
      sched: Split the guts of sched_setaffinity() into a helper function
      sched: Allow task CPU affinity to be restricted on asymmetric systems
      sched: Introduce dl_task_check_affinity() to check proposed affinity

Yuan ZhaoXiong (1):
      sched: Optimize housekeeping_cpumask() in for_each_cpu_and()


 fs/aio.c                     |   2 +-
 fs/eventfd.c                 |  12 +-
 include/linux/cpuset.h       |   8 +-
 include/linux/eventfd.h      |  11 +-
 include/linux/mmu_context.h  |  14 ++
 include/linux/sched.h        |  25 +++
 include/linux/sched/sysctl.h |  18 --
 include/linux/wait.h         |   2 +-
 init/init_task.c             |   1 +
 kernel/cgroup/cpuset.c       |  59 ++++--
 kernel/fork.c                |   2 +
 kernel/sched/core.c          | 440 ++++++++++++++++++++++++++++++++++---------
 kernel/sched/deadline.c      |   8 +-
 kernel/sched/debug.c         |  10 +
 kernel/sched/fair.c          | 211 +++++++++++++++++----
 kernel/sched/sched.h         |  26 +++
 kernel/sched/topology.c      |  65 +++++++
 17 files changed, 729 insertions(+), 185 deletions(-)
