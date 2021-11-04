Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F202444DF0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 05:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbhKDEbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 00:31:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:60554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229477AbhKDEbS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 00:31:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 10ED860EDF;
        Thu,  4 Nov 2021 04:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636000121;
        bh=TKeK/+vxB8t1P8ZeczAyl/3rBcV1wlhlUZbhndXr6dg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Efu375FVnI9iquoOMt/+o9S8bfCO8gyAupWKmjQMofzB91mzl5v7Nt4BUaD2CN/To
         0P5dpKIUV2c1W4v6tjqNKUzdxoWozBVpOrt/46UO15iuCGZ0hUfk/8XXm5lOy+DH88
         i7b3ySADX3Wi56ro5j85xqCXHZOXPae5ErJToDQS54mkvRHnnkscueqR6ag7dvGm6P
         ESS8LYps7LRqMLiNBHYHyQDuFOO296VE7EP85xyj49W+eF3nWYXD3qkfCfG8ZND+s+
         /toCa7h0B6Il8eYT8YKEgFnvlXjx+5gv+yuf723efBvrn91JbgIpgl6hNSSy/VsFJ9
         oGCoYQ7DE3P5A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id EDDED60173;
        Thu,  4 Nov 2021 04:28:40 +0000 (UTC)
Subject: Re: [GIT PULL] clk changes for the merge window
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211104004857.609841-1-sboyd@kernel.org>
References: <20211104004857.609841-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-clk.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211104004857.609841-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus
X-PR-Tracked-Commit-Id: e2ceaa867d266472b31f3e03ba16f3120aefc152
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7ddb58cb0ecae8e8b6181d736a87667cc9ab8389
Message-Id: <163600012091.31948.9267957881949704248.pr-tracker-bot@kernel.org>
Date:   Thu, 04 Nov 2021 04:28:40 +0000
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed,  3 Nov 2021 17:48:57 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7ddb58cb0ecae8e8b6181d736a87667cc9ab8389

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
