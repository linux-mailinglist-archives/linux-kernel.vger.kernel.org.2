Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C89E43F0B9F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 21:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233040AbhHRTNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 15:13:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:41556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229965AbhHRTNa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 15:13:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 908C461075;
        Wed, 18 Aug 2021 19:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629313975;
        bh=Xwq0Z9245Jwi8Fdwuf53fjHBK/k0/fGSQ4UmHwe6bbM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=rcaye4vszBvKLkktQdYIEX2xAZzzzkfVVt2jDR4s37HtcQME5zNBm7jQk0LwAdKF+
         gOfVM/AEV26MvPxbrEadz7u2L7TvWZ8zStwNlMp905dJE774oTQoGyoxWkJ7e98LkC
         0FZJPWg3AcmZQtoaNwBUhv+pcta+Dd9I3cZwmgyUgL719355v1pLu0/STvXkWha8Mn
         SDUBfQBrpzibkWfXGjTLRe40q+qG0DCXrrhgyzk8/2Ksm9ddixrGbgwtEmizyxU5ff
         VztCTEkrm+GOQpYCLanSRQ1thgmUgWu0A4rmtJhM0gK47bb3lKnsyqWztAyJOJxqP6
         VJTydbFM4EeCg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 7904F60721;
        Wed, 18 Aug 2021 19:12:55 +0000 (UTC)
Subject: Re: [GIT PULL] Clang CFI fix for v5.14-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202108180134.4FDC95B434@keescook>
References: <202108180134.4FDC95B434@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202108180134.4FDC95B434@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/cfi-v5.14-rc7
X-PR-Tracked-Commit-Id: 14c4c8e41511aa8fba7fb239b20b6539b5bce201
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a83955bdad3ee1c8d29f345252dcb1806fe22365
Message-Id: <162931397543.7328.754434761166806152.pr-tracker-bot@kernel.org>
Date:   Wed, 18 Aug 2021 19:12:55 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Elliot Berman <quic_eberman@quicinc.com>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 18 Aug 2021 01:35:15 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/cfi-v5.14-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a83955bdad3ee1c8d29f345252dcb1806fe22365

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
