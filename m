Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF32F3269F6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 23:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbhBZWYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 17:24:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:56042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229996AbhBZWYg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 17:24:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id A7F3F64EC8;
        Fri, 26 Feb 2021 22:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614378235;
        bh=VEmOKrtc5TGBfhDVCfeBY7ofIC7lRH0rx6DqYvgZeR8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=mVyLdcRsWYrblhS3GzS0AjyPx4U48bnALtTvCr7Tsq96Tr1WXdSq86JgqBHwlLZNc
         w3nGiMQoiUrW9tHNkbgKY+ACuHwQlf/9HG1m55xnz4TEe1MllydjEBV7tF5633cGsu
         28PqgDKHg17Qy3JX7QxWDo5TPZH7/tUwCP5XNoerkrYVqnIyn+91P08CO6nj5zZ2yd
         TvkNCrqR0Wl8OR9hCdtsP9kQaRDawq8jjTHVUInbhRY2krSoaPbkJzkU6OR9ygDd7E
         xPhFJYQGWAn4BOlbLt8IJsN87WgypthZz1mnxxxptkmVyCnVSzfByYizNFQ0FbhsaH
         4VuZWoNftIw9w==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id A089960A0E;
        Fri, 26 Feb 2021 22:23:55 +0000 (UTC)
Subject: Re: [GIT PULL] Documentation fixes for 5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87blc68xtf.fsf@meer.lwn.net>
References: <87blc68xtf.fsf@meer.lwn.net>
X-PR-Tracked-List-Id: <linux-doc.vger.kernel.org>
X-PR-Tracked-Message-Id: <87blc68xtf.fsf@meer.lwn.net>
X-PR-Tracked-Remote: git://git.lwn.net/linux.git tags/docs-5.12-2
X-PR-Tracked-Commit-Id: f37a15ea8db022373a2cb6d1a6004c65c2b7f17e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3fb6d0e00efc958d01c2f109c8453033a2d96796
Message-Id: <161437823565.23821.5516656633036808087.pr-tracker-bot@kernel.org>
Date:   Fri, 26 Feb 2021 22:23:55 +0000
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 26 Feb 2021 11:54:04 -0700:

> git://git.lwn.net/linux.git tags/docs-5.12-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3fb6d0e00efc958d01c2f109c8453033a2d96796

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
