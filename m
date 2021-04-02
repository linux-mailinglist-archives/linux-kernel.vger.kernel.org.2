Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C846353156
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 00:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235421AbhDBWsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 18:48:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:53158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231577AbhDBWsa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 18:48:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 01B3161057;
        Fri,  2 Apr 2021 22:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617403709;
        bh=qp9VKtTKFc1tzH8awtiuHwGQtmePI2YfX+wQGEU2IRc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=e151tc5WWMmPNRRD1/4T9tUj2WQ6ffhx6tjFk7/X+AB9/R/tYUOf1JEcIf+qEdDL4
         OPvYvkJS2f0ToXcJjys5S08nq1M14Jj7CwocwQT8lJ8cjXTB9ZaOAxqgYzD4U0vQRS
         egD7Vp1SYBAK1XrM3UoaV5JASeiglGuaUv6ks/dfNNFgJYU4/tyF5CAWhrMOC87Emh
         jg3Xv9zPdlNPvqpaV0wtGfUDyr7Nun1Y8b25Ox9eEk5hWBNFT4m2f6Niy3ogJMaFa6
         2oM5E8h6QiSIXSY2+0jOeSWmOw6khUU9t8Ee5pZB41VQPYy7J+TmJDgCAxduw7qulq
         MEdqvLbNHl7tg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id C97BD35212A5; Fri,  2 Apr 2021 15:48:28 -0700 (PDT)
Date:   Fri, 2 Apr 2021 15:48:28 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@fb.com, neeraju@codeaurora.org,
        ak@linux.intel.com
Subject: [PATCH v7 clocksource] Do not mark clocks unstable due to delays for
 v5.13
Message-ID: <20210402224828.GA3683@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210402202929.GA22273@paulmck-ThinkPad-P72>
 <20210402203137.22479-1-paulmck@kernel.org>
 <87pmzc498v.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pmzc498v.ffs@nanos.tec.linutronix.de>
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

Changes since v7:

o	Fix embarrassing git-format-patch operator error.

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
