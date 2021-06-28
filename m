Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5855B3B692C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 21:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236775AbhF1Tg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 15:36:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:41206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236705AbhF1Tgt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 15:36:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 7A31E61CA1;
        Mon, 28 Jun 2021 19:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624908863;
        bh=oJiPsHvV00R8oZIgGxppvEeJFrZkwI/+ioptfHX246s=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=oplKfW2haYQjfxrUqbAalZnbQVKhwyeWRHa0Jo1Mo6aslcsmwMW7OmjpnprPts5Tm
         wuzk4VUf0C23mVMyX4AJ1ysts6VLazvyH33L0NmmbZgmNIbdqdhzlk6t1Y2Ebr46y8
         UZr+9teoax5bLhRdLQg2rs6tP22ldBeKJFxywUbNOZa6082MTBP/m02j9JwmKPQKP1
         XbNU7hPdIYC3ZowM8y+9cV2cOUghMYR7rLk0gBbeWL4ZgbRJQNJVbdRXM8gW0MO1u9
         b+pBUijuraCt2ZAng4vIN2C875C8yVqIsBPcsOMoqwIbBEjmxBcUDZmrVRc8P/itg0
         LT9uDnCeeimbw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 6CB8E60BFB;
        Mon, 28 Jun 2021 19:34:23 +0000 (UTC)
Subject: Re: [GIT PULL] objtool changes for v5.14
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YNlkrfFqO/bsKq5D@gmail.com>
References: <YNlkrfFqO/bsKq5D@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YNlkrfFqO/bsKq5D@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-core-2021-06-28
X-PR-Tracked-Commit-Id: d33b9035e14a35f6f2a5f067f0b156a93581811d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b89c07dea16137696d0f2d479ef665ef7c1022ab
Message-Id: <162490886344.14456.9677018670087771513.pr-tracker-bot@kernel.org>
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

The pull request you sent on Mon, 28 Jun 2021 07:57:01 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-core-2021-06-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b89c07dea16137696d0f2d479ef665ef7c1022ab

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
