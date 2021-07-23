Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB1F3D3E8E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 19:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbhGWQnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 12:43:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:44156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231174AbhGWQnB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 12:43:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id BB82560EE2;
        Fri, 23 Jul 2021 17:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627061014;
        bh=QaJgb/hbiEaQ8PFUbVpTRHd5BuAzFYYU9CAnarfaK9Q=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KF8SRBdWYHjCLp6ZtEdaS3K25WTURpFMDwcAnRqDsguhzRSQy8JFL0b2EHk/cBwKt
         dq1dH8F8uwTj775BBhUdIOj7m3SmZGpZwLOw4bkVUXYGSpdsMl2lMtoQs2n8taGhNw
         UhmvUzBAtDsJqaAFykXatBUL4htf4wH/LHMZ8VYNXqWhSuFbL4aA+WKfo5LSK+Ud8f
         X2wb2pnas3NoA9GL3wMMf3ezpGtlYzP6/9CkfPjlxykuzjqvaJ+fR6s54TtWxJSkM5
         qkgUyy1voDUpMRIU4lH3QNUTluOvTlgIJOfkb/4zl/CuAtJgAHF98ywYnbGSvQUwqi
         RRknGtY7x2QUg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id B2B3060976;
        Fri, 23 Jul 2021 17:23:34 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc driver fixes for 5.14-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YPrYnDNc9hRmqa+z@kroah.com>
References: <YPrYnDNc9hRmqa+z@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YPrYnDNc9hRmqa+z@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.14-rc3
X-PR-Tracked-Commit-Id: c453db6cd96418c79702eaf38259002755ab23ff
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8072911b2fc3fc4b94d1d44063cf55cbbea1fb49
Message-Id: <162706101472.5428.2815433909777170898.pr-tracker-bot@kernel.org>
Date:   Fri, 23 Jul 2021 17:23:34 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 23 Jul 2021 16:56:28 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.14-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8072911b2fc3fc4b94d1d44063cf55cbbea1fb49

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
