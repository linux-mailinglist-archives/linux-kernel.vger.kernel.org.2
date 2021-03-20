Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE62342954
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 01:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhCTAJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 20:09:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:49864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229447AbhCTAJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 20:09:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 964E261974;
        Sat, 20 Mar 2021 00:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616198960;
        bh=umix5YONrXk+KNv/eX3+j/xTXCIlzU1j4aTWNny8+IU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gxLMNnqDQivtuHaetZFFCdj0D66TEt+3HfdOQ57sog4ktucb9yAIuOKd+5wjXfktn
         jozG7P1TQEize1B1xcOqqqaUuRzuCSsAVIUqeXBd6wVry7iokUcBRsf6kJmTvCrCL5
         VMv3q9XMoIsJ4zWPcu7fc6Jd7ioTeYqJiZeUaJwldRc2bPraZchLrJDV/ZxgwgDm3H
         RXSM9HpL/mQ+hoMfMGzwYLuOmj6qn0yHyKvqW/dDChCnDP2Zkc+aAL83rWfOTHP30p
         fYp2A2FH7WUD+bHOPuxgDLZoVo1FG6biQgW3vp+6KCvO2Xm0u5ogZJfgbQYYLOs3Wv
         ulFRlWB4o8PtA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 836E6626EB;
        Sat, 20 Mar 2021 00:09:20 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 5.12-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5hr1kbfpa2.wl-tiwai@suse.de>
References: <s5hr1kbfpa2.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5hr1kbfpa2.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.12-rc4
X-PR-Tracked-Commit-Id: 50b1affc891cbc103a2334ce909a026e25f4c84d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 769e155c5395100fc468aa87703c486f276c16cd
Message-Id: <161619896047.24257.948582213806773059.pr-tracker-bot@kernel.org>
Date:   Sat, 20 Mar 2021 00:09:20 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 19 Mar 2021 10:47:49 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.12-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/769e155c5395100fc468aa87703c486f276c16cd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
