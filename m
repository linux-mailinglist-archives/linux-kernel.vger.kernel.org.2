Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C851D3F342D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 21:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237034AbhHTTBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 15:01:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:54854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229512AbhHTTBB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 15:01:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B4171610FF;
        Fri, 20 Aug 2021 19:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629486023;
        bh=BvgPxhCAddH1VjNR02w4lxjUIplbwTPx+pzLmIpjQ3E=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=umWZBx+HzcJggGxTutOO5IYDNA3sWXfsF43rOZfJWQ8sLHuf3kWhdbagJMM+Q/ppH
         7aEH2wBMygzIOVb91SPCoDKiJlRC5FGRxtkW9cUt6VbWV0Tljv4zfNPHwigwwJSujQ
         cWXfQZ8/DrYS8DxgTzSsT3JMfadiYHuEkAo460I+xiBNB8GiAw0W22KgMVVQsYPPKP
         aUCdDEZOnKozDLXUS+J2IbWEDs7/8gMzorsJOEnx+UMyHFVGw/+iPfDU75IQtBlY3Z
         9CHfMjEenOKozTzBCv6eXc5fBmTlHCBsT3mIISeMiewmULzON9lPpF03LED7LQ95+7
         cLfZLkxpaSPVw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7A3315C0399; Fri, 20 Aug 2021 12:00:23 -0700 (PDT)
Date:   Fri, 20 Aug 2021 12:00:23 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        kernel-team@fb.com, ak@linux.intel.com, rong.a.chen@intel.com,
        sboyd@kernel.org
Subject: [GIT PULL v2 clocksource] Clocksource watchdog commits for v5.15
Message-ID: <20210820190023.GA1387549@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Thomas,

This pull request contains a single change that enables clocksource
watchdog testing on systems with HZ < 100, as an alternative to the
earlier pull request that prohibited such testing.  This change has been
posted to LKML:

https://lore.kernel.org/lkml/20210812200112.GY4126399@paulmck-ThinkPad-P17-Gen-1/

this has been subjected to the kbuild test robot and -next testing,
and is available in the git repository based on v5.14-rc2 at:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git clocksource

for you to fetch changes up to a5e8561a2bdf276fdd2a7f63a8154930863fcbda:

  clocksource: Make clocksource-wdtest.c safe for slow-HZ systems (2021-08-16 12:00:02 -0700)

----------------------------------------------------------------
Paul E. McKenney (1):
      clocksource: Make clocksource-wdtest.c safe for slow-HZ systems

 kernel/time/clocksource-wdtest.c |  5 ++---
 kernel/time/jiffies.c            | 21 +--------------------
 kernel/time/tick-internal.h      | 20 ++++++++++++++++++++
 3 files changed, 23 insertions(+), 23 deletions(-)
