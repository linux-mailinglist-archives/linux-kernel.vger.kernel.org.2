Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D608631A07E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 15:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbhBLOSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 09:18:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbhBLOSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 09:18:30 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645D3C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 06:17:50 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id n10so1151560wmq.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 06:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=iiujjOHvtZAODEfLb0tLU6fe/RCnQvJN34qWX/IBjDs=;
        b=Q9axIxcfsuiTwGYtL3ogQFVF5XEC/BSmo2SMLwXNMYIeIoxhj1L0iYWMxNyrle8atn
         CHPeanuzlQbWnEomeS6ZIrXZeECiYQARcCeX2Mj2ihYW6zN+ahbQwddI4b9rfBqWOoqq
         5S0/ePct9yYq98SNoohwR3oGNGYsCuA+MssMnl31Wm0TByByz0V4Om1NhAlNtqxTySAa
         JXmbUcS/sOD9tupYvlG2yhJAuXlz0kdSSXx+L46Rk3MhU0DMdw74oDU89PTvZHWgBp7V
         Nlx8Jly+HjHHftv33Hk9rdnO3Fq+bPnR2hOPFbeeaxnEGo31mrt6BgZkFMyF0d8ZCTEh
         WYWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iiujjOHvtZAODEfLb0tLU6fe/RCnQvJN34qWX/IBjDs=;
        b=Eq4K0QL9+T3EJSt0yw2i9bSj7eJHpemzav1gUqOBg4VwHri16HJRRD4icrsIr4H7l9
         0WNPSf7TM9XUeMnIL2nu6C4BNDxE5dj62sZkbl9uKW0aDm3/zRADaur3yB27SgmzL4nA
         PDy4j2HAVHHiKDE5AfOTDUWVYh1JS6QKoH6qPLkTTHq3Mh6w4ylt2Jc6zM9n8yZmVXp6
         qrMClrur+uZKz2gPrQGtsSMKBl7rEuoIoREqKvjR21QeGMMlUZpxBsatcA3e6dz3SK4N
         lHpYlicLSkge2UcQig13hmmy1fR5AjG9K186F2EKYcWRAWFAtpKmGg0KG13FaQcKbXkk
         EhZw==
X-Gm-Message-State: AOAM533d6BfNUaUYet/5d4tsKPFfxXbV7HnLhyRUSB2GOpK3Y2Bi7Pg9
        8dlaSL3gx0qdzu6ExzCSnN+YeA==
X-Google-Smtp-Source: ABdhPJz8BBe5FK6Jpvlrk53veLie+sZ+9n9KBZO69HxRdOMC5F7isahhd/Jaq5K3wE+KwOH6OxV+Ww==
X-Received: by 2002:a1c:20c7:: with SMTP id g190mr2836838wmg.156.1613139469002;
        Fri, 12 Feb 2021 06:17:49 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:ad4e:cdb3:8eaf:6329])
        by smtp.gmail.com with ESMTPSA id f14sm14254156wmj.30.2021.02.12.06.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 06:17:47 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org, valentin.schneider@arm.com
Cc:     fweisbec@gmail.com, tglx@linutronix.de, qais.yousef@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 0/7 v3] move update blocked load outside newidle_balance
Date:   Fri, 12 Feb 2021 15:17:37 +0100
Message-Id: <20210212141744.24284-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joel reported long preempt and irq off sequence in newidle_balance because
of a large number of CPU cgroups in use and having to be updated. This
patchset moves the update outside newidle_imblance. This enables to early
abort during the updates in case of pending irq as an example.

Instead of kicking a normal ILB that will wakes up CPU which is already
idle, patch 6 triggers the update of statistics in the idle thread of
the CPU before selecting and entering an idle state.

Changes on v3:
- Fixed a compilation error for !CONFIG_SMP && CONFIG_NO_HZ_COMMON
  reported by kernel test robot <lkp@intel.com>
- Took advantage of this new version to add a short desciption for
  nohz_run_idle_balance

Changes on v2:
- Fixed some typos and updated some comments
- Added more cleanup
- Changed to way to trigger ILB in idle thread context to remove a possible
  race condition between the normal softirq ILB and this new mecanism. The
  cpu can already be set in idle_cpus_mask because even if the cpu is added
  later when entering idle, it might not have been removed yet from previous
  idle phase.
  
Vincent Guittot (7):
  sched/fair: remove update of blocked load from newidle_balance
  sched/fair: remove unused return of _nohz_idle_balance
  sched/fair: remove unused parameter of update_nohz_stats
  sched/fair: merge for each idle cpu loop of ILB
  sched/fair: reorder newidle_balance pulled_task tests
  sched/fair: trigger the update of blocked load on newly idle cpu
  sched/fair: reduce the window for duplicated update

 kernel/sched/fair.c  | 118 +++++++++++++++++--------------------------
 kernel/sched/idle.c  |   6 +++
 kernel/sched/sched.h |   5 ++
 3 files changed, 57 insertions(+), 72 deletions(-)

-- 
2.17.1

