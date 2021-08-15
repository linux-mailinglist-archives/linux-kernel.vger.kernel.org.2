Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 364D83ECA5E
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 19:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234168AbhHORBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 13:01:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:52878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230138AbhHORBD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 13:01:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 247266120E;
        Sun, 15 Aug 2021 17:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629046833;
        bh=7FKK49HTn9FjzTyiR8E24wR1eakIx5Mq63z/XCADXzc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=f1jOZBVs/LQJz0dif650d7U78SWMFVwXyn78/6otYtrMbi713IilaKSkwin4UH4rO
         M8xcpqavnvdV6c153xkX5j1HIOi3CxIOVZUJ9X+Ec0ZYPXpMh+Oj6peyUt0eUmBB1V
         GLDb3ZX8mtQWez6R32uSY7FnmfoUDtZtr3JPFaUdg0BL8wobVr/+nZOMViBti5ocEz
         aoGyqV+2PYZU3AZzFomO3rBWq57vJNhcKLVPRWhCllYA91c+qXefjZ98wQZUFpndfO
         21XtT/UxBUQUcDt4Nqvd/lzCphWTZEayUYEb13nno7vQIs5wXQ6Awn4sNVcDojJPG2
         RbGkOri9UNfwQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 1E38F60BC7;
        Sun, 15 Aug 2021 17:00:33 +0000 (UTC)
Subject: Re: [GIT PULL] x86/urgent for v5.14-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YRjIvlrCb8YjXdvJ@zn.tnic>
References: <YRjIvlrCb8YjXdvJ@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YRjIvlrCb8YjXdvJ@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.14_rc6
X-PR-Tracked-Commit-Id: 064855a69003c24bd6b473b367d364e418c57625
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b045b8cc865316062e520693ad6c8bac85aabece
Message-Id: <162904683311.11260.15892136935758196333.pr-tracker-bot@kernel.org>
Date:   Sun, 15 Aug 2021 17:00:33 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 15 Aug 2021 09:56:46 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.14_rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b045b8cc865316062e520693ad6c8bac85aabece

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
