Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA79C323228
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 21:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234335AbhBWUdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 15:33:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:44628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234323AbhBWUcz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 15:32:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 854D164E85;
        Tue, 23 Feb 2021 20:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614112335;
        bh=IJRjf/kUX2xVYMsBNpvlReUG/RKtDLiZ4T57zaaKthI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=iukyUy15XaJXxEPWoE+0iBPFTkMpvuxq6c8ntqKnGKdEDoSZOnjAF7cmuR+jpxRzt
         WNzkBbGVoavVgK8WOuoUnpCRGS7XWhn9uu0hGEMK0bOoibk8smaTbHRDP+IOEtLB/E
         +3i/xTmKqIQqqCpx9ygahixc9+qscLau1qPa9fzjcCIYxCo+1GysXf+NzdiW3TSxFZ
         BdmsqTNtgk5F4ERbs33BcZB0PdBD6GwkiwDQVnjH27GrRQucxYGZe0vO1yrnXaznrv
         1z+UVfZ4a8gTYmHxqoVEMWRGLFKvN/bk9T74kUacJrfqTyarRVloJs7fmu3wjT2R6q
         ItLebeq7Xc3bA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 77ABE6096F;
        Tue, 23 Feb 2021 20:32:15 +0000 (UTC)
Subject: Re: [GIT PULL] clang-lto for v5.12-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202102161211.6FDD4FE@keescook>
References: <202102161211.6FDD4FE@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202102161211.6FDD4FE@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/clang-lto-v5.12-rc1
X-PR-Tracked-Commit-Id: 112b6a8e038d793d016e330f53acb9383ac504b3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2b8689520520175075ca97bc4eaf51ff3f7253aa
Message-Id: <161411233543.28784.1211053616865833054.pr-tracker-bot@kernel.org>
Date:   Tue, 23 Feb 2021 20:32:15 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Bill Wendling <morbo@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        George Burgess IV <gbiv@google.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 16 Feb 2021 12:34:37 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/clang-lto-v5.12-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2b8689520520175075ca97bc4eaf51ff3f7253aa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
