Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1539320DBA
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 21:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbhBUUy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 15:54:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:42448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230375AbhBUUyZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 15:54:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 30ED764E09;
        Sun, 21 Feb 2021 20:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613940825;
        bh=Vapo5YunR6TOV9nUkqyeU4ui1c1Ol7cQWku43RD0VHI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=BsMiQSSk4fO+6Jo0B2/z3DCBD5YJESNveeOMUiWTv25grhd7u9ljZtMbKQiqRKxPE
         rdgD+GDp/RGKlA3VyMF25x3N+LAcjF0PyTD5Nu7Sroc/wmQs88fuMYCAO+e//q0x3X
         z3IVEYzJDqt0Q9AeYVrUQvszcObJzAapgf6b1yFYjUAHtR19rtj6IRzp/oFFHWASrg
         ZKdNpbZvwESJRMgB2HQf9OpCbysFulR8/bnT5SwGv/I/o5v4EN+ohDHIPyQ7mEl56X
         vz0tZhndNgHFeLecrDAq1lqj0qb3IZY3HbQGodIBVe+J6VqI5BQQYE53M8U4jZzTGB
         r/ZjB4oCixnZA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 198A760192;
        Sun, 21 Feb 2021 20:53:45 +0000 (UTC)
Subject: Re: [GIT pull] irq/core for 5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <161341798844.14643.10479841258453089369.tglx@nanos>
References: <161341798844.14643.10479841258453089369.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <161341798844.14643.10479841258453089369.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2021-02-15
X-PR-Tracked-Commit-Id: 0b6d70e571a1c764ab079e5c31d4156feee4b06b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b5183bc94b6d2789abb9b5eda6cc3e0601524c79
Message-Id: <161394082504.25590.11690072754690453953.pr-tracker-bot@kernel.org>
Date:   Sun, 21 Feb 2021 20:53:45 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 15 Feb 2021 19:39:48 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2021-02-15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b5183bc94b6d2789abb9b5eda6cc3e0601524c79

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
