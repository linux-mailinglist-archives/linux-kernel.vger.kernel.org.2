Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB4114071D5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 21:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232909AbhIJT1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 15:27:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:36036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232584AbhIJT1L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 15:27:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 0ABB2611C3;
        Fri, 10 Sep 2021 19:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631301960;
        bh=cHC1slDp5og8XWCZUc4LD3ckqKL5rJE1mc0HqB2fkB4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QPOiFgZLu1LkjKFcyqPMt1bL+19OJVyUzi7/WZbvmuSgmzMUdWfD+JOkvK2PFNIlF
         1nsIYpqYPvMVma460tA04DlsybTtOkxjnqiWtrLsiAJLfRVQNyUyKaJBBxaWZtoYZG
         Q/jyv0UVizQpo5xD+DDietNHB9f9cQ1S3m4KnvcCh4fJV/+WAgs0gqxn1dLpCSfh1m
         6ZDElOWNAVA8arN4NQECraGYrkPS7e5vYVD2hsr1S1gHRZ7DBcRCMlj9ztOeouaIit
         cRbMKC8lop3SYTbpKlSmq7AMX40qybAa8eOwVKY1ycAHvmDQHJ9aMJPc1PcKanjWXp
         Y3c4zOCzvIu8w==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 059FA609BA;
        Fri, 10 Sep 2021 19:26:00 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fixes for Linux v5.15-rc0
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YTt+RAMfjZdchT8W@8bytes.org>
References: <YTt+RAMfjZdchT8W@8bytes.org>
X-PR-Tracked-List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
X-PR-Tracked-Message-Id: <YTt+RAMfjZdchT8W@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.15-rc0
X-PR-Tracked-Commit-Id: 8cc633190b524c678b740c87fa1fc37447151a6b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 589e5cab170843b2f7f8260168ab2d77163d4384
Message-Id: <163130196001.21375.6132090372979009289.pr-tracker-bot@kernel.org>
Date:   Fri, 10 Sep 2021 19:26:00 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 10 Sep 2021 17:48:20 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.15-rc0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/589e5cab170843b2f7f8260168ab2d77163d4384

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
