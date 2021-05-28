Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92A9639475D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 21:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbhE1TBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 15:01:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:60956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229602AbhE1TBj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 15:01:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 7D62D61415;
        Fri, 28 May 2021 19:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622228404;
        bh=ZeWWXdOF6BhfpQHG58TQ2tTm0Mo7GI/LlbvlTP/CUlE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qGSZGGfeC6olyztHSF9WPKujLor6i5+sNP4RxmxYPW95DzqkW8NCSF+EKNIpQAOZV
         ZHtN8chTNfCMCNVNIWSP8oUIx23zko/5LwBZ7ns5CSUqdw4sC7F2ZDq4UN9q8gW0/u
         HQ/pBL1/ya1h2u2ESi5/sLdWdbJNSM7cdEfuOLKIf4o7DOEm+1ImLhU4yKrtnDmEQ3
         44Xey+k0URo9a7ahdakDzS6yTEHlsXQ3y5bp8myam68WpYUfvfVwoBjATyj0WyuAuE
         TfQZrmweppAFRAwoGqQV4Tq/vtbcXkanoJRbaJeSfGnk3V+VJjDwv/8AyHkEclEbnS
         2kjl5SpX5fz5A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 72C50608FB;
        Fri, 28 May 2021 19:00:04 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 5.13-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5h8s3z3u43.wl-tiwai@suse.de>
References: <s5h8s3z3u43.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5h8s3z3u43.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.13-rc4
X-PR-Tracked-Commit-Id: 50dbfae972cbe0e3c631e73c7c58cbc48bfc6a49
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fc683f967aa97969463b9578a9e18e484472385f
Message-Id: <162222840446.1554.7402625835716864618.pr-tracker-bot@kernel.org>
Date:   Fri, 28 May 2021 19:00:04 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 28 May 2021 14:45:00 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.13-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fc683f967aa97969463b9578a9e18e484472385f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
