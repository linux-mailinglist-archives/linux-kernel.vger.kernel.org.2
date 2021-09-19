Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2F1410D5C
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Sep 2021 22:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232742AbhISUie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 16:38:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:54536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232373AbhISUiX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 16:38:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 8DD3361159;
        Sun, 19 Sep 2021 20:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632083806;
        bh=Qp2cRJT3mzok+hB/SJ7k/vE6dQNQO4913rrCdsmN4TU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=b8AGAPQlKn3xU3KELvB1ZgPhzgQLqB0XR60z9rC6fSOH0l/1TYY+QteaXvVOeWAkD
         lndwCGwFlB18CqQ/dHRoiYDInB5Nu8ZNteNDmpq3PSRxC8JakiKPi/PYudAY/gPj91
         URxTvrR8uGqh2KD2RKpN9301oWauRaX13Kk6Q5czTlVAl2GToIygeRXMi8iUoAe3ed
         wevsOD/8l4zVcqhHx0nVcGYxtlfsu5/nCoCbA958rUVOm49PsHWzgkW1uG5DcePVJu
         dUNAdlmHJJfVGuCUslKV4fyeTYooAKzXe7Gvt02IWMV3Mexkl08cKKpTQimgU/wn9m
         HmCur3Jeixalw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 8674D60A2A;
        Sun, 19 Sep 2021 20:36:46 +0000 (UTC)
Subject: Re: [GIT PULL] Updated x86/urgent for v5.15-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YUeFrR016RVgUf/d@zn.tnic>
References: <163207602242.947088.16824174748243890514.tglx@xen13>
 <163207602540.947088.6038710845965846842.tglx@xen13>
 <YUeD9Gcx99EbMyMA@zn.tnic> <YUeFrR016RVgUf/d@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YUeFrR016RVgUf/d@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.15_rc2
X-PR-Tracked-Commit-Id: 81065b35e2486c024c7aa86caed452e1f01a59d4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 20621d2f27a0163b81dc2b74fd4c0b3e6aa5fa12
Message-Id: <163208380654.27843.1843438419815671874.pr-tracker-bot@kernel.org>
Date:   Sun, 19 Sep 2021 20:36:46 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 19 Sep 2021 20:47:09 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.15_rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/20621d2f27a0163b81dc2b74fd4c0b3e6aa5fa12

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
