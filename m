Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 510A03ADF74
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jun 2021 18:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbhFTQvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Jun 2021 12:51:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:46312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229650AbhFTQvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jun 2021 12:51:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 1459261042;
        Sun, 20 Jun 2021 16:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624207769;
        bh=B96y30fHy0N6j4wZx7AW/ioMAsU22bHHBmmVq3KnI2Q=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=tQKOai/bkpx9GOUbUPMz7nksdL3oRZ1/O7VOyBxmqHvJE9J9wKdEL3P6FuYtG1kqA
         5/od/E6A0tjx8WXiPmBQFT4AC058QLX9k7U9T7lHy1cca62O8VKYYzPLxXOSlp37Qc
         XO8xMjJgUwTuig4j8bhKDUfIK+RQouEVMQSQfCLWfb9dnzy25QjD923rilyi45vPK+
         30suuJyWID7N3bc8ojQAY6nS7YWb6sKMq5LIsssZI78pDEeTXAGssc5qkj44rUPSq6
         QQ3cM7w4zEMDtfer67LoCspRPCAokfS7PyB5dR+4InUGz+/gXFXzARzKkpFQpYEfwX
         pg2gM3vU7BqwQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 01B7D60A02;
        Sun, 20 Jun 2021 16:49:29 +0000 (UTC)
Subject: Re: [GIT PULL] irq/urgent for v5.13-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YM7qHTVw1/X1m70S@zn.tnic>
References: <YM7qHTVw1/X1m70S@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YM7qHTVw1/X1m70S@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/irq_urgent_for_v5.13_rc6
X-PR-Tracked-Commit-Id: a13d0f8d117ca6b7885b51c4b21fe8d5a9eae714
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9df7f15ee922429dcd6bcde68559ccb23f2dbd20
Message-Id: <162420776900.12594.9672543984754506044.pr-tracker-bot@kernel.org>
Date:   Sun, 20 Jun 2021 16:49:29 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 20 Jun 2021 09:11:25 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/irq_urgent_for_v5.13_rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9df7f15ee922429dcd6bcde68559ccb23f2dbd20

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
