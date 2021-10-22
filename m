Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFFA0437118
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 07:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbhJVFMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 01:12:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:41630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229463AbhJVFMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 01:12:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 0EBEC6120D;
        Fri, 22 Oct 2021 05:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634879413;
        bh=hAUsbK095GhU9u03l79kWnzchsQorHpB0MDHbzvNxkw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Z1WauhgmbEJmYAbkIlC54FYXSUiXQHK7PBkQDRjjnjk/zosxZ28p16rGebclvKNlC
         IJahHif4dBJlO1NMJKzIrzrfyuJrXwgkWoZ1fVCuQxeZq3CWmSUHWiJ2SDFcx6Wwdy
         82mXZsFhAGUcS9xzSAPt96ttwXEiyKZ3wAcbZjFAVvNKeHDh5F0iBeLoIhCydI988O
         PulMYRnP3YQtPxcxgBi8xHc3MjEGl9IM4UkxDtUkKt9HCklKCNqVO1LA5Fx3iOTdhS
         77Ug7r0/QEFpQrvWPj4eksibF6xy2tz5zTmlfAnRsClHOic9r+gpqvWUK/ZkabPiKL
         V78KIrac67QtQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id EE2E3609E7;
        Fri, 22 Oct 2021 05:10:12 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 5.15-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tzoEc2rNg9tObnmTnqhg_BEcKQiqgAgqAQOphJa1M760g@mail.gmail.com>
References: <CAPM=9tzoEc2rNg9tObnmTnqhg_BEcKQiqgAgqAQOphJa1M760g@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9tzoEc2rNg9tObnmTnqhg_BEcKQiqgAgqAQOphJa1M760g@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-10-22
X-PR-Tracked-Commit-Id: 595cb5e0b832a3e100cbbdefef797b0c27bf725a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 64222515138e43da1fcf288f0289ef1020427b87
Message-Id: <163487941291.3037.7507080835979258699.pr-tracker-bot@kernel.org>
Date:   Fri, 22 Oct 2021 05:10:12 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 22 Oct 2021 06:08:20 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-10-22

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/64222515138e43da1fcf288f0289ef1020427b87

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
