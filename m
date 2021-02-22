Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A651632200A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 20:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233267AbhBVTXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 14:23:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:50578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233017AbhBVTQa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 14:16:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id C7D0A64E32;
        Mon, 22 Feb 2021 19:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614021120;
        bh=I/Xh/FA1M3Bm5vbT/IOVO74+snpT3QhPzryyrzo0HJo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=rKJ51AwPF5smzg17AEg0M5njcaFbA289Gad6aC/uybp2Afu3mCfoAvewgVm+gX57D
         9dS3WDTqqjP8WjHMs6Ys71H/wGX7LDI4Lc5rm79vaDdAc3Od5Nyvw+XmNlG4NHHPyp
         5yygvq7LT5dcYd/+KEBq46IrcL4EFudyZsQA3smMUGupo4KiNWJIpf1nbAeVvd9Kuq
         /H6zPKgk92hlsXSMCo+fgaZTf0p6pzzfoiN5r1iSCEzQxN257g0iHlES378v23X4ki
         S2L//AATMfRNah2S9rTTInxWOmuxaNIQRQS8eUIcTEJ0kQUEdhTpg0s34GdhcZ7Q4c
         /7dtcIMqmL9Zw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id AF0CF60963;
        Mon, 22 Feb 2021 19:12:00 +0000 (UTC)
Subject: Re: [GIT PULL] printk for 5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YDOy7NcXzfCJcPXw@alley>
References: <YDOy7NcXzfCJcPXw@alley>
X-PR-Tracked-List-Id: <linux-mm.kvack.org>
X-PR-Tracked-Message-Id: <YDOy7NcXzfCJcPXw@alley>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-5.12
X-PR-Tracked-Commit-Id: 16182ac1f02c8a5fc9753f9b8b5f3ef8c01707d8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b2bec7d8a42a3885d525e821d9354b6b08fd6adf
Message-Id: <161402112065.16114.1888500204452719345.pr-tracker-bot@kernel.org>
Date:   Mon, 22 Feb 2021 19:12:00 +0000
To:     Petr Mladek <pmladek@suse.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 22 Feb 2021 14:35:08 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-5.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b2bec7d8a42a3885d525e821d9354b6b08fd6adf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
