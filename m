Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09EBD36B7F3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 19:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236526AbhDZRUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 13:20:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:60398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235358AbhDZRUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 13:20:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 15E6A613AC;
        Mon, 26 Apr 2021 17:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619457561;
        bh=n67hrhM2y/XwXa7oEu7GonjbeyDI7uiCJFnHKOB4LPA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=eTgMUJGye5ZJ7wfHUjwvB84o9h9BR/dYVcf8pzOkyHTl64Vtp8YxEBmJMSlloArNN
         CMmwnCocgPSJ3NvEf+DsyUNaRIGireEI3AOEp2kSaX13bL9/bPhyDPa1d9U3kibQmK
         VYOZ5bQ+vDSUBew0fZO6x797wjJXwxJvu6c7mfhtvpF5dQgWZOPMZIgz+xVNjDtGJ6
         MFYfKYZ68hbv13jIbI//acT9jn5tj6jnJLLMVpfH9deKKFJml457XV0KOBKumU2+iP
         /8dDapY/Azp4+lAnJO5QbWdfJEpXjWwJf5NJo/2La/YBuF9Co9yMiaIrXAmOpxMmtF
         0vI+pjxuYBWJA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 0D049609B0;
        Mon, 26 Apr 2021 17:19:21 +0000 (UTC)
Subject: Re: [GIT pull] x86/vdso for v5.13-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <161943945664.1498.12541012822712127877.tglx@nanos>
References: <161943945302.1498.9201552430413038175.tglx@nanos> <161943945664.1498.12541012822712127877.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <161943945664.1498.12541012822712127877.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-vdso-2021-04-26
X-PR-Tracked-Commit-Id: 70c9d959226b7c5c48c119e2c1cfc1424f87b023
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 69f737ed3a1c0e7619565bb4c01dff5ec8991d85
Message-Id: <161945756104.14705.12975873526066760604.pr-tracker-bot@kernel.org>
Date:   Mon, 26 Apr 2021 17:19:21 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 26 Apr 2021 12:17:36 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-vdso-2021-04-26

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/69f737ed3a1c0e7619565bb4c01dff5ec8991d85

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
