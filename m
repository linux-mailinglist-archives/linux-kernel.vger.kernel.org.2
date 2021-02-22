Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45740320F0D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 02:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbhBVBWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 20:22:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:54850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230225AbhBVBVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 20:21:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id E549C64ED7;
        Mon, 22 Feb 2021 01:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613956854;
        bh=bSvHipOf+VuBMn8ysPi0Z5I3Lk8XKXQHsOt+RisgrQM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=OEuGZkas8GUDpdABJETyKGni3wOZm+Or3y6/BxJoHd3ACls7ccIRhc2P5wBmS7WY2
         I8DBdTmeJFQY/i+iSGBT7Nx+xAvViLAUAXoNh0ojkFKh/WglcVWXgitraTFqk1OFF7
         fh04BXQemcu5/GXpOSNXBmPNO09OYk5E+4MsGLFyvXzi8iy+N+DQv5K1s93STJkHTb
         3gmwBIvz2/wymFK27PkSXJ5p7h1ijSs6cQpm5cWWN/H2YSvLwmNLnanvEoxH29+fpJ
         mZSwe529Uwv9TKhCEGqdh3my1oa1EbDVJy7hYciMUq4EiQiixllvdea+YcyscYpg1E
         z17ni6slPxz5w==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id DE87260A3D;
        Mon, 22 Feb 2021 01:20:54 +0000 (UTC)
Subject: Re: [GIT PULL] Audit patches for v5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhR8gwyPpGnHbELBJ+2AZKQD0YTmhtSsLULjNbp7M-UM8g@mail.gmail.com>
References: <CAHC9VhR8gwyPpGnHbELBJ+2AZKQD0YTmhtSsLULjNbp7M-UM8g@mail.gmail.com>
X-PR-Tracked-List-Id: Linux Audit Discussion <linux-audit.redhat.com>
X-PR-Tracked-Message-Id: <CAHC9VhR8gwyPpGnHbELBJ+2AZKQD0YTmhtSsLULjNbp7M-UM8g@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20210215
X-PR-Tracked-Commit-Id: 127c8c5f0589cea2208c329bff7dcb36e375f46c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 23b6ba45f321bd5c4cddde4b8c85b3f71da3cdb8
Message-Id: <161395685490.836.328492314576460126.pr-tracker-bot@kernel.org>
Date:   Mon, 22 Feb 2021 01:20:54 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-audit@redhat.com, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 15 Feb 2021 17:10:37 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20210215

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/23b6ba45f321bd5c4cddde4b8c85b3f71da3cdb8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
