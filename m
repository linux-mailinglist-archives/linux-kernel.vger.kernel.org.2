Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB1B45E46F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 03:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345139AbhKZCaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 21:30:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:46706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243919AbhKZC2J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 21:28:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 9B8F661139;
        Fri, 26 Nov 2021 02:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637893496;
        bh=YOooNViB+AMgsR+IFA8wIlJTLIL4Y2MljwkKm15gsKA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jpU6GkMxvAOIKz6D/XR3f9XKGMRrjbOBUH2pLRey81RIkHauARyYbYI+zYl+r7vXg
         j0pRD0vZYMi6UDjIWdGp2plRv5ThtmZBnUT5j6bfqrs7TniRWe8+1D5xXq7UeFT6FD
         hPlv+OR5wA6SVBRPBSyYX/oGESieP0EVUrlbuvWb/IEAIO7YA+RaaxqDHe0C/nu1np
         cOQ4j0cmbQEpDtLaoUxw+GML66W7FtZM970cM9sw9yNDkwzDjiEzLMmx34twUpzW0H
         9DGHf1M0FJ85TBdXKsthQhmLGtVY6WG7Wi4s4tEl5XrZ7EijiEfMHsZTndxXb5ROmI
         qt28g2E7dY7uw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 88C62609B9;
        Fri, 26 Nov 2021 02:24:56 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 5.16-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9twJOj8+cfEPArF7N_TZpVM8vN+S4s2mMM7phsS-ZOgmJA@mail.gmail.com>
References: <CAPM=9twJOj8+cfEPArF7N_TZpVM8vN+S4s2mMM7phsS-ZOgmJA@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9twJOj8+cfEPArF7N_TZpVM8vN+S4s2mMM7phsS-ZOgmJA@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-11-26
X-PR-Tracked-Commit-Id: fc026c8b926835b46509a2757732bfa38a2162f1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a4849f6000e29235a2707f22e39da6b897bb9543
Message-Id: <163789349650.12632.8523698126811716771.pr-tracker-bot@kernel.org>
Date:   Fri, 26 Nov 2021 02:24:56 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 26 Nov 2021 10:52:04 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-11-26

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a4849f6000e29235a2707f22e39da6b897bb9543

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
