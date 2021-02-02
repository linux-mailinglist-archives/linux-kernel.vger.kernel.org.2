Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6BC30C703
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 18:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237129AbhBBRHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 12:07:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:39528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237188AbhBBRFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 12:05:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 27B6064E08;
        Tue,  2 Feb 2021 17:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612285478;
        bh=VC5LqtqoOGNchCIo7lALn5q+/JwuGiCZTs3nO1fxMlI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=PlZ52YT5ODGzr+rRU9aV67PzZi+Q3f8/im/rbEpNShDmHPHZkRlmhh5bHSoKYb7sI
         Kve65DGLf/e9YdFr3VjOI0Pd4uf+GGzJAUjnSh5bHdlXVmHEFuhgSTwKMsxwNQycyL
         2tvDTzOwXUlOyxoRqvtN5Rg5rNvgVAER95g9op4tmyaovh0kSqdXMCKtFPVv5IfLtO
         JTc9+Q3T0e2CtbtARILQ0+Jhh4AuGncSPadXdp3CU2FHaAp/gI6Fnykl0ecIx/EEPT
         7TWCq0rD3L0MMJgJVWMGNBkEfvF6Ps8QJa4GjofDp6fpuV1yXw1HZL+moTiOVeHURO
         WI39Xj6zZ3WSw==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id C8DB83522865; Tue,  2 Feb 2021 09:04:37 -0800 (PST)
Date:   Tue, 2 Feb 2021 09:04:37 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     john.stultz@linaro.org, tglx@linutronix.de, sboyd@kernel.org,
        corbet@lwn.net, Mark.Rutland@arm.com, maz@kernel.org,
        kernel-team@fb.com, neeraju@codeaurora.org, ak@linux.intel.com
Subject: [PATCH v3 clocksource] Do not mark clocks unstable due to delays
Message-ID: <20210202170437.GA23593@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210106004013.GA11179@paulmck-ThinkPad-P72>
 <20210112004258.GA23158@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112004258.GA23158@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

If there is a sufficient delay between reading the watchdog clock and the
clock under test, the clock under test will be marked unstable through no
fault of its own.  This series checks for this, doing limited retries
to get a good set of clock reads.  If the clock is marked unstable
and is marked as being per-CPU, cross-CPU synchronization is checked.
This series also provides delay injection, which may be enabled via
kernel boot parameters to test the checking for delays.

1.	Provide module parameters to inject delays in watchdog.

2.	Retry clock read if long delays detected.

3.	Check per-CPU clock synchronization when marked unstable.

4.	Provide a module parameter to fuzz per-CPU clock checking.

5.	Do pairwise clock-desynchronization checking.

Changes since v2:

o	Rebased to v5.11-rc6.

o	Updated Cc: list.

Changes since v1:

o	Applied feedback from Rik van Riel.

o	Rebased to v5.11-rc3.

o	Stripped "RFC" from the subject lines.

						Thanx, Paul

------------------------------------------------------------------------

 Documentation/admin-guide/kernel-parameters.txt |   31 ++++
 arch/x86/kernel/kvmclock.c                      |    2 
 arch/x86/kernel/tsc.c                           |    3 
 include/linux/clocksource.h                     |    2 
 kernel/time/clocksource.c                       |  174 +++++++++++++++++++++---
 5 files changed, 188 insertions(+), 24 deletions(-)
