Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00D3F3949AE
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 02:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbhE2Awh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 20:52:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:42396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229559AbhE2Awg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 20:52:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 223DE613EB;
        Sat, 29 May 2021 00:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622249461;
        bh=zp26Vj2SlecmqK2KnSI/qQy0LK60wbK7LLbary+EemQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HrwkcG4JYauHHBxLFZyZOWC7uvOVm4HsefuEU31gCYK+xkD4TUsVKAXYHI+47ZShy
         4GP8z6ML6P3Gw47ZibWpTUip4cP9Xd9ikGPqBp9w9oLBFZqJG8lLg6vbZKsBZbVmnd
         Y2Z6B2efKdfziCVW1eaJXyYdxh4SwfwaMgG3Kv6eL5/eHzqNsS7ra1CIAknelaSCks
         XoPVI+6EvGcdecPfmnwPaJFDGvPvHknYCFlpEhLTWMqsFi3T3XcLoVWRUo8sf4DJev
         cP2HbJ9Hpp9rd2y6bhv/40BvDzNYR1+01TvIHbvpo4OHoZV2jelgpMIJQgXoXVuLMv
         hG5A8rycxW+eQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 15B86609EA;
        Sat, 29 May 2021 00:51:01 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools fixes for v5.13: 3rd batch
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210528202720.281688-1-acme@kernel.org>
References: <20210528202720.281688-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-perf-users.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210528202720.281688-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.13-2021-05-28
X-PR-Tracked-Commit-Id: 8fc4e4aa2bfca8d32e8bc2a01526ea2da450e6cb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f289d990450cfa16869b9ff670e611e5df51f1d9
Message-Id: <162224946108.17808.9305731889815715348.pr-tracker-bot@kernel.org>
Date:   Sat, 29 May 2021 00:51:01 +0000
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Felix Fietkau <nbd@nbd.name>, Ian Rogers <irogers@google.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Nageswara R Sastry <rnsastry@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 28 May 2021 17:27:20 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.13-2021-05-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f289d990450cfa16869b9ff670e611e5df51f1d9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
