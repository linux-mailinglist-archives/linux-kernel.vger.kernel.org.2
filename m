Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C481F3F0B9D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 21:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbhHRTNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 15:13:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:41566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231743AbhHRTNa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 15:13:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id A6F4161101;
        Wed, 18 Aug 2021 19:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629313975;
        bh=tWJVXmHLKwZwrWALAVkciII8aZrRR9EHd7/Dyrz4D0Y=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=sfALscjztStlpDa57tWhNL++EdOcLbfHXti4+3hre4gsXCHaVCx0mp1Zv1cf8MPRY
         7S6ef1FAwGaw+wW2V7fuAGIRO0Gx1BcXrdU8gPJMDQYoSEMZyVGcLLlt/jAlvriujs
         VZcpKatjdI5ChfJ3Anys4NtxHRzdtQy7Rxs67psFc5Q46NVS2CCqWco8oXVKwfolEm
         40trCqbnzA9o9uNg17ft9qmjW4w+p6HpYoa6/VpBPFzC1h56aAvAHKabKd54jAhLRj
         IsvGposRs5jC943JwVtXWWDUssgqp2EyN40kIZIIFctfeaFg6OIiUDnX3TBN35P9up
         IFuP8R51xRvRA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 9CD2A609EB;
        Wed, 18 Aug 2021 19:12:55 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 5.14-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5hv943ar6m.wl-tiwai@suse.de>
References: <s5hv943ar6m.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5hv943ar6m.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.14-rc7
X-PR-Tracked-Commit-Id: 4bf61ad5f0204b67ba570da6e5c052c2095e29df
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 01f15f3773bf3653a708e2c18c370beb16ca23c7
Message-Id: <162931397563.7328.9233828290549239491.pr-tracker-bot@kernel.org>
Date:   Wed, 18 Aug 2021 19:12:55 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 18 Aug 2021 14:11:13 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.14-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/01f15f3773bf3653a708e2c18c370beb16ca23c7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
