Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B623333A7FC
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 21:39:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234128AbhCNUi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 16:38:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:41572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234075AbhCNUir (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 16:38:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 8917D64EC6;
        Sun, 14 Mar 2021 20:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615754327;
        bh=9gSSykMQxwZI+nXQtMc/qwkaaup8VerQGwZRtyQrjmo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=m9xCvcS1rLhwhl6mrjW2cANqiuhOs9OJBdHNuVK4lLh2mmmA0ZHWeh2LZvz3FA30C
         sMyrQCU+ULCjSIMIJBs3cZyLR8pi8PW8S/4Xv2IWtyJUgScCtGnM0woECsHmKKAPEw
         m2kr3PVJbsddaoYfnOAA68seAH1Aguje42cXwjGqFuwiyNsHel2oEKL7bSfx94clUk
         Yt7/S2gXHMLj76ljuRay2jhSy52OvTspTVjkX6HZz5xQCCGMGiHUswQ0un6cyVcS+1
         BwyjbmYb9YCL6iX1nruNQLPMuypElLywQC4W/Jfmjzf28p70QLf0CXdK50lpIHRZfm
         BkedI30aQ42Lg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 842EC60A45;
        Sun, 14 Mar 2021 20:38:47 +0000 (UTC)
Subject: Re: [GIT pull] irq/urgent for v5.12-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <161573640150.27979.5672484140896063253.tglx@nanos>
References: <161573639668.27979.17827928369874291298.tglx@nanos> <161573640150.27979.5672484140896063253.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <161573640150.27979.5672484140896063253.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2021-03-14
X-PR-Tracked-Commit-Id: b470ebc9e0e57f53d1db9c49b8a3de4086babd05
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 70404fe3030ec2dcf339a9730bc03bf0e1f2acf5
Message-Id: <161575432753.20317.595448555807906595.pr-tracker-bot@kernel.org>
Date:   Sun, 14 Mar 2021 20:38:47 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 14 Mar 2021 15:40:01 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2021-03-14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/70404fe3030ec2dcf339a9730bc03bf0e1f2acf5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
