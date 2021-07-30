Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25FB23DB44B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 09:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237748AbhG3HKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 03:10:32 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:46804 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230226AbhG3HKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 03:10:31 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R541e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=changhuaixin@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0UhQ.kzM_1627629022;
Received: from localhost(mailfrom:changhuaixin@linux.alibaba.com fp:SMTPD_---0UhQ.kzM_1627629022)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 30 Jul 2021 15:10:23 +0800
From:   Huaixin Chang <changhuaixin@linux.alibaba.com>
To:     peterz@infradead.org
Cc:     anderson@cs.unc.edu, baruah@wustl.edu, bsegall@google.com,
        changhuaixin@linux.alibaba.com, dietmar.eggemann@arm.com,
        dtcccc@linux.alibaba.com, juri.lelli@redhat.com,
        khlebnikov@yandex-team.ru, linux-kernel@vger.kernel.org,
        luca.abeni@santannapisa.it, mgorman@suse.de, mingo@redhat.com,
        odin@uged.al, odin@ugedal.com, pauld@redhead.com, pjt@google.com,
        rostedt@goodmis.org, shanpeic@linux.alibaba.com, tj@kernel.org,
        tommaso.cucinotta@santannapisa.it, vincent.guittot@linaro.org,
        xiyou.wangcong@gmail.com
Subject: [PATCH 0/2] Add statistics and ducument for cfs bandwidth burst
Date:   Fri, 30 Jul 2021 15:09:54 +0800
Message-Id: <20210730070956.44019-1-changhuaixin@linux.alibaba.com>
X-Mailer: git-send-email 2.14.4.44.g2045bb6
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Huaixin Chang (2):
  sched/fair: Add cfs bandwidth burst statistics
  sched/fair: Add document for burstable CFS bandwidth

 Documentation/admin-guide/cgroup-v2.rst |  8 ++++
 Documentation/scheduler/sched-bwc.rst   | 85 +++++++++++++++++++++++++++++----
 kernel/sched/core.c                     | 13 +++--
 kernel/sched/fair.c                     |  9 ++++
 kernel/sched/sched.h                    |  3 ++
 5 files changed, 105 insertions(+), 13 deletions(-)

-- 
2.14.4.44.g2045bb6

