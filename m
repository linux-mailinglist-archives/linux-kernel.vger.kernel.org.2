Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB306376A7E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 21:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbhEGTIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 15:08:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:58660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229470AbhEGTIl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 15:08:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 2B89061004;
        Fri,  7 May 2021 19:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620414461;
        bh=P10gg8r9PbfV2aPkW5Ktrjnn06aJ+klLBRWkCABzEcE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=EHO4wH4+0n/ZNqG4xPuPOxwvFOKDLvmaWu37D7JEV5nyMOMdX0RX5fyomzhOOdcod
         oIoN7/gdlkXfb9uefp06hYvuX4fz4KqBRevDR7xzd8CCZKOocB0cKZ7gFWnWem9c/7
         jLaYQWmZ4orYyLxldRcYYsf7H149tJ00A9HIXOUH/yMjzUlH6ZNOVEinm0Gg18Zums
         pEO5KjxmABMdnA6xWeTPpfU4vi/6GC/3ZRyj6mvnebNavydKWL7xHBTFVcwyKfPOBB
         sIciiDQJS9FNqF/H5Cxopf66DeoGJ7zMDCa9alUe5Wdf4Zp7XWu2MyJ12sGH/F+R8F
         HZt+eBxAyzUJw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 1A65260A0B;
        Fri,  7 May 2021 19:07:41 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 5.13-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5hsg2zhrt2.wl-tiwai@suse.de>
References: <s5hsg2zhrt2.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5hsg2zhrt2.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-fix-5.13-rc1
X-PR-Tracked-Commit-Id: f48652bbe3ae62ba2835a396b7e01f063e51c4cd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2059c40aded724b3af139abb55cabeab5e0f5878
Message-Id: <162041446104.12532.218278952164837333.pr-tracker-bot@kernel.org>
Date:   Fri, 07 May 2021 19:07:41 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 07 May 2021 10:27:37 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-fix-5.13-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2059c40aded724b3af139abb55cabeab5e0f5878

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
