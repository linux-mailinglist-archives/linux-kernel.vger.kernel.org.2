Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8883BAA2A
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jul 2021 21:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbhGCTn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jul 2021 15:43:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:57042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229649AbhGCTnX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jul 2021 15:43:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 407256145D;
        Sat,  3 Jul 2021 19:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625341249;
        bh=ssUkt0riviV1IsJVUIQXNg7JEeb5zqDAj9uEW5cJsNE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=WgPc1x6OYKMBkqAEYzepy8vl/pb5nRfzgN2jDklx3RI+UY6gePCTaK5LJQUonK3Sj
         t4heA1oRe7Bw+pvZaDq7BfUri59Dr4qwdbnHooQo7sV0KlwfeBKlIm15w1Itr3Q1Fq
         hCZWhBBLW0qvyNreOy+8NNZO0Hd64B5jvWVzaukpwadEnJ+kizqVPZPT8ulIrO0g2l
         FYnCMJWpwM87qfp/Eu18ERihkl97lGwI+zBtmhIWv004f6MKns1tfVUQTVdnr2NDTK
         KigPvBmhatzyijwQjNs6luJKpbJiZjIQdy1Vn6BLOGrd6B5AX6OIB2Z3lEgTJ5Ch1H
         sHKYdapqK7gpg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 3914360A37;
        Sat,  3 Jul 2021 19:40:49 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Updates for 5.14
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210702095047.75807884@gandalf.local.home>
References: <20210702095047.75807884@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210702095047.75807884@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.14
X-PR-Tracked-Commit-Id: 4030a6e6a6a4a42ff8c18414c9e0c93e24cc70b8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 757fa80f4edca010769f3f8d116c19c85f27e817
Message-Id: <162534124922.29280.4184107657109217480.pr-tracker-bot@kernel.org>
Date:   Sat, 03 Jul 2021 19:40:49 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Austin Kim <austin.kim@lge.com>,
        Chunguang Xu <brookxu@tencent.com>,
        Colin Ian King <colin.king@canonical.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ed Tsai <ed.tsai@mediatek.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Joe Perches <joe@perches.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Paul Burton <paulburton@google.com>,
        Qiujun Huang <hqjagain@gmail.com>,
        Wei Ming Chen <jj251510319013@gmail.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        zuoqilin <zuoqilin@yulong.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 2 Jul 2021 09:50:47 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/757fa80f4edca010769f3f8d116c19c85f27e817

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
