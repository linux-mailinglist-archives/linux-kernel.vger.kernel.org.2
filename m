Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E11745CC1A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 19:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350477AbhKXSey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 13:34:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:39126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350073AbhKXSev (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 13:34:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id B06976101D;
        Wed, 24 Nov 2021 18:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637778701;
        bh=wQShQAmG8Sjbt8Q85kact5yxmUk7CpXRv2PcHEN2V+o=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=giSsWr0A7b6jkoFr2ro83w1ik7oz8uBKt/GBZ/Ku6Dgc7w7aVYgAqqBHQZbENVJIr
         8DapIohvra7aSjAP9TCKDLVmfp/2XaefLBTVPPlHOye8wWtX/l2KGkISTEfTUeYmcL
         LcTTcOrHB2kF9cAEk+bj6e5Ko2lFZ0aaBL9ueiScDYohyb4m2pNw0GQxG3RHJ62xIm
         i1SrCmQjXeusKLrAX2E4kulvOXpLav9EHXA3nVrB1QdU+CJFyINqNGyPJSRqW5R4Xv
         sdzJUhhUVlEjdVMpBOrLeSoxDb4zsWsXLPshuXhg2vdCLTKWhVp3TaKCxBGclooFK7
         LaUrKVrbtealA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id A3010609D9;
        Wed, 24 Nov 2021 18:31:41 +0000 (UTC)
Subject: Re: [GIT PULL] tracing/uprobe: Fix uprobe_perf_open probes iteration
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211124100956.6905a198@gandalf.local.home>
References: <20211124100956.6905a198@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211124100956.6905a198@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.16-rc2
X-PR-Tracked-Commit-Id: 1880ed71ce863318c1ce93bf324876fb5f92854f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 29889216befc1cee635da8a64f48caae47ffbcaf
Message-Id: <163777870166.19345.16319597399796102639.pr-tracker-bot@kernel.org>
Date:   Wed, 24 Nov 2021 18:31:41 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 24 Nov 2021 10:09:56 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.16-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/29889216befc1cee635da8a64f48caae47ffbcaf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
