Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDD9410870
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 21:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238967AbhIRTyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 15:54:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:36406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238842AbhIRTyE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 15:54:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id D1CF2610A5;
        Sat, 18 Sep 2021 19:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631994760;
        bh=pw1JqnSHLWuvVx5pWr5i7hCgQQQ09ZiPklcTLOV9vxo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Djv/RM0ULpLANUSgxw9VxmHwGlgo/8ke/sEnXTx5NBc+LRO9P2oFwgQ9YY5uEatUi
         XwIG+qKk3DlJYD6zrmLayX2OoXPQQAPuoEnWzzNua/yS24OH/gBCHNuXheTJFwkr3r
         j4tTY5hddfg7SCJlkgJYCSwMZtUBcKxMXWynIjPa41GgOJr5NmojDitvREy3tW10Aa
         zZmkmPLt+SOu4ILkHxJ3jGKKtClbM7lBNBWEbd0u5BnUfwzcRA8V0ycBDYAFV+7p++
         c1Wf58UF5nkuYFiNwCnOoFxHDwhcJa454aNnQA/4DvCf60rQGabsoxrxBoI89EikmP
         nDKZIymgvbyUQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id C68AE60965;
        Sat, 18 Sep 2021 19:52:40 +0000 (UTC)
Subject: Re: [GIT PULL] s390 updates for 5.15-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <your-ad-here.call-01631958563-ext-0235@work.hours>
References: <your-ad-here.call-01631958563-ext-0235@work.hours>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <your-ad-here.call-01631958563-ext-0235@work.hours>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.15-3
X-PR-Tracked-Commit-Id: f5711f9df9242446feccf2bdb6fdc06a72ca1010
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 93ff9f13be91c5f36bb3e5d23237702155deae74
Message-Id: <163199476080.362.16314800399703535644.pr-tracker-bot@kernel.org>
Date:   Sat, 18 Sep 2021 19:52:40 +0000
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 18 Sep 2021 11:49:23 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.15-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/93ff9f13be91c5f36bb3e5d23237702155deae74

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
