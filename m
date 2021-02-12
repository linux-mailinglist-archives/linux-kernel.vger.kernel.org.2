Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EAAA31A5E0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 21:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbhBLUO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 15:14:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:51050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230477AbhBLUOC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 15:14:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 73E6C64E9A;
        Fri, 12 Feb 2021 20:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613160769;
        bh=B3++KDflkOjvCe+ME1KYfsxGZHeSAbk6gQfKZ4sLRLE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Vqq1RtNe0q99DO5q75QE3VhVSJ0t7rkiTx6eyTgouCNiu23ycOLPcOwwojtFLBfT9
         FqufCGRfrucC1WEsUNwdFyRwaKFQEAhpswBaYwSCehA7qEXwjhwEZXznGAJf+4gOc9
         g0dhy+uSbtx3r7zrvmO1ogCtNgurfFtCFSRio0zlVNIkb913KGXHsgvhKahWliKrpf
         fmY+1vZhjobqqBjLP/3spOrTRAp5ROldmlkmb5xHRx5LbCVTwdKA0nrdGH4tmA3LyT
         1aBula9rFHxSJmbDRxWWzIvkSqcQpAYT2lkb4QhMN/kgWoux7mMIMb2GC78gwb9UMZ
         /5Oqvql86kWzA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 6E87160A2C;
        Fri, 12 Feb 2021 20:12:49 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Check length before giving out the filter
 buffer
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210212094517.7930a8b1@gandalf.local.home>
References: <20210212094517.7930a8b1@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210212094517.7930a8b1@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.11-rc7-2
X-PR-Tracked-Commit-Id: b220c049d5196dd94d992dd2dc8cba1a5e6123bf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e77a6817d413589be35461d0cd5a431a6794b3b9
Message-Id: <161316076944.13717.10774664717666781497.pr-tracker-bot@kernel.org>
Date:   Fri, 12 Feb 2021 20:12:49 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wen Gong <wgong@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 12 Feb 2021 09:45:17 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.11-rc7-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e77a6817d413589be35461d0cd5a431a6794b3b9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
