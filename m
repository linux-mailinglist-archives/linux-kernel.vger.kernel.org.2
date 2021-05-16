Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A66038202A
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 19:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbhEPRVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 13:21:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:57746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230152AbhEPRVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 13:21:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id E78BF6108D;
        Sun, 16 May 2021 17:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621185603;
        bh=eQqktNOxKFrjyTWSILiww8sVzGSyqCufw2YPhTtLRMo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FNIlTZVp/xjNFmB8KYTIyRRXOLGpTMH39LzqhPfYwDZiveFdVOtjaIvJZSPSUUvsW
         iQ6eq289r59g1hNTqMSJFJoigrX3E5yA+mWolcLOEr07nuV14rvNsA/Ne8G//jcO37
         xFOOkmWw73NF5VOptLxcqysqpTfd9gKnGPcV2Sk6usMGvkGQ3VxfL6mXddnoewftJE
         vDfAuymjXovbjhu9bYl7YHFAedFUep6b/1fwJBBni/lmUrpYfoMy6eJfxYryVS5isA
         gxnPYIHQapa5EG63wem+U6SWVFQxYDadpTuXNU0Ued8jjaMovO8paI0vUfmB1nJ+5/
         JjPmj4t24w7VA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id DFAD1609FF;
        Sun, 16 May 2021 17:20:03 +0000 (UTC)
Subject: Re: [GIT PULL] Driver core fixes for 5.13-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YKDfPQXx0g768cw4@kroah.com>
References: <YKDfPQXx0g768cw4@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YKDfPQXx0g768cw4@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.13-rc2
X-PR-Tracked-Commit-Id: bb4031b8af804244a7e4349d38f6624f68664bd6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 28183dbf54edba614a90ceb6a1e9464b27845309
Message-Id: <162118560391.27926.15075027599854753828.pr-tracker-bot@kernel.org>
Date:   Sun, 16 May 2021 17:20:03 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 16 May 2021 11:00:45 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.13-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/28183dbf54edba614a90ceb6a1e9464b27845309

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
