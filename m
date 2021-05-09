Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9331237788B
	for <lists+linux-kernel@lfdr.de>; Sun,  9 May 2021 22:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhEIUvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 16:51:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:59372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229683AbhEIUvC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 16:51:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id DF3846135A;
        Sun,  9 May 2021 20:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620593398;
        bh=MRn2TqF+F1OQQsUPPcSLj01bNmIn3EcEdO3S7acU8A0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=DrRdy7fRAzZCqyuwzxsXAT2Cl3+YkExRSrELcj0iVpwPao3UsQL9ZUARRCJVYjVIY
         QgTawDBSSksRvYMgMXpFGrEtow7/hqKWdh8DfUBaiwNAncUh10bWZrb0tuchPL5/nf
         mIMwv0B51yHU+UigQB+2cSuWY86zGEtR7YdTUr07DaoNl3BVYjU3DQhkxTu9cQ19w6
         mL5ZH3m3m2douwQgk608/+c424/bneRFG8XOzvpUz+IkueITwmGJFx4S2qHBHMQ4vc
         UppkUEZdKHM3qBGHdLfw4A7+3obeGeXThGjjgvDvaT0vZo5UegSR0qn2IGYbGUuo/R
         PFFzqEbOBuEiA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id CC41C60A21;
        Sun,  9 May 2021 20:49:58 +0000 (UTC)
Subject: Re: [git pull] drm fixes round two for 5.13-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9twAN82gkzrfc2CGQopjkjEdWtBKMF2DgBOtw+6RsZ++fw@mail.gmail.com>
References: <CAPM=9twAN82gkzrfc2CGQopjkjEdWtBKMF2DgBOtw+6RsZ++fw@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9twAN82gkzrfc2CGQopjkjEdWtBKMF2DgBOtw+6RsZ++fw@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-next-2021-05-10
X-PR-Tracked-Commit-Id: 0844708ac3d2dbdace70f4a6020669d56958697f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: efc58a96adcd29cc37487a60582d9d08b34f6640
Message-Id: <162059339877.8686.14928053703025006797.pr-tracker-bot@kernel.org>
Date:   Sun, 09 May 2021 20:49:58 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 10 May 2021 04:16:02 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-next-2021-05-10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/efc58a96adcd29cc37487a60582d9d08b34f6640

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
