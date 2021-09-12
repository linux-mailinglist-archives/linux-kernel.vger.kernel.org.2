Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99C21407F77
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 20:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236001AbhILSmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 14:42:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:41136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235547AbhILSmj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 14:42:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id C7F836108E;
        Sun, 12 Sep 2021 18:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631472084;
        bh=EicyJwWLaT51gM9kgRDzW5rEXuKsPY/FDSe9KGbZB0o=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=nuiO28R/2OifdZoFu6DSujvL8ZKhHu+68FvVQH6WMItEeq1U4OPandL4ZSv+AsWBH
         VqIftaQugYOg1kObjROgrEIps1z37oUY6zSoLvOyw2bLxQo0zKySJoU/GNasv9uQvx
         Ep5iZj5ELU3ypMXBhaUKN+E0uDaQsHZ9nP45G8TXRpxpEurmVNGRG1BHcJiUxVNX98
         agutLy6nPchcZE3wTBrbFYObtbzQgp8hKSC8C4MXkJqSLDCoy5iCExHcyFzt+rt3tN
         aaKo2JimkSqLk240EMGq2ADWAF5PLwuCC4oNykFrDKc3lRy9rPKwB5vKobbmNjPPfZ
         4eSVRSVpI3SUg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id C155C60A47;
        Sun, 12 Sep 2021 18:41:24 +0000 (UTC)
Subject: Re: [GIT PULL] sched/urgent for v5.15-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YT3C3lE09Yvx2e8h@zn.tnic>
References: <YT3C3lE09Yvx2e8h@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YT3C3lE09Yvx2e8h@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/sched_urgent_for_v5.15_rc1
X-PR-Tracked-Commit-Id: 868ad33bfa3bf39960982682ad3a0f8ebda1656e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 56c244382fdb793986097df8e29f9f9320bc2c60
Message-Id: <163147208478.12542.17460318380428522006.pr-tracker-bot@kernel.org>
Date:   Sun, 12 Sep 2021 18:41:24 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 12 Sep 2021 11:05:34 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/sched_urgent_for_v5.15_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/56c244382fdb793986097df8e29f9f9320bc2c60

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
