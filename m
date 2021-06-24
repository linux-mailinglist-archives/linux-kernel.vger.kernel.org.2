Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC7423B3400
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 18:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbhFXQga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 12:36:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:41020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229881AbhFXQgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 12:36:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 4F279613DC;
        Thu, 24 Jun 2021 16:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624552446;
        bh=9Fu3cyntTE5rmYQfTQsO1kYCmzHiBR+4+KFBmMtwD8U=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=l3NvDae+rErw86j0mQveeOREwIiInvhYFm3yNZGA7g0qsWXT0VWxnImQPEit6eLQ1
         zccAYNIGmVsjQJ98F43mC+/fn0hzZo2pZr+KgqeBHTXhro5yiDL7lTlnEosZECe8Ek
         vX8dLjg7Fxphlqj4AUNNlEAHUXcnvdPwjkN3EH/IRxka/6CLHnu9i6BnaDDK+3HKrF
         0AxkOgVGCJapgC4eDupEtGqoi4kt5fuSc+j1YDVexHgDdWnMRBviGwJBYEzQmzNKh0
         UZqLOQc+2l0B2lm7DDsS6002ZN/F1kWWK8XS4c4wdSJHdeBhy6dqvWbXoy/ElpdVOO
         3Dn7AsHV4ohpw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 46EC360A71;
        Thu, 24 Jun 2021 16:34:06 +0000 (UTC)
Subject: Re: [GIT PULL] scheduler fix
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YNQvB82UKfDV57eE@gmail.com>
References: <YNQvB82UKfDV57eE@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YNQvB82UKfDV57eE@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2021-06-24
X-PR-Tracked-Commit-Id: fdaba61ef8a268d4136d0a113d153f7a89eb9984
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 666751701b6e4b6b6ebc82186434806fa8a09cf3
Message-Id: <162455244628.8751.9189902656628536533.pr-tracker-bot@kernel.org>
Date:   Thu, 24 Jun 2021 16:34:06 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 24 Jun 2021 09:06:47 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2021-06-24

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/666751701b6e4b6b6ebc82186434806fa8a09cf3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
