Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDE4235304A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 22:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236041AbhDBU3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 16:29:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:49282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229647AbhDBU3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 16:29:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 54EB8610A0;
        Fri,  2 Apr 2021 20:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617395369;
        bh=4yDnOxXCAIb+Rga5ly+QMhe9etGPtwP6q1XGcLulqyQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=R9CxUiZWRPm2Sweo9J+KBvk786TrI+brRyi5wlyQ/FAHykzVqgLFBZBUa/CBLu8mV
         HBsQbN0LHz6nfZNHU/Errk3wETcQRFMIRFrVmWUB6XP5F6SW4RxkXxlgc1vn+GboSv
         uUJhlTS8RjviaPZ/3NHIGIp+kZ1uVL0wg0WCxznJvdP3h/0MAClbVYxRi96XqSKxHi
         Mjbtmz8nsdub3aBCYSKLV38CVfBWL294naruS0fJogxqeptHOaW0KbLiJDaopDLX8e
         paJvJ87A8TLvP41zIxxThJ/hjyQcvHv8UeqXqmgdL7eqbnvFNUxZ5mEHda+DnpFml3
         a/OZa32yW7u8Q==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 1D8BC35212A5; Fri,  2 Apr 2021 13:29:29 -0700 (PDT)
Date:   Fri, 2 Apr 2021 13:29:29 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     john.stultz@linaro.org, tglx@linutronix.de, sboyd@kernel.org,
        corbet@lwn.net, Mark.Rutland@arm.com, maz@kernel.org,
        kernel-team@fb.com, neeraju@codeaurora.org, ak@linux.intel.com
Subject: Re: [PATCH v5 clocksource] Do not mark clocks unstable due to delays
 for v5.13
Message-ID: <20210402202929.GA22273@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210106004013.GA11179@paulmck-ThinkPad-P72>
 <20210112004258.GA23158@paulmck-ThinkPad-P72>
 <20210202170437.GA23593@paulmck-ThinkPad-P72>
 <20210217212814.GA14952@paulmck-ThinkPad-P72>
 <20210304004931.GA25461@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304004931.GA25461@paulmck-ThinkPad-P72>
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

Changes since v5:

o	Rebased to v5.12-rc5.

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
