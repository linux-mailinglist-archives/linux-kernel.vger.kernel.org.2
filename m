Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E78A36E089
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 22:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbhD1UuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 16:50:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:49950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230122AbhD1Utz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 16:49:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 4F2E461449;
        Wed, 28 Apr 2021 20:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619642950;
        bh=xJwg1yadRCY3Vdu4oM2nUmFuLd2WAgQcmm4tJjeuirs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FGq/NqTz4uHPyIAhD6pwdY5AxuYrzMNuF6T7ix9SeGZ6VtfzYnU/1Hkj1od8N2wv8
         YVCyyhLzYX9eRVOaEHGJ37+CEeNjPYXe5bcXKpKsF3QHu/Gdr819K3EJsRjIhJSsPu
         sB2URFiKItUHr627TiwVmE7J5lIm6UnE+8ZIHcgJZoWmqT9VkdJb7szAWZ23J5Pfzw
         qf9bDA3uskQkq38TiVNrT2kmIvojsB8dCmTKWszMzdxeReDYemcDWmpuMK4Z7BWsXg
         PQs9WvQIMFstcrJCd0D/J3YyEGEgNQkHIjFkCbB+fKFynCKS8SDthZ7JiWHk8mMSSH
         mSwVjtVYX7UvA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 39BA260A23;
        Wed, 28 Apr 2021 20:49:10 +0000 (UTC)
Subject: Re: [GIT PULL] RCU changes for v5.13
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210428071032.GA84588@gmail.com>
References: <20210428071032.GA84588@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210428071032.GA84588@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-rcu-2021-04-28
X-PR-Tracked-Commit-Id: 120b566d1df22a0a4543ac0e8aef875c49dd2c21
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9a45da9270b64b14e154093c28f746d861ab8c61
Message-Id: <161964295017.5673.3392990436146609069.pr-tracker-bot@kernel.org>
Date:   Wed, 28 Apr 2021 20:49:10 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Triplett <josh@joshtriplett.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 28 Apr 2021 09:10:32 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-rcu-2021-04-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9a45da9270b64b14e154093c28f746d861ab8c61

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
