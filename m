Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5FED3F3501
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 22:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240270AbhHTUKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 16:10:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:39036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239177AbhHTUJ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 16:09:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id EF7166113B;
        Fri, 20 Aug 2021 20:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629490161;
        bh=Rbmh9tZaum46gFgu1NYXbe3cNdYf+Vu8SsYLN5tqBEo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=N9dsLNkoRhDtRj8v19GKgWu9u69OzNED9dtVjCWHzxJoPiVMCEBevSAprcSXB6hLd
         +eqeXtrGhdqC0E8jNqk3z0TViitp5dC6C2E9LtXA/SGz40TlpTSXKJt837u7LOPoKY
         k9EkQu3F0wrJwkv/6Kq8RRKBc+2UhXJ4TOj5YTjFgsF5S3NaDQQVz8nOxX+OYLgs4D
         kqiJd0jrSBSgidL9qwVoXoUe/bGUCP5SZHEcJ0aKFN934xvwTEkpEJeYotPWVQS66F
         Chgbi7pFrt0l52oae1xYEgeHThwm5DXTREi6cYTU4hqf5OF5B90SJkyd0Qab6V0c6c
         TGn6Hlnk7dyPQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id E96F460A50;
        Fri, 20 Aug 2021 20:09:20 +0000 (UTC)
Subject: Re: [GIT PULL] another sound fixes for 5.14-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5hsfz479m9.wl-tiwai@suse.de>
References: <s5hsfz479m9.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5hsfz479m9.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.14-rc7-2
X-PR-Tracked-Commit-Id: 65ca89c2b12cca0d473f3dd54267568ad3af55cc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 43a6473e4713004fbe755a062c2d37c9bde05c2e
Message-Id: <162949016094.21370.2538007767908876412.pr-tracker-bot@kernel.org>
Date:   Fri, 20 Aug 2021 20:09:20 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 20 Aug 2021 11:23:26 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.14-rc7-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/43a6473e4713004fbe755a062c2d37c9bde05c2e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
