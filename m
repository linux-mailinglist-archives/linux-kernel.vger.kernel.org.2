Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECB43ADF76
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jun 2021 18:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbhFTQv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Jun 2021 12:51:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:46298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229600AbhFTQvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jun 2021 12:51:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id F32A960FF4;
        Sun, 20 Jun 2021 16:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624207769;
        bh=PPGN/1SPzLAraf0Id5GXKIOAQWATV7oW4688Q/6b6Os=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fu6ReBo0XBRorzAXoosKWNznKEEb6UTf9so15poxBClo1oCEA7eIcz1P1SUOAISjD
         8rnjOa2FTeE/Yq7jeF86YmmrO7ktleaCtdBwhruNW+hv4KoNAFwW5yKPs56Uw/mTQn
         VqPU7sn2jpkKp9RpD0SYpwjs42vjBIOBOqjOwnnqXn+FKLXnhfjixU8vHc6r5SWLiN
         Rn+5Z/5pU/50wKgNghgQNvaB2y6TPSHcXBNAR03NmBzbrF0KnpT1KKQjDxweyIV+7z
         a32NcgHRzW3HK/1Wjf97XOq99ho1QMK7KGyyfoWucWnev0L1a1UDNbJyX31nTouFzD
         StWflQMf6lr0A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id E6A7760A6C;
        Sun, 20 Jun 2021 16:49:28 +0000 (UTC)
Subject: Re: [GIT PULL] x86/urgent for v5.13-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YM7nUwsJ+1v66B9m@zn.tnic>
References: <YM7nUwsJ+1v66B9m@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YM7nUwsJ+1v66B9m@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.13_rc6
X-PR-Tracked-Commit-Id: 28e5e44aa3f4e0e0370864ed008fb5e2d85f4dc8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8363e795eb79a74c857ba89e3b04668a33fe3344
Message-Id: <162420776893.12594.6843724404482148757.pr-tracker-bot@kernel.org>
Date:   Sun, 20 Jun 2021 16:49:28 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 20 Jun 2021 08:59:31 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.13_rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8363e795eb79a74c857ba89e3b04668a33fe3344

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
