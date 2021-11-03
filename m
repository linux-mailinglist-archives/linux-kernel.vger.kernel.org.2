Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E832443CC5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 06:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbhKCFlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 01:41:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:36294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229650AbhKCFk7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 01:40:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 794E661108;
        Wed,  3 Nov 2021 05:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635917903;
        bh=F9aD5bIgPlWGSZ6Ur+nSt+x5YzmTGCwvzSjjGjg+3ag=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=YZ2Gxdv+R29/hmfSNGSH4iXQoARuL0JOkIco+Y4ynSk0Qc5po3HY69bSoy/tyUoc0
         MSzw88/kipi05swbprEdBhyQwxl2Q+d8298wmkv2bSaH6FpBqLOpQaO8fhp6tDj460
         u0q/daJf3gdUFv/fbduK9tOOmIIYx/tDUc2bRhgWIH8RJFj78foyDyQovzqsK9UpeL
         qNhlSY2QWTOdmZmRVx3bfqtAOr23jcI1l/fIQcDDy7wyhL5CGwkcoOvD7uStVZ6Z9l
         eturgo/p1OQeeDhhn52fZVFcYphdLjwOxdPxEkDwXkkctav4G3AZtW9QF/1v07sC+N
         oz5mxO0LbfKHw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 60A5560173;
        Wed,  3 Nov 2021 05:38:23 +0000 (UTC)
Subject: Re: [GIT PULL] Documentation for 5.16
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87wnlq2r7v.fsf@meer.lwn.net>
References: <87wnlq2r7v.fsf@meer.lwn.net>
X-PR-Tracked-List-Id: <linux-doc.vger.kernel.org>
X-PR-Tracked-Message-Id: <87wnlq2r7v.fsf@meer.lwn.net>
X-PR-Tracked-Remote: git://git.lwn.net/linux.git tags/docs-5.16
X-PR-Tracked-Commit-Id: 603bdf5d6c092eb05666decd84288dfda71eee90
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 624ad333d49e136c54a342ce0009a05b439616be
Message-Id: <163591790333.8140.6704315962931009930.pr-tracker-bot@kernel.org>
Date:   Wed, 03 Nov 2021 05:38:23 +0000
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 02 Nov 2021 15:16:36 -0600:

> git://git.lwn.net/linux.git tags/docs-5.16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/624ad333d49e136c54a342ce0009a05b439616be

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
