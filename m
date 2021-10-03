Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22578420367
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 20:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbhJCSWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 14:22:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:48688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231401AbhJCSWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 14:22:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 3E3E161165;
        Sun,  3 Oct 2021 18:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633285248;
        bh=UJv2k5sDjNRyvfeFJ7vp8E4+moJXYjHlQRavpdgIoHU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=B74HU1121apVH5V5UjbzBka6jFcojIommiLosTOW05SLmU6g1+k4UZm3NML+h3RIv
         BK1m+bBMptBkLf64mL/mcb75nzkovebVQuo1JTP3oO//Jd1PC6XXuQWnO17bjcDYIe
         L9ShLUpPOgZJ7/M1t+r+25S01ImpqJNoy6NWePTplwLLwMbVd2PEGWlGr0AJ5WLXCR
         +Irc+/wx+GfKdzcD8HXVtPAC+w2l0MTWTnnW1D86UC0YK6FKsyjnDIL/BFQLmbENcz
         wXepSk8L6xFXwghxvTQICQMjGfIkaJGBz6gbVcN933SfFUOSXvBDDYvSx9Rmwe0980
         5TVz0Lvlnz88w==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 32518609B4;
        Sun,  3 Oct 2021 18:20:48 +0000 (UTC)
Subject: Re: [GIT PULL] perf/urgent for v5.15-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YVl+FSNMK3BSy9gd@zn.tnic>
References: <YVl+FSNMK3BSy9gd@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YVl+FSNMK3BSy9gd@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v5.15_rc4
X-PR-Tracked-Commit-Id: f792565326825ed806626da50c6f9a928f1079c1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3a399a2bc465e7fb0e788bfbffefc9399d628a25
Message-Id: <163328524819.23868.11000150912942100387.pr-tracker-bot@kernel.org>
Date:   Sun, 03 Oct 2021 18:20:48 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 3 Oct 2021 11:55:33 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v5.15_rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3a399a2bc465e7fb0e788bfbffefc9399d628a25

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
