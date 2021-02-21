Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53147320E32
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 23:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbhBUWE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 17:04:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:49008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230462AbhBUWDL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 17:03:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id A233164EE9;
        Sun, 21 Feb 2021 22:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613944918;
        bh=sdMS44GPptRHo2XnNcbqyfg8NDuKHPgbC8eFbDV6ED4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QQCnfE6VP88Ji646J3V3q0nzagttNhOWqCTHOtqM/xXCcuW0AEaPCu8uJ1a8eOfOD
         QpT0cS8PgWuQg0u2HPqgX5uINrnDoeT/UIJ3knh/9FoolwqOYdUZEKj8U/XjoZd5fd
         /bEp/8+SBQed6Lio1nMkkMjLvfYMsgx5hbe4f1mNAPayzDNovsW4A9Wlvet/KtAJQB
         70Xz8pHPJgx0A6LhYXU29RHMhTXjzf+WR9afwc/yu2i9pO0RwNT2vPm4lnlhxzsUs2
         iwz9+UIHl7fF54ZPEedbh8tGYLE3b1GQKXsOdsIv7iyC8P65nVr9AdX48uHbmdTZZv
         uEvD/OOdwvhDQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 9BD5960191;
        Sun, 21 Feb 2021 22:01:58 +0000 (UTC)
Subject: Re: [GIT PULL] parisc architecture updates for kernel v5.12-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YDKQpwGHc7IDsDcp@ls3530.fritz.box>
References: <YDKQpwGHc7IDsDcp@ls3530.fritz.box>
X-PR-Tracked-List-Id: <linux-parisc.vger.kernel.org>
X-PR-Tracked-Message-Id: <YDKQpwGHc7IDsDcp@ls3530.fritz.box>
X-PR-Tracked-Remote: http://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-5.12-1
X-PR-Tracked-Commit-Id: 2347961b11d4079deace3c81dceed460c08a8fc1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 08179b47e1fdf288e5d59f90e5ce31513bb019c3
Message-Id: <161394491863.8676.18180667482029690629.pr-tracker-bot@kernel.org>
Date:   Sun, 21 Feb 2021 22:01:58 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 21 Feb 2021 17:56:07 +0100:

> http://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-5.12-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/08179b47e1fdf288e5d59f90e5ce31513bb019c3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
