Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC9B83ECA5D
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 19:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233396AbhHORBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 13:01:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:52904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230282AbhHORBD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 13:01:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 4105E61221;
        Sun, 15 Aug 2021 17:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629046833;
        bh=iXiJPnew9qNmt55mZ0ttBJ8GfWZ5GUuXfexpLgyq26c=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=SHWcBmX51gnDY06Dj6rAMwiQyLafNvPOTncwxRuRbyjdv55W+zBPAHhIIDtgCTnyA
         /WHvzemX9kX0BMJKKb41r8/7LUCwhHA/LJQTrZqn+vWTXGbEKlAyB19F+9q0+1DqPJ
         y2umROltoGwvR1xjAfSidkRl72faexpIywzGs9tUk45rtspnfxalQK1Yk2pa/+qUBd
         wW1SnnEDY1j4Jau9mqgbUS/RlPw14I5kBCJYC3HFh1Jq7Q0GeK/9/q+fu9rlVWghI/
         h1+h77ahQCl8fes52fGjnsUxoSIqIHBZ5vZak2RwWpuVOeEvGAmCiCA0zRbkdOXQiI
         v4ChhCzCZuqjw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 3521F60A69;
        Sun, 15 Aug 2021 17:00:33 +0000 (UTC)
Subject: Re: [GIT PULL] efi/urgent for v5.14-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YRjKKLSZD5aN88W2@zn.tnic>
References: <YRjKKLSZD5aN88W2@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YRjKKLSZD5aN88W2@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/efi_urgent_for_v5.14_rc6
X-PR-Tracked-Commit-Id: 55203550f9afb027389bd24ce85bd90044c3aa81
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 12aef8acf0991e8a4a5fe892067e2c8fc6760ace
Message-Id: <162904683321.11260.14863447914399167104.pr-tracker-bot@kernel.org>
Date:   Sun, 15 Aug 2021 17:00:33 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 15 Aug 2021 10:02:48 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/efi_urgent_for_v5.14_rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/12aef8acf0991e8a4a5fe892067e2c8fc6760ace

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
