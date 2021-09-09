Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A868A406006
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 01:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349210AbhIIXZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 19:25:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:52424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343811AbhIIXZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 19:25:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id D2B81610C9;
        Thu,  9 Sep 2021 23:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631229838;
        bh=l+eA/n0/0RhhozsD6YvEc0DYKwwxtRZfJhCaubZxuhQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=W1A+zA6hJaB6u5KyckJkn88odBDWonffF7iIzhxpNyVY0ycfClrSIYuNmfhwk6gP2
         IBJ9d0Pmyt9cXlSmQehOJawfx50zU1y5QdE1Ga9o6QBR8NOUeEYb9CD3FdFEcR2ucp
         Puuc3ltyr11KRWL8XqSiZCQ+qfNzMufXrA39D9ffP2SHDgGyOLsM2GLDcjUo2NEWhO
         wvhfr6qBdfZVWa11NrSx8Ar7kaS0V+U2Mj2iG5aK/6tkxtIv9lRwA5ijZCMCgwyUKm
         TX7UypQ9xie1UEDWIEIumkLu8eKMIb1LT4ghKwfXQDAg6p4y7c5QO32y+NtKe9vTst
         ija1Ti4kAnDdw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id CCFC8608FC;
        Thu,  9 Sep 2021 23:23:58 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 5.15-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5h7dfpq1nt.wl-tiwai@suse.de>
References: <s5h7dfpq1nt.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5h7dfpq1nt.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-fix-5.15-rc1
X-PR-Tracked-Commit-Id: 25fca8c9e0d79ca4c5bb0199dcc52ab0ea4cbd7d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ae79394a628530372e3b0aae4cb9e6495186558c
Message-Id: <163122983883.18294.10988222208550084712.pr-tracker-bot@kernel.org>
Date:   Thu, 09 Sep 2021 23:23:58 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 09 Sep 2021 16:11:34 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-fix-5.15-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ae79394a628530372e3b0aae4cb9e6495186558c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
