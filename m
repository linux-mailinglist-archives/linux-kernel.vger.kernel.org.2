Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C65CE3B69B9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 22:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237433AbhF1UgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 16:36:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:41506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235335AbhF1UgB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 16:36:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 1096361CDB;
        Mon, 28 Jun 2021 20:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624912414;
        bh=fOc+9fbp7eSWLBIG0EV8ztJzQ+mKd44VRt589wKtT3A=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=T3tWLgkMZQfWbn9q4dzozRFnVgmBCUFRMX3TEk1SeqiwWykwhkzkr6Oxth01s7sXk
         Q4Tb15Nu7E4CqGA2mcq/d66s3rkfuIU5f0gO7pualYWTrkMejE1Cl9TUOdKG0A73ke
         dnx3UgJIzEp40rOT7MsJV7cPBa09dUpYEK1/1s/k8zZBQK0YFd7diWJYyKIZm6yKX0
         hGXo2JR2mfMi0IKf06pEumDofSSocAvN4gxLrBRD2Aw4XXlAhhYaz2kubQviJaHGw3
         ezruQOJFY0omjVGJBPAVtMro1YE9SQHTURu2Mz5dl3UUW+kEVPm9zOS6hcNLTQ5kXM
         e6rZmkNkfc1cA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 068FB60A56;
        Mon, 28 Jun 2021 20:33:34 +0000 (UTC)
Subject: Re: [GIT PULL] x86/misc UAPI fix for v5.14
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YNl7F5G4CIHaVpvb@gmail.com>
References: <YNl7F5G4CIHaVpvb@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YNl7F5G4CIHaVpvb@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-misc-2021-06-28
X-PR-Tracked-Commit-Id: d06aca989c243dd9e5d3e20aa4e5c2ecfdd07050
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e98e8864b0b553389bbb7d2ed197729a434ba0f0
Message-Id: <162491241402.14584.2441278187046568230.pr-tracker-bot@kernel.org>
Date:   Mon, 28 Jun 2021 20:33:34 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 28 Jun 2021 09:32:39 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-misc-2021-06-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e98e8864b0b553389bbb7d2ed197729a434ba0f0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
