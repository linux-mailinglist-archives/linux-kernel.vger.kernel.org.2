Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2977132403E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 16:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235160AbhBXOoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 09:44:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236995AbhBXNcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 08:32:25 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631B8C061793
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 05:30:25 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id w7so1791619wmb.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 05:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=UOFwRD1FgRA6MEC5Xp6hiDeGTtRx5W6SwmdjJ6Nc2V0=;
        b=oqRPByOyUUv4ZTcjnRH8Vdp0VJ+aeUd8eE5ueydEefmztprKnoEbSw/HWx2rFTKD1R
         BeMsYIjEFLI+UWWEx3XCuEFUKOaklgfFQaxhrhKeglqWH/gbcop6DcHWG4+ETqY9spHG
         JUdyw4V60xTHcnOwvUN45NHtXD3eBjHJl2pYbqZjAvJJlrVK4KG+EK76vyQhGieSrXL5
         PsFEyLDqj3fANbyqlrWF1aMvZ91vj+x+UxpUcrccVHsKiWU+v7alj/pw2R7/KnOWhmiD
         hrU3fKVXvqw93dC1HjmXsVQmPAEJRwsk9SSZsfV6gDpXU6+gO6hkQkhjc7ljmTMtH+Ee
         QUOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UOFwRD1FgRA6MEC5Xp6hiDeGTtRx5W6SwmdjJ6Nc2V0=;
        b=M1/EIuuCAwwr6XHzG9U6K9WvfjfwrZCWXFeKAFFfwWLNvVOFru439kF+vBqSBTD3oO
         XVpLE2IsOmoII3z2H/YgoO74LWl8IKhtdbN94rcmcTpbrR6Qs06Wuu97UYCsUpFsblbg
         mPYt6IGiuQZzplTHuEisF1Hf1wfqcg3IgiA/IEvRe2MsVHvFovYAKaW1WFVYdsl9a0xy
         SuI0o3HTVEKOWuO0l7+sw0yR3fGx2NxdzjNHHkWo4joDFEQZZf7LoXjvnqhHxeIM5wma
         gYYTWr0xSZIpFOhGaZcjygSKeUsEDSd+Wg5iu6KeNdwXQVmWfvUuGafd9JuiGp7TGAmi
         lORA==
X-Gm-Message-State: AOAM530A4HkiBuJJ3dZvHLwsA+PnuImhdSz46sSwP9y1BglCbfdu/JKz
        cbIdmtfuMqTIrqJa0N4NsTfPOA==
X-Google-Smtp-Source: ABdhPJzklsUYtIy+9cvRcTvFD81+6JqDBJEFP+o8/8ZCV6gB0jw1kmK7IsJXHVYbWs/Fvfc+Yb83bw==
X-Received: by 2002:a05:600c:410a:: with SMTP id j10mr3682546wmi.172.1614173424013;
        Wed, 24 Feb 2021 05:30:24 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:58e9:8af9:3cd4:ded2])
        by smtp.gmail.com with ESMTPSA id h10sm552611wrp.22.2021.02.24.05.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 05:30:23 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org, valentin.schneider@arm.com
Cc:     fweisbec@gmail.com, tglx@linutronix.de, qais.yousef@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 0/7 v4] move update blocked load outside newidle_balance
Date:   Wed, 24 Feb 2021 14:30:00 +0100
Message-Id: <20210224133007.28644-1-vincent.guittot@linaro.org>
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

Changes on v4:
- Add a dedicated bit for updating blocked load when entering idle.
  This simplifies the management of concurrency with kick_ilb.

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

 kernel/sched/core.c  |   2 +-
 kernel/sched/fair.c  | 118 +++++++++++++++++--------------------------
 kernel/sched/idle.c  |   6 +++
 kernel/sched/sched.h |   7 +++
 4 files changed, 60 insertions(+), 73 deletions(-)

-- 
2.17.1

