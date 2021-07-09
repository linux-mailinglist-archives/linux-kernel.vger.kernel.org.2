Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 726293C2984
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 21:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbhGITX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 15:23:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:57550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229931AbhGITXX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 15:23:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 8C416613CA;
        Fri,  9 Jul 2021 19:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625858439;
        bh=w41MqLWCZVrKkXPru1mLtgmwejMDAJGww+t1PKadTdM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MZoR4J4urLASjIf2lNBh6d0mWEc4rufMW2IFJFrugL3cH2BcyRBxhvoZ14aI6oti1
         MRzjewvHfN2t00nzQTM7h/dZdUpzaJqTFyN3JLMMgMeeVR8+oL1CaQrfZ9WQ/SfPG/
         gMOgAdYj2Ecx2HS002zaUNge463mAVVbGAklnG6AQK5wbracrG5BWeqXWkljZwi9Ye
         1ATFFAIxiw9DYcqHdeT9wpFgf0goEOmeWDBh0WGwo6huLkbG2rl3PzjWjySVqfUBWb
         cAcvlU/9b0C4wgXIYULE0FuGfOlcXG2K9BuxKbSKtME+U+YvVUt/45y6GCuTvJh1ZA
         LSe+xVh5ZtrCw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 862A0609AD;
        Fri,  9 Jul 2021 19:20:39 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Fix for histogram and clean up in ftrace
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210709092256.567f77a1@oasis.local.home>
References: <20210709092256.567f77a1@oasis.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210709092256.567f77a1@oasis.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.14-2
X-PR-Tracked-Commit-Id: 3ecda64475bccdfdcbfd5b9b7e4bf639d8b233da
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5a7f7fc5ddbbf9bf63eaa8cb9a0d254ab984f3d6
Message-Id: <162585843954.13664.17450618214890991774.pr-tracker-bot@kernel.org>
Date:   Fri, 09 Jul 2021 19:20:39 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baokun Li <libaokun1@huawei.com>,
        Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 9 Jul 2021 09:22:56 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.14-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5a7f7fc5ddbbf9bf63eaa8cb9a0d254ab984f3d6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
