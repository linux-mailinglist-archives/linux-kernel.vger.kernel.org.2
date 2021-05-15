Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA1CA381A55
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 19:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234351AbhEOR4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 13:56:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:43104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234189AbhEOR4Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 13:56:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 3BFA6613C5;
        Sat, 15 May 2021 17:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621101303;
        bh=n/rcyWVsk3DR5OPSgSoH+tAVPm5AtZGQ8ue9XRvYpZA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=OhUYLSVzzcg3arpaWPDVrb2uu7HF/uP2H+/kXEE9WQ8SlZSmSbGz6I8N2dGD39iB0
         PHgu9dQCg9Djm3nFGRolnxU+7Oxg5a2LA3Ah6cpDhdi7OC0tBUbMqdF3EWFzOtQbyZ
         JQvvGGIRcKZZV41N9E41kr6af6zmyhZpMUmsALIELAYBzBLIy4lihTOan6hYekA46t
         AsIjzchy/186D23f2ICn7/6bHNKmOapemhRXyJExflYhY+uXgG6SCKB0iAQExRdVPs
         E+/ah1IVPefK8iVDskCTj2t6kxUbY+edUxUfUFbJv9HpgESARTl9ArhhRHE8YqE4QJ
         H1Ma3qZ+nh/Dw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 3544C60963;
        Sat, 15 May 2021 17:55:03 +0000 (UTC)
Subject: Re: [GIT PULL] scheduler fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210515075041.GA201049@gmail.com>
References: <20210515075041.GA201049@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210515075041.GA201049@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2021-05-15
X-PR-Tracked-Commit-Id: 3743d55b289c203d8f77b7cd47c24926b9d186ae
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c12a29ed9094b4b9cde8965c12850460b9a79d7c
Message-Id: <162110130321.14651.8832130277989416571.pr-tracker-bot@kernel.org>
Date:   Sat, 15 May 2021 17:55:03 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, juri@gmail.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 15 May 2021 09:50:41 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2021-05-15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c12a29ed9094b4b9cde8965c12850460b9a79d7c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
