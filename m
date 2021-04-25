Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28E1336A876
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 18:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbhDYQwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 12:52:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:56356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231150AbhDYQws (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 12:52:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id C30A1611F0;
        Sun, 25 Apr 2021 16:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619369528;
        bh=/F4AwyVE2uWFDbl6sVkdBgZmguojyNWQHVxgRdMDdLo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=UHyvcXTGRyC0YcyOIS0EeT2Kv4uwGin5JNfyCmbEfR03hQdp7aNaYguQIxBa+SPxu
         6XKQGiZ5Jm4jOydkG/KCfiU2pGQQpDg5Ukkxtfb0MRKcdoRDuQ27+LJg9FEYpJjRvq
         2U0RjBpq75YrUwbKchw8RyzecpGxEDy+/ey4/CdjSPXAfmGa154ROzi/og1VaLlRnh
         KX+bMzjEhpNx1OReRftMdwJHsHn9DjDC7H5RGSvBi5NZ5kORFhAh7JbfhOrc8mE8Go
         x00gtXcB8eugfKV/Ad4jxlEJKAWVdt6zm55posARId5+APtZZkgV1b/8LVl8xImwVO
         k6OHsX+iRUigQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id B95AF60CE0;
        Sun, 25 Apr 2021 16:52:08 +0000 (UTC)
Subject: Re: [GIT PULL] sched/urgent for v5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YIU24WgaUnl0kh7g@zn.tnic>
References: <YIU24WgaUnl0kh7g@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YIU24WgaUnl0kh7g@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/sched_urgent_for_v5.12
X-PR-Tracked-Commit-Id: 0c89d87d1d43d9fa268d1dc489518564d58bf497
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 682b26bd80f96c2e4da3eb6dcec8bf684b79151c
Message-Id: <161936952875.1859.9042601329090879485.pr-tracker-bot@kernel.org>
Date:   Sun, 25 Apr 2021 16:52:08 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 25 Apr 2021 11:31:13 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/sched_urgent_for_v5.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/682b26bd80f96c2e4da3eb6dcec8bf684b79151c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
