Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF8C36EFB6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 20:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241251AbhD2SvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 14:51:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:44060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233830AbhD2SvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 14:51:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 4938C613B3;
        Thu, 29 Apr 2021 18:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619722224;
        bh=mxgY94h9P30HJz1BgUb4GSmNYb7X8XF04xPKYVVnjsM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=H2YDGhNST73DaZzvnijOI0wQvYnvDFAjxacpX/UDu8Eaw8P2+6IW5l+2Utv9tjSAt
         pNTf80BMOr/DKIjDA20/jt6IUDrAqxZNF81MBMPE2+j94ETaqlIBWMzWsyacokIUui
         AJsRWU+D0SrQJ0xhSkWDXYFC5t/5A/YDrJ9pS6dFw8fK3tJm//RHDwFBm2VpIVePcz
         HzQQ9HwLbutQ7jhbtZ3mz+uJI4auvZizu3hpkAjYeByAtXX94MtpuX0B5rV0xUfQIp
         UCKYqaeRE/mBPvaKz65bF5U6RePLSmj2L8oS/uVz9CG0Wnhj5t3cP7l4rXSQvmxkp2
         vYafx9YeBoxhA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 444E560A23;
        Thu, 29 Apr 2021 18:50:24 +0000 (UTC)
Subject: Re: [GIT PULL] arch/microblaze patches for 5.13-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ffad0699-7966-f601-3d88-8ad1157bf2b8@monstr.eu>
References: <ffad0699-7966-f601-3d88-8ad1157bf2b8@monstr.eu>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ffad0699-7966-f601-3d88-8ad1157bf2b8@monstr.eu>
X-PR-Tracked-Remote: git://git.monstr.eu/linux-2.6-microblaze.git tags/microblaze-v5.13
X-PR-Tracked-Commit-Id: 47de4477a8e6bfd202640567ce4bf17cc1de60be
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d0cc7ecacba8a5b6bbdd5aa6ba3d1bc2fe59b580
Message-Id: <161972222427.6619.17853712516870550013.pr-tracker-bot@kernel.org>
Date:   Thu, 29 Apr 2021 18:50:24 +0000
To:     Michal Simek <monstr@monstr.eu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 29 Apr 2021 09:52:28 +0200:

> git://git.monstr.eu/linux-2.6-microblaze.git tags/microblaze-v5.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d0cc7ecacba8a5b6bbdd5aa6ba3d1bc2fe59b580

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
