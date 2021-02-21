Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E421320DBB
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 21:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbhBUUya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 15:54:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:42454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230345AbhBUUyZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 15:54:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 42A1A64DF2;
        Sun, 21 Feb 2021 20:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613940825;
        bh=vixM8ppTZ+ZezkWZqL+iMduk0kqZcqvoD9agfEIxnZQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=bgaA6bC7ICYrbgn5Fso0TE1zWaUhJZsV03dFk/Iarity66oYqYhNXhS754gdTokFM
         D0kgJNTEhM/V2H1RGoIxUJigRsZdkd1AzlOi/qY3RrCoqfWWSF3Xn7wvxzXu0qN7s9
         0bTXE7bisuqjdlGTu35FCzOEzH6Ifr3YFc6YEO6UiBesv0HwB+C5ep6yGNbjUNa11e
         cbeyzjropYWiV++7HJtm7wUDfz4qbZkQiNDOOFA/A8Dam9TotEAgmYXsgKnSzRlMWv
         bPsObt4cjesz8UL0/Pftxf95yuCrgcmr4RW5/aLlzgo3A71Tipcg+VyT9giu5l+vlb
         oxxzY2+FEJNpA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 37FF760967;
        Sun, 21 Feb 2021 20:53:45 +0000 (UTC)
Subject: Re: [GIT pull] timers/core for 5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <161341798970.14643.14223719119031979462.tglx@nanos>
References: <161341798844.14643.10479841258453089369.tglx@nanos> <161341798970.14643.14223719119031979462.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <161341798970.14643.14223719119031979462.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2021-02-15
X-PR-Tracked-Commit-Id: 11db5710d4a954148e00e376f04ba91a498a20dd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3f6ec19f2d05d800bbc42d95dece433da7697864
Message-Id: <161394082522.25590.3328995944099175130.pr-tracker-bot@kernel.org>
Date:   Sun, 21 Feb 2021 20:53:45 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 15 Feb 2021 19:39:49 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2021-02-15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3f6ec19f2d05d800bbc42d95dece433da7697864

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
