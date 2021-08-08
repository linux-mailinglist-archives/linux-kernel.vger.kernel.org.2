Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB4B3E3C38
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Aug 2021 20:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbhHHSgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 14:36:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:37840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231607AbhHHSgN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 14:36:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 9196560F55;
        Sun,  8 Aug 2021 18:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628447754;
        bh=nCSnbrDLnSyAr31z4DkHY/c3Wd4a/iyIffjfbWLDSXw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=vOEKVb3jthqKyMhRr0UN7ZsVieO9JwnC7nfQBLE0TKQa6bI6JGUV1Ho3kwLVtjkhw
         3BOGBD7/pX8ysdQQkSrP9U3NTfwDWaoUCWWL1dxqGwiZdp9nf6dpz1+smKAM5l7fXR
         KgWzpSLy4xvx1cInsjudHNPTtZp+3uadAa8UXwizaSzIk+1fyKbwg099hlOsMsz7w4
         8GdNovJJr0A08FtNxpF8iVT+sxlxNILkne4IgHRtq04jpi382AzYkxF0TI133X6nV9
         3Hjez4phg58OBTNmFccvFbJrGcXtcteBZp0GIeDnVHVDmUe+txP9Yy91zSESu61voI
         2P+VyKx1ecyxQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 889F86096D;
        Sun,  8 Aug 2021 18:35:54 +0000 (UTC)
Subject: Re: [GIT PULL] Staging driver fixes for 5.14-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YQ/AjpNS3y41k/uT@kroah.com>
References: <YQ/AjpNS3y41k/uT@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YQ/AjpNS3y41k/uT@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.14-rc5
X-PR-Tracked-Commit-Id: c7b65650c7f41d3946c4e2f0bb56dfdb92cfe127
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 911c3c5e01516a1339eb54d9ca478a789002936b
Message-Id: <162844775455.32600.2059164090152550632.pr-tracker-bot@kernel.org>
Date:   Sun, 08 Aug 2021 18:35:54 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 8 Aug 2021 13:31:26 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.14-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/911c3c5e01516a1339eb54d9ca478a789002936b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
