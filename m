Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9491335A77D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 21:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234477AbhDIT7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 15:59:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:37250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234412AbhDIT7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 15:59:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 31CE960234;
        Fri,  9 Apr 2021 19:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617998366;
        bh=T0BSgdVLpRmBgAnPWTejDSc98krY1A2GeGxW7OYNlPI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=h6n8CG1y3Hh82AW2u/KCJdghGObaMSML6iTd/RaOPXpAYSu0DTqgP5JBcf5JbYp+S
         fgFfid2xVOzUMKzVTLCk5ImBMibwn6UijzUqrb3yAiKU6IaSv5hIRWrH1NPBL/kI+b
         SLRVmsnFFkE/rxEOgJIJxUZ4v+8nuPQn8A5mGs8Xj8H0RnX6yr1sF1rTed/7QZLTSr
         v3M7jRvGH0Bwb/H490oHN4IvpN9TtcMkdRhTQvCBVNrQf0jPYoPnqZtkSQIn3/aLME
         0Gf2CdLtNemF1IhDUVbo8kZ11dOhEDYnB//w8Zo3CxYtdKzBuBr67kCHO2boHl8G1Z
         LbPLS2o6dJ1zQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 2D12B60A71;
        Fri,  9 Apr 2021 19:59:26 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 5.12-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tzEK7pEZ54TMCMc0yLto5QhnBjGE0X6X6Ca+N9EAc+U=w@mail.gmail.com>
References: <CAPM=9tzEK7pEZ54TMCMc0yLto5QhnBjGE0X6X6Ca+N9EAc+U=w@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9tzEK7pEZ54TMCMc0yLto5QhnBjGE0X6X6Ca+N9EAc+U=w@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-04-10
X-PR-Tracked-Commit-Id: bd119f471299c8692a00b2f5e9bba8e3b81c3466
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a85f165e1f38c0a5a6e671ce8126a8cafe35af09
Message-Id: <161799836617.7895.18282958904138240237.pr-tracker-bot@kernel.org>
Date:   Fri, 09 Apr 2021 19:59:26 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 10 Apr 2021 05:46:21 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-04-10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a85f165e1f38c0a5a6e671ce8126a8cafe35af09

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
