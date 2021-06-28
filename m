Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9823B692D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 21:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236705AbhF1Tg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 15:36:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:41228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236713AbhF1Tgt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 15:36:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 9255361165;
        Mon, 28 Jun 2021 19:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624908863;
        bh=SJFHINRkUTebbI2bZbxlBWEpofAx2SWW9rjDxaPbfeo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=nuQ1olwvLAPY4JlU/2tVl2eV9oRcMSiBuRQrcsKQdL3GHJaWHWTPtnC0rfg0KHWG2
         baQqXIjXKMSa5edwDFS6yFaCY+IQrAhAIvIxQRdyJy84JHsQ7LmY4QHcrXWDXE6sN2
         IG1jySnP2NH5fSlF8HiCbp54sRxVx9ls72uZ53WIm+WNT2A4SRW3E3wrsvE9ZFcW6N
         iVZl2yZDYwl0DSmJu/MRZ4gvi67zsitA00ScQupnrNR8Pp9u/SbSnbcObr8KUW0EEK
         2v0xkYoOM+B+mkAJ21lI+gt/l78uVMAO3JtUgED8zsUFCYNIncNAxq/mPnFaz0vLwM
         VJP7Xi2yu+ljQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 87F6C60A71;
        Mon, 28 Jun 2021 19:34:23 +0000 (UTC)
Subject: Re: [GIT PULL] locking changes for v5.14
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YNlo43RtRbxBb+so@gmail.com>
References: <YNlo43RtRbxBb+so@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YNlo43RtRbxBb+so@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-2021-06-28
X-PR-Tracked-Commit-Id: 0e8a89d49d45197770f2e57fb15f1bc9ded96eb0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a15286c63d113d4296c58867994cd266a28f5d6d
Message-Id: <162490886355.14456.16101484981323790029.pr-tracker-bot@kernel.org>
Date:   Mon, 28 Jun 2021 19:34:23 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 28 Jun 2021 08:14:59 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-2021-06-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a15286c63d113d4296c58867994cd266a28f5d6d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
