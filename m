Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A989D36A875
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 18:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbhDYQwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 12:52:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:56328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231149AbhDYQws (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 12:52:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id B4C6B61103;
        Sun, 25 Apr 2021 16:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619369528;
        bh=JWl5emZu1IPr5ICcV8SzRMNpxir0Sm1czXaWp1CDU3I=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=swEuIZWQjTZ7cgZ+eSU0nOWW2oT0T0muiFkNAvWqMJYA4hAWRD4F0XlI2gcBC4k2r
         aE/lw5z2ZiEY7oDAnhU+oVR4K1gNPkfpavnMEzpnbZf+VF9spWeimEzQ4TrILJYm02
         Q+lEjZgFW4j8vMaNdLR5L7+gMrZzPtB/eBxeYwFu/lIMgQbRkz5tpC6UPPxvTM6xW5
         EFqOfPcehB0Agbnsbw2vvqvo9vGjYkJRCy8+kP+OKoM6jhxPnSvwHQefUk+vuvjlEt
         uhT3i0l/A63sVTPjeosGVqDlXRBvYng9L4BYmjAqifV0nBwAGjh4PFdROsXg3fOxT+
         131zcxQMJoYjA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id ADE0F60283;
        Sun, 25 Apr 2021 16:52:08 +0000 (UTC)
Subject: Re: [GIT PULL] x86/urgent for v5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YIU1Tap67cOpUHMb@zn.tnic>
References: <YIU1Tap67cOpUHMb@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YIU1Tap67cOpUHMb@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.12
X-PR-Tracked-Commit-Id: 5849cdf8c120e3979c57d34be55b92d90a77a47e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 11fac7a004113466b7155e9b0d836156cf8a7e8d
Message-Id: <161936952870.1859.4726026522360382197.pr-tracker-bot@kernel.org>
Date:   Sun, 25 Apr 2021 16:52:08 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 25 Apr 2021 11:24:29 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/11fac7a004113466b7155e9b0d836156cf8a7e8d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
