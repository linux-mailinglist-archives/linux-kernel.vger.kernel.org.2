Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA3E5326A00
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 23:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbhBZW0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 17:26:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:56362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229989AbhBZWZS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 17:25:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id D2FA664F14;
        Fri, 26 Feb 2021 22:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614378255;
        bh=fEFdOzL8wap6Sr2/AAoWMszfm59GcHFI2o4as6ZOtLA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=VJj5sO7ETeBXWhOf4FvYzx9/WpZpwvpRMrfNIJ8JRS+xHUj10tRI/6mP6zG8bjc2t
         cYAwM65fKNJ24dL2NMudVnT4g+7o6F3xJmTRhsy988b2jZYzJlon6OieViwYQl2scW
         LnV90aTtauZUy4g31KruXM7uZ/3D4eGMfdjjG4xX8CkpixdwIxN8PBcw/TvSGDmog7
         /7L+BRgZ2ABt/4xeYk6lyFlrqg4jTa2QPlh66g4HspMQk7daBi0oIZ69UhqAsRDSxF
         mziphdhytTcp6uH6JC1u74aqr+lBgbSI9EDzr0FPXnjEOvj4rbiBk0CyCuHMtcxYit
         dCWUd3MZsUXcQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id CCF27609D0;
        Fri, 26 Feb 2021 22:24:15 +0000 (UTC)
Subject: Re: [GIT PULL] (swiotlb) stable/for-linus-5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YDkbCHHBUOmfI59K@Konrads-MacBook-Pro.local>
References: <YDkbCHHBUOmfI59K@Konrads-MacBook-Pro.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YDkbCHHBUOmfI59K@Konrads-MacBook-Pro.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/konrad/swiotlb.git stable/for-linus-5.12
X-PR-Tracked-Commit-Id: daf9514fd5eb098d7d6f3a1247cb8cc48fc94155
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ef9856a734af9bc71e5a8554374380e200fe7fc4
Message-Id: <161437825583.23821.11288444776785621159.pr-tracker-bot@kernel.org>
Date:   Fri, 26 Feb 2021 22:24:15 +0000
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 26 Feb 2021 11:00:08 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/konrad/swiotlb.git stable/for-linus-5.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ef9856a734af9bc71e5a8554374380e200fe7fc4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
