Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 110BA3F9D21
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 18:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236588AbhH0Q5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 12:57:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:41762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232971AbhH0Q5s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 12:57:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 91C3660EE5;
        Fri, 27 Aug 2021 16:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630083419;
        bh=Q8zwkwLqtXiNvZunBJnRbGrIJomhuTUqV5oBqM87gYw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jDfGmeDU3+jbAvAwXSZJ/n+ZLsVqBjuxnsuwjhAbXtT/RmPxbc3LFa+b/cd8tqTmR
         O+T1Bw1aOyxepLlsL70i5yS/kUbbqX7ZbBselR5AC1A4u8ykVSls8/Q2oBdtemh1KW
         lK6xM1auqht5CvlvqoZoaD0z9foOKGyecovN8cjdVVJhK8QaG4cx3F3V9tWbLce4+c
         OMOiNGfbHiVtbHy4WgYc39P7P5VTn+Ehnm8onPbzkfv6zgSMUBgiEHg3YEXr6HELJ6
         1hMvAZr+5Fyodk/WvFJD/TYaWYZFtifOFGkMgLYmeQjwNEZRq7cUWNF8mUizTacTdi
         kwnZqwGZgrOmQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 8569F60A14;
        Fri, 27 Aug 2021 16:56:59 +0000 (UTC)
Subject: Re: [GIT PULL] MMC fixes for v5.14-rc8
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210827144404.504978-1-ulf.hansson@linaro.org>
References: <20210827144404.504978-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-mmc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210827144404.504978-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.14-rc7
X-PR-Tracked-Commit-Id: 885814a97f5a1a2daf66bde5f2076f0bf632c174
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1a6436f375129a96adcc492013a466b934fcad79
Message-Id: <163008341948.31998.9462933030834600351.pr-tracker-bot@kernel.org>
Date:   Fri, 27 Aug 2021 16:56:59 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 27 Aug 2021 16:44:04 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.14-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1a6436f375129a96adcc492013a466b934fcad79

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
