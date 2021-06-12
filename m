Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFCD63A503E
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 21:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbhFLTLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 15:11:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:42652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231435AbhFLTLq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 15:11:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id D11FE61374;
        Sat, 12 Jun 2021 19:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623524986;
        bh=RCXP0w8s3e8xFrg6HAnXg8Y9nzzJfINPrRNIZZ65gxg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=F7X/7Nt+AVAdUZEvh4HaorscERQ8sMRX4rIYagIWThixfpjkW38ZY0VVNaUApKjMF
         sq/s0SK/3Rg4hv4w5upV9QKRV8tT20NcancOhZZq3S9QNUhJo4Vt8ei40OeBf07GOY
         6fnyr8e37p2foffrQ1X+p7nd4sntDGZ1xcE/M50/XEf3XIbqf2tIU2p8uHkqKBPw37
         LhKoEqnYFNVDv9d6h/ZrWimXQvUAyIN1s90KzOrW/OsageBVjZq9IjZLblQNAS7w+I
         yumIDo6uOpprX+u/CEU6QMXiL3vYR2c+58s+rX3br/+jcEnOhs7JvkZMpGyfYAWlkT
         goSNbm/NioEmw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id C86BC60CE2;
        Sat, 12 Jun 2021 19:09:46 +0000 (UTC)
Subject: Re: [GIT PULL] scheduler fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YMSwTuTE97YiP3cd@gmail.com>
References: <YMSwTuTE97YiP3cd@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YMSwTuTE97YiP3cd@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2021-06-12
X-PR-Tracked-Commit-Id: 68d7a190682aa4eb02db477328088ebad15acc83
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 99f925947ab0fd5c17b74460d8b32f1aa1c86e3a
Message-Id: <162352498681.5734.14285118410721912405.pr-tracker-bot@kernel.org>
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

The pull request you sent on Sat, 12 Jun 2021 15:02:06 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2021-06-12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/99f925947ab0fd5c17b74460d8b32f1aa1c86e3a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
