Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A380B45316C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 12:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235584AbhKPLyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 06:54:50 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:36846 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235629AbhKPLyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 06:54:39 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=rocking@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0UwtJaDZ_1637063498;
Received: from localhost(mailfrom:rocking@linux.alibaba.com fp:SMTPD_---0UwtJaDZ_1637063498)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 16 Nov 2021 19:51:38 +0800
From:   Peng Wang <rocking@linux.alibaba.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] Add busy loop polling for idle SMT
Date:   Tue, 16 Nov 2021 19:51:35 +0800
Message-Id: <cover.1637062971.git.rocking@linux.alibaba.com>
X-Mailer: git-send-email 2.9.5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now we have cpu_idle_force_poll which uses cpu_relax() waiting for
an arriving IPI, while sometimes busy loop on idle cpu is also
useful to provide consistent pipeline interference for hardware SMT.

When hardware SMT is enabled, the switching between idle and
busy state of one cpu will cause performance fluctuation of
other sibling cpus on the same core.

In pay-for-execution-time scenario, cloud service providers prefer
stable performance data to set stabel price for same workload.
Different execution time of the same workload caused by different
idle or busy state of sibling SMT cpus will make different bills, which
is confused for customers.

Since there is no dynamic CPU time scaling based on SMT pipeline interference,
to coordinate sibling SMT noise no matter whether they are idle or not,
busy loop in idle state can provide approximately consistent pipeline interference.

For example, a workload computing tangent and cotangent will finish in 9071ms when
sibling SMT cpus are idle, and 13299ms when sibling SMT cpus are computiing other workload.
This generate 32% performance fluctuation.

SMT idle polling makes things slower, but we can set bigger cpu quota to make up
a deficiency. This also increase power consumption by 2.2%, which is acceptable.

There may be some other possible solutions, while each has its own problem:
a) disbale hardware SMT, which means half of SMT is unused and more hardware cost.
b) busy loop in a userspace thread, but the cpu usage is confusing.

We propose this patch to discuss the performance fluctuation problem related to SMT
pipeline interference, and any comments are welcome.

Peng Wang (1):
  sched/idle: support busy loop polling on idle SMT cpus

 arch/Kconfig         | 10 ++++++
 kernel/sched/core.c  | 39 ++++++++++++++++++++++
 kernel/sched/idle.c  | 91 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h | 18 +++++++++++
 4 files changed, 158 insertions(+)

-- 
2.9.5

