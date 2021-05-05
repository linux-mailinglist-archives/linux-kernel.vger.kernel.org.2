Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 664B5373385
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 03:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbhEEBSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 21:18:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:59298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231822AbhEEBSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 21:18:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id F0376613C4;
        Wed,  5 May 2021 01:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620177429;
        bh=FqlzZPpO0Sup6WQF/MP9sdmkrnH6+QkILTYxQZy1ErI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=dtWcAWm5RiuxZZDI/731vBpx2InjqBNNbLA1Eho3FfDGBzYsPLr/fs+RfoYnh6lSJ
         K0F0uX0Y7Qy/rxPg+ZaxMv3g8S/CCGzQijUjAoy96YBvLF19OQv+rPnLtQRr2LZxnX
         gXhJ+nGpoJV7HY/nM/iat5gpX2GwWt/JL+cccG76a4HUN35DCEWGeOSjz4YVgh0s4R
         m0PPytuW4KX1zziYuE/H/TYaPZwsIlt6t/DE6i5wZ1RKhBEbxo2gFuipYNL6C3klbh
         aXLUyWU+JJE2RnNkm6VFz5UNNsMPAYCVLDHfnAiuBsMDeJGc77oU1JosAwxgNm1NAr
         t/t3pOtOnjyiA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id E89BD609E9;
        Wed,  5 May 2021 01:17:08 +0000 (UTC)
Subject: Re: [f2fs-dev] [GIT PULL] f2fs update for 5.13-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YJCGSeyA7XoNcyZT@google.com>
References: <YJCGSeyA7XoNcyZT@google.com>
X-PR-Tracked-List-Id: <linux-f2fs-devel.lists.sourceforge.net>
X-PR-Tracked-Message-Id: <YJCGSeyA7XoNcyZT@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-5.13-rc1
X-PR-Tracked-Commit-Id: 9557727876674893d35940fddbd03d3b505e7ed8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d0195c7d7af6a456c37f4b4b2df5528f10714482
Message-Id: <162017742894.16566.9409108512793318888.pr-tracker-bot@kernel.org>
Date:   Wed, 05 May 2021 01:17:08 +0000
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 3 May 2021 16:24:57 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-5.13-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d0195c7d7af6a456c37f4b4b2df5528f10714482

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
