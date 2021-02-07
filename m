Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9234312732
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 20:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbhBGTXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 14:23:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:34570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229491AbhBGTXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 14:23:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 99861614A5;
        Sun,  7 Feb 2021 19:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612725789;
        bh=msh9b6gLp5g+4J4ZMnBvvfjYMhDNUKmW83TLyiQU/pg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=L4MYpxKvO/07DIedD1PTFzhgv4K0ApU/HyRSIxdKFW4N4K7srFu2NvmJW4mNSxIwc
         ay9ThT6/vC04OSU0GQnr/RZXL5XVRwyJ+wbXrGJdo3KX3cxKvzzNAdV449nkgqzZdP
         h9GL2bHJ0DMn8q6nLyuYnPHxlhpBcbHvpZJox7w6sYhwAxGzq0rKhh3SGPztDeJv7y
         Zrfu6SgXtgckO7NMZJDClrfKJuLxpAYdc8tVQrr7aARsNWf2piQfmGLdAVh0396sbv
         CmXoa4smgr7LE+qi2qwVNtuSiG4x7XIG3Pxbd0QVO7eS33P9i/V7dORQp9SH+w+h5j
         EKw4UzOGLv+CA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 852DD609FE;
        Sun,  7 Feb 2021 19:23:09 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping fix for 5.11
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YCAUnVvH3rA24ZCa@infradead.org>
References: <YCAUnVvH3rA24ZCa@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YCAUnVvH3rA24ZCa@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.11-2
X-PR-Tracked-Commit-Id: 9f5f8ec50165630cfc49897410b30997d4d677b5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ff92acb220c506f14aea384a07b130b87ac1489a
Message-Id: <161272578948.18997.5094577277878785721.pr-tracker-bot@kernel.org>
Date:   Sun, 07 Feb 2021 19:23:09 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 7 Feb 2021 17:26:05 +0100:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.11-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ff92acb220c506f14aea384a07b130b87ac1489a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
