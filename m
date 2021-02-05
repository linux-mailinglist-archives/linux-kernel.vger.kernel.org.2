Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4FF31105E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 19:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbhBERJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 12:09:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:43598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233749AbhBEQcN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 11:32:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 7FE6F64E56;
        Fri,  5 Feb 2021 18:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612548790;
        bh=TuFNjPw1NsrOwjuRo3deQ7Iau/3JzS2c+Vvx+VpO4yA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=pUSxiIb+nPFA/B3n7GVwjiXtPRdn8tBBQIUbuZ8KbaAZ130Tl5Fq1hG+BFEIDGMGP
         oOiFSKcQed8jNCvl6o/MHoi6xyf1c8hBjuCoCaIHUfH07UveZCPPkuqJts6AntH+Jm
         6X0CHSNs3+TxxPTYrbVoeioCqd5CWXdY7c8xwnqd2d8mSmsmxOdLwrv3jiVCTKyaW9
         53UFQcs+6UqE2PdqOI7XrN7frLFiN1RT92iqJJd9s1M++V1EmGsxjwPCeyAjXZhHOn
         IV4exwKqrw0Rt4JCRXA3boPcrsgxn+P6guY/8cvDDed8zagR0HRp3owBALQbc+z41d
         6jlWjnVxQFC8w==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 7B15660978;
        Fri,  5 Feb 2021 18:13:10 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fix for Linux v5.11-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210205160146.GA28800@8bytes.org>
References: <20210205160146.GA28800@8bytes.org>
X-PR-Tracked-List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
X-PR-Tracked-Message-Id: <20210205160146.GA28800@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.11-rc6
X-PR-Tracked-Commit-Id: 4c9fb5d9140802db4db9f66c23887f43174e113c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 97ba0c7413f83ab3b43a5ba05362ecc837fce518
Message-Id: <161254879049.14736.13228089910092450378.pr-tracker-bot@kernel.org>
Date:   Fri, 05 Feb 2021 18:13:10 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 5 Feb 2021 17:01:57 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.11-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/97ba0c7413f83ab3b43a5ba05362ecc837fce518

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
