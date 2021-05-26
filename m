Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22D503921B0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 22:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233701AbhEZU7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 16:59:32 -0400
Received: from foss.arm.com ([217.140.110.172]:49866 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232716AbhEZU7b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 16:59:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B91811D4;
        Wed, 26 May 2021 13:57:59 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A11383F73B;
        Wed, 26 May 2021 13:57:57 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Quentin Perret <qperret@google.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kernel-team@android.com
Subject: [PATCH 0/2] sched: SCA vs hotplug vs stopper races fixes
Date:   Wed, 26 May 2021 21:57:49 +0100
Message-Id: <20210526205751.842360-1-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

This is the continuation of [1]. As Will noted, that patch isn't sufficient to
plug all the nasty races involving SCA, hotplug and the stopper task, hence
patch 2.

I have to apologize as this didn't see much testing (a CPU hog, a crazed
taskset, and some hotplugs in a loop), and unfortunately I need to call it a day
before running away to the british wilderness 'till Monday. I'll get back to it
then to expunge the remaining daftness.  

[1]: http://lore.kernel.org/r/877djlhhmb.mognet@arm.com

Cheers,
Valentin

Valentin Schneider (2):
  sched: Don't defer CPU pick to migration_cpu_stop()
  sched: Plug race between SCA, hotplug and migration_cpu_stop()

 kernel/sched/core.c | 50 ++++++++++++++++++++++++++++++---------------
 1 file changed, 33 insertions(+), 17 deletions(-)

--
2.25.1

