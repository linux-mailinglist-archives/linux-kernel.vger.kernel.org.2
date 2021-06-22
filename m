Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7275E3B10B2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 01:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbhFVXoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 19:44:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:52464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229747AbhFVXoT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 19:44:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 832DF61001;
        Tue, 22 Jun 2021 23:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624405323;
        bh=qZQkBLOe98WsjGPAxnla3e+Hq/ezUT9cZQPV+QJE7ys=;
        h=From:To:Cc:Subject:Date:From;
        b=sUSquB2YrYXoUP3Uq1KLtWR4sMLS62PmsLvsjeBMj0HCi0X/HMrhP2on9YHDhbBen
         z5uvWgt5RU7QoC7lHpKnkBQvGbrtZftzyOtutKuthMejgw6tGfgskzwfSj7KCkNxLO
         A3LMF1UQ85CVJct3Phe+8piSt1F3yoMn9n05CqEHCPKTqYtKQoxowBCaRadrXWjb6+
         kTRlsohja/iJgO7N37oDU8EOCiPju0H2FJfUrtjhSSUMWm1gsx9mxeCKbJ6OzbuBPI
         yq7AL+6vF/rT668xg5nQPjzU1haGP3v0jXr6peYmjOB2e57hCPs7vKrkotq267C223
         cc0f2/YnYAKYw==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 0/7] posix-cpu-timers: Bunch of fixes v2
Date:   Wed, 23 Jun 2021 01:41:48 +0200
Message-Id: <20210622234155.119685-1-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series addresses reviews from Peter. I also updated with appopriate
tags:

_ Add Fixes and Stable tags on the 1st patch

_ Add Acks from Peter on two patches

_ Elaborate comment about base expiration reset on
	"posix-cpu-timers: Force next_expiration recalc after timer deletion"
  (per Peter)

_ Assert sighand is locked on thread_group_start_cputime()
  (per Peter)

_ Factorize fix for all cases where timer doesn't get queued on
  posix_cpu_timer_set() (per Peter)

_ More cleanups

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	timers/urgent-v2

HEAD: 9cc6f1cc0e96053d709dd05b64ba5796a5b13664

Thanks,
	Frederic
---

Frederic Weisbecker (7):
      posix-cpu-timers: Fix rearm racing against process tick
      posix-cpu-timers: Assert task sighand is locked while starting cputime counter
      posix-cpu-timers: Force next_expiration recalc after timer deletion
      posix-cpu-timers: Force next expiration recalc after itimer reset
      posix-cpu-timers: Remove confusing error code override
      posix-cpu-timers: Consolidate timer base accessor
      posix-cpu-timers: Recalc next expiration when timer_settime() ends up not queueing


 include/linux/posix-timers.h   |  11 ++++-
 include/linux/sched/signal.h   |   6 +++
 kernel/signal.c                |  13 ++++++
 kernel/time/posix-cpu-timers.c | 100 ++++++++++++++++++++++++++++++++---------
 4 files changed, 106 insertions(+), 24 deletions(-)
