Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A43E73C9D04
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 12:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241565AbhGOKpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 06:45:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:51924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240920AbhGOKpR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 06:45:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4CCC5613BF;
        Thu, 15 Jul 2021 10:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626345744;
        bh=b/sL8zHkisD/HzbVrljIHYIhZIykUVYQyVwtFXfH/e4=;
        h=From:To:Cc:Subject:Date:From;
        b=la7gOxpTYZ3qusxIK+m6zmFrf18U8hwcQ9sZ42vLbnnxXmj+2pB5jE/02GPHLukYP
         J7peiUK1x4dUkjcVipAKWw+YdzQIJ/ykQnochUAZXJ6HbJs0Fqs/jocAxeh2aKuSvJ
         J8j7R8+1W2eeEajdJIHDvpZHUkytJZptzIptvXkr7CF/c243esYXk2xiT/0dfUZG7e
         anmgItmmJtnb4yw/ZFUphd3KhhyVvyXDmwFzsmmp0+pVxbcXFXjzRL/Sc85RRPnd7+
         wIyIHXSLFEukwGIuZPWV1LLM76Ge6OfPz2m3Ck1LE47DwqXTKLk9Gob7iNtxNQMhHa
         KnFDvRC4KdXRA==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [GIT PULL] timers fixes
Date:   Thu, 15 Jul 2021 12:42:16 +0200
Message-Id: <20210715104218.81276-1-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas, Ingo,

Please pull the timers/urgent branch that can be found at:

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	timers/urgent

HEAD: aebacb7f6ca1926918734faae14d1f0b6fae5cb7

Thanks,
	Frederic
---

Frederic Weisbecker (1):
      posix-cpu-timers: Fix rearm racing against process tick

Nicolas Saenz Julienne (1):
      timers: Fix get_next_timer_interrupt() with no timers pending


 kernel/time/posix-cpu-timers.c | 10 +++++-----
 kernel/time/timer.c            |  8 +++++---
 2 files changed, 10 insertions(+), 8 deletions(-)
