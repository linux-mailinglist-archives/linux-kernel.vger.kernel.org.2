Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1D3D4435B9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 19:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235121AbhKBSkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 14:40:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:36402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235128AbhKBSkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 14:40:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 8C99A60F90;
        Tue,  2 Nov 2021 18:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635878250;
        bh=QpxY/uns7tQK5EXcdc/OiRfBOqwtoDAAxJlS+tca5nU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QvvkBJ2t3/rm2HEgM5rLJesmGZZxeFwaiP4Obzbbig/ebJkWmBkGBDxBXrxnkm1gL
         8cP3J3wCLF2wmZLzfZXWrLcypE8o1lwsn5zyJN1z/BChdFHu8GDlSdk/TCTkXnm2iw
         RmfR8J9a89VmjxhuDXM2Icdso/MvdwD2hFN+RSQhn9EH/v2w6CMukuW+EavPq9r+xv
         7NEwRhd844aqMES52mItA/x2G2yFpseGix2EnyfaTteaR6pfJY4WOns2WgAqGjhweR
         CpRIelt2u4y/pezGu2FUMyvKq5zPgbsnQpgelCptdANJiOht/21wQQD5ILadbGmUPj
         t9gce5p6Od7iw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 861F660A3C;
        Tue,  2 Nov 2021 18:37:30 +0000 (UTC)
Subject: Re: [GIT PULL] printk for 5.16
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YYEZeIVxrp8MJ/yb@alley>
References: <YYEZeIVxrp8MJ/yb@alley>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YYEZeIVxrp8MJ/yb@alley>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-5.16
X-PR-Tracked-Commit-Id: 40e64a88dadcfa168914065baf7f035de957bbe0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0aaa58eca65a876c9b8c5174a1b3ac23be6440ad
Message-Id: <163587825054.14475.11193399961487963007.pr-tracker-bot@kernel.org>
Date:   Tue, 02 Nov 2021 18:37:30 +0000
To:     Petr Mladek <pmladek@suse.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 2 Nov 2021 11:56:56 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-5.16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0aaa58eca65a876c9b8c5174a1b3ac23be6440ad

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
