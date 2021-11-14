Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B77D344F9D7
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Nov 2021 18:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236215AbhKNRzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 12:55:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:35468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236153AbhKNRze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 12:55:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 11F4060F70;
        Sun, 14 Nov 2021 17:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636912357;
        bh=yqrXQ/C45Q/JXJFk4Pgaq58vW7681vm8MeFN5T+WNZM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Uz0o9eEVV5cvLsJeso/+8204Nu2lXAmzDOF+aaQyPFvX+dAoPQObH8sypNAN6D2cY
         twZyHZhkOROidOngytWK6xERVhS7POJi4n5bKYjG7XWBcpKiNJK23tGWvPh1wm5jv4
         T6BXp1DpXpGUTWlStFoQjugqI7Q8mJi+ZR7W3/vo29RhX14NYfoo9TZjZAfGt8ZsfP
         DEJcP1amHHodPfIYmpuqPZW7GRvsvb3xgVEwq8SjHlJXT2qdrp15+rgJFZpE0H3Mf/
         PjQOCCsPCKVyGSZQ+GFYurBkAi526UItDQ0MpE8tjxigCMzTjoNRkG2yqgf+f/O07o
         oqL9U10XlryJw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 0B50B6095A;
        Sun, 14 Nov 2021 17:52:37 +0000 (UTC)
Subject: Re: [GIT PULL] x86/urgent for v5.16-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YZDeRkX012h/ZJzR@zn.tnic>
References: <YZDeRkX012h/ZJzR@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YZDeRkX012h/ZJzR@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.16_rc1
X-PR-Tracked-Commit-Id: fbdb5e8f2926ae9636c9fa6f42c7426132ddeeb2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1654e95ee30a82bec843e73a591f9ea3db8da8db
Message-Id: <163691235703.31405.9385995275684122664.pr-tracker-bot@kernel.org>
Date:   Sun, 14 Nov 2021 17:52:37 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 14 Nov 2021 11:00:38 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.16_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1654e95ee30a82bec843e73a591f9ea3db8da8db

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
