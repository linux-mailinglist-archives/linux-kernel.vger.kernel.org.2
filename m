Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA2939B7EF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 13:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbhFDLdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 07:33:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:34240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229740AbhFDLdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 07:33:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4A839613F9;
        Fri,  4 Jun 2021 11:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622806324;
        bh=HBQeEl/CUgi+q6JezbobhTZCvfu9mgxmoaahKITVgPQ=;
        h=From:To:Cc:Subject:Date:From;
        b=LBUxY5BpUKhPrEgSAYTDfML8Y2JaVbPPeF/f6lpCOStOUQfmoe+vfBVkC03Qn927K
         6xei27p1wkZ84eDYGFfnYKfnjEAGlq4pfpaAdW27UruWgpIY+jrHQk2CkoImnIFNNI
         kg4479S83pvscF4Dq4+NccM77ZAAh3PHFbiIczkXkOeCD5QNtyRahwkdiDvy8QJ/PL
         VfCmUV89hh80Ut5W2jXMMzLZqX6R1GwJqvuCqNWBrB3UAL+Xfi6jh3PZ3tJFwqwoIc
         BkIMyL2+xW7uleVKQyZvnxa32fm/PwcLyq7eVKd1zny2ZQxmyPpsN+tMrttCE2IQ4q
         90zEIK9GHvOng==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 0/6] posix-cpu-timers: Bunch of fixes 
Date:   Fri,  4 Jun 2021 13:31:53 +0200
Message-Id: <20210604113159.26177-1-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first is a race due to locklessly starting process wide cputime
counting.

The others stop the process wide cputime counting and tick dependency
when they are not necessary anymore.

Note I don't really like patch 5/6 and in fact I hope we could manage to
remove this early inline cpu_timer_fire() call from timer_settime(). All
we get from it is headaches. Besides, the handler isn't invoked from the
actual target and that doesn't sound ideal.

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	timers/urgent

HEAD: f8f908c9d2b2f1e100cd549206c95a4e65e5f023

Thanks,
	Frederic
---

Frederic Weisbecker (6):
      posix-cpu-timers: Fix rearm racing against process tick
      posix-cpu-timers: Don't start process wide cputime counter if timer is disabled
      posix-cpu-timers: Force next_expiration recalc after timer deletion
      posix-cpu-timers: Force next_expiration recalc after timer reset
      posix-cpu-timers: Force next expiration recalc after early timer firing
      posix-cpu-timers: Force next expiration recalc after itimer reset


 include/linux/posix-timers.h   | 11 ++++-
 kernel/time/posix-cpu-timers.c | 97 +++++++++++++++++++++++++++++++++---------
 2 files changed, 87 insertions(+), 21 deletions(-)
