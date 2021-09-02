Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED9C3FF27E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 19:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346745AbhIBRij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 13:38:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:35644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346741AbhIBRiS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 13:38:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id F3189610FF;
        Thu,  2 Sep 2021 17:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630604240;
        bh=d5f2d51tKM2k6GfytW5hu9z0ZTLWTCHVzTv3dXBEACw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Ujs/U7tx0EZjrH4F4+Scj0F8/bjTqkyEoqmx5tjFqWVchvKGiKcpkewh4gk0BQcKf
         3EOKfey+nqIrgF2p+YT5wo7OdenarA3zOfEsU3bzz2QitTaKKORcaDzlsuKUikqBmJ
         /wmU553+KzxWpIIjB0FKDee5zwx/jxDWdjax89B9WOzedtEpKOxgtFqgJWIDLfJsht
         JokiC8TECYD1GkOQqARwD81SyDM2ziF9vB1Ftm8rMA/UvrFGwe9qM2EOGqCken9ANX
         tUTwvkJMJk98hCc+kq1KMnnX9yBpa6UU6NUV0rx4U/ipMidOw/HppvQahOlL1zgJqc
         pEQFwuX9B8bqA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id ED99F60A0C;
        Thu,  2 Sep 2021 17:37:19 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping updates for Linux 5.15
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YS9kkqNhU0TPA9Fr@infradead.org>
References: <YS9kkqNhU0TPA9Fr@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YS9kkqNhU0TPA9Fr@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.15
X-PR-Tracked-Commit-Id: c1dec343d7abdf8e71aab2a289ab45ce8b1afb7e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4a3bb4200a5958d76cc26ebe4db4257efa56812b
Message-Id: <163060423996.29568.10200852879962767088.pr-tracker-bot@kernel.org>
Date:   Thu, 02 Sep 2021 17:37:19 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 1 Sep 2021 13:31:30 +0200:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4a3bb4200a5958d76cc26ebe4db4257efa56812b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
