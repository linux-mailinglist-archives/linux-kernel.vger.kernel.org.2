Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC304420369
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 20:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbhJCSWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 14:22:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:48692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231408AbhJCSWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 14:22:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 4C49F61A35;
        Sun,  3 Oct 2021 18:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633285248;
        bh=4yWtlucJjoJNcrLie1jJSwgNYw5oTvI9q/XSqjKjVF4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MOch9ftZoKK0NkIm/q8TsdavBkJI4BKm51eCJwB4z/1gCz/ZHqi8Oto8nF2ZJkYoy
         EzryzrYBggZjXbnYLPibodBIyssYao2se7ONewsUuwDj0sIvnCtwuh9EzZDzILsyia
         cEv0rWvsyiiUtKDigI0SMAnOYUh9Qnf1qRrYTpEZM7aVyt67d8PmAHxP+9IHsa38QG
         RY+VWfP+A3Bu50c4HlZbncx2Z9iIW5xYqA6JqGakbIka1hEyCVAJXCLapUdMN0NIYc
         3ESEnIEYtCiVoHJKPulSFd5C5Jzv67tsq/FyhA8rkM8rgqAyfHBunBMsAKmirD3Are
         sVa1aeWaIAVIA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 419BA600AB;
        Sun,  3 Oct 2021 18:20:48 +0000 (UTC)
Subject: Re: [GIT PULL] Driver core fixes for 5.15-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YVmDByRt0G36h1nC@kroah.com>
References: <YVmDByRt0G36h1nC@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YVmDByRt0G36h1nC@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.15-rc4
X-PR-Tracked-Commit-Id: df38d852c6814cbbd010d81e84efb9dc057d5ba6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 84928ce3bb4e20ec7ef0e990630a690855dd44cc
Message-Id: <163328524826.23868.16072687246699723966.pr-tracker-bot@kernel.org>
Date:   Sun, 03 Oct 2021 18:20:48 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 3 Oct 2021 12:16:39 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.15-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/84928ce3bb4e20ec7ef0e990630a690855dd44cc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
