Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E157639358B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 20:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235894AbhE0Sn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 14:43:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:45226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232416AbhE0SnX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 14:43:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 5C080613D1;
        Thu, 27 May 2021 18:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622140910;
        bh=VXatjFi7e5S32DXaMFXcfx1fqakx8PI0p8STJiuxb+M=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=F4IPD0RYj2DDP6oKicO14nx5hhWa8yiTM6kqwoLPHgp1z3Bid46s/zFzTfKzMQPUS
         xB2qdxFFoj2nxNIbneC4bdrYjh6micyQ0lN2RvnUygiH6M3XUVRDlnPEl/QuQWcz0k
         N/F9qKKnVkFcktl8olZMWfiHz2Y+xNrFyXVQVDgF849uGVqGo5IXsXKhyEUr2bYxTN
         crD0KAFZdSSmmrVfooSzbz5BKY5N9J9Lb37rEbpWoVl3Z5t91n3ppGr1La/AQrz8rz
         3rqUxgxa4rECIlBB1Dh336whKTMmUga2MTJ/VVgxMZ9txdRKLmbWH7CsNBin6o7Wjz
         Y1dxF9E4cUlCQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 5279260CE1;
        Thu, 27 May 2021 18:41:50 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fixes for Linux v5.13-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YK/dheM2NZz6KOkb@8bytes.org>
References: <YK/dheM2NZz6KOkb@8bytes.org>
X-PR-Tracked-List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
X-PR-Tracked-Message-Id: <YK/dheM2NZz6KOkb@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.13-rc3
X-PR-Tracked-Commit-Id: 0ee74d5a48635c848c20f152d0d488bf84641304
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 96c132f837ff0639702d04d229da190f636a48b5
Message-Id: <162214091033.4321.14027615366383525738.pr-tracker-bot@kernel.org>
Date:   Thu, 27 May 2021 18:41:50 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 27 May 2021 19:57:25 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.13-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/96c132f837ff0639702d04d229da190f636a48b5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
