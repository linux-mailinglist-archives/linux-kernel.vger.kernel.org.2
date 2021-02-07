Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC303126AB
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 19:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbhBGSaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 13:30:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:57426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229587AbhBGS3z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 13:29:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 04C8164E31;
        Sun,  7 Feb 2021 18:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612722555;
        bh=/tCEd7eKaNePaQDSH4Wrcul4LuPIRbKjCHR37mET5Gs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=kOGly7xM6TjUXarKFbYvWrdVpjUBpDosPUERUchG7R/00DxxcHL7yPby6S2JG9t82
         YX6JbT05iWQOqIAf8/5Gi/2TkNBCH8US0BrF8ooKLBVkiK89Nznw1/S+xmRWlLRZCJ
         OOLEi6fMUQBTVs+6Yw3vuTG+dUQVEiAfxIwFJ5y+ZaE96ysQ6RquJurZtHexjoMXDj
         +veCPcAir4ogkyJW7JScL7jk54delTPc41UV+wzlcxqABRJ2RuzccK72IFFDa8m+Ga
         tW5uk2grLCjJr/X6Zr4bRpg5FraMHULDQYxbJ0r8U69UdnkaSJj/sCauzfushiUUi+
         E8O+WRLbt4g+w==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id E93F160A0F;
        Sun,  7 Feb 2021 18:29:14 +0000 (UTC)
Subject: Re: [GIT PULL] sched/urgent for v5.11-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210207111510.GC32127@zn.tnic>
References: <20210207111510.GC32127@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210207111510.GC32127@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/sched_urgent_for_v5.11_rc7
X-PR-Tracked-Commit-Id: 2452483d9546de1c540f330469dc4042ff089731
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6fed85df5d097298d265dfcc31cf1e0c1633f41e
Message-Id: <161272255495.27145.8081033322919973693.pr-tracker-bot@kernel.org>
Date:   Sun, 07 Feb 2021 18:29:14 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 7 Feb 2021 12:15:10 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/sched_urgent_for_v5.11_rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6fed85df5d097298d265dfcc31cf1e0c1633f41e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
