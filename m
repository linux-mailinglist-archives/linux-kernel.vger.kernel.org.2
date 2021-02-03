Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 042A830E366
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 20:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbhBCTj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 14:39:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:43776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231213AbhBCTjW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 14:39:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 3863F64F87;
        Wed,  3 Feb 2021 19:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612381122;
        bh=oNlGnzBIazpZ0i7Wj3lHbpSnHgGT/HiV0QvY8Au/TZo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KYeAYYuc7W2E3AUR2w1EVQRZ/iApzTP9G8JSMJTTP39KH4BJ7YjqcC8nS8FUiMaJZ
         LfQRW8Uu6k/6JyKdIZ1GvoUHYblancBF0QRAP/wr7Xf5OwiJZaVOdHHnQExiZrwG+t
         /AYAxbZrut2GojSsAiQKUBj5Q73tKdKG+ov2gSnOk8ibdv/98MZMpRx8Qh2K+5o8OJ
         X1dAHsuHHpgG29qcamAByw5xV73M2kE/Xaty1XcVB3suCw4JUIoXJARHu2Wt9Vbd4w
         wN5yIqxN0xpk6NYt64b8H4fTukUZgKuNuEHCpvi2rGLUsDbWH6YpnEsAu5JepkKAPX
         J2C1zt/a4B3sg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 33551609E3;
        Wed,  3 Feb 2021 19:38:42 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fixes for 5.11-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210203184408.GA5226@gaia>
References: <20210203184408.GA5226@gaia>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <20210203184408.GA5226@gaia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes
X-PR-Tracked-Commit-Id: 22cd5edb2d9c6d68b6ac0fc9584104d88710fa57
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3afe9076a7c19140b789d144d0ba1e9be2db4265
Message-Id: <161238112220.20071.16365451471144489588.pr-tracker-bot@kernel.org>
Date:   Wed, 03 Feb 2021 19:38:42 +0000
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 3 Feb 2021 18:44:11 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3afe9076a7c19140b789d144d0ba1e9be2db4265

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
