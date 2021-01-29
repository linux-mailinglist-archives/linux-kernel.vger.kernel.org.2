Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF20308FE9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 23:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233588AbhA2WOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 17:14:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:57530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231246AbhA2WNn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 17:13:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 9048B64DED;
        Fri, 29 Jan 2021 22:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611958340;
        bh=h6MGi6mvoSZKWi7KUPYhYFxjOzHzmU7gFO1gAnUUCK0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Zi1e7aBxc8NdGJ7Lg+facJwo7sSUAb1wTJFwG/TydIVu/726IXvZDYZs3EuWINTzv
         Xmu2q7zsDkIbBUxUBC1lXqjP8CV7sygaBote5uL2wTHkEp0m3q006l8ObDfai4fXnj
         egTSzP/Q4WTgMK2gaN/a/uLYRGRxz/Dq9NIYQAxAg0nfSjXqF39nxO1vSHpjr3s1g4
         nBnIXP2+ioQaBdpyaQQNWZqVI1NGr3iOKkdVbYhfWakyG/vA6aJPajoEqwcuymT08p
         KwsjzCnkbcin5HkzAsUGSV5NlZDZ6H7WbPY5Fy0FZ/QxA2w/CRqZk7+/t2BUnjpN0H
         YhyqihRfd0R6Q==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 9D33660176;
        Fri, 29 Jan 2021 22:12:20 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fixes for 5.11-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210129190322.GA4590@gaia>
References: <20210129190322.GA4590@gaia>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <20210129190322.GA4590@gaia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes
X-PR-Tracked-Commit-Id: a1df829ead5877d4a1061e976a50e2e665a16f24
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0e9bcda5d286f4a26a5407bb38f55c55b453ecfb
Message-Id: <161195834063.1476.13006716210513036830.pr-tracker-bot@kernel.org>
Date:   Fri, 29 Jan 2021 22:12:20 +0000
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 29 Jan 2021 19:03:24 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0e9bcda5d286f4a26a5407bb38f55c55b453ecfb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
