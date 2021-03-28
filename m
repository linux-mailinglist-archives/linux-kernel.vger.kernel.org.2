Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5934D34BE87
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Mar 2021 21:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbhC1TWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 15:22:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:51566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231330AbhC1TWY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 15:22:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 43C2261999;
        Sun, 28 Mar 2021 19:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616959344;
        bh=tuovERmVoh1FWm4i8Zgj5Ngx1X81AQ9X7HlAFZ8nai0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=OqLHRgsEJAq4t7tSQYHeRebkGzn6bpQfdj0u4kppc+X8b/7HbzYOtEI3facIDPlbf
         hD7pg8LhNMkD2fM9oP28E0hvRVtAkn6SAx2ve1pAGx3Fs7YV2ZkVaDVt6Y5SCl0bZF
         95zme4OsZdaxQ/U8D8d5DS722LFu47zwTDFNg2emVICrtV5JWhUDEeJ0d2GDEZNOt5
         0IWAdYVefjJ52R3SXHczkUxzh0VvVjiGC/mzku1zK/n4hI0rQrdbIaMw/ytTvnocAi
         OTVjkJY7BIHDRfd29Ld1525uTvEbzJc/Liic5/EilOrXgLfGFf7w095XDpoxf0hyNG
         V54tuMiGVVQ2Q==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 2BB0D609EA;
        Sun, 28 Mar 2021 19:22:24 +0000 (UTC)
Subject: Re: [GIT PULL] locking fix
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210328102843.GA347473@gmail.com>
References: <20210328102843.GA347473@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210328102843.GA347473@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2021-03-28
X-PR-Tracked-Commit-Id: 291da9d4a9eb3a1cb0610b7f4480f5b52b1825e7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 47fbbc94dab61a1385f21a0a209c61b5d6b0a215
Message-Id: <161695934412.29365.8251458133132294947.pr-tracker-bot@kernel.org>
Date:   Sun, 28 Mar 2021 19:22:24 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 28 Mar 2021 12:28:43 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2021-03-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/47fbbc94dab61a1385f21a0a209c61b5d6b0a215

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
