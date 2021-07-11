Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8C153C3EBA
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 20:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235956AbhGKSZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 14:25:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:45180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235786AbhGKSY6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 14:24:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id AF9EA60240;
        Sun, 11 Jul 2021 18:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626027731;
        bh=54nb+lirJxGfh8XLokRQ7rJ1WKeUTqIpI/18FK/eaB8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=A6D1/yO1VKF0m95NnjRZDuQDazj8csIByfoLEUAjD2drDeFXa3aQbCS7gkrQHgB3F
         ZvpI9LBQbwuoy15yWwA3GlXULZjVSovMzh59qNhuYXUBHzmGpFOVaDbOC7OIDWj6ir
         7YdT0AUVkAAEkbZLuXHZ8COJnIjqsq8fmRFLRjl6mkcHFwNMEmBi4gFy2o6N/fH8wm
         hmJd3yvFF5TESojRCcM36q3iJcVQa671tMcN258YbLxRB0liyaoxYaNuEyps1Bqk2s
         5G0ZNJdDwvxyvs/AmzIGGwDQzZIlu20yloZP5GcW0fFVVBCI1w74ZO36VU/QHuXpjH
         6iaAp7kUiGY8Q==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id AA0DF609CD;
        Sun, 11 Jul 2021 18:22:11 +0000 (UTC)
Subject: Re: [GIT PULL] IRQ fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YOr0zV5US6ajbTaM@gmail.com>
References: <YOr0zV5US6ajbTaM@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YOr0zV5US6ajbTaM@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2021-07-11
X-PR-Tracked-Commit-Id: 48400483565f0b7e633cbef94b139ff295b59de3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 98f7fdced2e0efb1599a37b3e57671a7884f3a25
Message-Id: <162602773169.20558.9454475052050085943.pr-tracker-bot@kernel.org>
Date:   Sun, 11 Jul 2021 18:22:11 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 11 Jul 2021 15:40:29 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2021-07-11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/98f7fdced2e0efb1599a37b3e57671a7884f3a25

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
