Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15FB836A878
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 18:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbhDYQwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 12:52:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:56388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230329AbhDYQws (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 12:52:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id E3BE261364;
        Sun, 25 Apr 2021 16:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619369528;
        bh=CDIdzxtDLn5xMGuEYA/VuLxanogDL0B1k1kSTATX++U=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KE/+HwCIhmtTG5hQpW6RGSBuSzhszdVZHMg6tbfWNszjrMs3kc4xqwFB/mmrIXNGg
         KeDMErqpO/pjOaXujytjrrEhsRI7V2DMgjFQOCxg/G6NvgrZtn21axryu32ItUj0fx
         9AIn+7SzzFFlPawOQt3EfylCNtKcjNdHkdcaKrgiRlr4Ykw4VbjLdQsD/cMAe5oQ02
         ls3+oG1tRku2PSm3Xjz8R5VSprsVtlhjbPerpSVpZT3YJG/t/yTmoOX7dBxvzCrl2l
         dh7/NryzS07oi+YhRb60d54OHKhdSSGuILYvmxj47tA6X11HxsrYx/5VRVphlO4c58
         fNGss+FxnT5Jg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id D5CA260CE2;
        Sun, 25 Apr 2021 16:52:08 +0000 (UTC)
Subject: Re: [GIT PULL] perf/urgent for v5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YIU6hPAcb0g1QdV4@zn.tnic>
References: <YIU6hPAcb0g1QdV4@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YIU6hPAcb0g1QdV4@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v5.12
X-PR-Tracked-Commit-Id: 4b2f1e59229b9da319d358828cdfa4ddbc140769
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 24dfc390079c5bda43a689d8b83812ce308e1e07
Message-Id: <161936952887.1859.8820681133622508435.pr-tracker-bot@kernel.org>
Date:   Sun, 25 Apr 2021 16:52:08 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 25 Apr 2021 11:46:44 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v5.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/24dfc390079c5bda43a689d8b83812ce308e1e07

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
