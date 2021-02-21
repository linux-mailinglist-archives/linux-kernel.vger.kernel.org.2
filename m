Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 208DA32085F
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 06:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbhBUFKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 00:10:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:44112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229995AbhBUFH5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 00:07:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 0138164F11;
        Sun, 21 Feb 2021 05:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613883996;
        bh=/FcBmPopVhffM5G84MTbVlA3fOYRIPdRAs7LZDNhoBU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=NeNO851gUFphC0iwNrojyF+4KIk5AebdoRmgKut9J90+HcB3wpjHQigXsyIuJqRzl
         mdi9pVQ4Fx3rHpy65qjq2xmjixwwTQLLN/MC5T5NIz5TXGuR8CFuPP80r5gcHYYO6O
         52WvOvMKOb4UEap9NaVeKOZ+xvnUxLC5sje1EizPLXi0gNrUIjVWrngkRtufvV8jqF
         KUhoVnTMPiz6Uu4wJk01JwGkrcC0egZRZV4stsE+gFhqzcGAr1mgnc0Cy/xgUJEigo
         0r88+0PS0rYghe6/heOz8mo0Ca4UVDwFoPhTBcPqHrwDeNb43Bvpba9T+4lvUapmat
         nLz0Cu1eEtTMw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id EEF2B60A3C;
        Sun, 21 Feb 2021 05:06:35 +0000 (UTC)
Subject: Re: [GIT PULL] x86/misc for v5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210215114132.GH23409@zn.tnic>
References: <20210215114132.GH23409@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210215114132.GH23409@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_misc_for_v5.12
X-PR-Tracked-Commit-Id: 02a16aa13574c8526beadfc9ae8cc9b66315fa2d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 317d4f459393e27b3efedf571bd9e78a23fcd2ed
Message-Id: <161388399597.9594.15910271193600567095.pr-tracker-bot@kernel.org>
Date:   Sun, 21 Feb 2021 05:06:35 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 15 Feb 2021 12:41:32 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_misc_for_v5.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/317d4f459393e27b3efedf571bd9e78a23fcd2ed

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
