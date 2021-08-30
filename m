Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFA23FBD61
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 22:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234906AbhH3USY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 16:18:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:50440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235071AbhH3USO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 16:18:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 6416E60F8F;
        Mon, 30 Aug 2021 20:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630354640;
        bh=sdlN5z1bcrFsnMe04mWJzFCQCmqgb2hxjJWfLNY9yuU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Z3Ro8pwPxaHNPcRYuvoN9gnRcxjBz6/JcvJJrkfMSn6ATQFcDdEcHCpQ9TYiRjnKP
         s2KrlfuruOBxAGfKdw7wfo5oSyfTJfmwDnd+Z5gpdm+dNrhOGBmJ/A5ox1QuXvGvRA
         61Rx8Fbi6tkURMdR5cJ9xP7QyMhgCw6LW3QRJPbYIaOTq7yKNVTW0AaYYmi2ZOvPaH
         GUzd+w4JvDkCSmRMV4Z7XenWPMVPypddT+ZVnZIet9KDYUXxpWVbORjhXs6YV7+73D
         8/MsKedV4Shy9d+B/zsv3mVzxucPtAkrM8Rp8qpaLm6w7ZZYl4hqrFL3x3Oi0eFGjk
         sQOJc8aPJUMMw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 5A88B60A3C;
        Mon, 30 Aug 2021 20:17:20 +0000 (UTC)
Subject: Re: [GIT PULL] RCU changes for v5.15
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210830041459.GA3067667@paulmck-ThinkPad-P17-Gen-1>
References: <20210830041459.GA3067667@paulmck-ThinkPad-P17-Gen-1>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210830041459.GA3067667@paulmck-ThinkPad-P17-Gen-1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git core-rcu.2021.08.28a
X-PR-Tracked-Commit-Id: b770efc4608d24fb446b94e1087d9989425dd39b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4ca4256453effb885c1688633676682529593f82
Message-Id: <163035464036.13905.18117433424165242858.pr-tracker-bot@kernel.org>
Date:   Mon, 30 Aug 2021 20:17:20 +0000
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     torvalds@linux-foundation.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, akiyks@gmail.com,
        unixbhaskar@gmail.com, frederic@kernel.org,
        xiehaocheng.cn@gmail.com, jiangong.han@windriver.com,
        joel@joelfernandes.org, jwi@linux.ibm.com, fishland@aliyun.com,
        broonie@kernel.org, w@1wt.eu, bigeasy@linutronix.de,
        senozhatsky@chromium.org, yanfei.xu@windriver.com,
        zhouzhouyi@gmail.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 29 Aug 2021 21:14:59 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git core-rcu.2021.08.28a

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4ca4256453effb885c1688633676682529593f82

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
