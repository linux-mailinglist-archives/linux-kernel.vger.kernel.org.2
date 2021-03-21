Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5E49343423
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 19:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbhCUSqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 14:46:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:47508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230114AbhCUSpf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 14:45:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 6C12A6194D;
        Sun, 21 Mar 2021 18:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616352335;
        bh=BIbtVwDYC2uqMlYCewFPKg9DBAzOI+xcIbaoYzHUi5k=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KOPV7ARRj2NRstUsOe3E3PZsksYrgAk45xAvlHiBfK+zcP5YHQbztyRwK32uIiYGH
         i7dOTzpUZNXn5lAVM38VbOCgt3PEr6VWjnZN3ihG7AFgXBT8UvGQLJZ2X5iC6gfFMR
         79uUeLeymlev0S+NPvqUsjP4w+BjrbVacy/Tiyq0F+yZzOIOphtk/lwdhY1lP9+nVK
         NaEQLjpQuH4a6HL1smWfVfNqZHz2f/G0QqpwzBfPnoFVpDfdtJY2SmlR3YmTxRYRhl
         nJg11lxUj3gxbwcSe2PKx5nYTBWdnYzvCWzYW8XjGlOtiQ+fPZhTM2on9qftwG6dbV
         kSqk5cpP1mEYA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 5F65360A6D;
        Sun, 21 Mar 2021 18:45:35 +0000 (UTC)
Subject: Re: [GIT PULL] perf fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210321105636.GA201014@gmail.com>
References: <20210321105636.GA201014@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210321105636.GA201014@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2021-03-21
X-PR-Tracked-Commit-Id: 2dc0572f2cef87425147658698dce2600b799bd3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1c74516c2da40ead2c22c4ac07c117c20f9c31ec
Message-Id: <161635233538.28302.7979045784421892933.pr-tracker-bot@kernel.org>
Date:   Sun, 21 Mar 2021 18:45:35 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 21 Mar 2021 11:56:36 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2021-03-21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1c74516c2da40ead2c22c4ac07c117c20f9c31ec

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
