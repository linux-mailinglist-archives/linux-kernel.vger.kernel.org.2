Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C53EF41273E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 22:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbhITUYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 16:24:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:47016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230064AbhITUWg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 16:22:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 6F33A60F46;
        Mon, 20 Sep 2021 20:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632169269;
        bh=L6Oh+cYwHOn96GAyR1HD4oBLjFVLqWzP6p1yXMcUTVw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=tbDzGS60nuSRtYHMUnTokrHsElmqJfL3BfvVHivSPemFWzTdAclqDrJks3eDvcCxd
         Ui1y3Qq2I2fo69Qky1pkm7lBKzcIrCP7cIJ7B5sG3fEev+1WWBqSX+hh/P+U3rWofO
         A3INS4ZbJzzUayTNiMA7Fu1NE7C7j8Pu6KmzphsbcGAgDgoXmu94EgnT3rDLsow+t8
         S8rXy3Ctx/svHMex6L1bk+5+qy1PLIn9MCJRX+OorIVbyw1WqJouMCWeidD073bM+o
         OISKISGbek+975k5ZQ+YIp/QI6imqGe4GCwbr7tuGL8RLOngBKTXJv0v5pdXq2ruKM
         mTbC6U6+Tr5JA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 657AB60A2A;
        Mon, 20 Sep 2021 20:21:09 +0000 (UTC)
Subject: Re: [GIT PULL] regulator fixes for v5.15-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210920121936.DFBE661040@mail.kernel.org>
References: <20210920121936.DFBE661040@mail.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210920121936.DFBE661040@mail.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v5.15-rc2
X-PR-Tracked-Commit-Id: dc9660590d106bb58d145233fffca4efadad3655
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2ff59bad6f24813e4c9e8f2022684010ec0e58d2
Message-Id: <163216926940.8691.5428310571457449578.pr-tracker-bot@kernel.org>
Date:   Mon, 20 Sep 2021 20:21:09 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 20 Sep 2021 13:18:43 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v5.15-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2ff59bad6f24813e4c9e8f2022684010ec0e58d2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
