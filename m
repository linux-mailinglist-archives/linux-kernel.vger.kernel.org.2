Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4657F31E157
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 22:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbhBQV3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 16:29:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:50710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231616AbhBQV2z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 16:28:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F3A1564E58;
        Wed, 17 Feb 2021 21:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613597295;
        bh=+s6kyvidSro6M1MNvoRGlwm1ScSQRwQLiGUb60mL0yc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=CAd3dg2bj286w02Yiz/m6q8UHiX0ztwriIRcRGvhGHN7jS8IPDMtnYy+59xF9nIAG
         xBRU0l+TsLAv9yNqm5ZQwS3sBGWaCI6XsWIG7ra8GjSvCY0D6Dju/KKlw3ZtPKdCUD
         wSHm1KZ0u4+uN6CUIauqZy/K9YrydICXv7Zwf7dYQWlY4iBsnYNW/tZlLmT94od16/
         EnuwAogqKZw7H2ULaluEQXp8Gsoq4KLf3Mu7pX7gqVvsobh7JF4/Zh0w2aR7wvPDCq
         dGE02D3XYNeZeQQrDpmOu1036lU+r0fajljnMes43IXMlQ8VF77ZjKA+Y2DlIN9wNy
         /2xApTSPWFZxA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id A605A3522611; Wed, 17 Feb 2021 13:28:14 -0800 (PST)
Date:   Wed, 17 Feb 2021 13:28:14 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     john.stultz@linaro.org, tglx@linutronix.de, sboyd@kernel.org,
        corbet@lwn.net, Mark.Rutland@arm.com, maz@kernel.org,
        kernel-team@fb.com, neeraju@codeaurora.org, ak@linux.intel.com
Subject: Re: [PATCH v3 clocksource] Do not mark clocks unstable due to delays
Message-ID: <20210217212814.GA14952@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210106004013.GA11179@paulmck-ThinkPad-P72>
 <20210112004258.GA23158@paulmck-ThinkPad-P72>
 <20210202170437.GA23593@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202170437.GA23593@paulmck-ThinkPad-P72>
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
