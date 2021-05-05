Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19CA5373384
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 03:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbhEEBSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 21:18:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:59288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230328AbhEEBSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 21:18:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id AF557600D1;
        Wed,  5 May 2021 01:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620177428;
        bh=tOvpORL4pZCL/85TtD6K9Nbq4340ZVvyD3mf9i3tQcw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=aTKnCJYUdKHY6B9G6Qe4vttFNmvUT8BBMtxBtoAf9N7LOzJyalkXSb9hTA1aahw5J
         n6zdiCpi7G0NhUNhtNTiR0ZER4gSGgWPxw+Np+hVQIKvSy6o+QQXxDRn2kCeq/t5T/
         UBwHeXbOyK5QQJMmqlA/aOIaHbORV2AdhGSN5KUyJmuV15J+1RNjWQtrCNWP/wadjF
         4e25Si6T88dvQJHSYQ0qxpxMIgSfT3Y6IhSQ7fZ108IcrIA7xfM000PHwEAuWJzgAY
         /9vwfccJho+yx7cdOmBx35Z4AFOhen2vd7v4wi+SIiMNFgfccUB/VdVz0H3zEM4hwp
         Rxvj/1fLAW+Zw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 9D19E609AC;
        Wed,  5 May 2021 01:17:08 +0000 (UTC)
Subject: Re: [GIT PULL] JFFS2, UBI and UBIFS changes for 5.13
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1258125270.55580.1620159361990.JavaMail.zimbra@nod.at>
References: <1258125270.55580.1620159361990.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: Linux MTD discussion mailing list <linux-mtd.lists.infradead.org>
X-PR-Tracked-Message-Id: <1258125270.55580.1620159361990.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/for-linus-5.13-rc1
X-PR-Tracked-Commit-Id: 9a29f7f020e06f14eb126bcb84a7f0d166415824
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 51f629446cd172e324deb0146741888cac5dedca
Message-Id: <162017742858.16566.6652519615271581325.pr-tracker-bot@kernel.org>
Date:   Wed, 05 May 2021 01:17:08 +0000
To:     Richard Weinberger <richard@nod.at>
Cc:     torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 4 May 2021 22:16:02 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/for-linus-5.13-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/51f629446cd172e324deb0146741888cac5dedca

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
