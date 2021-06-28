Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5C483B69BC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 22:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237494AbhF1Ug3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 16:36:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:41422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232281AbhF1UgA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 16:36:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id BF0D061CD7;
        Mon, 28 Jun 2021 20:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624912413;
        bh=uqeD4fmpViDkpFxjzHDczMPiJNMf516fRNpmZ9bw3wc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=nHJ4Hcakg8SOdudwAkWDl/f9YsJzkw9gYaaKm5MRT7vq7JTwmF2oAKPuMVV/qP6Xh
         E5/znET15ZsCmV6k1oKb6qaE6rbvgAVElKoeHIWAUOZWRNOwyirqRn6P0jl+8hhS+j
         +mpwBMBLDrrWa/vyGRXLnGIyuJqCt7x2NUt58yRiL6tZE3Ci/LGTwU8SIT5N9+Pi/W
         R8/t/B8Q83+uDrvBFu+1B7dp+hLWlUwlZC01eiWZwZOD9E7QAT66IURg2Lj5RvesQI
         F9pyQxHt9IBxsq7hMDMifX7qwuyedNWAM+Q2bBOd/mCQkd03R6x8z6IIM+13BHBgn+
         7mVbc/2shanRQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id B07C960A71;
        Mon, 28 Jun 2021 20:33:33 +0000 (UTC)
Subject: Re: [GIT PULL] x86/boot change for v5.14
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YNl5RRO5PSlokM+G@gmail.com>
References: <YNl5RRO5PSlokM+G@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YNl5RRO5PSlokM+G@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-boot-2021-06-28
X-PR-Tracked-Commit-Id: f279b49f13bd2151bbe402a1d812c1e3646c4bbb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1b98ed0e83577bc03515f498a5de342f7dbf0b47
Message-Id: <162491241371.14584.9791681829497137467.pr-tracker-bot@kernel.org>
Date:   Mon, 28 Jun 2021 20:33:33 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 28 Jun 2021 09:24:53 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-boot-2021-06-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1b98ed0e83577bc03515f498a5de342f7dbf0b47

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
