Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C972B3D4F47
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jul 2021 19:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbhGYRJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jul 2021 13:09:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:48402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231296AbhGYRJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jul 2021 13:09:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id B536D60F11;
        Sun, 25 Jul 2021 17:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627235386;
        bh=7pETpqCU40IXUaFx5pvopBByYFHbdyxIvzK1JeQNbOE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=bAQCAKKRRS1boVg3TYyp36sWLiQ9I0SeVoZnKTd43M5Jyl6chC/02FbtB5btZVZKx
         f6FCc4VrH8jW+Q8+l5eF153iunNOFVFCX/jCUpEA5XJpaHyTiPPGpoawvk1cHBO7dv
         i+qBzZwCtK8IoPX1tz63A7JGpdSVjAT5sW+H8Q0gNQMxj14C4vGV3P+JSSiAhuKKYY
         LV67XUTU979vdwYNxE19knooUuqsn8J3ZW4QLyXbhTEHMb0rvrdhbJOXiwZxkbKud7
         nFI1xIuzCNleGLciNcv9A2zZ5Ob7KFS4zyAWhx2AESIWXGkTLo2EfhAUeKmXYF9jcC
         E1mgnOQhEYaQQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id AEC6D60A2F;
        Sun, 25 Jul 2021 17:49:46 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping fix for Linux 5.14
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YPz+qQ6dbZVDbMwu@infradead.org>
References: <YPz+qQ6dbZVDbMwu@infradead.org>
X-PR-Tracked-List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
X-PR-Tracked-Message-Id: <YPz+qQ6dbZVDbMwu@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.14-1
X-PR-Tracked-Commit-Id: 40ac971eab89330d6153e7721e88acd2d98833f9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 04ca88d056b44efee1e7635c74c0be3705efc72c
Message-Id: <162723538670.30584.9150662147851995225.pr-tracker-bot@kernel.org>
Date:   Sun, 25 Jul 2021 17:49:46 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 25 Jul 2021 08:03:21 +0200:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.14-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/04ca88d056b44efee1e7635c74c0be3705efc72c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
