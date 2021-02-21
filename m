Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8534A320E63
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 23:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbhBUWxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 17:53:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:53808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231847AbhBUWxk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 17:53:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 6152164EC3;
        Sun, 21 Feb 2021 22:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613947980;
        bh=beU37vgyLzR0GWf1iv8QDmH77p2/Dnn6d4xXEQsAdmE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=VvHCRIDmsGhFHv79Hs28EphZVutuqzEDKT7Pra7jEzqhlkGXcQ2plKQPyEKcFAF5i
         Vh4DSUg/qVRVjCwTEa0uIAJNlPzYLhIkwSbvz7N55yuLeLJcc87p/aDaHk3CICdtS/
         D/ElJ5gQLvvkvtBtIiwvPeVM65f6DCOIowxO1TAEhHjjxDVGMz0r4zZAorrINhLx1W
         ney2GNQn5EnNSiFd0cNCs9FqXN2bTJeTCJ1MK1e/aLHLbX1EUPVsCDBrutbiUacY99
         wh/M5hdBM3QfGfetMBmYJWTkku0/uZyAIwGjKjh+uXC/zzC40OhBVOLe8CpWVok69Q
         kuSIHTHiYHYcA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 5CE3860192;
        Sun, 21 Feb 2021 22:53:00 +0000 (UTC)
Subject: Re: [git pull] drm for 5.12-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9txd-x1NKWK9BBqVTDNOR00zNqcXgs76YJrDfL94eMLYqQ@mail.gmail.com>
References: <CAPM=9txd-x1NKWK9BBqVTDNOR00zNqcXgs76YJrDfL94eMLYqQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9txd-x1NKWK9BBqVTDNOR00zNqcXgs76YJrDfL94eMLYqQ@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-next-2021-02-19
X-PR-Tracked-Commit-Id: f730f39eb981af249d57336b47cfe3925632a7fd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d99676af540c2dc829999928fb81c58c80a1dce4
Message-Id: <161394798037.6686.4750501257597585917.pr-tracker-bot@kernel.org>
Date:   Sun, 21 Feb 2021 22:53:00 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 19 Feb 2021 16:06:19 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-next-2021-02-19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d99676af540c2dc829999928fb81c58c80a1dce4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
