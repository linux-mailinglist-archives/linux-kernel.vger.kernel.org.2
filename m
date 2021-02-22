Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1545F321EF4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 19:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbhBVSOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 13:14:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:37802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231997AbhBVSNY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 13:13:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 6DAE164E77;
        Mon, 22 Feb 2021 18:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614017520;
        bh=TWlDqxdjAPXK7Y0HwZjmvPBdNDFxLJ5zbrktq7vyzpE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=OS6Cn+sZRkm5Du4WWBK56VbJkCxjitO3M0TMSVVwlWaHyuCP9jmmhXE31LXysyTiN
         Ef19H8u+p8UVhxhAtLGjQOTMipEexNVYcP6xpEEy+bQZn6f3qDCj/c19RyopoumQFC
         bSkJDJQS4fzie/3KsT41eVyPNv9PAwZdedL6nFRgPv3aqBCTeqq/zI1pk9Pa9Ancmw
         9in/UGggcMiq0KXvZL1y7Zu+6vrZlPnZSxcWDVxCnerYR3m+AJpr0m+5FEb4/trdHq
         /cdklajdaKmFQ0IS50DiA1aLVm0KF6Z4io5kTZJ1E++GIUNkPrgzBHxrv9bSgfJmC4
         dp7fA/Xb9l5QQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 6906160982;
        Mon, 22 Feb 2021 18:12:00 +0000 (UTC)
Subject: Re: [GIT PULL] I3C changes for 5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YDL9slBuOqU83/RK@piout.net>
References: <YDL9slBuOqU83/RK@piout.net>
X-PR-Tracked-List-Id: <linux-i3c.lists.infradead.org>
X-PR-Tracked-Message-Id: <YDL9slBuOqU83/RK@piout.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-5.12
X-PR-Tracked-Commit-Id: 5c34b8e7e8bb605925b33e1aa7dc17966811219a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 36c1b20d15703662aa0f14a32a8bd19ab3a33076
Message-Id: <161401752042.943.3286519972663636563.pr-tracker-bot@kernel.org>
Date:   Mon, 22 Feb 2021 18:12:00 +0000
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 22 Feb 2021 01:41:22 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-5.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/36c1b20d15703662aa0f14a32a8bd19ab3a33076

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
