Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B436E44F9D5
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Nov 2021 18:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236334AbhKNR4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 12:56:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:35524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236154AbhKNRze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 12:55:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id AAB8861077;
        Sun, 14 Nov 2021 17:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636912357;
        bh=kO6PoQMdres4jWtjAxy8VSxK2DgqrzLBmJAbA0R64p4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qiGG9rOrP5dmhdnVX0nX5/ud8kY5TWnUnsVM8A5R1HDdHW+KoXk6ydXVIEAs7HfnS
         oESGN45SWyyX7pIXvknXez/Ye3gN/RX+RpA6F/19U+crUOQZ5Of5X71QgFDeZ1vk+H
         1YJWNL1/4pnDgTjVT6vQDky/uvWvUSc4oMKHwBqM2IPGqyscbvXCaziiCz3cpbvb74
         fIa5dLtXHev5XjixmBmct8VDbnKYM125i5kmm5k8PUVrzJgFDRdDVfceULBBeIBywJ
         vy8FO9SDVliEdUwLTOYiZqJF8MDzbxXI3OPYREyHnChwOILZY8lawtKGsE+qWjVBbL
         kRryCaAb4Tgmw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id A45686095A;
        Sun, 14 Nov 2021 17:52:37 +0000 (UTC)
Subject: Re: [GIT PULL] sched/urgent for v5.16-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YZDxFAYjVp2nRteh@zn.tnic>
References: <YZDxFAYjVp2nRteh@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YZDxFAYjVp2nRteh@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/sched_urgent_for_v5.16_rc1
X-PR-Tracked-Commit-Id: a8b76910e465d718effce0cad306a21fa4f3526b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fc661f2dcb7e41dcda9ae862efb822bb2f461646
Message-Id: <163691235766.31405.435556343359456049.pr-tracker-bot@kernel.org>
Date:   Sun, 14 Nov 2021 17:52:37 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 14 Nov 2021 12:20:52 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/sched_urgent_for_v5.16_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fc661f2dcb7e41dcda9ae862efb822bb2f461646

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
