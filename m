Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87C9E353536
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 20:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236885AbhDCSS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 14:18:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:59604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236550AbhDCSSn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 14:18:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id D44DD61288;
        Sat,  3 Apr 2021 18:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617473920;
        bh=sk7aYmJTvaJCDQVkcBZ8iha5PQ2NxjBAnKw4SYjWsgE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KDygUTWZBZhMEJlh41RkoF0kEOuH0rViZUo7UZjosklD6bQ9nzxTNGw57nM4kBzK0
         55W2Kzoo+ymsvAyzmqaq7km/MMPUU5h3qMozHjO7aHfRdc9f9xJKVAWTQcJlyzTWr0
         uh3LGme2Ojqcuo7WXZYn0Qe1GYOJBYGvakUgC726TcaJhyUnrDZ7wx7TrAdzQZnEn5
         1oubV4kivAsGMwycikHAdUStOnMAtq2k8ePlQx9C4N7/I7o0RRttu9h+DWiL5FSlqR
         6dvHHRx2kPx6lcsfAFUEIwGaO8hpVeQ1HK2wF06wpmX5sUKLcgkUs0ZpI7kMybCza1
         y8juHngs9eJJQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id CAD436095A;
        Sat,  3 Apr 2021 18:18:40 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc driver fixes for 5.12-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YGhI3oAZas6R5jQ8@kroah.com>
References: <YGhI3oAZas6R5jQ8@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YGhI3oAZas6R5jQ8@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.12-rc6
X-PR-Tracked-Commit-Id: 3756b6578709c55819742f6ba0c18f93e8901397
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a443930a3e8eaf70c8768cc2c923d1d85b71262f
Message-Id: <161747392082.13474.14587250976835756232.pr-tracker-bot@kernel.org>
Date:   Sat, 03 Apr 2021 18:18:40 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 3 Apr 2021 12:52:14 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.12-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a443930a3e8eaf70c8768cc2c923d1d85b71262f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
