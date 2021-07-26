Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8F03D59E3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 14:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234253AbhGZMOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 08:14:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:50476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234072AbhGZMOu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 08:14:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CC70B60F45;
        Mon, 26 Jul 2021 12:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627304119;
        bh=dF3bcYVZjrToiiFeynXBJaQUeLiCWZ2ycIVhBM/7cL4=;
        h=From:To:Cc:Subject:Date:From;
        b=h+GTM4yIgwK7NwN1rE9GFXzg5B63lX7ZvCdKFiw4ub1TGEwwiLNeqGtGV2tnQ7KkM
         xWEXnsGhhvzbmFGi6mOiAeFjX7EYyo4jm9G4SzuOwtIH/8W64JDg4edfHxbUv8as5N
         nUSBVAn2na5FuRFE9Iucu5R0JGbSq42bnECdBKyiCAA+TkIWG09OiarCd7CX0YaEcY
         iW/xkwnGTXLWTSA2WKnMJT3bsJXRE9ifh+59xXlvzp1QiQU3kOcwqS8Kkp+9SV3gf9
         5sO92cumcM3pg3bZa7JGLCYPIaGW1ckQ4xRWkt0NWVc6OOr3HJKhrsDZkKbE3OInFD
         4RLQk7rjTRR8A==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: [GIT PULL] posix-cpu-timers leftover overhead fixes
Date:   Mon, 26 Jul 2021 14:55:07 +0200
Message-Id: <20210726125513.271824-1-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas, Ingo,

Please pull the timers/core branch that can be found at:

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	timers/core

HEAD: 63a17eea7d5516f9e927fdc52b45f1d040fdcf35

---

Those are not regression fixes since these bugs precede the git-era,
therefore they are not carrying a stable tag.

Several posix cpu timers events (setting, deletion, expiration) may end
up leaving needless elapsing overhead after a timer has stopped or
even after it has been deleted. Those overhead are:

1) Costly process wide cputime accounting that rely on concurrent atomic
addition during tick or even more frequent scheduler internal stat updates.

2) Retained tick dependency on NOHZ_FULL configurations.

Hopefully this series gets rid of all the possible culprits.

Thanks,
	Frederic
---

Frederic Weisbecker (6):
      posix-cpu-timers: Assert task sighand is locked while starting cputime counter
      posix-cpu-timers: Force next_expiration recalc after timer deletion
      posix-cpu-timers: Force next expiration recalc after itimer reset
      posix-cpu-timers: Remove confusing error code override
      posix-cpu-timers: Consolidate timer base accessor
      posix-cpu-timers: Recalc next expiration when timer_settime() ends up not queueing


 include/linux/posix-timers.h   | 11 +++++-
 include/linux/sched/signal.h   |  6 +++
 kernel/signal.c                | 15 +++++++
 kernel/time/posix-cpu-timers.c | 90 ++++++++++++++++++++++++++++++++++--------
 4 files changed, 103 insertions(+), 19 deletions(-)
