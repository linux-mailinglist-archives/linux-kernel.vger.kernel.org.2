Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 771153ADF7A
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jun 2021 18:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbhFTQwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Jun 2021 12:52:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:46316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229654AbhFTQvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jun 2021 12:51:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 21D386109F;
        Sun, 20 Jun 2021 16:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624207769;
        bh=CRTBFLDp7KREb/yNYBC/sc0liScFytqRYGxp/0jDx48=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Ezk8fikHeYI8ahcehkET9umdFqZnqDXcE1MhkCbtBxFo9CZtRhliiw7SbSsFp5m/Q
         GwdsIPaNnfwtW/4DdgykFsEaMyrpINZ4kd87fqbFFyWmEG2ZieYcpBk3IKcniMM4Xt
         r3LGZRD+ZxXpVMYPPVHy1WqfaFyw6np+DlEyL+2LAICcGnfwvZpS3Me9lq9iqw7dDj
         JOHo3d2cdtANnqN/kchhK17r6zRVBcYahMOzSUSHBx/sk0cWFovI4jXABlm0DLK6xU
         EWM8YPTlaQDzSapJ1zhbNpGLnLWMZ/jWFHk5xzcfaENieUS0Eq73LWzBK/R04LfnBS
         fTLkeooqVA5ig==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 1090E60CD5;
        Sun, 20 Jun 2021 16:49:29 +0000 (UTC)
Subject: Re: [GIT PULL] sched/urgent for v5.13-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YM7sJj5BDD9ncbdB@zn.tnic>
References: <YM7sJj5BDD9ncbdB@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YM7sJj5BDD9ncbdB@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/sched_urgent_for_v5.13_rc6
X-PR-Tracked-Commit-Id: a7b359fc6a37faaf472125867c8dc5a068c90982
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cba5e97280f53ec7feb656fcdf0ec00a5c6dd539
Message-Id: <162420776906.12594.10403175871668095624.pr-tracker-bot@kernel.org>
Date:   Sun, 20 Jun 2021 16:49:29 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 20 Jun 2021 09:20:06 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/sched_urgent_for_v5.13_rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cba5e97280f53ec7feb656fcdf0ec00a5c6dd539

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
