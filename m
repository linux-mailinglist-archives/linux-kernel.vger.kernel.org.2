Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD7274179E5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 19:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344494AbhIXRfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 13:35:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:51774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344195AbhIXRfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 13:35:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id E2F9161250;
        Fri, 24 Sep 2021 17:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632504825;
        bh=H/Dbz2d4WFi4F1Y6ZJoDhhbEE4xQZXif/FbKFN55Wuk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=XIKhLaUNTlh9J+XZqESGClYSDa4uCIMK1BexrYV3Ge0GiEXbhm7bWkH9sfFNoSPgS
         CaC1wvvFMWF7bJqQQMuiwjLKM1UmjobyVc2kUdWOIJrsGsyOdl/DRqszDaFY4heg73
         plKSGAKLbpZ8YxWrMVLQxmWQhuPryyuD90knuhiQ9YzECbsOukCp7qMLOkK/WEpHtK
         SbMYMKLzQlpvPp0j34BNyjubavjyCeYbv4Dzu7Td+7D+2x0C9WycyAeZPbhPnZiR/D
         JsPKIX8VMJhZZJRWD0OuHfSO8kZmBpui9T4r130EXq5jg6XNk66aN7doDr1pL9UvpI
         Pxizd9NmpDGHQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id D645C60AA4;
        Fri, 24 Sep 2021 17:33:45 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 5.15-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9twLyUfPDxjmJ_+s8G5-JmET36vvGpuWM2TBDNUqEowXDQ@mail.gmail.com>
References: <CAPM=9twLyUfPDxjmJ_+s8G5-JmET36vvGpuWM2TBDNUqEowXDQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9twLyUfPDxjmJ_+s8G5-JmET36vvGpuWM2TBDNUqEowXDQ@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-09-24
X-PR-Tracked-Commit-Id: ef88d7a8a5c94d063311a5581d9a8f0c0e3a99cb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e61b2ad3e1914b70c657a8fd7524078ae37a7da4
Message-Id: <163250482587.13479.14293953924599270647.pr-tracker-bot@kernel.org>
Date:   Fri, 24 Sep 2021 17:33:45 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 24 Sep 2021 13:18:05 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-09-24

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e61b2ad3e1914b70c657a8fd7524078ae37a7da4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
