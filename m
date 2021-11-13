Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC49E44F508
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 20:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236104AbhKMTrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 14:47:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:33134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236057AbhKMTrT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 14:47:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id A500361207;
        Sat, 13 Nov 2021 19:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636832666;
        bh=qjKVF+R30OaY0jTv/XtMmQw9pfN+A18vJ8yIhEcSnCQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=I+HyOqhG3QXUyhHaX8KzlC9yfodCLLl95lmz4Sd8jIA46Wy+gvuBB1g5+Rqf9rPm0
         L4TXeCDnyLSJOquceCWohjfMIxBhudtpFwaA3QDUDFixzZBksfeN/mAGtOre9A7o5T
         UMzgry40PCWcRg+ETr/FAklh+cB/BaiwdKmWgKrBkeSViQl6332RCja5grXY4WOId/
         lHCffHKQVO2Lgc0/kmjZw8JPFw9w0w+pdhs259kK1mQDvKZjX2wl7cfjqDFscZKeVb
         x1x/OJXlKXCJzW3c3MJCJ3vTHeQqnEUhmIdAaNaZj6ERacuvWmG2XBCT1euOQjAVWQ
         vu8Od5jPYlCjw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 9910760987;
        Sat, 13 Nov 2021 19:44:26 +0000 (UTC)
Subject: Re: [GIT PULL] f2fs update for 5.16-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YYyX3oZXNAjYzG0A@google.com>
References: <YYyX3oZXNAjYzG0A@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YYyX3oZXNAjYzG0A@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-5.16-rc1
X-PR-Tracked-Commit-Id: 5429c9dbc9025f9a166f64e22e3a69c94fd5b29b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5664896ba29e6d8c60b6a73564d0a97d380c0f92
Message-Id: <163683266661.24678.17070565669479389986.pr-tracker-bot@kernel.org>
Date:   Sat, 13 Nov 2021 19:44:26 +0000
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 10 Nov 2021 20:11:10 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-5.16-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5664896ba29e6d8c60b6a73564d0a97d380c0f92

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
