Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1DDF320E1E
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 23:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbhBUWCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 17:02:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:48578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230240AbhBUWCa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 17:02:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 5679064EBE;
        Sun, 21 Feb 2021 22:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613944910;
        bh=rBHPtKMqOcQkuEVyZSPxC/b0gZx8t1BQ7Ni4l5JX3Tk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=iqR+SwALQl1MXZY1ijCf6f3DlHAsVpPnuPi3B+2dD7OlMZTAj9+FvtWeMFlQWC0EC
         NrN8/cgbzm1nimgggff6fOkhPGmIOB5mKyA+/kqt7GCgp58dl9OAL5eOM4HZH1lQDp
         0xKKN3ll3p8LUyUQNml1+PeiM7jKNmZpicfsE/l6UDQPHS2O2LP5pDVxT0xVLiMpB8
         HO+lPFWJbJcTWHZFMzxM6AT0FGuFsy/oOg+5Lj2N3FcxOEkCdXxAS0v/1pLjJbLcRl
         fN3GzPCsMxfAFwth5vAyZ1R58whwiv+NybBW1pbv1T4PEDNuBon3Tuob1DyFuEDPTC
         opBveriSZ4Pcw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 5228660191;
        Sun, 21 Feb 2021 22:01:50 +0000 (UTC)
Subject: Re: [GIT PULL] m68k updates for 5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210215151127.2550851-1-geert@linux-m68k.org>
References: <20210215151127.2550851-1-geert@linux-m68k.org>
X-PR-Tracked-List-Id: <linux-m68k.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210215151127.2550851-1-geert@linux-m68k.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v5.12-tag1
X-PR-Tracked-Commit-Id: c396dd2ec5bbd1cb80eafe32a72ab6bd6b17cb5a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b811b41024afa1271afc5af84f663515d9227554
Message-Id: <161394491033.8676.10772278445065167378.pr-tracker-bot@kernel.org>
Date:   Sun, 21 Feb 2021 22:01:50 +0000
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 15 Feb 2021 16:11:27 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v5.12-tag1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b811b41024afa1271afc5af84f663515d9227554

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
