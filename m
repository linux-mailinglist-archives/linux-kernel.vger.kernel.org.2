Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9321A39FDBF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 19:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233708AbhFHReL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 13:34:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:60908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233025AbhFHReJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 13:34:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id AB5E861378;
        Tue,  8 Jun 2021 17:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623173536;
        bh=qnP+V6BY0/Z2wVCoFRaAivZqbdccjmjs9oMO+Hf4YpA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QuhWnkP8FAbZSmWogf5JObyRCEyuNRtJQKjbL/zSUYOL21oUSER46lGd/ITBkFfu6
         qmdLyhrlFMWH2lP/AsxTtNxFuHro0ohrIOpXVN3ISN/bw2ypnYvuKJ9BJBFy0yeNlb
         ol0CPq3TVuGOxF9h0yg1IvX/bOXvr/0X/ex+GEIxhiackrO/Xko7MOvBlEI8dSYcHd
         DLniRLL7UMJjmzoq6FmAfJ6raog0CCVdmcjqci81d2B+DVsatj2qoxh87uFkF6lcSM
         cvwINOMDw6lN1M1TouheUvLcPdvq7QuX9i5drX7bpTkhnU097BMRn09MOToFYLfo7K
         nV9a/dtkBzYKQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id A1C3460A22;
        Tue,  8 Jun 2021 17:32:16 +0000 (UTC)
Subject: Re: [GIT PULL] orphan section fixes for v5.13-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202106081019.A88177D6@keescook>
References: <202106081019.A88177D6@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202106081019.A88177D6@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/orphans-v5.13-rc6
X-PR-Tracked-Commit-Id: d4c6399900364facd84c9e35ce1540b6046c345f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 374aeb91db48bb52216bb9308d611c816fb6cacb
Message-Id: <162317353665.21484.1851960167726969603.pr-tracker-bot@kernel.org>
Date:   Tue, 08 Jun 2021 17:32:16 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        kernel test robot <lkp@intel.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 8 Jun 2021 10:21:13 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/orphans-v5.13-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/374aeb91db48bb52216bb9308d611c816fb6cacb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
