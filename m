Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D36738F585
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 00:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233933AbhEXWUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 18:20:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:60070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232911AbhEXWUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 18:20:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 83CB16101B;
        Mon, 24 May 2021 22:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621894711;
        bh=QaoCAH4RtEQ6HxKpzpr0acTJlKQnl/fh4mkBPoEoAAM=;
        h=From:To:Cc:Subject:Date:From;
        b=ZU/KcJq21KL/JiHKC/aBcBbqVpsfut45RAieVL+hbM9lU7BN+898oe6wEOG7fvrG4
         y0TBK3IsP3NuyLxXbJil33bhC1ygsvu38gyIIvsTEMpwM5+gn4r9UxOIQCvjhzr4cZ
         acQdPN+E9Z5t2WpPC49Uz8YQMteZfCSas77sh/Smj+LwjFTb9K9QRUMIJH4h5agoZl
         lKy2knQCwft8cUukJCl91K/uBeZEIn45ONFLAmHt7EZFb6oc3+a5Z7mKGn+LOekveT
         JiwQOEb48Q2ZSRK3ZVlmI7USWLWT23mUDur8cUUTxL7kdu2VKx3oC7/o+vHkJfH0ix
         9HWAbszh/oFGw==
From:   Will Deacon <will@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Lorenzo Colitti <lorenzo@google.com>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?q?Mika=20Penttil=C3=A4?= <mika.penttila@nextfour.com>,
        kernel-team@android.com
Subject: [PATCH v2 0/5] tick/broadcast: Allow per-cpu timers to be used instead of broadcast
Date:   Mon, 24 May 2021 23:18:13 +0100
Message-Id: <20210524221818.15850-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This is version two of the series I posted last week:

  https://lore.kernel.org/r/20210520184705.10845-1-will@kernel.org

This patch series adds support for hardware where the per-cpu tick timer
cannot wake up from deep idle states (i.e. CLOCK_EVT_FEAT_C3STOP is set)
yet there is a secondary per-cpu timer which is generally less preferable
(i.e. slow to access) yet capable of delivering the wakeup.

Changes since v1 include:

  * Fixed module refcounting and use of clockevents_exchange_device()
  * Require CLOCK_EVT_FEAT_PERCPU for new wakeup per-cpu source
  * Fix transition to oneshot mode while idle
  * Tested on my x86 laptop

Cheers,

Will

Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Lorenzo Colitti <lorenzo@google.com>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Mika Penttilä <mika.penttila@nextfour.com>
Cc: kernel-team@android.com

--->8

Will Deacon (5):
  tick/broadcast: Drop unneeded CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
    guard
  tick/broadcast: Split __tick_broadcast_oneshot_control() into a helper
  tick/broadcast: Prefer per-cpu oneshot wakeup timers to broadcast
  tick/broadcast: Program wakeup timer when entering idle if required
  timer_list: Print name of per-cpu wakeup device

 kernel/time/tick-broadcast.c | 143 +++++++++++++++++++++++++++++++----
 kernel/time/tick-common.c    |   2 +-
 kernel/time/tick-internal.h  |   5 +-
 kernel/time/timer_list.c     |  10 ++-
 4 files changed, 140 insertions(+), 20 deletions(-)

-- 
2.31.1.818.g46aad6cb9e-goog

