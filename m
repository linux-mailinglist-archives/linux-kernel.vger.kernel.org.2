Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43957362609
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 18:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237912AbhDPQxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 12:53:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:49614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235608AbhDPQxc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 12:53:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 2F15E611BF;
        Fri, 16 Apr 2021 16:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618591987;
        bh=9stCuRiAkm6slmsR/LRY4olcC73hbp6I2iNNHr2q5mo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=uQk4k0uGwW7+vi3yo0eEj4cnR1oY/+vxwhLBucpi+CcD1SHkk8l8SEp9NNz6wutFr
         qPbTzilHA2LEOBlfW0AR+WdX7EaAsdp8yK4JNCKx8L2x7d+LDDt+kF0393gdA9jNyH
         cYwi5FsOK7rOfuTiRwX0xAVWE37FLdCRBnEgWaMHg+tjQb+RLNlHKb2J4msWaaGFPs
         mn8d37E/zqD7CVgei/Rc9odvAjbxNSjTp/Ev5LZI4W+tSDJ4YqanOFAPdXmJO+IkXr
         FhLvPL1kNO3uRJPTDzHfRVu5sJ+dCGJvngd9E0vTxQLP1OSLp7lvf5eL63/UP6Tesz
         J2OKLDIGldFgg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 1BF3E60CD4;
        Fri, 16 Apr 2021 16:53:07 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fix for 5.12-rc8/final
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210416162451.GA11506@arm.com>
References: <20210416162451.GA11506@arm.com>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <20210416162451.GA11506@arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes
X-PR-Tracked-Commit-Id: 22315a2296f4c251fa92aec45fbbae37e9301b6c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 06c2aac4014c38247256fe49c61b7f55890271e7
Message-Id: <161859198705.3799.3259163036200596055.pr-tracker-bot@kernel.org>
Date:   Fri, 16 Apr 2021 16:53:07 +0000
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 16 Apr 2021 17:24:55 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/06c2aac4014c38247256fe49c61b7f55890271e7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
