Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05A603B692B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 21:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236729AbhF1Tgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 15:36:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:41174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236701AbhF1Tgt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 15:36:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 567F5613F2;
        Mon, 28 Jun 2021 19:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624908863;
        bh=p843uztPMWRB0fVQjCJWb1aN+wjW//pzxZlQwObyx3k=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=raE7hdKnZ4I9zSeCATcpTSwsYkLOSbvTWGOExKSuY+2dKcKSoucpzjlIsvZcxKodY
         ksJ60VQTQFYXJR/uHyAJtGWej6iI0rYWPqoUZlkwSSZWExOvwhHJ09z+UG3TfTgKas
         GpC9nbrOdT8seAMjfE+6Lqd/GGaXbo2gGd33eTWSvWpI9I+5LUCTeKrysHwGhI8/1Y
         e3lLshCKS3ALVFoI6DgiK6Yu0exnroQGpL9QgKcsJXv+gVXIAPNyEFa0gsXdJ2DNZV
         OW4h/6Lk72rpd8Kxw/fRjzNiA6T+yyiej6FVlUhfkNP5B0Q6Zi3p0GAi8H9owXT2jh
         EpolRxjMzPagA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 5093B60A71;
        Mon, 28 Jun 2021 19:34:23 +0000 (UTC)
Subject: Re: [GIT PULL] objtools fix for v5.14
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YNljN5OXy1opw86H@gmail.com>
References: <YNljN5OXy1opw86H@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YNljN5OXy1opw86H@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-urgent-2021-06-28
X-PR-Tracked-Commit-Id: e31694e0a7a709293319475d8001e05e31f2178c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b89c07dea16137696d0f2d479ef665ef7c1022ab
Message-Id: <162490886332.14456.11417796018920411740.pr-tracker-bot@kernel.org>
Date:   Mon, 28 Jun 2021 19:34:23 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 28 Jun 2021 07:50:47 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-urgent-2021-06-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b89c07dea16137696d0f2d479ef665ef7c1022ab

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
