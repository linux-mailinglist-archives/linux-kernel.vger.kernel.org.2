Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF12407F76
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 20:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235891AbhILSmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 14:42:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:41108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235571AbhILSmj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 14:42:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 9145061051;
        Sun, 12 Sep 2021 18:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631472084;
        bh=l3rhV0tkBWTwD4JjnXTK5rtCCpMDKrVLe9+6DnCxhCw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=L1f7tnhSNH8vMRMcbZqQCERXMtZfGlgHdVN2iu0Hfzvtmicb2PQUbkVO6+cmcAwRo
         pukqrrFvUQjsP6T80dmaZfHUQG3q8gV9iCqcltnz8j1FDEpnWI7Lr0OPzzVtEjxGCk
         KqeWfnd6B//BFiUvyDSMgZoGbpfQoQlhop9OqMigXDoJkQnF9wCB36ak0/nfoJdbUc
         ACp4MdWN11FZyV4TrkRtAhNgIDcBSI7wOZIkC8t8wTKOzS7AChVkCbJ9EUGCF8Vocv
         eAkfho0RDgP5fP99+p/2HlbI2ZAYswBWA0GHGsHtcdkyyzgeIHqkhalwPu5+F9NUtc
         C6trE3YutqlRg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 897FE600E8;
        Sun, 12 Sep 2021 18:41:24 +0000 (UTC)
Subject: Re: [GIT PULL] timers/urgent for v5.15-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YT3BFM+SWiqghjKm@zn.tnic>
References: <YT3BFM+SWiqghjKm@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YT3BFM+SWiqghjKm@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/timers_urgent_for_v5.15_rc1
X-PR-Tracked-Commit-Id: 39ff83f2f6cc5cc1458dfcea9697f96338210beb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7bf3142625c193db2dfbd7df2176b7cd910d9e4f
Message-Id: <163147208455.12542.9373147038292041606.pr-tracker-bot@kernel.org>
Date:   Sun, 12 Sep 2021 18:41:24 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 12 Sep 2021 10:57:56 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/timers_urgent_for_v5.15_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7bf3142625c193db2dfbd7df2176b7cd910d9e4f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
