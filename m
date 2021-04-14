Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE5F735EA7F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 03:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233188AbhDNBpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 21:45:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:41998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231976AbhDNBpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 21:45:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id E5823613C1;
        Wed, 14 Apr 2021 01:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618364689;
        bh=F8VTLZG5NvSY5d3GRUoCxfp2x2I3oidbJK8v9JwFiAM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Xoc3fzo0IyoOhdas9OBn+3MuPY2sUljAnzvaGWr4UJ9b8hrt+D6U+xStMe1Z6YdFg
         TVF7F27vXtBJXuPu571Q2ULunLk3RKMGRENbqUKKATIR/mZNusfCw+Pq2CpQplTfkq
         0muJHwg86D3m7alpQliSyewA702FJBBcWD+PWpk3fioNE7guc/B26db63cSnGeicmW
         vhfaVtMwFEk+Bi7qM+ycTNdVkxFx0Kik+KnJcBAL9UiDxzZ+yhA4nh5kcunc9VZx6N
         Er68BnLZ6iqEXXcG2YFsiObNdr5KV990LlxUaDR67Jr6Qf7o4GPDDFQB0Vn7fz+wrN
         V+95MyRF3Z4NQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id CFB6F60BD8;
        Wed, 14 Apr 2021 01:44:49 +0000 (UTC)
Subject: Re: [GIT PULL] tracing/dynevent: Fix a memory leak in an error handling
 path
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210413203716.339a87ee@gandalf.local.home>
References: <20210413203716.339a87ee@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210413203716.339a87ee@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.12-rc7
X-PR-Tracked-Commit-Id: 8db403b9631331ef1d5e302cdf353c48849ca9d5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 50987beca096a7ed4f453a6da245fd6a2fadedeb
Message-Id: <161836468978.24992.16322720666548931033.pr-tracker-bot@kernel.org>
Date:   Wed, 14 Apr 2021 01:44:49 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 13 Apr 2021 20:37:16 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.12-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/50987beca096a7ed4f453a6da245fd6a2fadedeb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
