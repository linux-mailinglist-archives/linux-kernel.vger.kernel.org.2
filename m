Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59CEA36E08A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 22:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbhD1UuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 16:50:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:50042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230305AbhD1Ut4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 16:49:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 48E1661451;
        Wed, 28 Apr 2021 20:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619642951;
        bh=kjBrNwzzfWPLfqP7wQfa6XqYxmJLab/LGltacZO4/Ek=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ekVlZrpXJ5+iruaFH5dwIGTAfo7V2WkkfUxdWXFrnEQ036rjgISneeELHepJhKFAB
         lcs3c4sQInV6m8EeLMvvAXhH2frW0auuvBb+OovR/TjaXZc2WO8LKgRdG7FnEDkohx
         IMP24yyliPYq9ukDnejAUP9IS7VBCCUkLiORU8e5y5iTccOFOAYV91PIyz7Ezqsmy8
         ob+k+Mjr+MeaEGZkqrDz6uM1lFBYx8PesXy13RW8N2feGc6ScJDDri9PTxiO23LL1T
         lRqjMfDoaAo9t62FW96ULoSkuYEDkMK/AjwVdBICIUJ8qZOJbgIuaJdwwpEwtDfX4r
         dxm4mVyAuH4WA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 418FE60A36;
        Wed, 28 Apr 2021 20:49:11 +0000 (UTC)
Subject: Re: [GIT PULL] scheduler updates for v5.13
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210428085606.GA339713@gmail.com>
References: <20210428085606.GA339713@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210428085606.GA339713@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-2021-04-28
X-PR-Tracked-Commit-Id: 2ea46c6fc9452ac100ad907b051d797225847e33
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 16b3d0cf5bad844daaf436ad2e9061de0fe36e5c
Message-Id: <161964295126.5673.12406382981893264611.pr-tracker-bot@kernel.org>
Date:   Wed, 28 Apr 2021 20:49:11 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 28 Apr 2021 10:56:06 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-2021-04-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/16b3d0cf5bad844daaf436ad2e9061de0fe36e5c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
