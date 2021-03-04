Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6D332C95F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 02:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1451454AbhCDBHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 20:07:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:47752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233907AbhCDAuO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 19:50:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1BC1B64EE1;
        Thu,  4 Mar 2021 00:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614818972;
        bh=iYRf087/Opa8vsTGwHqy6vskuxxhSrmzQZv4QjvlXEg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=JqUCyxltWlHhcA4tgHvOWRdzgj3L2ewNEAm6YdUsSDi/P9BRnMU+9FThXgcmg9yMJ
         UQdQolOFuY1WnUjNSBuVgas4PITDeMmFBimR9AFusMlcebxe4zrU24rASk5Pp6hkfK
         HCP+fypF4ByTOzNBTTfmVOISonToPAUoTejtXVitDCozA6IHqtW7k+z/tqmb6pWCPF
         kAB4OfcXBaFWceeljHNSe6sZ2lawVwey6N20TiDQkZ0jiN7YoyODi44/5lCXY1k/u8
         MoB8WjTFmuI0J54ZHiw0aKj/rEX2BnYk9iGzvnoRNcSbqcSN7g8G6C7OuA/2IBpQ7R
         Z52Uu1ulprBzg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id D97C83522591; Wed,  3 Mar 2021 16:49:31 -0800 (PST)
Date:   Wed, 3 Mar 2021 16:49:31 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     john.stultz@linaro.org, tglx@linutronix.de, sboyd@kernel.org,
        corbet@lwn.net, Mark.Rutland@arm.com, maz@kernel.org,
        kernel-team@fb.com, neeraju@codeaurora.org, ak@linux.intel.com
Subject: [PATCH v5 clocksource] Do not mark clocks unstable due to delays for
 v5.13
Message-ID: <20210304004931.GA25461@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210106004013.GA11179@paulmck-ThinkPad-P72>
 <20210112004258.GA23158@paulmck-ThinkPad-P72>
 <20210202170437.GA23593@paulmck-ThinkPad-P72>
 <20210217212814.GA14952@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210217212814.GA14952@paulmck-ThinkPad-P72>
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

Note that "sufficient delay" can be provided by SMIs, NMIs, and of course
vCPU preemption.

1.	Provide module parameters to inject delays in watchdog.

2.	Retry clock read if long delays detected.

3.	Check per-CPU clock synchronization when marked unstable.

4.	Provide a module parameter to fuzz per-CPU clock checking.

5.	Do pairwise clock-desynchronization checking.

Changes since v4:

o	Rebased to v5.12-rc1.

Changes since v3:

o	Rebased to v5.11.

o	Apply Randy Dunlap feedback.

Changes since v2:

o	Rebased to v5.11-rc6.

o	Updated Cc: list.

Changes since v1:

o	Applied feedback from Rik van Riel.

o	Rebased to v5.11-rc3.

o	Stripped "RFC" from the subject lines.

						Thanx, Paul

------------------------------------------------------------------------

 Documentation/admin-guide/kernel-parameters.txt |   38 +++++
 arch/x86/kernel/kvmclock.c                      |    2 
 arch/x86/kernel/tsc.c                           |    3 
 include/linux/clocksource.h                     |    2 
 kernel/time/clocksource.c                       |  174 +++++++++++++++++++++---
 5 files changed, 195 insertions(+), 24 deletions(-)
