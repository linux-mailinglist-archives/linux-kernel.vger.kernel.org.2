Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3D7239BE99
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 19:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbhFDR0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 13:26:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:53372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229791AbhFDR0i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 13:26:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id A895C61402;
        Fri,  4 Jun 2021 17:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622827491;
        bh=Aa+3iSPmDQ8e4YN9GOJ/Uc9LYW/OT8WxPdTK1WiPpDY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=n9RHaMfi6KQf49CSmFfuYyCSfRMwLIMLHw9l1x4OOFAq9I8qnceMfG9Z/ht1LmSI7
         Jxn0dHC4CxB6W+fd1tdRJkw6Et65nsDbOX4tZPToBx57Q55QuDsZqCZMVy+mt+h3mp
         +D7xJlB2prX/hlHxkSZCn2LQ1VOOUgC6JASNl6ns92c79HLHZ9VFbpvVRPLqipTJn9
         P/X7j6JSXLia5urj/+lECk5Kwl9fO7jSwOv9S4r0NVoh8Xziyib98JxVJm+VFfxeEV
         fNNN+iJrUVMWA2wcXz2sQ+W9VPoTV2FbwA2Aaaji5hdKBk5t8T5Hy1PxIj6q3E/wqM
         IDMrPAz6c36PA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id A3BEF60A39;
        Fri,  4 Jun 2021 17:24:51 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 5.13-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5hczt2glr3.wl-tiwai@suse.de>
References: <s5hczt2glr3.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5hczt2glr3.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.13-rc5
X-PR-Tracked-Commit-Id: b8b90c17602689eeaa5b219d104bbc215d1225cc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 16f0596fc1d78a1f3ae4628cff962bb297dc908c
Message-Id: <162282749166.14402.10153840669345167734.pr-tracker-bot@kernel.org>
Date:   Fri, 04 Jun 2021 17:24:51 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 04 Jun 2021 08:57:36 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.13-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/16f0596fc1d78a1f3ae4628cff962bb297dc908c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
