Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EFEC3DB29C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 07:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233624AbhG3FNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 01:13:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:42448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229696AbhG3FNQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 01:13:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 6E70E60C40;
        Fri, 30 Jul 2021 05:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627621992;
        bh=in0glC0/qJx3indA2Z7BJ09AIHm1buh7ievguXEF9Wk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qcB5noO7w76gKlSnjP3+DEjo82FfkD1MkAy3do7HyIxH96gbhtr1/WS49RSf8p/VP
         Qrf6fy4JH0LlhCOyk42Hv2na1t+a6634jC8uqE4k797e8O+alFiVziW1/uET3SvyWS
         OtX+/16r7eXiHfPOQENsKo8y9S1eI9K8OzWNy2l66t5Iy/aCDYzXPmT4FpMrSnVqc+
         2t362nv6EHPqlMYRl4UA5WeCeM7rB0mztqokMb45ZRN1gdc/koiQyJ7KHu9C6g2xT3
         0663h5lqnKwdjZ0unp+6ThOoQqoUyPZ+9a54UR7yCGCuuU74UcruhjEtMB2GD18be4
         6XBH54a1xSqwQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 5EFDA609E4;
        Fri, 30 Jul 2021 05:13:12 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 5.14-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9twko1gCNTB3CPf7CAQqWFayMj=1fa3ZoEwwviDFhF48kQ@mail.gmail.com>
References: <CAPM=9twko1gCNTB3CPf7CAQqWFayMj=1fa3ZoEwwviDFhF48kQ@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9twko1gCNTB3CPf7CAQqWFayMj=1fa3ZoEwwviDFhF48kQ@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-07-30
X-PR-Tracked-Commit-Id: d28e2568ac26fff351c846bf74ba6ca5dded733e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 764a5bc89b12b82c18ce7ca5d7c1b10dd748a440
Message-Id: <162762199233.22958.3909758694757785317.pr-tracker-bot@kernel.org>
Date:   Fri, 30 Jul 2021 05:13:12 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 30 Jul 2021 11:11:27 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-07-30

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/764a5bc89b12b82c18ce7ca5d7c1b10dd748a440

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
