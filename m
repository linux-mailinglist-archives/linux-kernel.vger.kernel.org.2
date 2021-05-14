Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01D993812AA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 23:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbhENVOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 17:14:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:49228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230202AbhENVOE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 17:14:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 3B2886135F;
        Fri, 14 May 2021 21:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621026772;
        bh=wvPflSxuR64CsBOTzwnuFaWm2Yuxepi+5EvBf7rsNLo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=q8EbJmJH3deJFfoX1nKTfOhGBZWRu65OJjUvN3f2t06WcCWX76Pu/rjhWlzLU5Rbu
         mdQbsUFVDMFsDqH9t2wYRw+dHasfa67Qbyj4xES0Bi4EsWcIhnkCqi6RgTH6Ber1kJ
         KXFjxl2Z7Ik8Rsyg0dIBbp3HteGKcAU2SGhU+wWK6ot+zLRtqOkuXlTgmeNI0x5HoX
         bsEEwoJuLJ6W0NaViAXEfgiqWYbxuq+zKmEsRydcKy9ooO28vEHHahYbqeDmmvZl09
         C151ME3PwiArIEl2SrHFXMYADB0Qk4EjSL4yoU3E/aO3XEYtPJR0ne7YSSPpU1HlaE
         7VqJ9EajFjfYA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 2907560A0A;
        Fri, 14 May 2021 21:12:52 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Handle %.*s in trace_check_vprintf()
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210514163702.7ae950d6@gandalf.local.home>
References: <20210514163702.7ae950d6@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210514163702.7ae950d6@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.13-rc1
X-PR-Tracked-Commit-Id: eb01f5353bdaa59600b29d864819056a0e3de24d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 25a1298726e97b9d25379986f5d54d9e62ad6e93
Message-Id: <162102677210.10467.14877913545885822211.pr-tracker-bot@kernel.org>
Date:   Fri, 14 May 2021 21:12:52 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chuck Lever III <chuck.lever@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 14 May 2021 16:37:01 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.13-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/25a1298726e97b9d25379986f5d54d9e62ad6e93

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
