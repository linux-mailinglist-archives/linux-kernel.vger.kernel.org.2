Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E92E44027B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 20:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbhJ2SwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 14:52:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:46646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230325AbhJ2SwJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 14:52:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 4DEFC60F4B;
        Fri, 29 Oct 2021 18:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635533380;
        bh=Yw8BuAyCj5lmO/aYizVkth+TbvDcoA0uPbpc5OUF+PU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Dsg0xF5ybL+R/Dk2yT+jD+uUeUYcAApuYG7HvwgJMQgLprs835shvPFy9qH2T/dsf
         JxV8HXnR9mEbdHMVZanHHFAG7ozz8eXs1Iga+1UW/zYhnmhgftWAwQHjbfiTcc/6ZS
         7JT/9TyVlc7TuOaPmalKeKZt5b/xFc5DG7nANmgP1txo0JSULiTNtdvAYh5NZBacZ3
         Xny1GmNeKApiFZ8FQCYaCGCg/cPtMqhrWtzBAJBJPDLoZ6yJsOmpRQ7UK8iYcwbHyo
         ujuwLMa4D9rxsJPYZY+uIwQK54WBfrA6mEElcDvaJS99f/JcpnbfeIRKPY6xOotiz/
         YHS5PFR5i9KuA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 45E5E60A17;
        Fri, 29 Oct 2021 18:49:40 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Fixes to comments
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211029101550.2bde4593@gandalf.local.home>
References: <20211029101550.2bde4593@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211029101550.2bde4593@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.15-rc6-3
X-PR-Tracked-Commit-Id: ddcf906fe5ed842034b2d995064c1de1dcc7e812
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6f11521267319659cceabe073112a0e35bcb7ff8
Message-Id: <163553338027.6387.16985287865526327575.pr-tracker-bot@kernel.org>
Date:   Fri, 29 Oct 2021 18:49:40 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 29 Oct 2021 10:15:50 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.15-rc6-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6f11521267319659cceabe073112a0e35bcb7ff8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
