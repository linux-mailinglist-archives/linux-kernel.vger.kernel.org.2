Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85F2F323229
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 21:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232870AbhBWUdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 15:33:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:44654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234324AbhBWUc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 15:32:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id BD65864E7A;
        Tue, 23 Feb 2021 20:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614112335;
        bh=o+HGA3AL9ZrDZ7zpCTGsrnuq69zeupJFE82p3qEoKL8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=T8Wr5Ca6G6IzOLN5CG+WR7fdG7u2dFb0xOHnuERi/fAL71fdmehiqe8U6oy9S5bG8
         DZfn05oS/zfMFgc8GkzQ/cC8oaFhrxdtjVJj9tqDRuzRzcUdhHQSprwyLAlxQsoUTs
         Q8alBo6r5rTGDHf/hGcLlG1XqRNwEdkNbs1pX1aOV3o1bnJ+RwJYf7lxLO+rCm2Pgx
         6UvfIXhYITOg3njaNtiCUQnzhEwkqSoIaXMprzRwT14Qo2oNzJTdJwNOh3AZmBMd7w
         mQ03RJXzTXgnDr1Y8jt4b1xDb4gYcGMJNXIFo7HQiiKARVQD9EXab27SwiFTW6wqwM
         RFyt19eUydtAg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id B81736096F;
        Tue, 23 Feb 2021 20:32:15 +0000 (UTC)
Subject: Re: [GIT PULL v2] clang-lto for v5.12-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202102221504.0418BE2D1@keescook>
References: <202102221504.0418BE2D1@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202102221504.0418BE2D1@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/clang-lto-v5.12-rc1
X-PR-Tracked-Commit-Id: 2b8689520520175075ca97bc4eaf51ff3f7253aa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 79db4d2293eba2ce6265a341bedf6caecad5eeb3
Message-Id: <161411233574.28784.11254724946266554668.pr-tracker-bot@kernel.org>
Date:   Tue, 23 Feb 2021 20:32:15 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Alexander Lobakin <alobakin@pm.me>,
        Sami Tolvanen <samitolvanen@google.com>,
        Bill Wendling <morbo@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        George Burgess IV <gbiv@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 22 Feb 2021 15:11:19 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/clang-lto-v5.12-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/79db4d2293eba2ce6265a341bedf6caecad5eeb3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
