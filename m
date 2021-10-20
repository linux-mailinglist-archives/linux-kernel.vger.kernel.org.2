Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 725464354BC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 22:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbhJTUsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 16:48:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:39930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230269AbhJTUsN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 16:48:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 13DA760F93;
        Wed, 20 Oct 2021 20:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634762759;
        bh=wGDFcbqhC+mo+7WXiL1S5yCgXcI7n/gryCE5KuVFVW8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=T2d4PtJblAIGbEKFYOJvufiwm9TkOP9BQ3hCfz1SPAQ3Vo5JFtS8M+zUbQIwPo177
         2pJBvYljbo8sO0omeas8BCOMYphr2lqpO92/bm/7G6SrjkP10PoCN0HQAQ0VyCt9J2
         6FRs6lU3fsF1gxwoYr7iPi29aPfwar/U7o6WXyTPS6zjqhavpj6BuCwUr0BZXQZPV1
         xv+G7zSEmqBmYHcR/0MFPCqTNtgNY6vmBYv/delCEeO0Z1BQc1UYHtxslfL0tZZKCK
         zTL1lH8zYI16sG51qNuf1QJrlHVWVDY42iOGzEhN0WyPQzMvhM48AJjMd5DWJyWQ8h
         LhtJDV4tyqNcw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 04309609D1;
        Wed, 20 Oct 2021 20:45:59 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping fixes for Linux 5.15
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YXBOiy+yS4pwwHeQ@infradead.org>
References: <YXBOiy+yS4pwwHeQ@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YXBOiy+yS4pwwHeQ@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.15-2
X-PR-Tracked-Commit-Id: c2bbf9d1e9ac7d4fdd503b190bc1ba8a6302bc49
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 515dcc2e02178ea8af2ea53b4ae5bdb6875b53ef
Message-Id: <163476275895.17864.16484280525762467197.pr-tracker-bot@kernel.org>
Date:   Wed, 20 Oct 2021 20:45:58 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 20 Oct 2021 19:14:51 +0200:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.15-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/515dcc2e02178ea8af2ea53b4ae5bdb6875b53ef

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
