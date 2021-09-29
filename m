Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0124D41C74D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 16:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344733AbhI2OxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 10:53:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:37652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344676AbhI2OxE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 10:53:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id B01C16147F;
        Wed, 29 Sep 2021 14:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632927083;
        bh=h2Ut0RpsY0Vy22EuMRC3N3guJSVTVldToeqB+Q5HSIo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Yxk8hQCFMLPq/1qN6XNMErdivMeIe1mjgfBvk8aULjVOsboKj7Lc66i4/SoCYOv1C
         Fkxgt4czSSmQwx5wPy5afwrasoZ+IsQcGt5gyFQeKWHjvAJTmpNSTKKhPo17topts9
         PEz4YWo06BaAADADHHdcdSP5P4u74nkDM2lnx7Pns3i0BD4yjOZj8sJgkbQX6ttTBO
         hxNqqoQh3oLxVwaEbHSgrw09P6pPhp2JVFufQUKcz8JqYOxpwoL9Ai8+0yMBMn0126
         WyacdVrmsuIAG3aAO8/kRPgjSrLFpnL9bM/aSY7lN3X1/sY2nTVIGmEqZDZQ8ZckaX
         wUmSvv4qCT0sA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id A4F6C60A59;
        Wed, 29 Sep 2021 14:51:23 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 5.15-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5hmtnvn96u.wl-tiwai@suse.de>
References: <s5hmtnvn96u.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5hmtnvn96u.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.15-rc4
X-PR-Tracked-Commit-Id: f2ff7147c6834f244b8ce636b12e71a3bd044629
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 02d5e016800d082058b3d3b7c3ede136cdc6ddcb
Message-Id: <163292708366.10457.3247531418616136301.pr-tracker-bot@kernel.org>
Date:   Wed, 29 Sep 2021 14:51:23 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 29 Sep 2021 09:16:09 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.15-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/02d5e016800d082058b3d3b7c3ede136cdc6ddcb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
