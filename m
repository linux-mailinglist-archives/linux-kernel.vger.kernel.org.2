Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9FE342955
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 01:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbhCTAJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 20:09:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:49868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229512AbhCTAJV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 20:09:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id A4F5B61982;
        Sat, 20 Mar 2021 00:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616198960;
        bh=UyFCj4v/8cbV0sd7GLfot4I6gShJKWeDUiZiBxojxBI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QTo1/0E99YLNxIgkIaaX85Z6dgCtaR/ssQmgp1tI1enosQlluB68z8KY/FXYembPu
         nvwy+bUQSXBcK/mORQcoqnLMOhyR827hspPdX0R/AZajfmOQDUhr3lMhS9+VLRGQoW
         jR1Ayc7k2/0ij0J+n2/yNQwN2vWz/kEIImqnF8jkW/0JXn7Yr7O6XIwEK2tnU+jczQ
         DNtbVaOaMslTcr2Q5bjfRq1jkzTHrpwpCIU1lAeaj1LIFyaJi8eIpiHor9dGAN4DUI
         uM6y4Prz35eFk1GqT8y/M9tK8tneHLMQr5kC1C41Cn8lRLmIFefKF+VOx7pS1U+klA
         c71x1B7M50BzQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 98CB8626EC;
        Sat, 20 Mar 2021 00:09:20 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fixes for Linux v5.12-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YFSHuWNVKFOTHJWt@8bytes.org>
References: <YFSHuWNVKFOTHJWt@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YFSHuWNVKFOTHJWt@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.12-rc3
X-PR-Tracked-Commit-Id: 8dfd0fa6ecdc5e2099a57d485b7ce237abc6c7a0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 65a103747104368cb1ba6f097dcc3f85b1dcf86b
Message-Id: <161619896062.24257.7896646706673366985.pr-tracker-bot@kernel.org>
Date:   Sat, 20 Mar 2021 00:09:20 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 19 Mar 2021 12:15:05 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.12-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/65a103747104368cb1ba6f097dcc3f85b1dcf86b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
