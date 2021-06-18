Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 696A43AD2DB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 21:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233957AbhFRTct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 15:32:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:37000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233581AbhFRTcd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 15:32:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 42C7A61279;
        Fri, 18 Jun 2021 19:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624044624;
        bh=Pl3fd+zhAVxKxIcpfO/lvsnFa+vN43WOInnXgCWlgvA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=AJPFDv+0hNHog6DnBzoBrZr/iZj+t6AhaakIr0LTfbhxqxZIcoTdXte2SXJqGcYm7
         /Ds5UpgwWRGTTh0OSDh5sYZvF2tvWQGPYUojE5DAPZZh5MpYQDOE3i63csbF+Gw3HV
         MwpANZWfuMG+Junt4K4tBFBNNgZZxx3vmHHBAAhdYVTUBTct6BThn4Lw5wRG9zBrVq
         LUlU/CYJRLT/QAYKEbD+ou4/W+UoLxnGak58l8EjZGfPQ69xZ6fVay+5jU6wgzXSCO
         QQY56/H5vMT8x/WqWL7Y7JYmGpHinitF+QUmkGQFZgu1YtZbyJPxGBfplmAxmOW+d5
         81BEzIzontdlg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 36862609D8;
        Fri, 18 Jun 2021 19:30:24 +0000 (UTC)
Subject: Re: [GIT PULL] ARC fixes for 5.13-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <f29fc4e4-77ca-f026-eb1b-c82fab8bb30b@synopsys.com>
References: <f29fc4e4-77ca-f026-eb1b-c82fab8bb30b@synopsys.com>
X-PR-Tracked-List-Id: Linux on Synopsys ARC Processors <linux-snps-arc.lists.infradead.org>
X-PR-Tracked-Message-Id: <f29fc4e4-77ca-f026-eb1b-c82fab8bb30b@synopsys.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/ tags/arc-5.13-rc7-fixes
X-PR-Tracked-Commit-Id: 110febc0148f8ab867344061d5cf95ee1e1ebb3e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b1edae0d5f2e79e2bdc523c1459f8c52ad26485f
Message-Id: <162404462420.17995.2302276550956275328.pr-tracker-bot@kernel.org>
Date:   Fri, 18 Jun 2021 19:30:24 +0000
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 18 Jun 2021 17:18:30 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/ tags/arc-5.13-rc7-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b1edae0d5f2e79e2bdc523c1459f8c52ad26485f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
