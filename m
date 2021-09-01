Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1633FE144
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 19:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344648AbhIARkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 13:40:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:39090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229962AbhIARkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 13:40:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id EFCC761026;
        Wed,  1 Sep 2021 17:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630517949;
        bh=zTMwuJ9yI6lksaZa0u++cZ346s96MRANmmK4hQvy3dw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=NnsdYW8GhEF2lJzk3/YJPgwSKS2/4WiaFt+f6fANcd9n37D6Krv1KMFlAz6vNiHzN
         s84uAd2HuT70cKIqxrSJrAedC4QepmxvWST3CLGsUprFHym45xoNiQiZ2vSt51oRB+
         IOWV7/s0Z9/v4kv5pChXu51Tlq6Lz6uA+AuBFtxDmEuvHfj8ER04IpMGthTFabwDwq
         rCpB25IlTKCpL29UIUona2TY+sGqXbXprTaO4WfYuqmg2H9UN6f3ikJLOTPjQ/GPSI
         PeC9O4hmnvn6QphL1zm+YHOpgB7o+0sLbUTd9DPsjhiWrTu+WxSQQyKYX7dOpPCjnX
         GE/G9QXSl5ebw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id E98C16098E;
        Wed,  1 Sep 2021 17:39:08 +0000 (UTC)
Subject: Re: [GIT PULL] sound updates for 5.15-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5hlf4godtc.wl-tiwai@suse.de>
References: <s5hlf4godtc.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5hlf4godtc.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.15-rc1
X-PR-Tracked-Commit-Id: a8729efbbb847f6ea9b06e73491ec8ddb560465e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0d290223a6c77107b1c3988959e49279a8dafaba
Message-Id: <163051794895.15355.7398851859304439364.pr-tracker-bot@kernel.org>
Date:   Wed, 01 Sep 2021 17:39:08 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 01 Sep 2021 11:17:03 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.15-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0d290223a6c77107b1c3988959e49279a8dafaba

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
