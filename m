Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B70B391D00
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 18:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234464AbhEZQ1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 12:27:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:38388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233629AbhEZQ1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 12:27:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 65343613CA;
        Wed, 26 May 2021 16:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622046345;
        bh=Rff+s8/qGL0bds1Gbre6PZ59RBghMMXlEuvk+nlSSdI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ZqjkQgwQOWyvZhOQEHhxS46apV0YVyRhNEzXFD3M6HZUZe2iixUdK1XIVj4T3UMi5
         oOrG5S6UIWH2Et4K2xv5/6eZc6ALcIJlnnQCHJhkNixpm25/epZneNoazLEa4HQfZN
         6G4QgvBQh6CfKqEVjXo7lVlivIpK/pgljYkzW6VDexvEWQU6XdxHBRQAMWjNVMRZm1
         ApGR8f9EBcHS+JSNvK+RZQGFWSjPAWQPF8jq/oXF//hoPrUl7V/YYVVMEabwFGLg6t
         GheI6x+WghY+KHu+qNWtlxWmq0o8v81ajbUYkXM80CXc2XPi1MfRDvKwIhUFzms5Dz
         AmR0Bh++kuNkw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 4A6AA60A16;
        Wed, 26 May 2021 16:25:45 +0000 (UTC)
Subject: Re: [GIT PULL] mtd: Changes for v5.13-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210526175924.4f9ab124@xps13>
References: <20210526175924.4f9ab124@xps13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210526175924.4f9ab124@xps13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/fixes-for-5.13-rc4
X-PR-Tracked-Commit-Id: 562b4e91d3b221f737f84ff78ee7d348c8a6891f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7ac3a1c1ae5152e1d18cf6df5b6c3c9847535e78
Message-Id: <162204634524.25444.1664185134093644010.pr-tracker-bot@kernel.org>
Date:   Wed, 26 May 2021 16:25:45 +0000
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 26 May 2021 17:59:24 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/fixes-for-5.13-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7ac3a1c1ae5152e1d18cf6df5b6c3c9847535e78

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
