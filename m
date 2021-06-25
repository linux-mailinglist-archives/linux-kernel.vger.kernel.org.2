Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF513B4870
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 19:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbhFYRve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 13:51:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:36588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230283AbhFYRv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 13:51:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id CD5AC61954;
        Fri, 25 Jun 2021 17:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624643347;
        bh=LW2oYkCClhr/lsFYGmI2Mp2i2CqNF/l21PFMxQAgpf8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Ml7kcFQqXQ1AXIPtXNg8M4/St5SjO1K76Q1JWFUw3gCiSUovzumbTux02dr76egOz
         5zapa7w52sutLmEH3P26SBcJUlrxc+xxquCnSXAOwGUzObJDrDGR/0geGDYq5q0ShP
         NBb5ioVgf+5M93rC5XLi1UDuUfX4hRoleWv8SMuyYiaSUtJwSKoqctQizpLyNzE1mv
         IfM1LM5oOZiLQzJwlCDOO+E3/o36gijek7tvSzFpbVthkmmn8GrZB+EmhPsRhbRvGS
         M9wybDGsP3rCX7XoD2pHIdPr6HCBZcce+JdC/FeAlLZXRtwL7rG9bQfIm6s7dLqIA1
         T/pTuZVwgbK3w==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id C75BD60A37;
        Fri, 25 Jun 2021 17:49:07 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 5.13-rc8 or final
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5h7diil5nt.wl-tiwai@suse.de>
References: <s5h7diil5nt.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5h7diil5nt.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.13-rc8
X-PR-Tracked-Commit-Id: 5c6d4f97267f02f47acea8a652265348ec12de51
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e41fc7c8e275ddb292556698c7b60a1bf1199920
Message-Id: <162464334780.2214.1299557263139665459.pr-tracker-bot@kernel.org>
Date:   Fri, 25 Jun 2021 17:49:07 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 25 Jun 2021 10:17:26 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.13-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e41fc7c8e275ddb292556698c7b60a1bf1199920

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
