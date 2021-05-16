Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBA438200A
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 18:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbhEPQq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 12:46:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:54420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229845AbhEPQqY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 12:46:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id C1D51610F7;
        Sun, 16 May 2021 16:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621183509;
        bh=gFe3Nkxxe5AEjo0ACgVP37XD/G3mI0QMq7xIRQy46Ys=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=d4LIiQ6Ox40bggkPfxDPEAR+uROKNIhDHyCrY8xXVO5+8M3QHQKR3TBGwMpr+Ee+U
         6WIEuW7nUhDn8ZPqE9j9zssQvts3DS67dYAngTQRWp+paj0ya40mOl2EFzyt6SYVQj
         dDnCsJBghu8mwCbEIjb2bjCG2hpmsLKvAvabo9hp+wMuQHJXg91KS7iOZRcE5DSJ+f
         5/Oec14e2VVKP6vLrOVGqT0PYTDMY3jkiS9PuzBW5bw42VjQ+uvSqHYgsDZtYEGaga
         UDjeg/D7DdEIHpjKjKpWZwB3dylVGU4VXgra6SbSndFLMW39rtDZs4M4f14J3qE0ce
         IAdWVDvpLTI5Q==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id B599F60A2C;
        Sun, 16 May 2021 16:45:09 +0000 (UTC)
Subject: Re: [GIT PULL] x86/urgent for v5.13-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YKDWjnjRglMNfFCN@zn.tnic>
References: <YKDWjnjRglMNfFCN@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YKDWjnjRglMNfFCN@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.13_rc2
X-PR-Tracked-Commit-Id: a554e740b66a83c7560b30e6b50bece37555ced3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ccb013c29d2d16e37c9114b1cea19fac5643b173
Message-Id: <162118350973.14702.13231190403825268912.pr-tracker-bot@kernel.org>
Date:   Sun, 16 May 2021 16:45:09 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 16 May 2021 10:23:42 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.13_rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ccb013c29d2d16e37c9114b1cea19fac5643b173

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
