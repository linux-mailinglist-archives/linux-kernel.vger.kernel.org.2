Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBD038AE5D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233948AbhETMgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:36:12 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:57896 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231661AbhETMfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:35:51 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=changhuaixin@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0UZVdWUN_1621514066;
Received: from localhost(mailfrom:changhuaixin@linux.alibaba.com fp:SMTPD_---0UZVdWUN_1621514066)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 20 May 2021 20:34:26 +0800
From:   Huaixin Chang <changhuaixin@linux.alibaba.com>
To:     changhuaixin@linux.alibaba.com
Cc:     bsegall@google.com, dietmar.eggemann@arm.com,
        dtcccc@linux.alibaba.com, juri.lelli@redhat.com,
        khlebnikov@yandex-team.ru, linux-kernel@vger.kernel.org,
        mgorman@suse.de, mingo@redhat.com, odin@uged.al, odin@ugedal.com,
        pauld@redhead.com, peterz@infradead.org, pjt@google.com,
        rostedt@goodmis.org, shanpeic@linux.alibaba.com, tj@kernel.org,
        vincent.guittot@linaro.org, xiyou.wangcong@gmail.com
Subject: [PATCH v5 0/3] sched/fair: Burstable CFS bandwidth controller
Date:   Thu, 20 May 2021 20:34:16 +0800
Message-Id: <20210520123419.8039-1-changhuaixin@linux.alibaba.com>
X-Mailer: git-send-email 2.14.4.44.g2045bb6
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog:
v5:
- Rearrange into 3 patches, one less than the previous version.
- The interference to other groups are valued.
- Put a limit on burst, so that code is further simplified.
- Rebase upon v5.13-rc3.

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

