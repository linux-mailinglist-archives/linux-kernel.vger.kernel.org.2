Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43C6F32085B
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 06:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhBUFIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 00:08:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:44110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229989AbhBUFHy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 00:07:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id DD2F964F0C;
        Sun, 21 Feb 2021 05:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613883995;
        bh=2NSV/jclokyiyXeIvDnp8ZSqKZV+9elrMjJgV/wv/4U=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=XNhkEVjgbUzo7aHJhDK5iMv0M3RPGqPjRZCh7/FUBimVxJsK8neHmy7idW4syyTIy
         ElEBdk4Qm2VVG3Hj1gdJFI4cKZFdHbriA4IPYxhU06HG06cEK/bt/PDnPjN+mIHNsa
         jf69cwai5DVufr9qaT3OZnl4dqD7+GqSPMTmN33AQOMEyGWIyVCY68lRLLVklgRDrA
         H9AX6HAs/gpcWEh057vPo8N+OtuhSnff2U0ZFZh8/QAUhTuYnK7Q67WFPj9xzH+joW
         l8RBWSay2dQo+cwq4aMMKzdRFbme3tSLj91avz1E3mBfCoAoGAxucibld+WRaKX8rp
         YvnJPtnngoLgg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id D302C60967;
        Sun, 21 Feb 2021 05:06:35 +0000 (UTC)
Subject: Re: [GIT PULL] x86/mm for v5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210215110249.GG23409@zn.tnic>
References: <20210215110249.GG23409@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210215110249.GG23409@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_mm_for_v5.12
X-PR-Tracked-Commit-Id: 40c1fa52cdb7c13ef88232e374b4b8ac8d820c4f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ae821d2107e378bb086a02afcce82d0f43c29a6f
Message-Id: <161388399585.9594.2558838334979153518.pr-tracker-bot@kernel.org>
Date:   Sun, 21 Feb 2021 05:06:35 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 15 Feb 2021 12:02:49 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_mm_for_v5.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ae821d2107e378bb086a02afcce82d0f43c29a6f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
