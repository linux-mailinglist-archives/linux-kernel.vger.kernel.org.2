Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC14410D58
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Sep 2021 22:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbhISUi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 16:38:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:54362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229995AbhISUiX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 16:38:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 4E2E76115C;
        Sun, 19 Sep 2021 20:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632083806;
        bh=o7h/89AjvmVy2HGX0hiS/lOOVZgluChY9ddz0Iym66c=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=C2/BNwWpHSxO7Dw3zLOYkag6eiPmmmZpLzNcLzofcyJefrch+iAdXfpSl7reSqAQ6
         SRoR/JH7tS2TBY+oEbZyInUHllpSS5RM3vSzGBhZ4Y2P4g2/B7F+xfGjzr9tNYqjDR
         kovSaDKJBbkv/PNx6KuWE4RYiaX/DK7vUY01sTDVTADxXVh29OM7wAELiMR6IOI8+S
         NlmfXGqP1rvzG2rDqkK4C8nr6s+Ruv/pQZvTY0QmAXAR4wHs4sBrxnS7ORZWNSxkk6
         7ThFzgHZqNXx/vd2HU0DDoHPOJIQftQSn1+WXUW58zjgvbGe0U+YTjxv10lYXd7h2K
         3XWAJgXvLlTGA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 41208609E9;
        Sun, 19 Sep 2021 20:36:46 +0000 (UTC)
Subject: Re: [GIT pull] perf/urgent for v5.15-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <163207602394.947088.16084244161007584223.tglx@xen13>
References: <163207602242.947088.16824174748243890514.tglx@xen13> <163207602394.947088.16084244161007584223.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <163207602394.947088.16084244161007584223.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2021-09-19
X-PR-Tracked-Commit-Id: b89a05b21f46150ac10a962aa50109250b56b03b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fec3036200b7d9df32c94eb2616447eb2f6e09ac
Message-Id: <163208380626.27843.2334995988258477422.pr-tracker-bot@kernel.org>
Date:   Sun, 19 Sep 2021 20:36:46 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 19 Sep 2021 20:28:09 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2021-09-19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fec3036200b7d9df32c94eb2616447eb2f6e09ac

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
