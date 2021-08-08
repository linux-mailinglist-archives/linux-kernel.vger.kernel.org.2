Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A45D3E3C3B
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Aug 2021 20:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbhHHSgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 14:36:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:37848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231967AbhHHSgN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 14:36:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id A577260FC1;
        Sun,  8 Aug 2021 18:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628447754;
        bh=GPN3zuF/GMPRJm7x1fXrptnBdnmnU9102sXIPBzRlOE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=tms5WNEW3ayu20cJxW/57u4a1ioaTKlPYx6eeDo5r/AxH5I/cE8argPSq5X3VjXGe
         GL/pj+sHGwV+/IZuqEymOQ5NUkv1d3PlbwUsaaOyhImIg+IFWBcyGwVXw7xoXoUwYA
         ikbBLvbWnCg3PHtgh2/teXn+xVurWk4/qZezDAokO71kvevi2PlD2QyNXe6OgEQ/gB
         x2fIjZpindbuH1LyeNB5mVHtezp3yk3+iB7TpOMSDX5lqSSwscQwhnbJiu2efjvlAA
         SvM4aZllDgV5ekoj5wiphFU/8BtpK67aCahf8IlR/PzupvMGpV4JxIzEvP06dQ4Rgh
         weTjXA+paydqg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id A027C60985;
        Sun,  8 Aug 2021 18:35:54 +0000 (UTC)
Subject: Re: [GIT PULL] Driver core fixes for 5.14-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YQ/AoZ14maH5H6nf@kroah.com>
References: <YQ/AoZ14maH5H6nf@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YQ/AoZ14maH5H6nf@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.14-rc5
X-PR-Tracked-Commit-Id: 75d95e2e39b27f733f21e6668af1c9893a97de5e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 289ef7befb65f82a148981ad5c133f57f6dda1df
Message-Id: <162844775465.32600.11554211715720346398.pr-tracker-bot@kernel.org>
Date:   Sun, 08 Aug 2021 18:35:54 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 8 Aug 2021 13:31:45 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.14-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/289ef7befb65f82a148981ad5c133f57f6dda1df

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
