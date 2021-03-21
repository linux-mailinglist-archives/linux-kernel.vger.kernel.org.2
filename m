Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A565E343426
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 19:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbhCUSqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 14:46:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:47524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230131AbhCUSpf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 14:45:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 85CA261955;
        Sun, 21 Mar 2021 18:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616352335;
        bh=EVk0MY3mGj1yzfbKOI2XjsICF67hl18w9OVE1w/+8xw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KFjPwaC8j2FhvpNMiwKPOKY07Uk/GWWzqV8wO+UtmSFwErxxdB6L5OovjY4hpjukf
         o0qbo96L6cABogJAu14fiULAtFflCCiL7cYjdtdTUbrw/xtyW9nEj7KfEC050cNquk
         hyvfyxST7i4hwrPodOqyMORTSDkM87x7LGCARm+3tmMZqesJgn9oIzLwbKqFwdYUdw
         RQLRoF3XinG+qJC2xJoJUaXgoA9lH0rSfDsSZvvN1yYq08ngkf6gZcm3sZM1TGiCI2
         mihLrhMywzbQc9G+3IKbjP8m1+km37Z9tRzxLahBCz9fGgnrYD84BY1b4od35wuP3T
         HDnYTcWavCB8w==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 7778D626EB;
        Sun, 21 Mar 2021 18:45:35 +0000 (UTC)
Subject: Re: [GIT PULL] IRQ updates & fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210321114315.GA290313@gmail.com>
References: <20210321114315.GA290313@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210321114315.GA290313@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2021-03-21
X-PR-Tracked-Commit-Id: 81e2073c175b887398e5bca6c004efa89983f58d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5ee96fa9dd78b2dc81b587e33074d877002d7605
Message-Id: <161635233548.28302.11813625661597563543.pr-tracker-bot@kernel.org>
Date:   Sun, 21 Mar 2021 18:45:35 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 21 Mar 2021 12:43:15 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2021-03-21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5ee96fa9dd78b2dc81b587e33074d877002d7605

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
