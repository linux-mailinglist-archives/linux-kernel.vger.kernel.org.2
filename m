Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6D636B70C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 18:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234545AbhDZQlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 12:41:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:49024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234579AbhDZQlC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 12:41:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 996F5613AB;
        Mon, 26 Apr 2021 16:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619455220;
        bh=QXFppmelZ6oZ+dxJyZKf5WyySvD2/tEM0nYAW1qRHuY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Wmmk8Y1+DG13lqds1HLSynE7NChetpOC8xclETlW9nSmoIC4YkejDN9/nq5laO11R
         9w4wyzGSNQRGHbQ4xPKxwhh0LkN21hy2GCIr1ZtROCWmtKLz41zQEHZQ5vY3lR3o0q
         O6fflnrZQhLAU1L4fiJJlglzWmU6BQJQPp0aCq3SRtZHV1hAA7qnCc3eQjPElji2zX
         By5iHKFBpdd65LzEoNICQnbK8GzRodN+GzWj7BagjamVgtezp7i2nuDREAgJyjmpJA
         i+a5UStpPx8VGuG+TpSV0yNRcvqjttRXGKDLCnGTRz43qQdeJP+a6YXsz+q4cmhbaX
         a794bCO+jBFeA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 8C35B609B0;
        Mon, 26 Apr 2021 16:40:20 +0000 (UTC)
Subject: Re: [GIT PULL] x86/misc for v5.13
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YIaO65uYSqiK+tWf@zn.tnic>
References: <YIaO65uYSqiK+tWf@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YIaO65uYSqiK+tWf@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_misc_for_v5.13
X-PR-Tracked-Commit-Id: f281854fa743f3474b2d0d69533301f48cf0e184
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 98ee795b21733a370bfdb3ba4359d2e31e6db514
Message-Id: <161945522056.27394.10228207664691297525.pr-tracker-bot@kernel.org>
Date:   Mon, 26 Apr 2021 16:40:20 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 26 Apr 2021 11:59:07 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_misc_for_v5.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/98ee795b21733a370bfdb3ba4359d2e31e6db514

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
