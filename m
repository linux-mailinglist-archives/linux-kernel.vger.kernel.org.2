Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9483A503B
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 21:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbhFLTLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 15:11:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:42616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231311AbhFLTLq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 15:11:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 9D07C6120E;
        Sat, 12 Jun 2021 19:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623524986;
        bh=PSbS8PC+Cavs00oynfVl/jxQFi1qt6STkd3GM5ovAfE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=SSCaIK8NRAxMPaNHAQDQAVGv+cjKHsBKUa9JHSo+Yh7kbJ3EqhaC6kbE28DIhOdPs
         947TajX4HFQpiAH05JdLr2rXjn58izaVBwySgdrrTpmAuGajOBh3/n0baFJ6OsxytV
         5OhiRW/9gg3V16A7BM5OHaxnQ3TKdziFt2HzX7B41s7wkkrlWAonLWNQ1p/GsF0SWp
         IZC+wF9O8YVBkQBP54DxvWMXiIv7hawengONvvzKoOQGsrhu5us9MFXCPOUmrkNkCY
         vBh+1nZk/NbjcJzd3KyKCj0bFqZtKUWLRMYuL5WTxNzL66ZI1yQjv1ufXLxfGxkQ4i
         bApzQ2ELmxfYg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 9199960CE2;
        Sat, 12 Jun 2021 19:09:46 +0000 (UTC)
Subject: Re: [GIT PULL] objtool fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YMSqmtLIojtlZQIQ@gmail.com>
References: <YMSqmtLIojtlZQIQ@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YMSqmtLIojtlZQIQ@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-urgent-2021-06-12
X-PR-Tracked-Commit-Id: 2d49b721dc18c113d5221f4cf5a6104eb66cb7f2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 768895fb774d7af32d17cf3a455b0bd6df272f14
Message-Id: <162352498659.5734.17566740387247227664.pr-tracker-bot@kernel.org>
Date:   Sat, 12 Jun 2021 19:09:46 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 12 Jun 2021 14:37:46 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-urgent-2021-06-12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/768895fb774d7af32d17cf3a455b0bd6df272f14

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
