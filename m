Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD34D320DC0
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 21:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbhBUUzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 15:55:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:42892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231358AbhBUUzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 15:55:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 097E164EE6;
        Sun, 21 Feb 2021 20:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613940826;
        bh=44jwTe95c2+673sqKkgGhLi76OA9WCqA6aa/fiR1EiU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=F5R0e8G6CMNVwwaKIHP1ZKIdGiaE0a0PHm0RbPcaPifqHUlV2OjVrxCpgYpU77Eg2
         rfEFbHRzx/dR0CdjmrMqX2NrAKsrs+OAhuyJzuTreoe6uGbdKW9TsfKihc2PW8Gaqq
         gjQm94lX9WgdetQE7Fcu5QjhqKR8uqgD4leZ2SuHAMbvY8Tla438bxZnmMUK5ini/U
         hWNWXxpEc8/npBiFE07JDss7mHgtbM3/iqFF9GSpZROdhBSBjFGhVaHvwTVFQASeWh
         9+sS2cSYJYgUbhAhjBLxQ5OntR5gIbuNqcCXBRu7FRG0DwiCwqUtkFwOxjn+kQLI60
         xeLcYsOi9bV4A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 00C0960A3C;
        Sun, 21 Feb 2021 20:53:46 +0000 (UTC)
Subject: Re: [GIT PULL] scheduler updates for v5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210217134323.GA493750@gmail.com>
References: <20210217134323.GA493750@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210217134323.GA493750@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-2021-02-17
X-PR-Tracked-Commit-Id: c5e6fc08feb2b88dc5dac2f3c817e1c2a4cafda4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 657bd90c93146a929c69cd43addf2804eb70c926
Message-Id: <161394082599.25590.13038609018318713174.pr-tracker-bot@kernel.org>
Date:   Sun, 21 Feb 2021 20:53:45 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 17 Feb 2021 14:43:23 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-2021-02-17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/657bd90c93146a929c69cd43addf2804eb70c926

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
