Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3CD3397EC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 21:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234598AbhCLUDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 15:03:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:60320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234567AbhCLUDe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 15:03:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id B120064F89;
        Fri, 12 Mar 2021 20:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615579413;
        bh=kbtHj+mopQvlFNd06YoCcNKFquAi3YdlINQNhne5QRA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=q7fdfWXSsSsCOYcEf1WlUQiEyftAG1MP/e63IsjCNuWRFUdd7jOSFXD+bESGnSdmK
         NFLG9BKpTBdn81ydAtCd2niukSvy6kJqP9sLj82ZoHSoRq73VVvM29fMXRq6VW3+ZW
         RqyJfqV4IUZTsTNK3I1moQNoVjHypfTTuo+uLQSx8zGAglS6OIynLZE17dAgXyJdok
         TKfn06vJ3PdtttGlwb+InDNocl3RLdQWbw4t9wf/wqi8/SYgngCQwdWxYD+xDLcIC4
         xEa3ye8OnRbtQRTnUaQqkGI4f/4O5lQWA0W2SW4zqGcTSRO/NcB0QKSyUu+mTe/raV
         rp6AuVFbO4Zsw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id ABA45609CC;
        Fri, 12 Mar 2021 20:03:33 +0000 (UTC)
Subject: Re: [GIT PULL] arm64: Fixes for -rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210312133415.GA359@willie-the-truck>
References: <20210312133415.GA359@willie-the-truck>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210312133415.GA359@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes
X-PR-Tracked-Commit-Id: c8e3866836528a4ba3b0535834f03768d74f7d8e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 17f8fc198a6fc64cee2b1e126398d0c41823f5a3
Message-Id: <161557941369.10515.7466598792552007882.pr-tracker-bot@kernel.org>
Date:   Fri, 12 Mar 2021 20:03:33 +0000
To:     Will Deacon <will@kernel.org>
Cc:     torvalds@linux-foundation.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM Kernel Mailing List 
        <linux-arm-kernel@lists.infradead.org>, kernel-team@android.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 12 Mar 2021 13:34:16 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/17f8fc198a6fc64cee2b1e126398d0c41823f5a3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
