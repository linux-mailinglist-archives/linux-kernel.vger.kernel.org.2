Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9D16434FF1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 18:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbhJTQSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 12:18:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:51982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231292AbhJTQSV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 12:18:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 8C252613A3;
        Wed, 20 Oct 2021 16:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634746566;
        bh=9d6FA9mPDn8T8HfU7Wet7q8UdfCcA9lTUXm8lyOy7zQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=C1K/foDZYWLBQOyk+d3Tx8xRbBJbjZOTD8jD5JLNuqurddvi7z4+5fn39B5KHVGsG
         ixCukHecCmkV7SqRtKW+GVB7tJI/pVbglqAgvTbaDqA5ElGOTfnd9mvGSJnMNYDmjN
         cvtlwqkE59GZn6LgkbDh2mHuw7mHH7rT8Sjr+wD87SF+3kKXJLgiLsnHq4RZYTKF7p
         8hvabYNMNrNrFczbiKn/vfsSFw3YcI5xT0tEV7m/BlT8PA3FsH4EhQp6RqyMP79ulg
         tletn3FCWsiGn6bZteL8uFKc+Hh2gvLqQmMkZpfbLHjcgX2ibLC2wKpnv4kby4Evgd
         Of3Enu5ScA22Q==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 86B09609F7;
        Wed, 20 Oct 2021 16:16:06 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 5.15-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5h4k9c19o7.wl-tiwai@suse.de>
References: <s5h4k9c19o7.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5h4k9c19o7.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.15-rc7
X-PR-Tracked-Commit-Id: 29664923725a384dc7e0f74af7c66e5ab7bb2a26
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8e37395c3a5dceff62a5010ebbbc107f4145935c
Message-Id: <163474656654.19537.3220628879987146398.pr-tracker-bot@kernel.org>
Date:   Wed, 20 Oct 2021 16:16:06 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 20 Oct 2021 08:40:08 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.15-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8e37395c3a5dceff62a5010ebbbc107f4145935c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
