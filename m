Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20F9C3589A9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 18:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbhDHQYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 12:24:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:59306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232047AbhDHQYb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 12:24:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id D417561154;
        Thu,  8 Apr 2021 16:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617899059;
        bh=UEnowNOaRd56o0UKmlauMCIi613xFc1J1+/q45O4WD8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ihTIymyjoVHtF+AKU/cXu4tQS1gQgFMqySUWF3T/FxTMLRds9lyBybyx5NE2AK7Ut
         RPklhqgIohrnvKJgXJ7qkI0z5F1QznWx78vRX2pvjwlLjGGZyl3ahW/0LokOtRIRnz
         NWUe3NwQWtnXk6ymCm7WlArMhMHEwMBTr51j+9Yk6NG+cfxJnG3t/8SZioWrE3YPYm
         Odghr4auhB8q6sFTpSAHt67FvqS37LXNGQHkmC1umpFE83SiXVX2rmDXf55hP/GIM0
         yzYTWsvpeeQ1hF16hVFaFSt/9FIcxqIFFpvBgNysyOrWk7vvB2teMyIQqIqCztehyP
         xeGedab688tYQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id CEF2060A2A;
        Thu,  8 Apr 2021 16:24:19 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 5.12-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5htuoh6iex.wl-tiwai@suse.de>
References: <s5htuoh6iex.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5htuoh6iex.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.12-rc7
X-PR-Tracked-Commit-Id: c8426b2700b57d2760ff335840a02f66a64b6044
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e0a472fffe435af52ea4e21e1e0001c5c8ffc6c7
Message-Id: <161789905984.11255.1257048573448459356.pr-tracker-bot@kernel.org>
Date:   Thu, 08 Apr 2021 16:24:19 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 08 Apr 2021 14:59:50 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.12-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e0a472fffe435af52ea4e21e1e0001c5c8ffc6c7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
