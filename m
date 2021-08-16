Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5BE73ECEFB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 09:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233725AbhHPHJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 03:09:48 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:37812 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233349AbhHPHJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 03:09:48 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=changhuaixin@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0Uj7Ybxv_1629097753;
Received: from localhost(mailfrom:changhuaixin@linux.alibaba.com fp:SMTPD_---0Uj7Ybxv_1629097753)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 16 Aug 2021 15:09:13 +0800
From:   Huaixin Chang <changhuaixin@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, anderson@cs.unc.edu, baruah@wustl.edu,
        bsegall@google.com, changhuaixin@linux.alibaba.com,
        dietmar.eggemann@arm.com, dtcccc@linux.alibaba.com,
        juri.lelli@redhat.com, khlebnikov@yandex-team.ru,
        luca.abeni@santannapisa.it, mgorman@suse.de, mingo@redhat.com,
        odin@uged.al, odin@ugedal.com, pauld@redhead.com, pjt@google.com,
        rostedt@goodmis.org, shanpeic@linux.alibaba.com, tj@kernel.org,
        tommaso.cucinotta@santannapisa.it, vincent.guittot@linaro.org,
        xiyou.wangcong@gmail.com
Subject: [PATCH 0/2] Add statistics and document for cfs bandwidth burst
Date:   Mon, 16 Aug 2021 15:08:47 +0800
Message-Id: <20210816070849.3153-1-changhuaixin@linux.alibaba.com>
X-Mailer: git-send-email 2.14.4.44.g2045bb6
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comparison in __refill_cfs_bandwidth_runtime is further simplified.

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

