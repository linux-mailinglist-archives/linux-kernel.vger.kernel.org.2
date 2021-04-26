Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCF0236B712
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 18:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234855AbhDZQl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 12:41:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:49066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234609AbhDZQlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 12:41:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id C1BE161289;
        Mon, 26 Apr 2021 16:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619455221;
        bh=G0cLHue0ZarxLycABvwDgcuocOhf/wFZrOH+gkYU13k=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=TMt/cTyQW0GGChR1IeVjv+Yx4YS3csN/nNTcOBRKK70rJ6zYPh28S6zfD3YT9C98j
         zZYcFC8+XxVlEvn4j2QMzUtgks7DoDZc88tSoG9dS8KaCMfhcDSUBbw7YG1OlSrF80
         NiqMTdtVyXQoY4rcBx5HAwr9E4Or1DVzjgHBJ4z5dblQqSZ27tZM3gaXhTjg9du69m
         vH4ZbIC2EKVW3bp6pzGkmiXg8/5Anl1KTNHX/YY/SoGMwT+5NJUWWN1ZCyfne8JOAz
         YI/rYQxnINdQpVpULAPR9kC9dWKIP+maJFcXsXQQu8t9vxvPffeGptJDbrstg5Ir4W
         7jJeBs6hRPW7g==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id BA75D6094F;
        Mon, 26 Apr 2021 16:40:21 +0000 (UTC)
Subject: Re: [GIT PULL] x86/build for v5.13
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YIabtQdmN3LmPWzM@zn.tnic>
References: <YIabtQdmN3LmPWzM@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YIabtQdmN3LmPWzM@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_build_for_v5.13
X-PR-Tracked-Commit-Id: 0ef3439cd80ba7770723edb0470d15815914bb62
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ca53fb2c7c7da99dc51e6c959c84c9b0aca4e040
Message-Id: <161945522175.27394.1859922172678370014.pr-tracker-bot@kernel.org>
Date:   Mon, 26 Apr 2021 16:40:21 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 26 Apr 2021 12:53:41 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_build_for_v5.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ca53fb2c7c7da99dc51e6c959c84c9b0aca4e040

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
