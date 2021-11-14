Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2235844F9D4
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Nov 2021 18:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236277AbhKNR4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 12:56:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:35500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236157AbhKNRze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 12:55:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 5D5B661027;
        Sun, 14 Nov 2021 17:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636912357;
        bh=B3Z9rAHL2B50JJYtsvY8HBlec4By9dSHxAPLGzufG0k=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=idyOYq9iwARTHzjWb5Dtot4F7ZjhH3/t5BYgzAge2LCyvvDHccRz64DMJfeioOPl+
         FbdWDCwnA6K5GX+l/0T9Y7aHtf2rTmh19vvRNIVFUhPvwyNYX1CEmkUM0vCFLDh6m5
         iRvlhq5EHFVH7eEhVXxSR/Qjp6dDVpckPoRhZ9MXjzPa160/T4+2Alud7SAZOUMOgm
         33e0IICPEpW8kzpXti1TdC9ENq0vXnFShgf5P3LdEiNxixFP/6VBWTXbj946mhdt7S
         RAKu3W1oRJg6jByF+9wD8FyqxR5HTEEUG+JC+WuBOQTgdx7CXQPCm5rCa7lFPaqHV1
         R2bnkJCj8jxGA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 57B5F609D7;
        Sun, 14 Nov 2021 17:52:37 +0000 (UTC)
Subject: Re: [GIT PULL] perf/urgent for v5.16-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YZDnxpLswv1HwBaz@zn.tnic>
References: <YZDnxpLswv1HwBaz@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YZDnxpLswv1HwBaz@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v5.16_rc1
X-PR-Tracked-Commit-Id: 4716023a8f6a0f4a28047f14dd7ebdc319606b84
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f7018be29253b89175d03284f8f49ac4ffed0472
Message-Id: <163691235735.31405.14996335258402373786.pr-tracker-bot@kernel.org>
Date:   Sun, 14 Nov 2021 17:52:37 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 14 Nov 2021 11:41:10 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v5.16_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f7018be29253b89175d03284f8f49ac4ffed0472

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
