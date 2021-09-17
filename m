Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E80840FDE7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 18:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243936AbhIQQbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 12:31:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:56956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243919AbhIQQbB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 12:31:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id B2A5260555;
        Fri, 17 Sep 2021 16:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631896179;
        bh=F+9ZYOY/fQCB+/cc3bWLn/U+CNBbgrbLdqp7h7nZ5Hg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=m38FJrdfUX6C3NvbwHdixpA9Zdjl2977a2g3SCaYy/X9GWcjxXMg7mXd7AF/g9gno
         uHEDVhIhIjVvGQd1LKSQBh4VBFtAIsRrvP/b2oM9CI6LGk9pQ1JwoeMiwHzCEB5l4J
         fmQnnAJE6u0vi4LeW4iwLwgluc5DyoUBdLKVg7DF8+vMEv13BqWFCdk41bWQpMblA8
         duY8ASeiXBDmlnL5Hn+vX1/z17RbfBJHMiw4m/aJDIa4/BxLA118sGNCvmfyAQZ5jc
         fsDo6m/3ahdbBbi36n9yB+cCFqIa5mELmaHSrmVKk0k17iG8bPvXcnfR4DO/S3BmjV
         IeOBgZHw5SqyQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id ACB5260965;
        Fri, 17 Sep 2021 16:29:39 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping fixes for Linux 5.15
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YUR6gpm+mTWqdil6@infradead.org>
References: <YUR6gpm+mTWqdil6@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YUR6gpm+mTWqdil6@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/nvme.git tags/nvme-5.15-2021-09-15
X-PR-Tracked-Commit-Id: 70f437fb4395ad4d1d16fab9a1ad9fbc9fc0579b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 65ed1e692f2b996292a5bd973200442816dd0ec1
Message-Id: <163189617970.30150.9881812220681119353.pr-tracker-bot@kernel.org>
Date:   Fri, 17 Sep 2021 16:29:39 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 17 Sep 2021 13:22:42 +0200:

> git://git.infradead.org/nvme.git tags/nvme-5.15-2021-09-15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/65ed1e692f2b996292a5bd973200442816dd0ec1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
