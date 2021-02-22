Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6132C322245
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 23:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbhBVWk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 17:40:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:45772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231459AbhBVWj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 17:39:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id D8E5764E4D;
        Mon, 22 Feb 2021 22:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614033557;
        bh=E+zVhSC3YmVWTGniPaODGRHqp8IQ5Np0rBoFVrUYc7k=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=PBsAbR0c7idmBcSbBSsRIpwzyEh/V/aEIckJvNkgjVLozoYokD+GrH40emHR8ircY
         +Wu8aDvgWFKnGndzRWUS53e2+HRn6o6DYpcglhs3Be8WnOBBB1Ag+bf0ZYwQjfp4n1
         uonHeLKyqdA+wWZRa9syyUc3b6mgIjpW8Y1QLm5xU2FjoBYKRax0icR4amr0BjnzWV
         t4t/3XFOgGuWv64o8YR7dsyTNp1swqbEpwMG9Ed7uyYmDy6WAYelJ5QxaixC8nqbKB
         wKfe8m2VMRrnU7D1cxhIWPdulkw60+DhdgUQqrBPZS3RdZzY679c12qkANOUhKRDRz
         sbk+KStmLeQSQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id D276960963;
        Mon, 22 Feb 2021 22:39:17 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Updates for 5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210221191721.7126befa@oasis.local.home>
References: <20210221191721.7126befa@oasis.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210221191721.7126befa@oasis.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.12
X-PR-Tracked-Commit-Id: c85c9a2c6e368dc94907e63babb18a9788e5c9b6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c9584234709aff90fbf38f71904a068ee9e8bce3
Message-Id: <161403355785.914.9624237485111115668.pr-tracker-bot@kernel.org>
Date:   Mon, 22 Feb 2021 22:39:17 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bean Huo <beanhuo@micron.com>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Jinyang He <hejinyang@loongson.cn>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Qiujun Huang <hqjagain@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Song Chen <chensong_2000@189.cn>, Tom Rix <trix@redhat.com>,
        Tom Zanussi <zanussi@kernel.org>,
        Viktor Rosendahl <Viktor.Rosendahl@bmw.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 21 Feb 2021 19:17:21 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c9584234709aff90fbf38f71904a068ee9e8bce3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
