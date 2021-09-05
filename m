Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E06CC401151
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Sep 2021 21:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238104AbhIETIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Sep 2021 15:08:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:37252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238071AbhIETIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Sep 2021 15:08:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 63FC760F5E;
        Sun,  5 Sep 2021 19:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630868839;
        bh=El+5GyrIl4PkiwWm9Z7IcUITtOnGYfdrLInGmRe72FE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FtB6yX2WY5WK63cljLx8uZ3uMG1m4a+bCgJrwEenuG+GDnnK2njWY4JW/0pptxOU6
         OsEEzUVbPVDf9o0OW9w5/oJwys4YgqjPsFaMi8OwUTa+fWPI2f8ufvlVDAEkPaQpYe
         RBrE+5R6Ow3tEPM9ZJrdPUTEsRyw0/PHGeDi7N0e+dpCiHqIEQA4q5AiNZuq0W4Ae3
         gIOGagcBZerRKGP7gc8qAznTJa0iKTRWQHUr8URvCp5Pzn9S6Znbdx9U/YHf9Y4js2
         tWW8uWT0UaAHOlYimFSBbmaK1AxVQ9jW1ozVpQSrPN0lUslG/E2QYXAQMGXsXKVkVd
         KDOidtwXWYkgA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 5CE3460A48;
        Sun,  5 Sep 2021 19:07:19 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Changes for 5.15
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210903115014.28dc0da6@gandalf.local.home>
References: <20210903115014.28dc0da6@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210903115014.28dc0da6@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.15
X-PR-Tracked-Commit-Id: 4420f5b1be7b117330526f3eabd13d840f510b15
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 58ca24158758f1784400d32743373d7d6227d018
Message-Id: <163086883937.6256.15918643550524606687.pr-tracker-bot@kernel.org>
Date:   Sun, 05 Sep 2021 19:07:19 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Shijie <shijie@os.amperecomputing.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>,
        zhaoxiao <zhaoxiao@uniontech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 3 Sep 2021 11:50:14 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/58ca24158758f1784400d32743373d7d6227d018

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
