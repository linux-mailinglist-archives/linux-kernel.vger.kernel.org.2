Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63DDA3AE604
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 11:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbhFUJaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 05:30:24 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:34136 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229597AbhFUJaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 05:30:23 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R751e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=changhuaixin@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0Ud8YYYK_1624267685;
Received: from localhost(mailfrom:changhuaixin@linux.alibaba.com fp:SMTPD_---0Ud8YYYK_1624267685)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 21 Jun 2021 17:28:06 +0800
From:   Huaixin Chang <changhuaixin@linux.alibaba.com>
To:     luca.abeni@santannapisa.it
Cc:     anderson@cs.unc.edu, baruah@wustl.edu, bsegall@google.com,
        changhuaixin@linux.alibaba.com, dietmar.eggemann@arm.com,
        dtcccc@linux.alibaba.com, juri.lelli@redhat.com,
        khlebnikov@yandex-team.ru, linux-kernel@vger.kernel.org,
        mgorman@suse.de, mingo@redhat.com, odin@uged.al, odin@ugedal.com,
        pauld@redhead.com, peterz@infradead.org, pjt@google.com,
        rostedt@goodmis.org, shanpeic@linux.alibaba.com, tj@kernel.org,
        tommaso.cucinotta@santannapisa.it, vincent.guittot@linaro.org,
        xiyou.wangcong@gmail.com
Subject: [PATCH v6 0/3] sched/fair: Burstable CFS bandwidth controller
Date:   Mon, 21 Jun 2021 17:27:57 +0800
Message-Id: <20210621092800.23714-1-changhuaixin@linux.alibaba.com>
X-Mailer: git-send-email 2.14.4.44.g2045bb6
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog:
v6:
- Separate burst config to cpu.max.burst.
- Rewrite commit log and document for burst feature.
- Remove global sysfsctl to disable burst feature.
- Some code mofication.
- Rebase upon v5.13-rc6.

v5:
- Rearrange into 3 patches, one less than the previous version.
- The interference to other groups are valued.
- Put a limit on burst, so that code is further simplified.
- Rebase upon v5.13-rc3.
Link:
https://lore.kernel.org/lkml/20210520123419.8039-1-changhuaixin@linux.alibaba.com/

v4:
- Adjust assignments in tg_set_cfs_bandwidth(), saving unnecessary
  assignemnts when quota == RUNTIME_INF.
- Getting rid of sysctl_sched_cfs_bw_burst_onset_percent, as there seems
  no justification for both controlling start bandwidth and a percent
  way.
- Comment improvement in sched_cfs_period_timer() shifts on explaining
  why max_overrun shifting to 0 is a problem.
- Rename previous_runtime to runtime_at_period_start.
- Add cgroup2 interface and documentation.
- Getting rid of exposing current_bw as there are not enough
  justification and the updating problem.
- Add justification on cpu.stat change in the changelog.
- Rebase upon v5.12-rc3.
- Correct SoB chain.
- Several indentation fixes.
- Adjust quota in schbench test from 700000 to 600000.
Link:
https://lore.kernel.org/lkml/20210316044931.39733-1-changhuaixin@linux.alibaba.com/

v3:
- Fix another issue reported by test robot.
- Update docs as Randy Dunlap suggested.
Link:
https://lore.kernel.org/lkml/20210120122715.29493-1-changhuaixin@linux.alibaba.com/

v2:
- Fix an issue reported by test robot.
- Rewriting docs. Appreciate any further suggestions or help.
Link:
https://lore.kernel.org/lkml/20210121110453.18899-1-changhuaixin@linux.alibaba.com/

v1 Link:
https://lore.kernel.org/lkml/20201217074620.58338-1-changhuaixin@linux.alibaba.com/

Previously, Cong Wang and Konstantin Khlebnikov proposed similar
feature:
https://lore.kernel.org/lkml/20180522062017.5193-1-xiyou.wangcong@gmail.com/
https://lore.kernel.org/lkml/157476581065.5793.4518979877345136813.stgit@buzz/

This time we present more latency statistics and handle overflow while
accumulating.

Huaixin Chang (3):
  sched/fair: Introduce the burstable CFS controller
  sched/fair: Add cfs bandwidth burst statistics
  sched/fair: Add document for burstable CFS bandwidth

 Documentation/admin-guide/cgroup-v2.rst | 17 +++---
 Documentation/scheduler/sched-bwc.rst   | 76 ++++++++++++++++++++++----
 include/linux/sched/sysctl.h            |  1 +
 kernel/sched/core.c                     | 96 ++++++++++++++++++++++++++-------
 kernel/sched/fair.c                     | 32 ++++++++++-
 kernel/sched/sched.h                    |  4 ++
 kernel/sysctl.c                         |  9 ++++
 7 files changed, 200 insertions(+), 35 deletions(-)

-- 
2.14.4.44.g2045bb6

