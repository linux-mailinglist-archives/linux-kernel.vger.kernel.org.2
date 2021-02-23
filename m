Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32FF8323392
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 23:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232450AbhBWWEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 17:04:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:41754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231284AbhBWWD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 17:03:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id BD81160235;
        Tue, 23 Feb 2021 22:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614117797;
        bh=ct9fGMDzbYU8gXhVMufO1J3Fn9cJAFI85/Jupld80u4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fKFQdmSDbGAfd/uK9LwG6qHWJQNGP42/2vdE9fi1pkkJwy2RqiImzJhNa56waPJae
         9k4/97WUT4igiXoUj8A5Tay/vPTVQwscpBUoPZQnt1m5lHdLpQlcIQBbk53b+VPcdU
         GdRfwMeHd0qkO+mJZS/t4YbMvFqK4l+irgsSA75FsxWQ0JufFXw+ERwfYvZt+1MEES
         9xkPiMLdN4Q/VhuZAN++zvG86uQYXktBfVawMt/0vZisMnK4nang+roPBa7JpteBoH
         sLSmYiD4hYnY/zZni5HdbTosMu1vG6rmCZfsr3Qn5wBkFb0LDJZajkOFw8IipHYBwT
         xkf5A/0SBNNvw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id B72AA6096F;
        Tue, 23 Feb 2021 22:03:17 +0000 (UTC)
Subject: Re: [GIT PULL] percpu changes for v5.12-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YDR2LTclQGy7OHKc@google.com>
References: <YDR2LTclQGy7OHKc@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YDR2LTclQGy7OHKc@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git for-5.12
X-PR-Tracked-Commit-Id: 258e0815e2b1706e87c0d874211097aa8a7aa52f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: aa8e3291729fd885351af0b077330721d4bf5db9
Message-Id: <161411779774.8064.16063264545868620073.pr-tracker-bot@kernel.org>
Date:   Tue, 23 Feb 2021 22:03:17 +0000
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 23 Feb 2021 03:27:41 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git for-5.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/aa8e3291729fd885351af0b077330721d4bf5db9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
