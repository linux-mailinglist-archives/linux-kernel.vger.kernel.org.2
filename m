Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B39E343445
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 20:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbhCUTCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 15:02:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:49694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230064AbhCUTCe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 15:02:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id E683E6024A;
        Sun, 21 Mar 2021 19:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616353353;
        bh=W8nhk/e9uQfq98pzoyRkw2HsgksWMgDekNOI2PiaBho=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QKNy2ItdJbNQazTMeBBEqNzXkwfWjBsH3da7jT8ocRXl6yhv4G/6FCotIBBlYrt/3
         Mn6drFHpXJmkhv/OvTnzVxExgcQrpudh/Xldy1EMeDWFO5AYmfR+mmbZN3Ga/y800x
         Yti9QoRv5UVCXenl7K5qkOj9YD2KtAGFqDi88cX3R/lcwXr803dgBuZsEzBwzRZqCg
         RiZli4+Jcp2lwGNp4qu9B4B0svP6bi7vcoGUDHfC+vqAIBdTxJ92TmD9hOjyhrQ3RE
         D0oYPoT8/b6t/8deYOccCdG0M4KBGHsHFmUNXWI+mBXH1pwxE2LWguOxrj5YyC5zeQ
         8TE6xPz5Gqkkw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id D428C60A6A;
        Sun, 21 Mar 2021 19:02:33 +0000 (UTC)
Subject: Re: [GIT PULL] Staging/IIO driver fixes for 5.12-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YFc8/KJBiKVT2Rt1@kroah.com>
References: <YFc8/KJBiKVT2Rt1@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YFc8/KJBiKVT2Rt1@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.12-rc4
X-PR-Tracked-Commit-Id: 2cafd46a714af1e55354bc6dcea9dcc13f9475b5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1d4345eb51a185b2ecd11834dbddca79cb922eb5
Message-Id: <161635335386.3800.2419849329640227912.pr-tracker-bot@kernel.org>
Date:   Sun, 21 Mar 2021 19:02:33 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 21 Mar 2021 13:33:00 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.12-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1d4345eb51a185b2ecd11834dbddca79cb922eb5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
