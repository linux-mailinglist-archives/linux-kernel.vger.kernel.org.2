Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7114836B7EE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 19:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235813AbhDZRUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 13:20:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:60298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235298AbhDZRUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 13:20:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 54D4661075;
        Mon, 26 Apr 2021 17:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619457560;
        bh=dKNFYEIrDYcPAdl6gva7t/YFdwxP6k/hmhaYpGsAPAA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=SeA2UVYu0vV0CcPQEYQnbvUYn2gqpmZN5zzZcHKCCbTM9vyGn6dg3f24YBM4MM5s9
         1+aLHxNrDd95+kehh31CjDLndMBl6vS9Yk8jj1DqcDFy6zJ6A5PvHBq5d4q7Hw5Tzz
         PExoCNOPlKZZQXvOazxiC7YLSRk7spmBjQFgzL/u+OOAIo/ZjUa12XjaqVEACCVYH6
         r9BxuYmwsJQrPU2U8ZxNnvgepdRv8rocy23pR2QqAOTBJNkF0xt76w7B5j7Lbu+c4s
         zJ8GHmAMOj0FvgIizWOdl+gZt0t/wNvUdS2q3euZ6F549JZCip/jsu21D5VACjxQIG
         u/OQyBduD+GYg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 4DD9A6094F;
        Mon, 26 Apr 2021 17:19:20 +0000 (UTC)
Subject: Re: [GIT pull] irq/core for v5.13-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <161942931322.31579.7197210361416957505.tglx@nanos>
References: <161942931322.31579.7197210361416957505.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <161942931322.31579.7197210361416957505.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2021-04-26
X-PR-Tracked-Commit-Id: 765822e1569a37aab5e69736c52d4ad4a289eba6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 91552ab8ffb81317656214daafd9a7bcf09ab0a0
Message-Id: <161945756031.14705.5029672615843402248.pr-tracker-bot@kernel.org>
Date:   Mon, 26 Apr 2021 17:19:20 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 26 Apr 2021 09:28:33 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2021-04-26

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/91552ab8ffb81317656214daafd9a7bcf09ab0a0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
