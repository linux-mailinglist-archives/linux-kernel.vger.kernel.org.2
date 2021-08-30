Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE06D3FBD82
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 22:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236538AbhH3Um2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 16:42:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:34806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235278AbhH3UmN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 16:42:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 06B2260FD8;
        Mon, 30 Aug 2021 20:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630356079;
        bh=dSJYFzOo/Lmboe4ybqz5OMI8Q7WFtcnXRZLm6+YoCtQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cTZTsiQ9yP6zDc6KFo6HeodLMe1oYa4ImiClcFCwN/TU6EP0N8/H9Kdw7r8fP6h0e
         CE2e8imydKv1Iz/YxiHhz1bVab21Xi+qxml8+A9U+NR+apIRdczJChC7fbrNB2x7IA
         xjzaw0n+cMJ6g0FfRLWaoSvIpKVJRrIYCpeDaR1LCfCzT5s4pnRA5djr4RBSUXeNYK
         cMJoT8IRhOMmKmSe+qAZOfo4C8yLugfxMtzbBi/3BTFY5KyoRC/jOvFDW1QMvpwWse
         6iL6spNPyP+5uy6L1q+v/1e7W0+T4dZ3+cesdT4CYANaQG5aWds2U/WfIdxrUCPKLs
         YeDYcY6ZRUNkw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id F40DD60A5A;
        Mon, 30 Aug 2021 20:41:18 +0000 (UTC)
Subject: Re: [GIT PULL] x86/cache for v5.15
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YSysp4mh5rake4Vm@zn.tnic>
References: <YSysp4mh5rake4Vm@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YSysp4mh5rake4Vm@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cache_for_v5.15
X-PR-Tracked-Commit-Id: 111136e69c9df50c3ca7d4e3977344b8a2d0d947
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 42f6e869a028abcf61422bc0d5de59d823db17b1
Message-Id: <163035607899.29257.3044164899914294140.pr-tracker-bot@kernel.org>
Date:   Mon, 30 Aug 2021 20:41:18 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 30 Aug 2021 12:02:15 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cache_for_v5.15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/42f6e869a028abcf61422bc0d5de59d823db17b1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
