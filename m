Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1D741F387
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 19:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbhJARrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 13:47:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:43792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355335AbhJARra (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 13:47:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id A48F9619F8;
        Fri,  1 Oct 2021 17:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633110345;
        bh=A0ixqXKF9TR89JixDePM4QYhyS0B3OR9sfVUyNPUABM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jRo97psFmPjf0nEQn2PYUFbFcp5T1qkJTrNBayFvyVVd8iOQU6obLywTYQNmklJQU
         q2VE3PKSa8aLnDTWuhMExB/kQPDT5a8/p5E984R6xrUIRpJj+tDvO7nq6S07jPy2IZ
         NtE1cIRw8u2PnmLOAeFN6iNnIvfnGCiMk0ogH9aJjlr+Y6ZamPPpFgFIfNj4Vn4xDg
         41VQCdP23I8T4NG6u9XJQIdkOdIOP6nsgROCHa8IONsWTiU9gixBXlV3dmcibizE6B
         CvvNnueWzqOlekIdGjkHgkpnc+th2tPmhNY7dGW0arbGfx3ZyTR6Kr8wcnRfjn8vC7
         DHPLyprjjg+3A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 9852760A4E;
        Fri,  1 Oct 2021 17:45:45 +0000 (UTC)
Subject: Re: [PULL] drm-fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YVc94kx7GVHwt+uc@phenom.ffwll.local>
References: <YVc94kx7GVHwt+uc@phenom.ffwll.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YVc94kx7GVHwt+uc@phenom.ffwll.local>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-10-01
X-PR-Tracked-Commit-Id: 78ea81417944fe03f48648eddeb8e8a8e513c4ad
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 24f67d82c43c9c594821ee1bc4367a23d89d9f8b
Message-Id: <163311034561.16016.7072504325548357764.pr-tracker-bot@kernel.org>
Date:   Fri, 01 Oct 2021 17:45:45 +0000
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 1 Oct 2021 18:57:06 +0200:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-10-01

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/24f67d82c43c9c594821ee1bc4367a23d89d9f8b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
