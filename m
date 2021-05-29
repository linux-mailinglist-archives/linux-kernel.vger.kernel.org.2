Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0ADC394D33
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 18:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbhE2Qup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 12:50:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:44358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229809AbhE2Qul (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 12:50:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 6E445610FC;
        Sat, 29 May 2021 16:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622306944;
        bh=FRTWn8SRJCjPTo+GLAcNDvx/1AI5z3GOao//Zijhpa8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Fm7ajFO7TopsIxLAuNIoBkHMKDpPjA0OBmWyy5BFqQa4vSqI5+lFtEuZFCcjWOV7g
         NQ/ByRft6yLMPN6UDT8C/s+H8Muwu/zz0D5cXKAEITdOw7zz/dDH/roMFJruKxHQ8o
         rwUS9r2PxxJQkgMceta/NqO0XcEAGc59wZlqaN7aGDHJzTkPoBbx/YC0AqhCm4Us2X
         XE+B7wq5zIC3f2N5cw5lP34nKhVwzcPKFqSs6RqnwNiGkHaR+uXm9N0qV3Pr/mX4D0
         MY4vCMPylciSHyOKLaWzX5Ye8CBUV8FhqL5go0cLdD6zDBUfHuMoiHJW9HU9GIt77R
         YeyezbPeHvt5w==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 684DB60A39;
        Sat, 29 May 2021 16:49:04 +0000 (UTC)
Subject: Re: [GIT PULL] Staging/IIO driver fixes for 5.13-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YLJPPF9wg6b1Cssj@kroah.com>
References: <YLJPPF9wg6b1Cssj@kroah.com>
X-PR-Tracked-List-Id: <linux-staging.lists.linux.dev>
X-PR-Tracked-Message-Id: <YLJPPF9wg6b1Cssj@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.13-rc4
X-PR-Tracked-Commit-Id: 54732a5322ff1fe0f42f2527fa6f5901a4de5111
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 494b99f712d00fee7e0927067081954fc493b6d9
Message-Id: <162230694442.3322.8781404301599251110.pr-tracker-bot@kernel.org>
Date:   Sat, 29 May 2021 16:49:04 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 29 May 2021 16:27:08 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.13-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/494b99f712d00fee7e0927067081954fc493b6d9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
