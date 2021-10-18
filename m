Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5411430E21
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 05:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbhJRDYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 23:24:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:50320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230429AbhJRDYn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 23:24:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 0B62A60EB9;
        Mon, 18 Oct 2021 03:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634527353;
        bh=wnmeTYdCTCDDf1OOaT20eSsKyzZVNHJX66ik+gOJ6+8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=lMrgCB4MpwSdSBNssRsuX3s2qcMmGKCXYTD6owrssfwxu1QNQW6wdKFXb+MxMahLs
         RpTvgFpPFxA4smovLavv0IpvFv6QA5b5oqpAwvG7UiHiopOI4Mk6YUv65Tvt9HDn8o
         KI6V0KcqEVysOFPTiSCVHGKRkLq6D2LEEwRgHVLZjLpgobmIj2qIc7Ssy7XgeIm6IX
         SxKV+ni/EHWhhJScTJ68D/KOO5CVeGhR/CyAP6SZciWbRKaAqTgCKBl/jIvG0/Ucq5
         gGsAe9d1b+Bg/0HUqlnVyB4hkquA4UM08jte2fsJpYngzKIteggJDTKY2XS1oyPU52
         RVvAiXwCkFdMQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 05992609AD;
        Mon, 18 Oct 2021 03:22:33 +0000 (UTC)
Subject: Re: [GIT PULL] Staging driver fixes for 5.15-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YWv1ojsgySFtQr5J@kroah.com>
References: <YWv1ojsgySFtQr5J@kroah.com>
X-PR-Tracked-List-Id: <linux-staging.lists.linux.dev>
X-PR-Tracked-Message-Id: <YWv1ojsgySFtQr5J@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.15-rc6
X-PR-Tracked-Commit-Id: 37f12202c5d28291ba5f83ce229771447ce9148f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a563ae0ff6dc1b810f08e52dff3ad16affed3d24
Message-Id: <163452735301.4914.7606356655556678242.pr-tracker-bot@kernel.org>
Date:   Mon, 18 Oct 2021 03:22:33 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 17 Oct 2021 12:06:26 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.15-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a563ae0ff6dc1b810f08e52dff3ad16affed3d24

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
