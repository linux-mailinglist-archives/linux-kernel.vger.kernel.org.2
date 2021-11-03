Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7AFB4445DD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 17:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbhKCQ3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 12:29:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:60994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232488AbhKCQ3d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 12:29:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 1F4416103B;
        Wed,  3 Nov 2021 16:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635956817;
        bh=nsglkqHbDDRUTjMk3G4HXimHNGq3+c9cODImE4slrIE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=lpFHxbU3M34kAQzqMYZ3ymPWB/iLnCVw4GWlMC926KVZw9munu1aNgjB4FyvHZibr
         ZgbIYQu258OPUvnm0HBaJblqTf/QB2ZDaLDakM/8FbtDOQIPQOIZL7o7ESv+2QskAq
         Mbdlgcz7qvRUCApjvUTFLgzJ/dq9xODJ2ltaN9BunVjWn7QfYbsNhu6hQxYVBkdH+r
         FULWrh8tP2yGGdxNAfRys6qKUYyfPxYAOZLbMZatdkYGcYWKguNeqz12bPYVJTGsl8
         GQ1oLWPROng8DH2QutW5BZqkEuHe5l5KpO8UKRajWSju8YgtHC5PyeNMLJ2GQ3+sc+
         x/c7BDox7Me5w==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 1795260723;
        Wed,  3 Nov 2021 16:26:57 +0000 (UTC)
Subject: Re: [GIT PULL] jfs updates for v5.16
From:   pr-tracker-bot@kernel.org
In-Reply-To: <f11c6abc-4f95-6031-0b30-813357647929@gmail.com>
References: <f11c6abc-4f95-6031-0b30-813357647929@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <f11c6abc-4f95-6031-0b30-813357647929@gmail.com>
X-PR-Tracked-Remote: git://github.com/kleikamp/linux-shaggy.git tags/jfs-5.16
X-PR-Tracked-Commit-Id: c48a14dca2cb57527dde6b960adbe69953935f10
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 655fedaad36c0b31a6f6cb8f469b739b2359d74f
Message-Id: <163595681709.8679.10447058999953931458.pr-tracker-bot@kernel.org>
Date:   Wed, 03 Nov 2021 16:26:57 +0000
To:     Dave Kleikamp <dkleikamp@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 3 Nov 2021 09:52:48 -0500:

> git://github.com/kleikamp/linux-shaggy.git tags/jfs-5.16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/655fedaad36c0b31a6f6cb8f469b739b2359d74f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
