Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56E8738B648
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 20:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235874AbhETSss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 14:48:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:39352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235810AbhETSsp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 14:48:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E640E606A5;
        Thu, 20 May 2021 18:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621536442;
        bh=Ty9aIb6o8gMXPzSHHmrqzigJgT7fYJt18EsmQyx3I/E=;
        h=From:To:Cc:Subject:Date:From;
        b=mnjyjb+xJtr4Y5Cw27i7TaA0OR+QqHDEcNQFd+NiV0PTYkXSwj/zDu7+goGcqpvRR
         LTfJL9AvGUYVd50dkbRkqeTLWtzadPYumAErEqxzDYad+Asa7/LihhvSdqPz7+MRpB
         TozXQbKF1XxQFx1o8NQSUQH3yohNut70zZhi+SQ+J0ikG3S3h2Q88LSWStlsfDNAAy
         Asfo4SvRdcHcg+HZqlSJ5EjQ+JdoDxUMvoYBZeqWeGvkFPXjVRbbFTPCSZkMeOYIDd
         OPpei2nCIIQjXwXHgNyWdnAZWdGa7qz4+FwoSw6zzEvzmS/mEIL9/ihuzwXcgGuCYa
         g9Ly+kytmXWtg==
From:   Will Deacon <will@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Lorenzo Colitti <lorenzo@google.com>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, kernel-team@android.com
Subject: [PATCH 0/5] tick/broadcast: Allow per-cpu timers to be used instead of broadcast
Date:   Thu, 20 May 2021 19:47:00 +0100
Message-Id: <20210520184705.10845-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patch series adds support for hardware where the per-cpu tick timer
cannot wake up from deep idle states (i.e. CLOCK_EVT_FEAT_C3STOP is set)
yet there is a secondary per-cpu timer which is generally less preferable
(i.e. slow to access) yet capable of delivering the wakeup.

The meat and potatoes are in patches 3 and 4, but since I've not hacked
on this part of the kernel before I would appreciate feedback on any of
the changes I'm proposing.

Cheers,

Will

Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Lorenzo Colitti <lorenzo@google.com>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: kernel-team@android.com

--->8

Will Deacon (5):
  tick/broadcast: Drop unneeded CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
    guard
  tick/broadcast: Split __tick_broadcast_oneshot_control() into a helper
  tick/broadcast: Prefer per-cpu oneshot wakeup timers to broadcast
  tick/broadcast: Program wakeup timer when entering idle if required
  timer_list: Print name of per-cpu wakeup device

 kernel/time/tick-broadcast.c | 135 ++++++++++++++++++++++++++++++-----
 kernel/time/tick-common.c    |   2 +-
 kernel/time/tick-internal.h  |   5 +-
 kernel/time/timer_list.c     |  11 ++-
 4 files changed, 133 insertions(+), 20 deletions(-)

-- 
2.31.1.818.g46aad6cb9e-goog

