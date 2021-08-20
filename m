Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 201573F34FC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 22:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239626AbhHTUKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 16:10:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:38960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238952AbhHTUJu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 16:09:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 7AD4461157;
        Fri, 20 Aug 2021 20:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629490152;
        bh=1AblUz05JyakNbDBgEp+x32OedoLAPuchfTOawQaXk8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=kstUbQsA3UMFeUm038rkr+HJv0SJvKtP/+oE1UYYZTeetAzGO3lrBiEqo1tCOmpmL
         1wTUB008jFbJNo5DgJv38l0uDTHXkiIFVXIv32vwOXlTqt+IIr1Dlp2uBkxql2VvTt
         ME6ivDlrj4o7eaZV0zOVLWWQEcfnSrYRlQtCEsCwG9W5t5565C/QZ6hEWg4YMtifaQ
         O2Xu5iV+C+CHp1X4zIOtNkCqXcN4GwEmCEF4VnVM2FysrNbalF+m2DYtRe0vCOqo/S
         hObQmvOv8ZsI0QGDvYXspifddJWkn34N2ENq0eP6e1e3pk7HHbDZbc405ggLgPv55a
         os32Ab4pOIXPw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 7472060A50;
        Fri, 20 Aug 2021 20:09:12 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 5.14-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tx-3de7XH+pbT8deG3E3BhfPde7rBCjRu0pSxtQ0tqGsQ@mail.gmail.com>
References: <CAPM=9tx-3de7XH+pbT8deG3E3BhfPde7rBCjRu0pSxtQ0tqGsQ@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9tx-3de7XH+pbT8deG3E3BhfPde7rBCjRu0pSxtQ0tqGsQ@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-08-20-3
X-PR-Tracked-Commit-Id: daa7772d477ec658dc1fd9127549a7996d8e0c2b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8ba9fbe1e4b8a28050c283792344ee8b6bc3465c
Message-Id: <162949015247.21370.12083039843230342662.pr-tracker-bot@kernel.org>
Date:   Fri, 20 Aug 2021 20:09:12 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 20 Aug 2021 15:36:29 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-08-20-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8ba9fbe1e4b8a28050c283792344ee8b6bc3465c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
