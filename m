Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECB63505F6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 20:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234766AbhCaSF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 14:05:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:46904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234627AbhCaSF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 14:05:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 1EEBE60FEE;
        Wed, 31 Mar 2021 18:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617213928;
        bh=lFUDSref5hXTy/ULFpYFWjrG8z1OvxVLKhFeZIVDvGY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=AZTQF6b4NxrwxfJAq7PH/5LJoLGmxuMg96xp/2aK+CwAVjjfq28KEZS7dtcZqlqyI
         iQh9UvsBqoJUHksgc0mE7K7SLXCyjE03dNmrXndZO3v2CRAvEcUL86t5R/2rTdWG8n
         tWgxwd2hi3sLyH4UUYENFIc8iJHDbAho9ZVKLjjCpo0iz0JhOYtBshh7RPQqowgqKm
         RiSx3wUqOPimn5m5wN9Z50urV4FO9t0Fr5YgreTNwWcmfNCTemZc4zldKPU2aSFu80
         AAxwrB7LcK75FvU1VGEoY02bFdaphC6nr8HDxOsSiCEhG2qaYdAwC2z6Z1yj4EIi+T
         m+1iXiSFjJKAw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 1232C608B8;
        Wed, 31 Mar 2021 18:05:28 +0000 (UTC)
Subject: Re: [GIT PULL] ftrace: Check if pages were allocated before calling
 free_pages()
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210331092711.2b23fcff@gandalf.local.home>
References: <20210331092711.2b23fcff@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210331092711.2b23fcff@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.12-rc5
X-PR-Tracked-Commit-Id: 59300b36f85f254260c81d9dd09195fa49eb0f98
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d19cc4bfbff1ae72c3505a00fb8ce0d3fa519e6c
Message-Id: <161721392806.28439.3205159381400242134.pr-tracker-bot@kernel.org>
Date:   Wed, 31 Mar 2021 18:05:28 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 31 Mar 2021 09:27:11 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.12-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d19cc4bfbff1ae72c3505a00fb8ce0d3fa519e6c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
