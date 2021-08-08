Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0D83E3C52
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Aug 2021 21:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbhHHTBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 15:01:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:43374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232334AbhHHTBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 15:01:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id BCC52606A5;
        Sun,  8 Aug 2021 19:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628449254;
        bh=keaZ6SeoTo65erj+HzJuC6iTaw2hs2XDB2bnTt0Nsfw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GggW28R5KRSWgNvHE9W9VPfj7l38VdbPmCMwUAZZPedVfj7Ae1ZcU69VZIxXqyjcB
         aqPl2Ie29MXNffe7aZgsykmxK0Tbh6CqrXIUJKq4nYx+SUWDW5H3afyj4xdHok0F7f
         +6qJfEIqwvwfqwJsB7idCKG1I02TbMhFIaKEgqtdCEl12azUencVkJuNqMFr1gJcQZ
         PS2T0hqp/2YMg3PaO/SV0OwTXib/8O7cx4AJwZ84mStr/ltIeI16SkMvukCkVqRa7v
         CIyOXUWGnx8xTMfiHrfHBMG24P0T/t5ZupQ8011GCa6PkQ3QMcDJCAqWW+FaWmtAZj
         M4KP6AdqIkpxQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id B0AD160985;
        Sun,  8 Aug 2021 19:00:54 +0000 (UTC)
Subject: Re: [GIT pull] sched/urgent for 5.14-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <162842243640.9524.17249767231918700773.tglx@xen13>
References: <162842243492.9524.2294192686333344509.tglx@xen13> <162842243640.9524.17249767231918700773.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <162842243640.9524.17249767231918700773.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2021-08-08
X-PR-Tracked-Commit-Id: f558c2b834ec27e75d37b1c860c139e7b7c3a8e4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 713f0f37e8128e8a0190a98f5a4be71fb32a671a
Message-Id: <162844925471.12585.13462193023567078869.pr-tracker-bot@kernel.org>
Date:   Sun, 08 Aug 2021 19:00:54 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 08 Aug 2021 11:33:56 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2021-08-08

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/713f0f37e8128e8a0190a98f5a4be71fb32a671a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
