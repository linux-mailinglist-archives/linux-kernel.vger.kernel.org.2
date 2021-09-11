Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 498B94079E8
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 19:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233358AbhIKRbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 13:31:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:49810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233539AbhIKRb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 13:31:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id DB2316109F;
        Sat, 11 Sep 2021 17:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631381415;
        bh=ofXtXvqr8WnPdIVvo12XN8cb3tYIBuDtHR1EHKVDWYo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=VA7gxbgisCSRyuXQCGoNttStmFqwJEde3WNjdSmkXhoWGEIC9CU9lelQhfj152IZw
         rWsmwvJWyA7B7Fm1Ax9CJ3SzZB1ZXDOJwxSalqLJ4HPVGU70dX8+i67IlnGGnmtUgP
         ReiRHFAKnYAj/uRm0kJr1IKDh9Ht5QdwHHSmptNcBmQi4cBKR1dG8mIhKccsGiGrjD
         Bd0PG1I+pyTinRPMW1++pkN6HzoQSYJ+xYAgZBsJ4EMJiT0zK+DLr7hqKZUPYHgkwf
         CK0+WNzaYpeWHbZrQKhJHqS+CrGAYwu9dYAvIyNYYoIOSxH1zKImfKoviOIwv4JHye
         thVJmfGJFX/xQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id C5EC0609FF;
        Sat, 11 Sep 2021 17:30:15 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Minor fixes to the bootconfig processing
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210910191324.217c2812@gandalf.local.home>
References: <20210910191324.217c2812@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210910191324.217c2812@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.15-3
X-PR-Tracked-Commit-Id: 5dfe50b05588010f347cb2f436434bf22b7a84ed
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ce4c8f882041341cbb3f1b4632b20440692cbccc
Message-Id: <163138141580.31861.800938944246496312.pr-tracker-bot@kernel.org>
Date:   Sat, 11 Sep 2021 17:30:15 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 10 Sep 2021 19:13:24 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.15-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ce4c8f882041341cbb3f1b4632b20440692cbccc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
