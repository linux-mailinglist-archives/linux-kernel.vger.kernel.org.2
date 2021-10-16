Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0AF4303AF
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 18:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240754AbhJPQZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 12:25:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:59478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240697AbhJPQZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 12:25:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 8269B611C1;
        Sat, 16 Oct 2021 16:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634401401;
        bh=qSUEhZQAIX5RLkRs0n5qXJNIZdqWHr4nx1R2tLc3nNo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=iRKFk/+YOCM7BR4nnGvmh9E1AWyBhgAyBD4IiIT5NXL5Adl+t26Pv7OXkhMeb80dG
         kZAbDc/DUqfzdrdtXXoL5Sek4nRF6PRq8Sj3qGAzqqcfPOWFe97Y48jfV4xR5tb2qP
         B9JA/TwWFOYJPisj8iEP+Eci8ATblyo/iwPNBL5MvRKM+beIMSNRHOuH7dKbeVPjN2
         ZDVuq9x9wH/X/JF6s3pUCtorPGgo1JbNjWM9GUfdR3uXzsy3nlBfD8Vus3Hx2ZiG+H
         qw3IFnLVvyyNe7AyFmoBa68Cl4oZTmIqOUYxrlb7i4BY2U0Q3uDqYUXPdfv0J7PtZx
         ZKOvW+R2VI1vQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 7C68960A44;
        Sat, 16 Oct 2021 16:23:21 +0000 (UTC)
Subject: Re: [GIT PULL] ARC fix for 5.15-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <8dd82653-d44e-7470-6490-bc486c09590b@kernel.org>
References: <8dd82653-d44e-7470-6490-bc486c09590b@kernel.org>
X-PR-Tracked-List-Id: Linux on Synopsys ARC Processors <linux-snps-arc.lists.infradead.org>
X-PR-Tracked-Message-Id: <8dd82653-d44e-7470-6490-bc486c09590b@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/ tags/arc-5.15-rc6
X-PR-Tracked-Commit-Id: c3ca31ce0ea1e1ae34748ded54b6ccc319e7ed20
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5fd01b7263999c09f0596f5efd726b681474283c
Message-Id: <163440140150.26929.1332097449801208345.pr-tracker-bot@kernel.org>
Date:   Sat, 16 Oct 2021 16:23:21 +0000
To:     Vineet Gupta <vgupta@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        lkml <linux-kernel@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 15 Oct 2021 18:17:38 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/ tags/arc-5.15-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5fd01b7263999c09f0596f5efd726b681474283c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
