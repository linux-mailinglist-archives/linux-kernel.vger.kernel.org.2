Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A29F13A503C
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 21:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbhFLTLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 15:11:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:42642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231428AbhFLTLq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 15:11:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id BA63961357;
        Sat, 12 Jun 2021 19:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623524986;
        bh=RGVjKld84Q7PJtFhuee+4U6MlM9oI+ZjZ5VF6oA9zQc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=l9ARDJSco/38LEe1npSSYyGUzJ7GSKlTC34zn+MLkyK+uDLscJ3zytT1Fn1cDucE3
         HQfmUdwJRx3JbhK1mjmu/8EHbdUczV/ZwnzpFfeTN94V8bDw8dDsYcDpKbHh1Lysx1
         MxiSpvUu8DbPyyLq8jjZGD3NDtl6+1k/rEOwHLtktMofv5XPTd6UNF2m6UHSAObh2d
         2lqkaWZbkEnF6hFZpcpPthM/bRP5bcDRjRQImwqlWo4/H7kbhgLJ2IV5xB3oJaU2W5
         dt8omwWhB/rwhiiGat+WbM77VxhHem2BtS1NZhzKWhkdJACNRsER9ttNSRGUIFRfai
         TYOnk/McDe6xg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id ABE0560A49;
        Sat, 12 Jun 2021 19:09:46 +0000 (UTC)
Subject: Re: [GIT PULL] perf fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YMStDxqWUUZTxiz4@gmail.com>
References: <YMStDxqWUUZTxiz4@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YMStDxqWUUZTxiz4@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2021-06-12
X-PR-Tracked-Commit-Id: a8383dfb2138742a1bb77b481ada047aededa2ba
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 191aaf6cc4a7db907520f18af3a90b260e7dd091
Message-Id: <162352498669.5734.9726216767463935259.pr-tracker-bot@kernel.org>
Date:   Sat, 12 Jun 2021 19:09:46 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 12 Jun 2021 14:48:15 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2021-06-12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/191aaf6cc4a7db907520f18af3a90b260e7dd091

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
