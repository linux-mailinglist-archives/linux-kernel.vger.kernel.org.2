Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9875D363341
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Apr 2021 05:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237204AbhDRD3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 23:29:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:41646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237179AbhDRD3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 23:29:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 481B86120A;
        Sun, 18 Apr 2021 03:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618716548;
        bh=JDCSjvKTH30D9ejYBlLFWVDWZtSqvItw+rte0XJ0jS0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=rrOaI/E8Fcik1SYC+oMVpdg+m7SOUxb0u9Mkt6sb1H2LUvW3Vomm+miO81mw7w6j0
         tJII/6NKi3J0T4v54P92FggoaWfF9r8H3ZhqVI9ZTYLhihjNXxfShfV2r16vGQ/nJo
         NaWomWrv+m1v0qKlrbtm+zwhODKZ8k8qLnmY9Y3cQ3WZb4tWKmo8hvHNJWI+vlkD+c
         F3/Of0Lw7UE8ERJG4O7cA1RFKtczfTtNeC/lAjpn6+OTHv0xEy0CdoxqsZFacoxMCX
         9B52dpRSjmhT3QnBs+2JUrD/+QpKK89hByPoooAJDLErMWypHw7WZgElJoJgWBic+B
         R1juoOda/guEQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 4167060CD6;
        Sun, 18 Apr 2021 03:29:08 +0000 (UTC)
Subject: Re: [git pull] drm/vmwgfx fixes for 5.12-rc8
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tzVDp7PB0Rv8+Lmi4Ervp8QRio6phvRy_H-oFUHe3phSA@mail.gmail.com>
References: <CAPM=9tzVDp7PB0Rv8+Lmi4Ervp8QRio6phvRy_H-oFUHe3phSA@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9tzVDp7PB0Rv8+Lmi4Ervp8QRio6phvRy_H-oFUHe3phSA@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-04-18
X-PR-Tracked-Commit-Id: 796b556cbfdbe0d65b9793e63653ad24f9fa033c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: aba5970c4da0059ed8052188a341a85ac8845d6f
Message-Id: <161871654826.19812.18251212107299642091.pr-tracker-bot@kernel.org>
Date:   Sun, 18 Apr 2021 03:29:08 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Zack Rusin <zackr@vmware.com>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 18 Apr 2021 09:48:56 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-04-18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/aba5970c4da0059ed8052188a341a85ac8845d6f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
