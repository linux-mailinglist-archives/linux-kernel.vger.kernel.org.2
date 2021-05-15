Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4EC381A51
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 19:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234301AbhEOR40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 13:56:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:43090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233372AbhEOR4Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 13:56:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 1B8C1613C3;
        Sat, 15 May 2021 17:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621101303;
        bh=2VnbhHrSaPmxzFK2MVV+L+5r6o1iBeSvmQ7ab90CtBI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=o7HBCgR7QYXI72NgqtIPUi9SI4RQcG6gH8fwW8vfnb5L8UYq+pzuVQMOcEoUTT1c1
         rbHReyyR3k5bUNvenCJ6VAUBYxN9rBsPXLLsz2G7vMUx6+6aS2x+nG45Z3Rm2gOZFz
         JqJPvUdnbGMPNmOOVfLlPavRGXSmvgY3vdcIFHD8J8GMG+Kp/Q1vec8OyrwN5HBNXt
         GFUubWxz7Xx7TiZmTBGvqvfq7FQsrQ3HlKLDoSah81b0Cg6etd1S0Fup6v65CP2JbL
         9e2SaXj0OnkRDhaVFgj8AY2I+Bcz4/hxvloaH6Mjz4owGoCBCnfq1Zdwug9blyI7Pv
         LtwTuZjJTjNAQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 1300B60A47;
        Sat, 15 May 2021 17:55:03 +0000 (UTC)
Subject: Re: [GIT PULL] IRQ fix
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210515074413.GA81426@gmail.com>
References: <20210515074413.GA81426@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210515074413.GA81426@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2021-05-15
X-PR-Tracked-Commit-Id: 0d3ae948741ac6d80e39ab27b45297367ee477de
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 077fc64407457d504882a7ba8c3348df4dea8042
Message-Id: <162110130307.14651.11512332227328227526.pr-tracker-bot@kernel.org>
Date:   Sat, 15 May 2021 17:55:03 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 15 May 2021 09:44:13 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2021-05-15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/077fc64407457d504882a7ba8c3348df4dea8042

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
