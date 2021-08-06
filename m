Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB6073E302A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 22:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244913AbhHFULx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 16:11:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:40080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244666AbhHFUL1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 16:11:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id DD74A60EE9;
        Fri,  6 Aug 2021 20:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628280670;
        bh=Pvk22jbQYb1CNoFJr9YZzQhtvI5Y1OiXPhfdxz7TTmU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=SmkmF8u49+xBYHh/7X36phyl06V6VtzYtxT8EorL2dUR5mDUBbRU4pv+0HOzsMtMn
         AFJTMmbmjN+b3pGDNz4AiizxVv6arwCnke3teUBkXlC3GRLTM/21+0SdsWiW1NMxSY
         Z4GzVq7/ok1FeBfavGdUQOPPKif1BForKyeDfw3M0z5TRFJ61u+vUJ/Y0p7+fJUblg
         g+KutcWkLGUkcP5jLw7AS1yZg2RCA6J7KOtt5QQJwfyE6qps8IwCcDD9vPLI7DzNju
         2RyOYlPxy1Ed/VtML6iT9Xfruxy8rJgIgYpd4fz6w2ScxAsecfdOzzNHkrn7XgScwD
         O8FXDb6qSgfEg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id D6D6A609F1;
        Fri,  6 Aug 2021 20:11:10 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Fix race between tracepoint static call and its
 callback data
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210806141228.744aa3f0@oasis.local.home>
References: <20210806141228.744aa3f0@oasis.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210806141228.744aa3f0@oasis.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.14-rc4-2
X-PR-Tracked-Commit-Id: 7b40066c97ec66a44e388f82fcf694987451768f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2c4b1ec683f28e0054bb25a55d50fe552d0611ea
Message-Id: <162828067087.25549.9195621744178476457.pr-tracker-bot@kernel.org>
Date:   Fri, 06 Aug 2021 20:11:10 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 6 Aug 2021 14:12:28 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.14-rc4-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2c4b1ec683f28e0054bb25a55d50fe552d0611ea

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
