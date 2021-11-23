Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 426B045AEDC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 23:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239798AbhKWWIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 17:08:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:33888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239742AbhKWWI1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 17:08:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 4CFDB60F5B;
        Tue, 23 Nov 2021 22:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637705119;
        bh=AMntnG/Z2KLQ84VImhXPphi15VJ5OR9LSjH70k1HHHY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=TE7ratOvaX9MF/IptCu4ou3IGIXaZebE5v4V7H1MCPwcCK3Au24gW/ARWUB9SOhkZ
         jVa+7skZDGaCRALyQkiabyhYuQ1gCHXRYwC+7u0vTMYbqPvFVzY5shBYpivvXnRDMb
         Dc7dgKf1J4/hEJbV6FkCSJDQibaO/GnPbo6EUvLxCZklZ6TVMfY/k5jhY3hWRixbPz
         nmFwQI9kTedyduppLLVVQ2/yOxx7HlDeB7jxhYW0KmBARQP18RAlG742ZxckwJQ9Xj
         4NXU6OBFEo2oA2UMlXGapoP3jFxJTkObiF9QY8UE6tCxPqEw34p528VGBMoZT1zrn3
         0xOnIbFWoy9Fg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 476AE609D9;
        Tue, 23 Nov 2021 22:05:19 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 5.16-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5hfsrn9f0n.wl-tiwai@suse.de>
References: <s5hfsrn9f0n.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5hfsrn9f0n.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.16-rc3
X-PR-Tracked-Commit-Id: fa9730b4f28b7bd183d28a0bf636ab7108de35d7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b735936289d26404895a544ccc36d7874485ba9d
Message-Id: <163770511928.14610.9915333517461570088.pr-tracker-bot@kernel.org>
Date:   Tue, 23 Nov 2021 22:05:19 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 23 Nov 2021 14:29:28 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.16-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b735936289d26404895a544ccc36d7874485ba9d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
