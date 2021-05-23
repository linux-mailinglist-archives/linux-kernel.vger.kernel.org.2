Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 076DA38DBF0
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 18:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbhEWQg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 12:36:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:58690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231800AbhEWQgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 12:36:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 52F93610A8;
        Sun, 23 May 2021 16:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621787699;
        bh=XCLn7tlTwPUIArwGSHEZRytG+THpySx4T+YOOQ1zLLI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=OoMYjACMRp1L5kNoPu3zcrqyLangi2D+QAC+eo1bCo5KK2pCxS+Wt44hF0VKYKCD7
         zbzG5yOrnNjlTrU1kh5rKFEBMkKc8AeEAxt6RQo8ZhpLqu675MK6qYPm2pAnFxiG17
         qZjtGol5knidQyGq0eQdjCf+W4bwf5CTqTr+MBpl3mLMaH5D8iY8H0t+M3LivE0twc
         delvqqF4z0XCx3HsbA2GKOTOkobZrp+E1L07iXNKwIK5ScNDhUY2SIlplpd+F2vm53
         IZZl0h0wS8Fcer1eG7O44eQDdY30+i1IUwlTVz4aEOXN66ddT5WiP7WuJyJQZzmY3g
         uoKES0SrTMFrA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 4677C60A71;
        Sun, 23 May 2021 16:34:59 +0000 (UTC)
Subject: Re: [GIT pull] locking/urgent for v5.13-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <162177682445.10917.1808156686282700079.tglx@nanos>
References: <162177682324.10917.7221704858691713254.tglx@nanos> <162177682445.10917.1808156686282700079.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <162177682445.10917.1808156686282700079.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2021-05-23
X-PR-Tracked-Commit-Id: 3a010c493271f04578b133de977e0e5dd2848cea
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0898678c742ee913691d7f4a1606309825eee33b
Message-Id: <162178769928.22288.15550485422158563542.pr-tracker-bot@kernel.org>
Date:   Sun, 23 May 2021 16:34:59 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 23 May 2021 13:33:44 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2021-05-23

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0898678c742ee913691d7f4a1606309825eee33b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
