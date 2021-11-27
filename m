Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8CFE460167
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 21:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239581AbhK0UUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 15:20:24 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:60834 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234606AbhK0USY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 15:18:24 -0500
Received: from mail.kernel.org (unknown [198.145.29.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D23A60F1A
        for <linux-kernel@vger.kernel.org>; Sat, 27 Nov 2021 20:15:09 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPS id 6431A60174;
        Sat, 27 Nov 2021 20:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638044108;
        bh=RzxN9Bg5b97ZVToCOFUH98dMsXT6xSKfgIQ9FQ3jMdc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=hbMcrIJoj9IXazN5iGKXK4h2Xb8gY8WkBj38ddcH8zsa5suZmwwTimuHEXC0/nZP9
         Bq6CCiTn/llpYkF27kjV8g6DD/Q3iTWuzTQkVwGZqKAjwGj//X5urwrFOCU6JmKKZ4
         trBh3XHwtIbtnIkCy7pdpC49DMvWsOGlGfnP+aFSw12kZMti94yXtqs+guPy+Kz+q7
         GF+Ahr4MII+8V+dOMCKB/91Vb7/y8+Wk9TU1OwqkEUKh64fcuU97J8GN5id9PhYBQR
         qX4cI6h/LukCB42IlCq7NKthf69Illb92gg7sGiLSfXnAzQ8fYcXSomT0CERGDIhsH
         NXtkg1FBVlwCg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 4E75B608AF;
        Sat, 27 Nov 2021 20:15:08 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Two event pid filtering bug fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211127132822.5d4d2a8b@gandalf.local.home>
References: <20211127132822.5d4d2a8b@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211127132822.5d4d2a8b@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.16-rc2-2
X-PR-Tracked-Commit-Id: a55f224ff5f238013de8762c4287117e47b86e22
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 86155d6b43ced7768b70e7b57bcf53a6fb6b1f2d
Message-Id: <163804410825.16584.12285171360298460063.pr-tracker-bot@kernel.org>
Date:   Sat, 27 Nov 2021 20:15:08 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 27 Nov 2021 13:28:22 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.16-rc2-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/86155d6b43ced7768b70e7b57bcf53a6fb6b1f2d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
