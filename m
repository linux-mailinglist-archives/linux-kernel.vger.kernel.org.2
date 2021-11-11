Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B017444DE57
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 00:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234557AbhKKXM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 18:12:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:37118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234457AbhKKXMJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 18:12:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 2E26961267;
        Thu, 11 Nov 2021 23:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636672160;
        bh=vjJPbZUmaLWYS4CDq86wRLR85k1CkTk1zTMiaLTSahc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KWcVpouOIkfdnJbYCJh26d755hrGEy28hBsNnYmFu/3qT4rTmHGn2v+ROyI5m61IS
         vfDQulk2g7qiKsFbSEK0lY4h/qILiSWpRDu9FQY77Sq8V8cofHHGDZHrxZBaAQJsKe
         geI0GmZUWgHDEc0YYEtsTJo9KUlwJZdYQDV/cQUPVzQbw8j4avBMP8R2R9gf3r0wus
         9BKPKAn7yAvjL4kHFPptYQvDcVNiPflMNRaZbc7AgI8JJ4WkiWMRKoj+loGA98odBb
         ac7jbDNPeBwofPLC+2QjuCum75mLHMIQ4pXuy/5XCgkI8ngUZeeM/2PXy5ovOrQ4tQ
         +NgUDHX+ebtrA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 28807608FE;
        Thu, 11 Nov 2021 23:09:20 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Two locking fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211111090859.16098063@gandalf.local.home>
References: <20211111090859.16098063@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211111090859.16098063@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.16-3
X-PR-Tracked-Commit-Id: 2e6e9058d13a22a6fdd36a8c444ac71d9656003a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 600b18f88f2625ba48542dfeaa5fe8b23b3fd2c4
Message-Id: <163667216015.13198.10970010459884159039.pr-tracker-bot@kernel.org>
Date:   Thu, 11 Nov 2021 23:09:20 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Olsa <jolsa@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 11 Nov 2021 09:08:59 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.16-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/600b18f88f2625ba48542dfeaa5fe8b23b3fd2c4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
