Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7EE44F504
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 20:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236067AbhKMTrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 14:47:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:60092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236053AbhKMTrJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 14:47:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 1CDD961056;
        Sat, 13 Nov 2021 19:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636832657;
        bh=SOohovcpMYj76l5StA5OySttoJ9fEJLI96EwedJXHXQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=E1xbLlzgg9V9w7H4b3rHUBD0kGD/hCJ0jNun9af1DGyCIwyKmPX1Io0u8g+6KopJy
         JwKWf1IsqAz8NB5/OqSt7TxEY34PRGhMa9JzeHKZbBXWHYJ2ZVrjX7FXlmc1Czql/a
         zTtsNoteWgsERSFQFQ+re32O+AMxOnfxAa1WW49727ApT5v9ZywtLccZjCUVUV/htQ
         Ehq1UUBX0Pe1pv8UqpYua46bulUL6EKZsnE2SEkoWreUvhxoZVYwAgzaPYKbU2kizU
         vBs0OAJI9ci+2Dg9or6b7QSzmdQNhCTGh8uh/ms7ukSzsF7x/pLS++nTV+lPZjM/KD
         o3HKoy2hfT9Bw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 16A4A60721;
        Sat, 13 Nov 2021 19:44:17 +0000 (UTC)
Subject: Re: [GIT PULL] erofs fixes for 5.16-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211112151303.GA28430@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20211112151303.GA28430@hsiangkao-HP-ZHAN-66-Pro-G1>
X-PR-Tracked-List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <20211112151303.GA28430@hsiangkao-HP-ZHAN-66-Pro-G1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.16-rc1-fixes
X-PR-Tracked-Commit-Id: 4c7e42552b3a1536f3cdf534aba8c4262ee26716
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a27c085874caf1a2d944bc0acc4b4ee76ffa9296
Message-Id: <163683265708.24678.6013028869466264092.pr-tracker-bot@kernel.org>
Date:   Sat, 13 Nov 2021 19:44:17 +0000
To:     Gao Xiang <xiang@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        Yue Hu <huyue2@yulong.com>, Liu Bo <bo.liu@linux.alibaba.com>,
        Miao Xie <miaoxie@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 12 Nov 2021 23:13:06 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.16-rc1-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a27c085874caf1a2d944bc0acc4b4ee76ffa9296

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
