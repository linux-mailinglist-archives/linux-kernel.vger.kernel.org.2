Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62460309822
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 21:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbhA3UCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 15:02:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:49000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230517AbhA3UCB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 15:02:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 9EC8C64E15;
        Sat, 30 Jan 2021 20:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612036880;
        bh=/cPHzyH5JYaly5OjGX9crtr2dEXXiFMMzkZ2CV61kA8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fJ+JfXk3b+gmyH8b5neKkXmGSp9V6gWoXdBmtv4dAIhQKb76esjBvbT0rbVLXFnLq
         6i9ahUfvI0ou89Zqq6IgBapEqW4pZr4ZC/h7nGhKFXLdbMAYqIgV3eHRO6sJJ6YSrJ
         KlpDXbGxJW0tNSaRl8nSCxnQ4FSLRqJ6uQAyKhFmIOlxBUZWHgy1Dz2rwYP5w++7pf
         AckR1aYvZJX7wZzIOE+n+izYxoqzl/E5iqf0u6miiMi6VgoOMl8igFp81tdT+tSJUh
         wzAjHEl7b2YKhfC17vxdor2B1sjfIutB8FATlbaoYfKkJkF06tm2FdYdcX1O6X9Od5
         0kBNEas+Yr3KQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 97FAD6095D;
        Sat, 30 Jan 2021 20:01:20 +0000 (UTC)
Subject: Re: [GIT PULL] s390 updates for 5.11-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <your-ad-here.call-01612020758-ext-9054@work.hours>
References: <your-ad-here.call-01612020758-ext-9054@work.hours>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <your-ad-here.call-01612020758-ext-9054@work.hours>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.11-4
X-PR-Tracked-Commit-Id: e82080e1f456467cc185fe65ee69fe9f9bd0b576
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3bf255315bed7ccdde94603ec164d04dc5953ad9
Message-Id: <161203688061.22475.9956161299881812060.pr-tracker-bot@kernel.org>
Date:   Sat, 30 Jan 2021 20:01:20 +0000
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 30 Jan 2021 16:32:38 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.11-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3bf255315bed7ccdde94603ec164d04dc5953ad9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
