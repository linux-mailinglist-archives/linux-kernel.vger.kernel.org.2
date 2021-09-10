Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCB84071D3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 21:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbhIJT1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 15:27:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:36014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232223AbhIJT1K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 15:27:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 5D8EF611CE;
        Fri, 10 Sep 2021 19:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631301958;
        bh=EATeyJm8qfF3SE8iCM5kjfV79HUSox1zh5REqNXJj7I=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ZW4O/7SLLZWCHq9H6V1w+GhLxI0mF0wqGPsbdlsiOWMvibqvRifc+tDCDmYa14YUS
         vgccVeSYEz1I9ji7RNAVFiTd6e4vA3gI4OyEr7skt4uAfamZ7a5YD8EjEhwbqXGRmu
         1V8DSx3PIRCGz1zFLosJ9owGVM6/kG/tLcoFHJGRukHLe4C9bhwVFCuIXebrE2eB/w
         2qOYPHhOIQY/4oFQvxF9Y9YuPCsjQqcjT5NQMWEUbh9heWFocwOfYv1QYCbljaE7rd
         6ysvzXl4WCJYlva4oSz1Rl0Fsn5zLUNsRrZs1/6sdNdrthvOac2yYwO7X8BBUht5lC
         WYV8lzKJeGpQg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 4EF27609F8;
        Fri, 10 Sep 2021 19:25:58 +0000 (UTC)
Subject: Re: [GIT PULL] parisc architecture fixes for kernel v5.15-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YTsioP7hPOP47cfn@ls3530>
References: <YTsioP7hPOP47cfn@ls3530>
X-PR-Tracked-List-Id: <linux-parisc.vger.kernel.org>
X-PR-Tracked-Message-Id: <YTsioP7hPOP47cfn@ls3530>
X-PR-Tracked-Remote: http://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/for-5.15/parisc-3
X-PR-Tracked-Commit-Id: 671028728083e856e9919221b109e3b2cd2ccc49
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 23ef827c1bacc6c2b8314ff5bf571d4db57059b0
Message-Id: <163130195826.21375.9642517909511292941.pr-tracker-bot@kernel.org>
Date:   Fri, 10 Sep 2021 19:25:58 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 10 Sep 2021 11:17:20 +0200:

> http://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/for-5.15/parisc-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/23ef827c1bacc6c2b8314ff5bf571d4db57059b0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
