Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADACF342956
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 01:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbhCTAJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 20:09:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:49886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229564AbhCTAJV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 20:09:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id B9FE461983;
        Sat, 20 Mar 2021 00:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616198960;
        bh=EGTmeKg3w6ZtSwx9J7eQcXZMjC0fJ/6sg1mguHUXUPo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=i2gXHYG1QKIJsUR9ur6O+gwgikYwF4WdNa46XbtIcgoAGl9FEfvTn6IjnCDorrQZa
         1n2sJkAE266V9EhY+/n9Z+RsFsWJswOwgtXvmCwCPUb1QX4qkggx+VLIZLL/yMnoCi
         aoq2FJH35EOdLvI/TiuVuvf1elW4Ejpc7cLQgYAHcrjeZhJZK3XFA/7X0PJubcAGhz
         idXS1URcO04RTAN5ipzGDYXIZuje13BIBAHkAv6cWHI1kJYnqo78hXKuXRXKQ5CCaG
         0fVDVCX0q6mR+sBRU46Ms0QUNSGSpxhB7s5ysZ0NGrD806JJwHXNeyRYVJjCMqbhPI
         kuCt0i31ZIUCQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id AC53160A0B;
        Sat, 20 Mar 2021 00:09:20 +0000 (UTC)
Subject: Re: [GIT PULL] workqueue/tracing: Copy workqueue name to buffer in
 trace event
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210319094922.16e06f8a@gandalf.local.home>
References: <20210319094922.16e06f8a@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210319094922.16e06f8a@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.12-rc3
X-PR-Tracked-Commit-Id: 83b62687a05205847d627f29126a8fee3c644335
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 278924cb99c93861c1cc3d266d719095bbd84f16
Message-Id: <161619896070.24257.16978470415384796370.pr-tracker-bot@kernel.org>
Date:   Sat, 20 Mar 2021 00:09:20 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Zqiang <qiang.zhang@windriver.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 19 Mar 2021 09:49:22 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.12-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/278924cb99c93861c1cc3d266d719095bbd84f16

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
