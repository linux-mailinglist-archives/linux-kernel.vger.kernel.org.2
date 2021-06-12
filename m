Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72F093A5061
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 21:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbhFLTjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 15:39:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:33654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229814AbhFLTjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 15:39:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 63EC661186;
        Sat, 12 Jun 2021 19:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623526662;
        bh=r9qK+DRqPbBe7JhDn1qlNsL6Sl86I36A0ziEQhlfgnY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=X7QrhvxVs07Fb9lQEHUq6+ZSv6L34evlt/WPIRyV0sc//ccy4TzvORAt7TE46/4f0
         QGhNxCCFpCn8IWdV0M4+FYSPr4FO6s5AkcKWyxjGz9Pw88rB7p7fwoE+KjeOuAV0Ga
         x2ojMXUHVy6YpaJKqOcHpAWV18n2fB5LN1YB2iEhycfswYWhYmh8XxNm4uZNVSBOVJ
         wzufs9rQvDuMq8Ayy9lZpdcUJbhkHKLZm1jmde1/idiIIxrFE7+j23jh5RVoodqQti
         oLrUz3cb+o19JfyEouNhwrJUGt71lcb34uWYZ9Np2zrmLT+sXhAEqIZhsMNNzcbvOX
         y54opcbXFPY+g==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 5BB9F60CE2;
        Sat, 12 Jun 2021 19:37:42 +0000 (UTC)
Subject: Re: [GIT PULL] Staging driver fixes for 5.13-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YMTYtya0Sn/JVtz2@kroah.com>
References: <YMTYtya0Sn/JVtz2@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YMTYtya0Sn/JVtz2@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.13-rc6
X-PR-Tracked-Commit-Id: e9de1ecadeab5fbffd873b9110e969c869554a56
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0d50658834f9f655559f07ee61f227c435d8e481
Message-Id: <162352666237.18796.14283348494454025864.pr-tracker-bot@kernel.org>
Date:   Sat, 12 Jun 2021 19:37:42 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 12 Jun 2021 17:54:31 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.13-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0d50658834f9f655559f07ee61f227c435d8e481

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
