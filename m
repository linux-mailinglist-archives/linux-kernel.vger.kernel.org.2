Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7975F3B69B7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 22:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237418AbhF1UgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 16:36:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:41404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235961AbhF1UgA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 16:36:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id A150961CD2;
        Mon, 28 Jun 2021 20:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624912413;
        bh=Wq46VxtmToVT2+jODGjk9JG0Tc7D5JK+Bkx11hnXIgI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=UApRT1J1JjmXmLoGaRdMtg4pnPNLr3FvKXfSI53yPo8WyQkiOndUXX9GUOtvtTwBw
         +BRNjxaRPhFxcJG86Viwqc1c9iJfbY8q7wcY5Xq8pw3HPrt7gSEqR+EKe7htbz16ig
         Scte+Y4AMWVA2b7pqMpKPU/Kc4DfqwVfxYLuUma+78MU6TlYwjr+aw9vHpm4mgBFyF
         K+7lPnWqgyyEYDBErgT9PNs9TWo9uo1GpDkNmktG2GnyCUQVc2ov32fQzFgWFO51rU
         TdK6Q0tz2tUmggfgU7rDP53oTr6AckMS461jDdRdA+mFDzvCKq5NjDOe70VD7BLI1w
         +2hTMvkUJ6eIw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 8FBEF60A56;
        Mon, 28 Jun 2021 20:33:33 +0000 (UTC)
Subject: Re: [GIT PULL] x86/asm changes for v5.14
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YNl4piFBCfvmGgEK@gmail.com>
References: <YNl4piFBCfvmGgEK@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YNl4piFBCfvmGgEK@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-asm-2021-06-28
X-PR-Tracked-Commit-Id: 41f45fb045bcc20e71eb705b361356e715682162
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 909489bf9f88d314dc18be930cefa99ec9a4aac7
Message-Id: <162491241358.14584.4980028241520106878.pr-tracker-bot@kernel.org>
Date:   Mon, 28 Jun 2021 20:33:33 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 28 Jun 2021 09:22:14 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-asm-2021-06-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/909489bf9f88d314dc18be930cefa99ec9a4aac7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
