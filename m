Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9183D38202C
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 19:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbhEPRVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 13:21:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:57732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230103AbhEPRVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 13:21:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id D44C561152;
        Sun, 16 May 2021 17:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621185603;
        bh=5lOjwH2z46TugIK+WkNs76901KMjjXkpXmBfZ3tC7ZY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jhkz0ARq/U38TIcbkU1HOLSF1wvoQdD+oBVdZm6RUQMc87U3D0KcXM6c2mpN+4jcR
         Qvn3p44VZRODeqiRz6fLbfGba7tV+59dj+dmkeXdjRMAvJtBluncH2lFb1KqsCkWBL
         0XDgRrX+4cXezb2uiqMIQ/AVcpptH0FwucT2YKOsYQc8K2fErwHjTl3c6RxdSNLshV
         GTzhWepMSOY1t/ImaO/JvUFe5tbdIVgatR0IHWn2Rz2rdwHNcpJChjFzYNUD7hAS76
         xyjtWSOt3/XirqepIbXr2TEBVP4jjT3vpeIlH/sKHNwazYOVNLY74U7w1Azyr7gZl1
         xl3MQFVEXf1Sw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id C926260A4E;
        Sun, 16 May 2021 17:20:03 +0000 (UTC)
Subject: Re: [GIT PULL] Staging/IIO driver fixes for 5.13-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YKDfI+xY2SCpC4Ot@kroah.com>
References: <YKDfI+xY2SCpC4Ot@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YKDfI+xY2SCpC4Ot@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.13-rc2
X-PR-Tracked-Commit-Id: ba9c25d94dea1a57492a606a1f5dde70d2432583
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6942d81a8faa17d44d1286b63ccb7d920b29d065
Message-Id: <162118560381.27926.6986980324945803244.pr-tracker-bot@kernel.org>
Date:   Sun, 16 May 2021 17:20:03 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 16 May 2021 11:00:19 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.13-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6942d81a8faa17d44d1286b63ccb7d920b29d065

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
