Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54F503B69B8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 22:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237420AbhF1UgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 16:36:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:41450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235190AbhF1UgA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 16:36:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id E48F761CDA;
        Mon, 28 Jun 2021 20:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624912413;
        bh=yngRh/ZkTgR103nbBEPlbMpSnslPHbEXd5Eds3dPDWQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=JS7yjh0N8hr8Lz1gan5Qrt48rurYDW9g9diYMRxJ5/IA0XXdg4XGW7+Ibnr8Mpw25
         12RKfCqXvidzphT47+gzaM+EHvZlsp/oR10+CLDf4osOC2yMsdBMWvUg7ujbUQgMCM
         sEUswGABtDbxB7KcqbepLuvVph9eQK5KO+nBcEYY4UnTvdqQ3Nu3QDngwN0K4iE5Su
         8ZQOIVUWjWRpSEmMxaVQzlpIZX4ubX76Dkhg6ZxlyzuZraoIJSxCjk14lEdNY20KcO
         gR+2eD7BIBW2O6AmtwQCZOHCElo26UWKaaW5NwrCfOoiGrqmtnqaWdfdCoMh6ubnVf
         ymeEGpNDt6YMg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id DE21A60A71;
        Mon, 28 Jun 2021 20:33:33 +0000 (UTC)
Subject: Re: [GIT PULL] x86/cleanups for v5.14
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YNl6Wukqdm2FnAsZ@gmail.com>
References: <YNl6Wukqdm2FnAsZ@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YNl6Wukqdm2FnAsZ@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cleanups-2021-06-28
X-PR-Tracked-Commit-Id: 1d3156396cf6ea0873145092f4e040374ff1d862
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8e4d7a78f08a788a839bd88a2710ba7a71a86e24
Message-Id: <162491241390.14584.4886756046366512971.pr-tracker-bot@kernel.org>
Date:   Mon, 28 Jun 2021 20:33:33 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 28 Jun 2021 09:29:30 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cleanups-2021-06-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8e4d7a78f08a788a839bd88a2710ba7a71a86e24

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
