Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 082F740FFD7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 21:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343489AbhIQTax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 15:30:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:58260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235875AbhIQTaw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 15:30:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 7DAFE61019;
        Fri, 17 Sep 2021 19:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631906970;
        bh=MgAZhsC9YYXH0eMO0LIh/+e9w36OjRQfUqYYEFgnqvI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=mLQCrCl2Fgc7bZAnOym98F5MLn/oIixqG7RBHQKL/pokEUD7lJtHso5/J6AWf16rp
         9/hwuXyqA40tX3I4fllxAKYQoTdr+YeUqFQSDl/0aqtZ4McpdAfKoEzqU+S+7fmMc4
         zkqnLSYx9VycYg1JK4NvDbgNmrawLGUXAEL47zpNqNbvuqbhqRlPSlWfefAgZR/LLS
         uqPWoZhtz8FtFoF8uES3L9441mlJCLJlh9gcgp3KZP0d3cRha2MEerrCmdUwRT5A0H
         glHoN3+i0fT1gW/L/ykpixfvhi8tIXs6Ys3Z6apiYoHTItETaNYEBFNxgqEOQmqM/I
         EiL1v0wVGxzKQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 688ED60965;
        Fri, 17 Sep 2021 19:29:30 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping fixes for Linux 5.15 (2nd attempt)
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YUTEnFAls4dyIyJ1@infradead.org>
References: <YUTEnFAls4dyIyJ1@infradead.org>
X-PR-Tracked-List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
X-PR-Tracked-Message-Id: <YUTEnFAls4dyIyJ1@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.15-1
X-PR-Tracked-Commit-Id: 59583f747664046aaae5588d56d5954fab66cce8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b9b11b133b4a0b4f8dc36ec04d81d630f763eaa6
Message-Id: <163190697037.17353.4870116211073217387.pr-tracker-bot@kernel.org>
Date:   Fri, 17 Sep 2021 19:29:30 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 17 Sep 2021 18:38:52 +0200:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.15-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b9b11b133b4a0b4f8dc36ec04d81d630f763eaa6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
