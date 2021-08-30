Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFC23FBF0F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 00:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239115AbhH3Wkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 18:40:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:45448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238554AbhH3WkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 18:40:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id F1B2861027;
        Mon, 30 Aug 2021 22:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630363169;
        bh=fhgwBULQgzfL0K/ApKbBPO/w5zcUSqoqlb6NhBYq26s=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Gc26ZFzUNSiB3jnneIJFJdpibdiuei9vBFTTXXY940fqMV8602AI6i0BGolqtcATJ
         XFOER0zd+l2Sy1d2q6QT/15ng4rUyriSqTUY6FBlaw8Ro9MmgIOQokyAGu4ekevJ6S
         aEYlbKVgqJ33I2VU7/wDbQgjYNI5DLGnKHBwiYt3jUVf/7Ycc0tmtuKluKaDqTw2mS
         4lBmeOhh3lthfsA6NixPCbHEVhkZS8G0MWY4UB+KWx3T6WizV+N2IwCqxAgqj0brAq
         ajirLF7rVjgSquDk1KxPQYUH3Kk5yqyEUbpM6rtNC+MKBwz9NleiEgBBZLcIk9NzsN
         yBeLRtvU4841w==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id ECB6660A4F;
        Mon, 30 Aug 2021 22:39:28 +0000 (UTC)
Subject: Re: [GIT pull] x86/misc for v5.15-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <163031993985.58256.16849318566787748326.tglx@xen13.tec.linutronix.de>
References: <163031993120.58256.1250660796395121952.tglx@xen13.tec.linutronix.de> <163031993985.58256.16849318566787748326.tglx@xen13.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <163031993985.58256.16849318566787748326.tglx@xen13.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-misc-2021-08-30
X-PR-Tracked-Commit-Id: a729691b541f6e63043beae72e635635abe5dc09
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bed91667415be768be4e5d7691011f2b5e16d796
Message-Id: <163036316896.23007.6241597050210847792.pr-tracker-bot@kernel.org>
Date:   Mon, 30 Aug 2021 22:39:28 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 30 Aug 2021 12:44:50 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-misc-2021-08-30

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bed91667415be768be4e5d7691011f2b5e16d796

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
