Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 431E8320E2D
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 23:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbhBUWDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 17:03:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:48976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230288AbhBUWDJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 17:03:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 1F3F364EE0;
        Sun, 21 Feb 2021 22:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613944911;
        bh=ead7r2hcu1SPttI/kAhAKS9H4EVXgGhmWeMXsX6WnjY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=kDCX7cUCQChVjw3Ai6WDG6cZgDVcfhovlYZKrrIC8EnMvHFReLoqKuAb9gOCLQaba
         1s0uiCRFzSuu08IVxTVxZv1bsw5cd7bfxF+ptbTAJjTMkO3eKNOVR/6d8SzVpYPLCU
         Qgy3O9+6A+80gE4UFue5Ne22BfltfXSlT5zrS3cbzLUOl/vshvu9pgUOwkjfYARVar
         ljdp9wNeWjVIni3w5scUsrJBYpN8FB0SmP6i8NSBtJBiG/l5Xj7ag0UZlGnw5JMiam
         rpRiQyGI+ADr0Gx3Ilf6oY4RMLZzjvIZ/w25nPietqXs8vD3T8arT2LZi7qmLHx4U1
         ycj4lPrARWJ5g==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 1B0B460191;
        Sun, 21 Feb 2021 22:01:51 +0000 (UTC)
Subject: Re: [GIT PULL] JFFS2/UBIFS and UBI changes for 5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <2079847149.14899.1613937734472.JavaMail.zimbra@nod.at>
References: <2079847149.14899.1613937734472.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: Linux MTD discussion mailing list <linux-mtd.lists.infradead.org>
X-PR-Tracked-Message-Id: <2079847149.14899.1613937734472.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/for-linus-5.12-rc1
X-PR-Tracked-Commit-Id: 42119dbe571eb419dae99b81dd20fa42f47464e1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 66f73fb3facd42d0a7c899d7f4c712332b28499a
Message-Id: <161394491110.8676.13685988086312540707.pr-tracker-bot@kernel.org>
Date:   Sun, 21 Feb 2021 22:01:51 +0000
To:     Richard Weinberger <richard@nod.at>
Cc:     torvalds <torvalds@linux-foundation.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 21 Feb 2021 21:02:14 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/for-linus-5.12-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/66f73fb3facd42d0a7c899d7f4c712332b28499a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
