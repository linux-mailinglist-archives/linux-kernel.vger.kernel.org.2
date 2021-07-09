Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71A823C2980
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 21:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbhGITXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 15:23:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:57514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229854AbhGITXW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 15:23:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 20E7B613C3;
        Fri,  9 Jul 2021 19:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625858439;
        bh=Q78fSaOP2aKOcxGUD01rTkRSkZAUpmrwI7bLOGNk1SQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=raGlwF9eUoX2/nb+NO9GuAFI2r7Gxo1Z0SNBiSL2qHut4orRWnFa4GXhAjFq/4wrV
         LIz7kWzZehW/sShSdmuevPGB+grC7IzNBmPBJ/c4hE5eeLHf8Z2TmnR+8MiX/l9U4m
         0cNSMJfJ1+3DQwGi3chR+ikX4SBXIbQQ++Amy+IjkxNtJ3aO0KvP+UCjoGTl+Eh9CQ
         HvDEuBXNiOlncX11rzp36suxednTpci5I50nyc3MHJIuJWN0mPvbCPDZTsmUEbFUCE
         Qms0+m0AqRZG4q98Zh9pvSKkY+y668Nc/tvlBq+mllbn52eeuf37LZutIVzN7CAV9M
         HNPh+K9P9PEXg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 1B4F1609AD;
        Fri,  9 Jul 2021 19:20:39 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 5.14-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5hlf6f52aa.wl-tiwai@suse.de>
References: <s5hlf6f52aa.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5hlf6f52aa.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-fix-5.14-rc1
X-PR-Tracked-Commit-Id: 24d1e49415be546470b20429d748e240d0518b7e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3de62951a5bee5dce5f4ffab8b7323ca9d3c7e1c
Message-Id: <162585843910.13664.2007511654109156454.pr-tracker-bot@kernel.org>
Date:   Fri, 09 Jul 2021 19:20:39 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 09 Jul 2021 10:17:49 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-fix-5.14-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3de62951a5bee5dce5f4ffab8b7323ca9d3c7e1c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
