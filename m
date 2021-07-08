Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 476A73C1A23
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 21:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbhGHTwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 15:52:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:55480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230201AbhGHTwD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 15:52:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 782886141E;
        Thu,  8 Jul 2021 19:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625773761;
        bh=EkdOdgkxOsnXpLPBHWVAf4lmqTozrzxO6F85vmZ7poI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=VKtwfyMhYV+vHWVLQr4cnLIQM4ATACU226WDkxfYWJebQOXigSMvhr4janL+v0BfI
         KLDat0Pu47WWpiZPTzH0Y9q0icWEkiJJVSImZNHbKp+oD0KAxdrk2AVXTU0UuJtFPo
         t9CWkyyd8G1ll35VxWyUQBltX/BAu96sWcvoa6Vf1X98SAAPYHSQlmOOjA8PisLvkC
         kWPFXYoZsMVr7Zj+SU4rHq5xnsTAbSRqrvFjm/Tqxx98yj1SDorJInExOri/T/4Cp+
         KWPAVTeB2V5jzBhQxn0fR1UfphvnpVEms41p+ZmrsX5wlj+HqBy7phlQhsz8CKOBc1
         baJfxDUPgoWcQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 716D0609D6;
        Thu,  8 Jul 2021 19:49:21 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 5.14-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9txowZc9-MVfS_uvASJMnE4Okt4B8KHCyk3nC9x=-a+w3w@mail.gmail.com>
References: <CAPM=9txowZc9-MVfS_uvASJMnE4Okt4B8KHCyk3nC9x=-a+w3w@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9txowZc9-MVfS_uvASJMnE4Okt4B8KHCyk3nC9x=-a+w3w@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-next-2021-07-08-1
X-PR-Tracked-Commit-Id: 21c355b09711e95f8f0e7c1890b343c6cd350042
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f55966571d5eb2876a11e48e798b4592fa1ffbb7
Message-Id: <162577376145.18035.5408341954481611000.pr-tracker-bot@kernel.org>
Date:   Thu, 08 Jul 2021 19:49:21 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 8 Jul 2021 13:06:50 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-next-2021-07-08-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f55966571d5eb2876a11e48e798b4592fa1ffbb7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
