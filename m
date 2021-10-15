Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E969042F581
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 16:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240362AbhJOOhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 10:37:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:38118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240339AbhJOOhQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 10:37:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 315816120F;
        Fri, 15 Oct 2021 14:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634308510;
        bh=IQUxSiX8Rsf0c9tV9pXRUONxsUa+V5F9haD0LweM9dE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GFoZUWCQoClo1urhPN/Z1VT6MwzKybteYWsvlRntxgDfN7LP+pa2MrZ216yYXl4mL
         E2gKwlCMjuaDUPCvN/el6Lx6rI9O/8jm2z7fb9ygn5b9AAIDq9X42pC1q4BagSDxQa
         sjY/Shrr7dsenO8w/LJXtRsoRBcaPeYj3h2QaZODxE5DpphRYzaC6rPkDMI9UQGZwk
         TVxiK4pgxCY6/Gz8aknl1v/TjOsW8Nm0mmw8uXW+jtVFWHEZrJDPC0/UuV3qDSW4Ph
         NUCLZiPuWsZbdvHlxmVHC4Yy7Rpe8QXkPeh0VVxZVLw6M4rmDm9RK9i/MSFlBQ69Kq
         lYg7k6M58a7Sg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 2676060A4D;
        Fri, 15 Oct 2021 14:35:10 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 5.15-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tyo_PDz3NuSp4N-qidJ55FybBYs6do-f_5gb4iXvct5Zg@mail.gmail.com>
References: <CAPM=9tyo_PDz3NuSp4N-qidJ55FybBYs6do-f_5gb4iXvct5Zg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tyo_PDz3NuSp4N-qidJ55FybBYs6do-f_5gb4iXvct5Zg@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-10-15-1
X-PR-Tracked-Commit-Id: a14bc107edd0c108bda2245e50daa22f91c95d20
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 591a495d440ff8dd2b51a47eb6053c83f68a7f6b
Message-Id: <163430851015.21069.5237391876475990136.pr-tracker-bot@kernel.org>
Date:   Fri, 15 Oct 2021 14:35:10 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 15 Oct 2021 15:15:31 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-10-15-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/591a495d440ff8dd2b51a47eb6053c83f68a7f6b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
