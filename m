Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2235235B6A9
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 20:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236394AbhDKS4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 14:56:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:42012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231405AbhDKS4x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 14:56:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 7B9B46105A;
        Sun, 11 Apr 2021 18:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618167396;
        bh=opJAX1bVMW7M6fCaenCiV6OgGBPgNwMPANyEktYZTWU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=BA3hiVbnnwZSFvc67HmI1+8DlhCcA9Cnqt6LKvxEUGNHS07vlUrLDSXSKSArJGFJj
         /N4Bq+1zRTpy6wuzUnhT3jvFMK6SYBOpFG/HDgQKCw9i4p5+C8mNTcMMyPlklCAlFM
         9qSbDISCA3xtQTjHzIAmIENEiZSI17jR6/bW7PEoVXjR8yzUrHP+avRPnmdjm81Kad
         SfhYo5I7W/NvimkL0cEcWxevzAoaIlWUh2YRMEg9fqyaTRxKpxcOnQTPTd5k8cEb/y
         W9asRSzmCa9+5Jq/WsW+6f8ytLrMzZO4nKJzx5PCBUxZ7hWnmmM6IoHf5FpXmRT7Dd
         FdawteJFWZnQQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 740FA60A08;
        Sun, 11 Apr 2021 18:56:36 +0000 (UTC)
Subject: Re: [GIT PULL] x86/urgent for v5.12-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210411090332.GA13409@zn.tnic>
References: <20210411090332.GA13409@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210411090332.GA13409@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.12-rc7
X-PR-Tracked-Commit-Id: 632a1c209b8773cb0119fe3aada9f1db14fa357c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 06f838e02d3b6e161df08c910e12e8366f1cb465
Message-Id: <161816739646.6502.9317535321010534513.pr-tracker-bot@kernel.org>
Date:   Sun, 11 Apr 2021 18:56:36 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 11 Apr 2021 11:03:32 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.12-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/06f838e02d3b6e161df08c910e12e8366f1cb465

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
