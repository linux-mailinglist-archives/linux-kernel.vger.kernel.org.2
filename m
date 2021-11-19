Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5590445774C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 20:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236404AbhKSTtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 14:49:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:45452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236149AbhKSTtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 14:49:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id EB31061AF0;
        Fri, 19 Nov 2021 19:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637351177;
        bh=Fatu20UiZI42qmAY4VHyZ1WqXnoMvkmyBB3M6LR47Kk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ByM8/ZE1GpjCrb/8W7+TVjvLKdk4r5g7mY2mTInhj7IUbWTuCIoIN+DOrmNI0LlFl
         ME6E2dYacNewvvRnSTRJ1eHdvDLfP/F6Fy/lZelH3AXedz2EWyFseOyQXlsVJSwE4E
         te00DMliVX+22QeaD4/Cb0iB22qKil8lA0daEvVFIqXTmGuWuIND0HYfOf7Hm0Uo08
         rmMv+NQOSTDtPJTun7cA8B1kkLa/zxAeFSynq4W2x1oAGyAPr4eU8ZsTVgY9lozOcy
         LQsdHvtJzp+YOQIfR0Z018uZ6nMDxp65W4AXuTJ93kn9Cl9kfeLxYHMREu9JGITq8o
         ZrPUlSvKwJ7cg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id E50E060977;
        Fri, 19 Nov 2021 19:46:16 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 5.16-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9twL3jV37TWqwTUDfCdqMEeQDO6Zrgx+rkWNir8Q8eOqWw@mail.gmail.com>
References: <CAPM=9twL3jV37TWqwTUDfCdqMEeQDO6Zrgx+rkWNir8Q8eOqWw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9twL3jV37TWqwTUDfCdqMEeQDO6Zrgx+rkWNir8Q8eOqWw@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-11-19
X-PR-Tracked-Commit-Id: 7d51040a695b53d4060349c7a895ef4a763887ef
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ad44518affc66611644654cec9c165eb4e848030
Message-Id: <163735117693.2946.13384275708664260252.pr-tracker-bot@kernel.org>
Date:   Fri, 19 Nov 2021 19:46:16 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 19 Nov 2021 15:32:38 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-11-19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ad44518affc66611644654cec9c165eb4e848030

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
