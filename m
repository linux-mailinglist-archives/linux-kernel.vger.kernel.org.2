Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C26144F4D2
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 20:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236085AbhKMTSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 14:18:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:55014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236157AbhKMTSY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 14:18:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 03E5561245;
        Sat, 13 Nov 2021 19:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636830932;
        bh=jrEIaCJQqMtHj3+6l6JnuEKRgDCeQq+eprzHmqaP/zE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=NTEVjYE7prf3o/eiUWrDbGdRLO8myYP4AiPdaJGWWJkbRmPmv/315SwIARxCHflvJ
         ESd4yg/9oTSfcfiPeLpwfD3bAPlbM4g0QX2s7UtvDI4HV8DwBW1Fw9B033sI02KeN0
         cPpFlkxPfQQX6cwj6vIIEix6kS1WoPGKUiwk8YZt55WedWhgePYSb+UNgB2dUYtAt5
         qjT7eqWkEBaDBjo9YMA36wey54jV+GgTP3ZrD7VI32blq+ClXwmpILMtLji+XEEBVr
         rCSya0Wl6mkn+W+Ag7XpJX3jHKWRMnK2ZnqeDYS7Z9dvA32OK+WsXa8koE16DGi8pb
         1SPtIeWmakddA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id F23D160987;
        Sat, 13 Nov 2021 19:15:31 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Three small fixes for 5.16
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211113083520.26ec84ee@rorschach.local.home>
References: <20211113083520.26ec84ee@rorschach.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211113083520.26ec84ee@rorschach.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.16-4
X-PR-Tracked-Commit-Id: 1cab6bce42e62bba2ff2c2370d139618c1828b42
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7c3737c706073792133deeefae33ab17fd06e0c2
Message-Id: <163683093198.10343.2152856711886622919.pr-tracker-bot@kernel.org>
Date:   Sat, 13 Nov 2021 19:15:31 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 13 Nov 2021 08:35:20 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.16-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7c3737c706073792133deeefae33ab17fd06e0c2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
