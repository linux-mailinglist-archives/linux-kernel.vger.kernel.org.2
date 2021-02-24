Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54C1232440E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 19:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235411AbhBXSuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 13:50:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:34462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235031AbhBXSrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 13:47:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 133C164F14;
        Wed, 24 Feb 2021 18:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614192395;
        bh=wccjhusve2dyjRL1HJyUVCR22tEUmUjmRphLm7hPUZo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=CyBcyNICojGga/2cp1jrQWDk7wTlDILUHfR4uJqgy48A2vMmnhOb1chOc8LeUE7Q4
         Tvx76G62UKdRL+07jZnoNMfCFwyNFnxWs0jhINVUN6nw8hPosUzlH9gvmUB3qUdLWu
         raIGcfaYjX7ZlOjYXfKwufL/DTdlzcCs208boOQlrUSfI8lV1vyVPPnQz0KOemsc3N
         yy6HfpA/kDHCbo/R4vI8yOpPZpfFeVvGqefcsjy3pqnB/JiJu+6Jts4oMQVwvuCnbQ
         GMvmKqHkCApyXeesliwJIbOuZWBnebi10XKiUr2ItgtSyKLpGQAqgxSTTnb4DRgayG
         b51VRfqb3QxIA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 0EE46609C5;
        Wed, 24 Feb 2021 18:46:35 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping updates for 5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YDYEOTIu02GKL8T2@infradead.org>
References: <YDYEOTIu02GKL8T2@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YDYEOTIu02GKL8T2@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.12
X-PR-Tracked-Commit-Id: 81d88ce55092edf1a1f928efb373f289c6b90efd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a4dec04c7ff4307973ba502ce7b27330d9fe04b7
Message-Id: <161419239505.20610.6827236057190476216.pr-tracker-bot@kernel.org>
Date:   Wed, 24 Feb 2021 18:46:35 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 24 Feb 2021 08:46:01 +0100:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a4dec04c7ff4307973ba502ce7b27330d9fe04b7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
