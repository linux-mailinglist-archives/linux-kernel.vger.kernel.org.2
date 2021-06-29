Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC0333B6D26
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 05:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbhF2Dx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 23:53:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:44458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231817AbhF2Dwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 23:52:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 113A161D45;
        Tue, 29 Jun 2021 03:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624938629;
        bh=mBcihKQwRuYIZ7hNVGOlPKSYpIvpR8gV6G+gvDxoX7g=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=aiPdTynHNtEFxlQYB2eTkOATMfJC1v9pe8EUT3CRP6clMWRJ6/vKhLQebUBzWt2ab
         ZGOXLIMiwZA2H0WHZVc8lnsCqo+ma0QG4P8XJiWGab17VaDHy9t7ceVn5rV7wEzqZF
         JMpRwE7MeX0jIO5ewGnVgYpE1TzDvSz/yf1mV5Oxk0thveHDH/mKSpDKPJ4MRfanHM
         sFbJKYhi4PAwVoEaLiI9c9qY74YcawmMAYzU5LredGOzhAQAc4vPNW4GOlGPgFvVt1
         6q9e38Zcio6eHC3URFgQTdtkNqBo1M9RtQjc/tE3zH09MwRdu3sBeItJuxX9TAI2Ke
         SMawT/+C4I3sA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 0AD3C60A38;
        Tue, 29 Jun 2021 03:50:29 +0000 (UTC)
Subject: Re: [GIT PULL]  ucounts: Count rlimits in each user namespace
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87fsx1vcr9.fsf@disp2133>
References: <87fsx1vcr9.fsf@disp2133>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87fsx1vcr9.fsf@disp2133>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git for-linus
X-PR-Tracked-Commit-Id: 5e6b8a50a7cec5686ee2c4bda1d49899c79a7eae
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c54b245d011855ea91c5beff07f1db74143ce614
Message-Id: <162493862903.19305.8368460220248089655.pr-tracker-bot@kernel.org>
Date:   Tue, 29 Jun 2021 03:50:29 +0000
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Linux Containers <containers@lists.linux.dev>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 28 Jun 2021 17:35:22 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c54b245d011855ea91c5beff07f1db74143ce614

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
