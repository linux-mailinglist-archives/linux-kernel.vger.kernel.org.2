Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE233266FB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 19:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbhBZSe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 13:34:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:60262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230347AbhBZSdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 13:33:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 0CDB164F2C;
        Fri, 26 Feb 2021 18:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614364334;
        bh=8s3Fwk8VRD+pCW1Q70zHEwnifgxn1s7z4wEKMvai88U=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qMFYj4qso3RaNtd0BUySBCpRCGDYUu5tu7dqurNoqEfkUh7QuemptQp90uEiUEpYv
         RwIdV81QJpecYWyR667RF4EY7Vm0YyN9+7YnbcDBvfxdmQhRGFLR47AUf8dR6VQxNO
         iqdNT4pE9GZ4unFVz29WzJ5RvBMnOkYQ2+G5ZE/1DRta+pYLIchoFma2FuMZaNnQRM
         Dyf9BUekh8TA4Z2zoQTraFHKNVwCbE8bfb+nE4hvpJPFZliftQhwwPpjL5t6BW8k78
         ii2efRB5UKgjTzdKhdjXyQv5W1VVVuNoK3/2SK3tXAVH8HPI2JsL+iDy9GbbYTGOtF
         1nEG1EUiCo6fA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 0929460A0E;
        Fri, 26 Feb 2021 18:32:14 +0000 (UTC)
Subject: Re: [GIT PULL] Tracing: Fixes for 5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210225215417.1e19b408@oasis.local.home>
References: <20210225215417.1e19b408@oasis.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210225215417.1e19b408@oasis.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.12-2
X-PR-Tracked-Commit-Id: c1d96fa61eb74b1e211f1653acc5b68ac62c8ef4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8b1e2c50bce9f3cc4422c3ed087252b8347da77a
Message-Id: <161436433403.9780.5049110055492753107.pr-tracker-bot@kernel.org>
Date:   Fri, 26 Feb 2021 18:32:14 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Colin Ian King <colin.king@canonical.com>,
        Jacob Wen <jian.w.wen@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 25 Feb 2021 21:54:17 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.12-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8b1e2c50bce9f3cc4422c3ed087252b8347da77a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
