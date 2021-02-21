Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFB0320E64
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 23:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbhBUWxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 17:53:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:53826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231864AbhBUWxl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 17:53:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 86FE764EBE;
        Sun, 21 Feb 2021 22:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613947980;
        bh=NhCrjIpfdG6db7TdanoKDZXBwcbOsviXSL5HHQywyjw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GAuzBw151q0neJSKY/gm7cKgEmZAJBS+iMe14GYLOFtgk/aQQGA+d0vn5pd9eL53l
         5/nKCl1BatvoU6RhEGlrSpFyDmlvRH7jIDlnTnErA9L+eNPwg62i+AwVBqzgTMxxym
         9CiVBrKnX9UYbkfznMALX8LSqBPZKUNwmeUE3hWZHgSf6XeRDfoR3n3ERte7aapx8/
         TwPW9YHy5OUuqYj1TWr/ycY9Y6QvEUehR3D9MCOzWI/bgNA709c2Jo0wAgDm4+vVSm
         o4yGB5rVwGnMAnyq3jxr5j9n6NP1p1NMcIjuYLTDq0C76vcvurlGHC7kQT1yMA2/Xa
         NN93/6elc6ntA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 81DFD60191;
        Sun, 21 Feb 2021 22:53:00 +0000 (UTC)
Subject: Re: [GIT PULL] sound updates for 5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5ho8ggz9iy.wl-tiwai@suse.de>
References: <s5ho8ggz9iy.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5ho8ggz9iy.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.12-rc1
X-PR-Tracked-Commit-Id: c4294d7f057d05053412ebd0d5700228d0f2588d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 10e2ec8edece2566b40f69bae035a555ece71ab4
Message-Id: <161394798052.6686.8258692861799592347.pr-tracker-bot@kernel.org>
Date:   Sun, 21 Feb 2021 22:53:00 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 19 Feb 2021 10:33:57 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.12-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/10e2ec8edece2566b40f69bae035a555ece71ab4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
