Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6A4C3FBDDA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 23:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236842AbhH3VFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 17:05:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:39334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236009AbhH3VFM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 17:05:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 5960460FE8;
        Mon, 30 Aug 2021 21:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630357458;
        bh=QgSJAZd5/xth6ViX1Mg8LffXZO7upFj4cijUpibFqDo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ggTlag5hhKzh6geuJ8W3dU9tE6jRSPANxhX1AbBM5zn0HXEp1UEQ+iOQCb2qVfd3v
         uNdJAtIdZRTVeOR1JYIhkhe4+NjnqQ63EaE8YBXxtpKYAnBm1YLRjhkxrDhcj5hd8C
         ISSXG7Pk+9ac2iYYKX6DKzIJp5vMQsKPQVsxhu0PDo6lFTj99JIP/TG+QxzQhIoq3i
         pwawynilPPGjMhpcFM8Bww83eFUEgHr1eH8g3ngi/bR9raV7pYx/Xcs5s5XqbKyxVV
         PReHYEqM7s76e6pPCnV1qpnL2FyqyEZWemKKLUkuKGI+XDEfh9JxXs/TDgEvZsW8Bc
         0pas4qmP5/QzQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 486EA60A3C;
        Mon, 30 Aug 2021 21:04:18 +0000 (UTC)
Subject: Re: [GIT PULL] perf changes for v5.15
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YSytsSM2mOcpGHJq@gmail.com>
References: <YSytsSM2mOcpGHJq@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YSytsSM2mOcpGHJq@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2021-08-30
X-PR-Tracked-Commit-Id: 6a371bafe613b7746c3d3ac486bdb3035f77e029
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4a2b88eb0265a9d550982b188abf20618a0c1a84
Message-Id: <163035745829.10236.15352619566864058246.pr-tracker-bot@kernel.org>
Date:   Mon, 30 Aug 2021 21:04:18 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 30 Aug 2021 12:06:41 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2021-08-30

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4a2b88eb0265a9d550982b188abf20618a0c1a84

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
