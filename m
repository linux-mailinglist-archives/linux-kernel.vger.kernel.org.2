Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 829E744FB5F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Nov 2021 20:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236204AbhKNT7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 14:59:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:54168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231469AbhKNT70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 14:59:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 76F0960EE4;
        Sun, 14 Nov 2021 19:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636919783;
        bh=iSaxqWGrpbBDnhDlWwcm0yMAT/hKpBkVMJ4X1ZupjHk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=UBsKFZ1QZGu1jwXV++twRVcH3naCJ3KjTtXoJq/6ctuXhfSlTqKkhsyyA75Cmg8Fl
         1ciCjob8S0JJi/+bXg5FZRmgXv4ZN4jmSlL4et357BV2Hka1Oj82spqjOTn48ueYRm
         WDn4pGiSAwLB+9kT4CV3h4YsvaY/HgY5xLf39YpJrPxzMHQthKOLmkkJVYQ6qgyBq0
         MWDB8e2iXSVvz/pOCilhui2UOl7YHwKU1sMaU24MSASmAX31GOMUp4JfxBvipihNBU
         JC1Hk3stbQgTFxInmHkQXuvPL5T7AYKDKvddPYU6OqXHg9woOoPF9J1cP6+VoXy/51
         sjiaAYNDhdAwg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 6A8A6609D7;
        Sun, 14 Nov 2021 19:56:23 +0000 (UTC)
Subject: Re: [GIT PULL] few more parisc architecture fixes for kernel v5.16-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YZFcHM+23JDGpXTE@ls3530>
References: <YZFcHM+23JDGpXTE@ls3530>
X-PR-Tracked-List-Id: <linux-parisc.vger.kernel.org>
X-PR-Tracked-Message-Id: <YZFcHM+23JDGpXTE@ls3530>
X-PR-Tracked-Remote: http://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/for-5.16/parisc-3
X-PR-Tracked-Commit-Id: 3ec18fc7831e7d79e2d536dd1f3bc0d3ba425e8a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c3b68c27f58a07130382f3fa6320c3652ad76f15
Message-Id: <163691978342.22669.4510866585488919513.pr-tracker-bot@kernel.org>
Date:   Sun, 14 Nov 2021 19:56:23 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>,
        Sven Schnelle <svens@stackframe.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 14 Nov 2021 19:57:32 +0100:

> http://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/for-5.16/parisc-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c3b68c27f58a07130382f3fa6320c3652ad76f15

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
