Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 238313B692F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 21:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236893AbhF1ThN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 15:37:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:41256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236718AbhF1Tgt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 15:36:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id B477461CA3;
        Mon, 28 Jun 2021 19:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624908863;
        bh=EvAd9E9bLaaSgditr9tX5QpXfV79wsOONwg9BcndI88=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=F+yrIidjN1FMSuKykyosqE8AL7bYLWp5LLeqOWaHwIXdAJaysamesGWKvoLPr84d9
         VPJy1tyeEcBAEmHQD51usubAVs6Ga6AsjLCMrtCIeruq6iJd/X6f14GlHEo+l2lFvY
         IeszKxtKhaoNF03cBge/++2cOlhxKllDU7fmgCx55TF10fVbyuLA/0DfZXhzzqF5TW
         ZJYk4HzG/jZpiHvXrKkwNA5b4Vi/m69A+PtVg1LWBDqAVKxkKmRoxaquA9TndMXdhw
         GlK28G7XqobvWnkeu4AUdEtIT8umoqwIJkLJj6wbBHOOlX3HOuPcFGFStPvmlxozxg
         bC0nIcVsQGU7w==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id A651260A38;
        Mon, 28 Jun 2021 19:34:23 +0000 (UTC)
Subject: Re: [GIT PULL] perf events updates for v5.14
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YNlrWz8Y3Tdk0N54@gmail.com>
References: <YNlrWz8Y3Tdk0N54@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YNlrWz8Y3Tdk0N54@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2021-06-28
X-PR-Tracked-Commit-Id: 012669c740e6e2afa8bdb95394d06676f933dd2d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 28a27cbd86076c1a6be311c751b421c4c17a7dd9
Message-Id: <162490886367.14456.855351531337325613.pr-tracker-bot@kernel.org>
Date:   Mon, 28 Jun 2021 19:34:23 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 28 Jun 2021 08:25:31 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2021-06-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/28a27cbd86076c1a6be311c751b421c4c17a7dd9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
