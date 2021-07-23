Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 656813D3241
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 05:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233562AbhGWCyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 22:54:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:34372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233499AbhGWCyu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 22:54:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 9A0D960E9C;
        Fri, 23 Jul 2021 03:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627011324;
        bh=ET2Tk5p+JY6wGFFSou0Rht5borxfxJ4df4ED2ntoI+U=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=JWgqeuIdfEpR9AcQx8xQCr8ckXeK9NIXglbN9z5BvkVGKdL6k4clzLIP31f8VqOKh
         uSVE0tL2OScLEBsDbihm7PvdOO9E2ZlSIhvjS9J59tiDHjaJ7r6fudOjyivSIRzNAK
         bhA2OFJ+rJzP9l4i4OSfgGqVQO6bNtaZvwwOXssDbk+maNooVOZ/daoCQBlP0g4s5r
         Hf+0U5GOr5L6sakb27X/R9SMNsyu4mEfjB6HJbwSANXw//BS3oXopEFyMGvBoud1hw
         Jx9ZKCqbx0rvfimVdEMXid4/fmeiGwxhOiU/IyYdwlJ4CZCCR6eN993FRhJbQD4/l4
         8vhRd/ypscbDw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 87F0860721;
        Fri, 23 Jul 2021 03:35:24 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 5.14-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9ty45KQnKE_02R3jE5fJMhz26T9zU6LgDV92WUTd=0U1FA@mail.gmail.com>
References: <CAPM=9ty45KQnKE_02R3jE5fJMhz26T9zU6LgDV92WUTd=0U1FA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9ty45KQnKE_02R3jE5fJMhz26T9zU6LgDV92WUTd=0U1FA@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-07-23
X-PR-Tracked-Commit-Id: 2e41a6696bf828a7b06f520d147f6911c947a7af
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8baef6386baaefb776bdd09b5c7630cf057c51c6
Message-Id: <162701132450.13968.6864094523303505149.pr-tracker-bot@kernel.org>
Date:   Fri, 23 Jul 2021 03:35:24 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 23 Jul 2021 13:07:14 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-07-23

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8baef6386baaefb776bdd09b5c7630cf057c51c6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
