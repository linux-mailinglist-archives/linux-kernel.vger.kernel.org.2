Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 459B43BAEB3
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jul 2021 22:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbhGDUMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jul 2021 16:12:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:60612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229876AbhGDUMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jul 2021 16:12:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 26FE5613F6;
        Sun,  4 Jul 2021 20:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625429386;
        bh=5BImdNvHQdsnGZjF812rdg8IEAism2bnlc4ti3nIlHA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ARksApKw2ZpKMOhpTnego2txO9nfhLsa7UYB6aKfmjBSdPo6JlEhPYvyovI4ageST
         OMfGBws56Q27UsH4utL2DE6gdmMrvG299jCHkw2RT6FiRuFd9dXlB8TJU29eHFPzFB
         H3+VnJc62EZZ4BvQaIu9r+WlbWdz1ATTak8TuqiSbISDDeva1JegSBg1v7nb8b9+eQ
         Me6LVeYuByxD9h3FI3gZkNdxjsKPCyhm/0M6fRA7nfIEY+HcQPrXPZShxnw9jQz3C6
         0lLUX7sNonsQrYP/tBApAx62VGDfvk5EB84lLX8eas4yr/JRQprnWPY+Y9Av8A8lVY
         8Iqtj10hKwzgQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 1E25F60A38;
        Sun,  4 Jul 2021 20:09:46 +0000 (UTC)
Subject: Re: [GIT PULL] memblock, arm: fix crashes caused by holes in the memory
 map
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YOHO05xJAVItsYsg@kernel.org>
References: <YOHO05xJAVItsYsg@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YOHO05xJAVItsYsg@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/rppt/memblock.git tags/memblock-v5.14-rc1
X-PR-Tracked-Commit-Id: a4d5613c4dc6d413e0733e37db9d116a2a36b9f3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a412897fb546fbb291095be576165ce757eff70b
Message-Id: <162542938611.15409.11903756258889427744.pr-tracker-bot@kernel.org>
Date:   Sun, 04 Jul 2021 20:09:46 +0000
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Tony Lindgren <tony@atomide.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 4 Jul 2021 18:08:03 +0300:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/rppt/memblock.git tags/memblock-v5.14-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a412897fb546fbb291095be576165ce757eff70b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
