Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4181D42036A
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 20:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbhJCSWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 14:22:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:48710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231426AbhJCSWg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 14:22:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 6F18E61AAC;
        Sun,  3 Oct 2021 18:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633285248;
        bh=SQPnGxypz4nCv+tnMLQTTTLlndgWVmNCEswobujiY+o=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=VLpUjuW+1ealmGgDquiQtz3yO2n587x4MtsHOZcHHtnGVh8buAZM+I9JJD+WBWB29
         MOdSkSkR/6abJFq41iX8+2EmMvxzWfougftSgrAeaoPAngGopkXVvezdSdOwiGi/kk
         sE5fOHKG5pxgWqEwvWtZAXpSiwpLpDK/3rI1sTTD9qa9aesmR/BS/LU+jl0egnd7dh
         fA6Y8NS9GdkBpX9kCuG1VJ7ne0vJzdSqdwYDmXOxHY2vRdthqJDkJJeg5Xtqsq5sMk
         /T43Qew8opgXFojlswLOXpWvyLi//wfxmmtPoMIZDjeZUs+XI4BI/Q5rfUWZipIpYf
         3TFQ8HYqj8kgA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 61A4960982;
        Sun,  3 Oct 2021 18:20:48 +0000 (UTC)
Subject: Re: [GIT PULL] sched/urgent for v5.15-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YVmFmV/BDpXrn/yw@zn.tnic>
References: <YVmFmV/BDpXrn/yw@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YVmFmV/BDpXrn/yw@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/sched_urgent_for_v5.15_rc4
X-PR-Tracked-Commit-Id: 83d40a61046f73103b4e5d8f1310261487ff63b0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 777feabaea776a6bff3d198edfe931b0b45c45d9
Message-Id: <163328524839.23868.9476016198669745363.pr-tracker-bot@kernel.org>
Date:   Sun, 03 Oct 2021 18:20:48 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 3 Oct 2021 12:27:37 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/sched_urgent_for_v5.15_rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/777feabaea776a6bff3d198edfe931b0b45c45d9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
