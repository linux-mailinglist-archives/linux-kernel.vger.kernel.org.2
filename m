Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78CBD376B0C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 22:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbhEGUJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 16:09:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:41360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229925AbhEGUJm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 16:09:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 1CBD96143B;
        Fri,  7 May 2021 20:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620418122;
        bh=FO9qXiEJfP4OE5WTW3CHa/aD+VZcZGnbkgNdogcHlEU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=OOja2fb3CBclu29EE3A2yxYWBX8DhoGvhFzO11MU62/VBUVNNY724ApFU9J8bgXTz
         f44sLgB7xeCFpjLghVL4S6kS04P1W6b9Wnqy6oOz3FrNJZ/LJJqJ7J12E9RsM5kLK0
         nQ4PRBLWwogUMzMxKGHi5iPncMse1r/eMWILI1X9UC532Ir4d8pMGD6BBQ7vjpjx0q
         Dh4y/zxZDZ0dnbko4yk5gu9Ua6UhwuKsMFugA0QufEj/b4ORM7LwoqN3/jT4gMmCHQ
         07Qvqg+kjEq9g66Fn1MUfHsjEOLZ6edE8/PNDRidFXDYDRvVUstqQY3Xy+QrcnJx+J
         51o3+qZReTFAA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id F2D2960A01;
        Fri,  7 May 2021 20:08:41 +0000 (UTC)
Subject: Re: [GIT PULL] I3C changes for 5.13
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YJWVRyqnPVlz5vY5@piout.net>
References: <YJWVRyqnPVlz5vY5@piout.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YJWVRyqnPVlz5vY5@piout.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-5.13
X-PR-Tracked-Commit-Id: 0d95f41ebde40d552bb4fea64b1d618607915fd6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1ad77a05cfaed42cba301368350817333ac69b6a
Message-Id: <162041812193.8450.7884020637384781054.pr-tracker-bot@kernel.org>
Date:   Fri, 07 May 2021 20:08:41 +0000
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 7 May 2021 21:30:15 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-5.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1ad77a05cfaed42cba301368350817333ac69b6a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
