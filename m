Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3640F407FCF
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 21:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236080AbhILTyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 15:54:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:42254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232112AbhILTyg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 15:54:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 087226101A;
        Sun, 12 Sep 2021 19:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631476402;
        bh=YtLTJQGBFk8IGQYZ750iFkkrpIqI2W8WlLiC0KUB25Y=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=uhKcjwSuO3qWO4zNzoAfchdJDkgSQoQ6fhAK5tWuav4Nd9NDMKkO7HhhhfolGfMef
         laAekWjiR6smQXwO5p2vb/AzZ5MHU+ATo1Wgct6GFl0oU5S3TwBn6F2ktzH/o5zIrz
         p830KT0XITfAtTv4iIeeQMe5EsApQJYVgZeheGZtWGgz6nzOJFrt+8mXi9k9N828NV
         Y0vr5qsbLizueDDg0wS+hUcmFdHrK7YuM4G3eUTAURWXN16VsQnJ8qtKEaMZ5Jtg5x
         pEFoWKLPbLxucFZivqNCsuTlZOui8ninG7evkqZ4g7gizA6smDgiZD/wNQBC401Yqb
         jpbvwuhbIOeTA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id E9283609ED;
        Sun, 12 Sep 2021 19:53:21 +0000 (UTC)
Subject: Re: [GIT pull] smp/urgent for v5.15-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <163147543117.733664.1844354962871534405.tglx@xen13>
References: <163147543117.733664.1844354962871534405.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <163147543117.733664.1844354962871534405.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-urgent-2021-09-12
X-PR-Tracked-Commit-Id: c9871c800f65fffed40f3df3e1eb38984f95cfcf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f306b90c69ce3994bb8046b54374a90a27f66be6
Message-Id: <163147640189.15687.10229590781548665005.pr-tracker-bot@kernel.org>
Date:   Sun, 12 Sep 2021 19:53:21 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 12 Sep 2021 21:40:21 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-urgent-2021-09-12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f306b90c69ce3994bb8046b54374a90a27f66be6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
