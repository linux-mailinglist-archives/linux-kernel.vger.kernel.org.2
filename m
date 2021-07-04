Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD6333BAEB2
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jul 2021 22:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbhGDUMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jul 2021 16:12:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:60612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229919AbhGDUMW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jul 2021 16:12:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id A162D61410;
        Sun,  4 Jul 2021 20:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625429386;
        bh=4iV72Bre03xMwjZQyWWG0ZOSEVksPIEABvcwssWRSGQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=l7ljq1p1ZDSISQISspxUxH8enBGoldipcA1g+hENT73PSgDWKzk5RUzbHGGvXpnix
         w39BGdLOerHtVis85GfItetixL99bCTamcdpbd+8876ldZ1YWdjRHu3OA4tctdokIc
         tfLyu+BtKM6Eqi2m7ca3susCxtwDqLvNOkY8Jf4bRVAGSpVZ3pMtL5BpAeqwhG0wBs
         YHjkdD0JiRPAvLXbu2IskKikYqts20bN0LeriTny8EXVU4ufKRLk1pCYLOdoem4LXl
         qjqeDyn0j3KHZ7ELHIMY1JhCAo4aWcn/iuAQCgkRxZ0bJ2g2R9C7nQT0Wf0xOwdt8H
         AL2x7ysRo2+zQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 9BDA360A38;
        Sun,  4 Jul 2021 20:09:46 +0000 (UTC)
Subject: Re: [GIT PULL] KCSAN changes for v5.14
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210704172912.GA2969733@paulmck-ThinkPad-P17-Gen-1>
References: <20210704172912.GA2969733@paulmck-ThinkPad-P17-Gen-1>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210704172912.GA2969733@paulmck-ThinkPad-P17-Gen-1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git kcsan.2021.05.18a
X-PR-Tracked-Commit-Id: 117232c0b9126e254d84f38ccaf9e576ccfcd990
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b97efd5e98106e1198884c13762ef03637605f87
Message-Id: <162542938663.15409.10926326673351561747.pr-tracker-bot@kernel.org>
Date:   Sun, 04 Jul 2021 20:09:46 +0000
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     torvalds@linux-foundation.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 4 Jul 2021 10:29:12 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git kcsan.2021.05.18a

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b97efd5e98106e1198884c13762ef03637605f87

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
