Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B78D39BE98
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 19:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhFDR0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 13:26:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:53364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229690AbhFDR0h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 13:26:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 6BD0F613F8;
        Fri,  4 Jun 2021 17:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622827491;
        bh=DdCtVt0pkzSsp3mRx4YUn9TVjbdkp2pkEeLaa6fM4d4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=kTTCFZ6rCEI3ZOzbkDflO5YbsSilWlzFrX8Xh7QKiFu88mXkqgG7F6O8oQmwdFGjK
         BrnpXihx6kSIx+uZEv1v7wYpTStspzmal7k46z7Wok/izO5C4/1O2sBZZ30F+lcs2w
         k7ACDj1uXVpudOs3ldJ7hvtOHL+bN4CqEUwcEzc2v44JsDfyAm/ORfeydETCMzDOsi
         wXlETEMw7jYhF4elUj+Gcnh0ORvJx1j95r5OQUWx55UoFdmXG0YJeSye5pWbeY186V
         iXCqQYlnwDx3OwxZoCZ88oTHafktIkukIeC3wkUTTYHuBDZPmIq5CHCf/EMAGxeNks
         2aqH+gobfvQhg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 5957460A39;
        Fri,  4 Jun 2021 17:24:51 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 5.13-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9txo9kjV=iiFKVN5nS6aATwOD+dZ4RLZD7O6Ezya3tLAaA@mail.gmail.com>
References: <CAPM=9txo9kjV=iiFKVN5nS6aATwOD+dZ4RLZD7O6Ezya3tLAaA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9txo9kjV=iiFKVN5nS6aATwOD+dZ4RLZD7O6Ezya3tLAaA@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-06-04-1
X-PR-Tracked-Commit-Id: 37e2f2e800dc6d65aa77f9d4dbc4512d841e2f0b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3a3c5ab3d6988afdcd63f3fc8e33d157ca1d9c67
Message-Id: <162282749130.14402.9802907870136444648.pr-tracker-bot@kernel.org>
Date:   Fri, 04 Jun 2021 17:24:51 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 4 Jun 2021 11:54:28 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-06-04-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3a3c5ab3d6988afdcd63f3fc8e33d157ca1d9c67

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
