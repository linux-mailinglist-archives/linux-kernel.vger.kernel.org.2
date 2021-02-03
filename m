Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08C3030DEF3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 16:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234708AbhBCP7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 10:59:14 -0500
Received: from foss.arm.com ([217.140.110.172]:42532 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234645AbhBCPzz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 10:55:55 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D6795D6E;
        Wed,  3 Feb 2021 07:54:58 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9B5AD3F719;
        Wed,  3 Feb 2021 07:54:56 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     vincent.guittot@linaro.org, mgorman@suse.de, mingo@kernel.org,
        peterz@infradead.org, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, linuxarm@openeuler.org,
        xuwei5@huawei.com, liguozhu@hisilicon.com, tiantao6@hisilicon.com,
        wanghuiqiang@huawei.com, prime.zeng@hisilicon.com,
        jonathan.cameron@huawei.com, guodong.xu@linaro.org,
        Barry Song <song.bao.hua@hisilicon.com>,
        Meelis Roos <mroos@linux.ee>
Subject: [RFC PATCH 0/2] sched/topology: Get rid of overlapping groups
Date:   Wed,  3 Feb 2021 15:54:29 +0000
Message-Id: <20210203155432.10293-1-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

My keyboard still hasn't been taken away from me, so I went down and did what I
was rambling about in [1].

The preemptive degeneration check is the worst wart, but I think I'll have to
sleep on it before I can figure out a better way.

Something tells me the increase in group numbers isn't going to make me any
friends, so I've included 3/2 which is Barry's approach (with the subset check
condensed in a single spot).

Cheers,
Valentin

[1]: http://lore.kernel.org/r/jhj4kiu4hz8.mognet@arm.com

Valentin Schneider (2):
  sched/topology: Get rid of NUMA overlapping groups
  Revert "sched/topology: Warn when NUMA diameter > 2"

 kernel/sched/topology.c | 77 +++++++++++++++++++++++------------------
 1 file changed, 43 insertions(+), 34 deletions(-)

--
2.27.0

