Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B22935201C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 21:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235436AbhDATsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 15:48:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:43810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234807AbhDATs3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 15:48:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 797256023B;
        Thu,  1 Apr 2021 19:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617306508;
        bh=B7RN2E3cKyohbVXKMKP99pDf91zJMeLid7xwGDyIzLY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jecoxlojdMa7nV4IWBNp6f1FzkCRTbXitl2Zc1WAWlZzcqXLY1Gn06LZYk2toiISj
         AvwGLH72taDLg62mkMoX63IvI2pQy3W6VHJi8ZW1tCJ1f4SYd/aHYW2IVw33HnUaP+
         5ZrM7P+XCmCLPHJvk38ne53PSHci0mmEUoCd9b7HC/M/B6n09soU7A+8+IB5uGOLAw
         cKLhWRfSUQaC6CgBr2XV+F0JUIvbDD0nKwKIGDV6xB1hOtxHL5O/OJYo1+vICh+pF7
         nKBaZhvCa1paSKrUMVf/ZOGXiX3LXtswXF4mmZpnyUGV5gHstmYOtzDCJqlNXyZeB+
         Q+TKkthP29i/g==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 6D451609CD;
        Thu,  1 Apr 2021 19:48:28 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 5.12-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tzgCsiCMpLy2g3dZCg97PZ-4HKgLWtfj2ZRk8o5LhqLyg@mail.gmail.com>
References: <CAPM=9tzgCsiCMpLy2g3dZCg97PZ-4HKgLWtfj2ZRk8o5LhqLyg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tzgCsiCMpLy2g3dZCg97PZ-4HKgLWtfj2ZRk8o5LhqLyg@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-04-02
X-PR-Tracked-Commit-Id: 6fdb8e5aba6a33fe5f1a0bd1bcf0cf2884437ead
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a80314c327a937ff1213288adf0d11414c40a898
Message-Id: <161730650844.24871.1138995836045710619.pr-tracker-bot@kernel.org>
Date:   Thu, 01 Apr 2021 19:48:28 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 2 Apr 2021 05:17:07 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-04-02

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a80314c327a937ff1213288adf0d11414c40a898

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
