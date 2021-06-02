Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18EFC3993A5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 21:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhFBTiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 15:38:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:40846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229790AbhFBTiM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 15:38:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id A3EF961402;
        Wed,  2 Jun 2021 19:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622662588;
        bh=xkoRTx8PyiAvsSN/B21YSjsU38FXDkANSs7YDOHYkSo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=JprHzA2GRMfwZoOzXk69h1wKb7jb/6E73y5PuDvOVAPRSZ+LSuBeNEMJal8E3Dxvk
         sq8c8u+33g4Rb/BoYah9R8j2UXcoN38Z+5CvgdvyuQD0Q2eLF/2MA0cBABgG43Zpec
         8dBNsOXPdU5dnEalbEnbU91qi45lUgIF+5njrR3ndX8YXE5UA9EeeQLAESdBcYLvx/
         7Ta3c5+LwOB1xAjYccm1RbdvIzSYa84IclGkO5pOc1dqdLF7bsmOiHxFv9BWN8/mRs
         OHkS0PmcQlLBln4qDyKSUCp1EvDcOjUOOK/WyOxAgzFNNryFJUi15kGGMOdCe4SlbR
         2Q/D/z9VPID6w==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 9933260A39;
        Wed,  2 Jun 2021 19:36:28 +0000 (UTC)
Subject: Re: [GIT PULL] EFI fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YLfDmYv1VSoaaVpq@gmail.com>
References: <YLfDmYv1VSoaaVpq@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YLfDmYv1VSoaaVpq@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-urgent-2021-06-02
X-PR-Tracked-Commit-Id: e169fba4f464760dd9734c9e39e1c2e88e374f32
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 324c92e5e0ee0e993bdb106fac407846ed677f6b
Message-Id: <162266258862.13029.337587819674018201.pr-tracker-bot@kernel.org>
Date:   Wed, 02 Jun 2021 19:36:28 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 2 Jun 2021 19:44:57 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-urgent-2021-06-02

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/324c92e5e0ee0e993bdb106fac407846ed677f6b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
