Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C965334BE88
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Mar 2021 21:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbhC1TWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 15:22:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:51576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231417AbhC1TWY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 15:22:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 52CEC619A0;
        Sun, 28 Mar 2021 19:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616959344;
        bh=FWsjr8MVmSoCw/L4/034vpA2XC2I+kFjt2YKcrISclk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=UbFDhCOb/dKVLSA9SuGAKJNXbfK9CAEdF5velsw6sJSTNpPMttBHQj5URAqYMyMPF
         D7B/84vkv/Ql55BVjGgsAgl+zEXlITCbUgYcAdPJ+3r4Ks3ULV0ji9xEbmTsUrj13B
         51dMX+wx0b8EL9nnhWEv3l08flyD/4Eg5Jo4atsx0Nz7MwRVzmuedn1fgHaZoyj02T
         BWNwSzTj3Y9ZJlfgJSjVv1q9VITxzQhd3/8BoOPdFV5o9gnrMEVZUFsR5tsx76SC47
         5L25Tx3QkcZ4NLKQ0vHnLtyqpsyAKxV4KWxGgk1qA90Ru8NwgDKrGYTTHFBRp7xtRm
         9wabozg4gT65A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 442B2609E8;
        Sun, 28 Mar 2021 19:22:24 +0000 (UTC)
Subject: Re: [GIT PULL] x86 fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210328104442.GA480587@gmail.com>
References: <20210328104442.GA480587@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210328104442.GA480587@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2021-03-28
X-PR-Tracked-Commit-Id: 9fcb51c14da2953de585c5c6e50697b8a6e91a7b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 36a14638f7c06546717cc1316fcfee6da42b98cc
Message-Id: <161695934427.29365.1482489491090864932.pr-tracker-bot@kernel.org>
Date:   Sun, 28 Mar 2021 19:22:24 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 28 Mar 2021 12:44:42 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2021-03-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/36a14638f7c06546717cc1316fcfee6da42b98cc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
