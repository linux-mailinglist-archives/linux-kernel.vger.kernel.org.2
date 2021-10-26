Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF2943B3AD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 16:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236403AbhJZON0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 10:13:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:40584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230334AbhJZONY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 10:13:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 49AD46103C;
        Tue, 26 Oct 2021 14:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635257460;
        bh=fqg4tnVF7qPzQwQksBpsi8Ly4u+UIvAHAn4deAzhFgY=;
        h=From:To:Cc:Subject:Date:From;
        b=NfY+va6LIyeK37F6cKe7ZzTJcC09L2uwXvwy33EJdJHkVO7kaxwW0bbH7NIUlC5rt
         aDJC5KyW9t6sB8gkzd2KoZ1D382EsMcNSuhqx4bOoUjsSuLp8mqTr2XBZC2OEMj8hj
         e6Bl7UMwZhNt+FrOjtXTL/dd3hzKCzyMk1EjRgML+8jcZBLIFQhttkyK6X1rYbjez0
         nvJqdY6bMkGSgJeXIO3wV5/Ncr4MaO+Er0cE3M5QEarlzNsMZjhxTYMCX9B7n6Ot8X
         nO0t147BhvtKsyD+fKs0wU0CCVFDaTO8cF/EXsJBEjvm8hjjh10bTgpY/8NRgqSvLQ
         WwOo7woniP2gQ==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Hasegawa Hitomi <hasegawa-hitomi@fujitsu.com>,
        Mel Gorman <mgorman@suse.de>
Subject: [PATCH 0/2] timers/nohz fixes
Date:   Tue, 26 Oct 2021 16:10:53 +0200
Message-Id: <20211026141055.57358-1-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A bunch of fixes that don't need to be on the urgent queue since
they are not regression fixes. But they are still fixes...

Frederic Weisbecker (2):
  timers/nohz: Last resort update jiffies on nohz_full IRQ entry
  sched/cputime: Fix getrusage(RUSAGE_THREAD) with nohz_full

 include/linux/sched/cputime.h |  5 +++--
 kernel/sched/cputime.c        | 12 +++++++++---
 kernel/softirq.c              |  3 ++-
 kernel/time/tick-sched.c      |  7 +++++++
 4 files changed, 21 insertions(+), 6 deletions(-)

-- 
2.25.1

