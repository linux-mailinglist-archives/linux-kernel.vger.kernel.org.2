Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94AB8443A41
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 01:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbhKCALL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 20:11:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:60840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229934AbhKCALK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 20:11:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 9CB0E610C8;
        Wed,  3 Nov 2021 00:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635898114;
        bh=l6GesyVZcnCWevVTBw39JnCBZK3qajRza7E4zaSUyQU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=b/TU74lIdAA8EXPGeWs70Ufpql7NtaRRT4HiwsqklnM3iEIg0/HYjFFgsEnPddIg9
         5X4wEXLlFy+Eu4VbR8fij9LBfnka+kQ++FrUDQXwZ6hqBI2M42O3z7015n4kulfF1N
         oN/wFWpCBeoVO+Ff75t7Rkt062zIICxtF1aEGp1tBdzvmHBZhZ07O8SSKuE+t3a8cX
         SSP1ueVJZmpJnHFcdcvV3D8J47zxOCiAA1y3l5dsZUTYmiEVlezIvqf5OD9mHMcWXT
         tDcEfANW6WzczLYE3SUHReZO77H1GKLaL7oymXD2ccJkRp6bKzmNPRDZVp50QaN0/m
         b0JEQ4UWFU3MQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 89D13609B9;
        Wed,  3 Nov 2021 00:08:34 +0000 (UTC)
Subject: Re: [git pull] drm for 5.16-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tyOyz4_-OdjDduFkponSXycO6maBDFsWGTLv+j=_Vp6ww@mail.gmail.com>
References: <CAPM=9tyOyz4_-OdjDduFkponSXycO6maBDFsWGTLv+j=_Vp6ww@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tyOyz4_-OdjDduFkponSXycO6maBDFsWGTLv+j=_Vp6ww@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-next-2021-11-03
X-PR-Tracked-Commit-Id: d9bd054177fbd2c4762546aec40fc3071bfe4cc0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 56d33754481fe0dc7436dc4ee4fbd44b3039361d
Message-Id: <163589811450.12904.16056402760651247519.pr-tracker-bot@kernel.org>
Date:   Wed, 03 Nov 2021 00:08:34 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 3 Nov 2021 09:34:23 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-next-2021-11-03

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/56d33754481fe0dc7436dc4ee4fbd44b3039361d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
