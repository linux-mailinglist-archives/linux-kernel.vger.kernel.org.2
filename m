Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFB95320DBC
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 21:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbhBUUyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 15:54:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:42498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230469AbhBUUy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 15:54:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id A9E9C64EBE;
        Sun, 21 Feb 2021 20:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613940825;
        bh=GRJL4FRtR+oAGAwigrS0wssQIpumABfahJZtD6oWTjY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Umv6ex+GLnEdgNr8RNnhCI9vcS8ei3Cb4HEZA1U/2LNcwD7o8XyEl3WUXkdTThTMr
         g8qu3gKdSbOoQcJHuaebNrB/0/gkKSWopX8cGnYsETMQXy+BwuFfZDx8pxuk7PMejA
         vbSxjl+QkfywlY2yWO4XoJIV0SlmV0KSxR0J6OgKoJeXJ4sGkFIb+Q4biyMg6NzLoY
         ui2HYRqHhBiDqTPtidq2/WEBB2eio6YeXFP24xUGjbiXmqMbcBD7f3WMCyY+UfQANk
         is113F16vyogQJoKpziqw8mm69wa4IixzKX3Hoou0YKveoYAP3gRdhVtOkpS5/KPyd
         j43eiox3424Gg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id A1A8760967;
        Sun, 21 Feb 2021 20:53:45 +0000 (UTC)
Subject: Re: [GIT PULL] RCU updates for v5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210217110229.GA21245@gmail.com>
References: <20210217110229.GA21245@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210217110229.GA21245@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-rcu-2021-02-17
X-PR-Tracked-Commit-Id: 2b392cb11c0db645ba81a08b6a2e96c56ec1fc64
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d089f48fba28db14d0fe7753248f2575a9ddfc73
Message-Id: <161394082565.25590.13143043465350265229.pr-tracker-bot@kernel.org>
Date:   Sun, 21 Feb 2021 20:53:45 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Triplett <josh@joshtriplett.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 17 Feb 2021 12:02:29 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-rcu-2021-02-17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d089f48fba28db14d0fe7753248f2575a9ddfc73

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
