Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEBE6418A5B
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 19:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbhIZR2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 13:28:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:42424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229483AbhIZR2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 13:28:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 3AAF660F92;
        Sun, 26 Sep 2021 17:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632677224;
        bh=ICJkexNO3XUVL0nwddLZQxBTg8wcYRZcWywccEdYTeg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=bF8voSTO7ycD1+Ngm/w0Kbr0O0mZIosGcGFRHgBKJxNlFo19u6SI1nHEADj+/k3M8
         8dL8WXyRtMrrNZqY/wby+9BMqxrVPBYToGlRZZpPdqoIawxf1K4ao+Wfy6KsxdjWKJ
         gORwhtGrBcYuoks71HUIAsAOYX+eBm/1RxqfTMctAJMdAiJ5YTidaNdtm9t0djzRzd
         NaoqpX59wlKP5KQpi7A5HbAmYOHec8gtDDJAzENpqr6SzDOlRt7Ot5P762Z3FKqUvL
         OtrGM85Snuqt68WqeNytNjEcjYUPtjJXstPR+khyZGIL0qRdyHxQrhkMmSQnz0pbTL
         mZ/RuukN0uZDg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 2E500609CF;
        Sun, 26 Sep 2021 17:27:04 +0000 (UTC)
Subject: Re: [GIT pull] timers/urgent for v5.15-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <163265189373.178609.1258692845178002939.tglx@xen13>
References: <163265189226.178609.9712455554034472888.tglx@xen13> <163265189373.178609.1258692845178002939.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <163265189373.178609.1258692845178002939.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2021-09-26
X-PR-Tracked-Commit-Id: 8cd9da85d2bd87ce889043e7b1735723dd10eb89
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3a398acc56dd7592eba081ce1ea356151ab90e2d
Message-Id: <163267722418.5286.12623306224189043854.pr-tracker-bot@kernel.org>
Date:   Sun, 26 Sep 2021 17:27:04 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 26 Sep 2021 12:30:07 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2021-09-26

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3a398acc56dd7592eba081ce1ea356151ab90e2d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
