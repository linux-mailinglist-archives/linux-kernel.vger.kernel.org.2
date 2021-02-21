Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A617320CCF
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 19:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbhBUSnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 13:43:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:56662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230308AbhBUSk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 13:40:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 4498E64F06;
        Sun, 21 Feb 2021 18:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613932783;
        bh=kiZ0UhlyMSAINGdIufeE1sLrUYx/zC1STHU0x+Eo+ec=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=rTBMFipcdSmBkFCtZ7iPJW7xSZHUEAg2KIkr/rN4zvDpNDdC6BugI+AvpA4sJf/xQ
         5fGtqCKZ2nFOpS7Fno0N/wK6wgorW4cbnFcm480anTgcWiWGID603GLOoyQhYLvxlS
         fMsL7KY5WoriqG+7Il8PajNUW0qKNzGDztXsHIUTH+xH2+NNSguFxIWJDY0TTpW3VO
         nmtvOUl2CrjiPYciIYgExIuxEfgDsilcwtRuPvkgm9Kpj1W/49bz7oN2s3rSNFnHta
         YmF9xGnhxnCUOWHB7jkS/WwmHPFcoiYNPn0jEqCIqkl/2YY/vDFz0wnmm8lPrxItik
         zLUlft5CJRang==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 3C0FB60967;
        Sun, 21 Feb 2021 18:39:43 +0000 (UTC)
Subject: Re: [GIT PULL] f2fs update for 5.12-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YC18awybSAcVLPbr@google.com>
References: <YC18awybSAcVLPbr@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YC18awybSAcVLPbr@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-5.12-rc1
X-PR-Tracked-Commit-Id: 092af2eb180062f5bafe02a75da9856676eb4f89
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8b42fe123b013fbdc3172616b27d568d0cb9d2d6
Message-Id: <161393278324.20435.8703658147073031710.pr-tracker-bot@kernel.org>
Date:   Sun, 21 Feb 2021 18:39:43 +0000
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 17 Feb 2021 12:28:27 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-5.12-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8b42fe123b013fbdc3172616b27d568d0cb9d2d6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
