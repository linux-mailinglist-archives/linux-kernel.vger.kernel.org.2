Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B27131B297
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Feb 2021 21:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbhBNU7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Feb 2021 15:59:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:50654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229793AbhBNU70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Feb 2021 15:59:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 98B7864E29;
        Sun, 14 Feb 2021 20:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613336326;
        bh=j3ZyQfQbzeDQswUrtelK8BQP9QE01rydCKXVTpQTq2U=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=VwrST00jJ1UpZoRD61/NLptRfQhqAe3Rjv9lYvCElUbMIPvemS5q6Ap7RuWvaIHCy
         lQyN9XASmF3mV5/szdzBGmbP3smf3s8bTHLVtrWMOYoqCmu8QlxOvWl3NuTa6k342A
         mqjP4TdXBxhHhmPzqGPfiAe9RZJ57TZslWZvlSe28E6TCgwUiwJczK3AheENkCNwQC
         +l3W+bixChVRRYBhMwL5Ry7HGG+erodTGqIXvv9TAF/I8TAfgQSQZ8JgRyDMevfFki
         w6m5vTGGu4CUZDpIhiLaOqFMVf7xUoMyCkP2nIRr1FM/WxmiasDBcsrQjaHqxwDhPy
         hgSAE5UgmHpow==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 8578060A37;
        Sun, 14 Feb 2021 20:58:46 +0000 (UTC)
Subject: Re: [GIT PULL] x86/urgent for v5.11
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210214103414.GA29103@zn.tnic>
References: <20210214103414.GA29103@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210214103414.GA29103@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.11
X-PR-Tracked-Commit-Id: 70245f86c109e0eafb92ea9653184c0e44b4b35c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c553021498640050340924bd62fa580e253467ac
Message-Id: <161333632648.25612.16779176634718949865.pr-tracker-bot@kernel.org>
Date:   Sun, 14 Feb 2021 20:58:46 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 14 Feb 2021 11:34:14 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c553021498640050340924bd62fa580e253467ac

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
