Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E37D3B692E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 21:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236846AbhF1ThF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 15:37:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:41268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236720AbhF1Tgt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 15:36:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id C6E1B61613;
        Mon, 28 Jun 2021 19:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624908863;
        bh=c27oJ1oLqP8BpOY0qOS3TN5VXnllvkz2gA5nvH8jt+4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=YxBMym4gr9uV80eRGhhnuAS4/C17Spri5aMrptzGBnDCNkR3NYWBjdYuKF/CEhxeN
         XbrcqOhd9bH32UuWTSEbakrnaC+KNBcgpxIj/I2lB6Aoxsfokps4U8civsdE2Z2459
         KdNkzXZwJomn6bnaFtaSYAaA22pSL1sEKnN0Vb93B2lhhj5NUb48sH1ROMLmLa+B+9
         5zlnQ+iqdd6HfCmgeHg091/VjoMXHGJYvmG4ImFygo6h5vn1uVn/suqxJk/avuoV9V
         kp3wCbMo6XsD1T+xhhQS0KDWra6BgOyYo5/hLIVN9j+MgOsE2beMS909II9RIQh6m9
         TSy7VlRtgx5gg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id BD47160A71;
        Mon, 28 Jun 2021 19:34:23 +0000 (UTC)
Subject: Re: [GIT PULL] scheduler changes for v5.14
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YNlxcCpk4shGcPrU@gmail.com>
References: <YNlxcCpk4shGcPrU@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YNlxcCpk4shGcPrU@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-2021-06-28
X-PR-Tracked-Commit-Id: adf3c31e18b765ea24eba7b0c1efc076b8ee3d55
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 54a728dc5e4feb0a9278ad62b19f34ad21ed0ee4
Message-Id: <162490886376.14456.9240322397206238908.pr-tracker-bot@kernel.org>
Date:   Mon, 28 Jun 2021 19:34:23 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 28 Jun 2021 08:51:28 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-2021-06-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/54a728dc5e4feb0a9278ad62b19f34ad21ed0ee4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
