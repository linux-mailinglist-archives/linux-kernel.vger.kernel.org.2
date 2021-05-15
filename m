Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62104381A53
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 19:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234230AbhEOR4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 13:56:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:43098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234175AbhEOR4Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 13:56:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 2C8BA613C4;
        Sat, 15 May 2021 17:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621101303;
        bh=GtqlUivw78chzmAjVziwKIJ7VBVeQ3D5Dydd1uwo9b4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=I+T+DsSlFK94z1P+dZyV9Oe65OF+jKhccOqIZXWbjGMlnFDXTTSXDPLkQJjiFV1do
         IdCRWevx2XfY6gOwldtWKoW8RVmB22YQpPw13XdECB8iMrGuuzgyh0SNUzsgBQLtch
         tFL2Ai9wjhfPnh46PyztMWQkxmgctTZsNQA6yBCvVu4kqVGtYU0UzHI/QId5Ffm9M+
         Fgz0zLUjEcRKb3NIyypORUgXW/axczgbXgM7IvBai0PqKDD3UGbbbWZ/9G3vPcRMLR
         GZ1yzsXbX3hz2z9LZTsCpVcZhQLpX2GZ/VEoazOulAVoSCtCPgNUHVafapLRAX5WVp
         tyFMl5UZUSiSQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 2364E60A24;
        Sat, 15 May 2021 17:55:03 +0000 (UTC)
Subject: Re: [GIT PULL] objtool fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210515074645.GA145878@gmail.com>
References: <20210515074645.GA145878@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210515074645.GA145878@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-urgent-2021-05-15
X-PR-Tracked-Commit-Id: f66c05d6baf36069c01a02f869bebb75586f2318
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e7c425b7441a96b95a75304aed369077f71e3e83
Message-Id: <162110130313.14651.8188315454570518.pr-tracker-bot@kernel.org>
Date:   Sat, 15 May 2021 17:55:03 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 15 May 2021 09:46:45 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-urgent-2021-05-15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e7c425b7441a96b95a75304aed369077f71e3e83

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
