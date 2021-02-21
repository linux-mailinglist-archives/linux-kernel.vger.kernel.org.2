Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 586413208A8
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 06:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbhBUFlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 00:41:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:45494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229891AbhBUFlL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 00:41:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 1BD5C64E5F;
        Sun, 21 Feb 2021 05:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613886031;
        bh=mB3y5ZU5btwdfBVKaLvkn0Hc0Oby9mmSLMF1iYZZb9Q=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Gx1Q6R8cgKJDPW1fOV9/24CeQH0C+E0m8KgHnbaG0qw7k+bbIiJJ/lD6JeOeNV0Ne
         cmYQHP0TdrH7qvsrU9DEw5qeA4ZHQl0Fn4StVN0l7MX/r5FmCG69pBJiYDRJf781tK
         5+cHdk7C+tDlFwzpUImNAalmWQuIZ3nykWSrS3AID4BP6ndX84xjUcCzfG9SiP9UAF
         DZEVptoBwG8AvlqwbMmvsd+VD1Mr2WHogcfzKOeEsjqb0RCi+xXh/absx26BTgn8LM
         dVm8FEofm0oznx0lAgDj2wvQuNpUYZZ/8VRLGy44v8kOD3hG51HsvSbHIiNaSdWhK6
         h4kxwX2ACriHw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 1154E60A3D;
        Sun, 21 Feb 2021 05:40:31 +0000 (UTC)
Subject: Re: [GIT PULL] Staging/IIO driver patches for 5.12-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YCqhISE0U6/UJoLb@kroah.com>
References: <YCqhISE0U6/UJoLb@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YCqhISE0U6/UJoLb@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.12-rc1
X-PR-Tracked-Commit-Id: 4eb839aef182fccf8995ee439fc2b48d43e45918
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5d99aa093b566d234b51b7822c67059e2bd3ed8d
Message-Id: <161388603106.26679.15364746324127920251.pr-tracker-bot@kernel.org>
Date:   Sun, 21 Feb 2021 05:40:31 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 15 Feb 2021 17:28:17 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.12-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5d99aa093b566d234b51b7822c67059e2bd3ed8d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
