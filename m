Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4DFA40EBD6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 22:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239371AbhIPUrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 16:47:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:54344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232361AbhIPUrj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 16:47:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 0E9E26105A;
        Thu, 16 Sep 2021 20:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631825179;
        bh=hGRAFb6mFt9BFUKqdReSzfcflDrfVETbD9gztqKhu0A=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=N/PQTo5FHdCVVdqzqRUITBENe74TnTElwsMHONAFR4h8E43BRljzJ8kl7odlhZbjV
         kx7xgUTDxVk8opoTp65ViyNJppzbrfhkfqBw7+hYKCb7p1gCAF7dt8Pb/kft1UvA9L
         vANZfxOA+1rYn9j4WNnDo/QAQE4AEVORpbtdPfvC2lOYqJ273bDLPZNnsJehZu7xns
         Nq08hTGuOe5iSuZzm5G1z7ZcLlp7uJ+60ym1ULm9MRReV0uGdmgqrxQauzz/ZGSmty
         IVC6K/RcKVcZ/Cv8DjrNPsl4/jE48ZsaGtfihsq1UUbblP/KQ6ZkTFF6bVRXKMqfKi
         sty7xjvyEhq/w==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id F2D8B60A7D;
        Thu, 16 Sep 2021 20:46:18 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 5.15-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tyrmDa4qCvu0pf0JHU1DmDnq5H=1uE1JaGjLs6E6dPZNQ@mail.gmail.com>
References: <CAPM=9tyrmDa4qCvu0pf0JHU1DmDnq5H=1uE1JaGjLs6E6dPZNQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tyrmDa4qCvu0pf0JHU1DmDnq5H=1uE1JaGjLs6E6dPZNQ@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-09-17
X-PR-Tracked-Commit-Id: 109f7ea9aedce437b4b7737ab60bfea65d9dbdd3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bdb575f872175ed0ecf2638369da1cb7a6e86a14
Message-Id: <163182517893.9786.17583244550626963421.pr-tracker-bot@kernel.org>
Date:   Thu, 16 Sep 2021 20:46:18 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 17 Sep 2021 06:15:42 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-09-17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bdb575f872175ed0ecf2638369da1cb7a6e86a14

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
