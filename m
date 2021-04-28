Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 511C236D034
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 03:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236229AbhD1BSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 21:18:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:51834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230368AbhD1BS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 21:18:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id B377260FF1;
        Wed, 28 Apr 2021 01:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619572665;
        bh=hOZO+SPnyFvxLtuAUwDP9fN1YkgG5DsxCWBygsBLIZM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HE9+KAFPA0K6a6elYIM+R7J7mNtARTcdZUSANd55RVZG82wYRL8Vflsqbsb2BB6tl
         SFFqIFDoc5GG4Rw3HJX7okvUho2nASa5Y0LYjIsXZEoOF+Vick9i2HNn22gGlPIEw0
         f9tctUMrW90FccvVAS0htpDQeLy+LUKehLpc6ikIGkUtthq7Onjf101WLt+WCDF50J
         PcB9cUqttPE39lEFpxTdKKXL9oW97cLtOkmt3aQK5rmfEfA346d26nsQeIuWGlGoHp
         dZGYAa2HMPYIawXaTD4w+xIf9GTEjW7pNATpfhdLbdqcWbZHFo1uTfOJfcTpIVKtLY
         2Gx9Yi7Y77bGQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id AD66860A24;
        Wed, 28 Apr 2021 01:17:45 +0000 (UTC)
Subject: Re: [GIT PULL] printk for 5.13
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YIgXasI86BwJvQ0Z@alley>
References: <YIgXasI86BwJvQ0Z@alley>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YIgXasI86BwJvQ0Z@alley>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-5.13
X-PR-Tracked-Commit-Id: c8dbea6df351df211216b5f8877b020f21ecf75f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7f3d08b255d1806502e45fe70ca2ba9646eb3aa1
Message-Id: <161957266570.1632.8354892507095477863.pr-tracker-bot@kernel.org>
Date:   Wed, 28 Apr 2021 01:17:45 +0000
To:     Petr Mladek <pmladek@suse.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 27 Apr 2021 15:53:46 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-5.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7f3d08b255d1806502e45fe70ca2ba9646eb3aa1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
