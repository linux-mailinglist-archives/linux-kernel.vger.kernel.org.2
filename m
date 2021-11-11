Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2395944CE4C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 01:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbhKKA2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 19:28:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:39904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230311AbhKKA2q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 19:28:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id B704661260;
        Thu, 11 Nov 2021 00:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636590358;
        bh=fi4PjPJa9+8ZnwaBOSoJASFbQ3TU/31uMVNuOR6tPJc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=G5QqzLTXZtcnP9yovEvRsLG5ZJfp6P8rTdiC5Y4rV7JOU6RG6s4vypC+2BoPH36sU
         UmW8wCfFpwVzRdGsQXofUZkh8V9qDlXvCCFoFoOQQ1bw42Jl/zgWsNesmx1rCK/SWl
         zjqIt685lgsczf9HInE37c5XKOKS1/x56njn8dnyZWU9xvbmbewXuAzSd4Rrk48Pjo
         szZT5tbGAjrvjIFruD1pgI2B+OCvhQZDb88QG0O6PSsaaB6dguDxdFfLqpxPNwrYhY
         pnOf1KWzDovaHBGIB/y6Aa0VZ4+sYWQkm/cu1luWFG0Yms6PXnxtxF7Ne4ulNkecBV
         DGKLfQWGK5PZQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id ADE2260965;
        Thu, 11 Nov 2021 00:25:58 +0000 (UTC)
Subject: Re: [GIT PULL] prctl updates
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211110145526.1968029-1-brauner@kernel.org>
References: <20211110145526.1968029-1-brauner@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211110145526.1968029-1-brauner@kernel.org>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/kernel.sys.v5.16
X-PR-Tracked-Commit-Id: 61bc346ce64a3864ac55f5d18bdc1572cda4fb18
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a41b74451b35f7a6529689760eb8c05241feecbc
Message-Id: <163659035870.13025.10652688899400952167.pr-tracker-bot@kernel.org>
Date:   Thu, 11 Nov 2021 00:25:58 +0000
To:     Christian Brauner <brauner@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 10 Nov 2021 15:55:26 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/kernel.sys.v5.16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a41b74451b35f7a6529689760eb8c05241feecbc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
