Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 512E3320D1D
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 20:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbhBUTPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 14:15:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:34078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229956AbhBUTPb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 14:15:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 87529601FE;
        Sun, 21 Feb 2021 19:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613934890;
        bh=T0rAkxWOSDF9tWbpx6HmmhvHRUJc1xmau3Bz9wLbp1g=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=uTf5C2uhC1gNtm582/INehsK70wpVl5x5tw9eKbyZw4Ow5N5Xzo0REi8JBNPj760q
         f4M12IebmPPd0Nk507AawLD+ibjLteL4DgFAmPH8bxAzJwnnXPDfvLBSi1MaAkbNrv
         QvmYriSuBfjvtiHxhqoSoEPc9r02D7+WdrT83nBWxzOO+jLYm7c2lqs3zHY7J+ifMx
         y7/monR5jEmA9tCuaSu4D97VgDugYHi4OVQVhdbrR5W0t0OL9sLeVQ7lApIvrSvGQA
         ntFu6L/1UsauA9xb5YlviXiajQYYTF3S5kFKkRzb04uutZTXCWkpYEtdDu2B28GsWG
         jev4MkePDnTVQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 7432960191;
        Sun, 21 Feb 2021 19:14:50 +0000 (UTC)
Subject: Re: [GIT PULL] Remove oprofile and dcookies for v5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210215050618.hgftdmfmslbdrg3j@vireshk-i7>
References: <20210215050618.hgftdmfmslbdrg3j@vireshk-i7>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210215050618.hgftdmfmslbdrg3j@vireshk-i7>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/linux.git tags/oprofile-removal-5.12
X-PR-Tracked-Commit-Id: be65de6b03aa638c46ea51e9d11a92e4914d8103
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 24880bef417f6e9069158c750969d18793427a10
Message-Id: <161393489041.9182.14381703952935027622.pr-tracker-bot@kernel.org>
Date:   Sun, 21 Feb 2021 19:14:50 +0000
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Robert Richter <rric@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 15 Feb 2021 10:36:18 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/linux.git tags/oprofile-removal-5.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/24880bef417f6e9069158c750969d18793427a10

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
