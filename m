Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59855343425
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 19:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbhCUSqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 14:46:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:47482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230028AbhCUSpf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 14:45:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 4BE6C61947;
        Sun, 21 Mar 2021 18:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616352335;
        bh=taS95B2JKX3EeoXV2/iioOZMZK+lB1tX+LAmT0LamLU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=YxCD13ovjmZ0MJzENsAcfw+MqEBQd9gLw/Vm9NSouhOCfAvWvfNycVbsM5HWi+mU3
         ldHUqgn4X/GFhVUUfC4seugXGi+g7c5t9tV0YoCTdTjEjTsjZFxuJVvdZ2LmMqvn+y
         vBRZcGiVl0mI6N3F2DJrlQ0nS8z4lSblqfoTMLbaqkKCOTlmz62XYEGsEHxxU3L6Ok
         960QdgWzafzG5ZKwWU0awBsAF2jE4hdoM6mlgZOmdvtN28DtQEir0JS5CH/S4Utr43
         1Q+9DiCOI6MfxpZzlf7Q9fyQK0p2UhgCXaIZWCLJJq9p0hbmh6st7ngeynD45SCkQp
         axqeYxGcNS2og==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 474FF60A5B;
        Sun, 21 Mar 2021 18:45:35 +0000 (UTC)
Subject: Re: [GIT PULL] EFI fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210321104724.GA3399@gmail.com>
References: <20210321104724.GA3399@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210321104724.GA3399@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-urgent-2021-03-21
X-PR-Tracked-Commit-Id: 429257a430a0e81e9979256e0db718e35e7d9cee
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 92ed88cb4d7cd01eadb0f71063ceb5202548ce35
Message-Id: <161635233528.28302.7549879196884935471.pr-tracker-bot@kernel.org>
Date:   Sun, 21 Mar 2021 18:45:35 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 21 Mar 2021 11:47:24 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-urgent-2021-03-21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/92ed88cb4d7cd01eadb0f71063ceb5202548ce35

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
