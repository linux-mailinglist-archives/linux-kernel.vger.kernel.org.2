Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 869BE41F38B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 19:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355436AbhJARrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 13:47:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:43774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355312AbhJARra (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 13:47:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 8EBAC619EC;
        Fri,  1 Oct 2021 17:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633110345;
        bh=50KEU2tGlqTXnkEzUvBVWrpJ77cLKCuts7/ISS9Stfg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=iQTRvzzd8a5NNlJX09ICpyZwXBCoZ1DdteeXkp1nbvOPfg+dnuYCi0AP/bdsrqKgi
         cPAeyAIxS9uAPhWmO6sdY+h7+r2Bg1e2QY6yUHOZTnFowisnqBhmpoFpVHUZ3csCk+
         BeRuG+xsU7s0B6G2qOCOjr1QJVtO58x7wwe4I5MMiGEDYUV8BpBS6ovXaBUFx+UGY2
         tRPoDfTP7oThTCFL/ULSNb7D3qOWwTwsKWQGH0v6ANanFoPn1nUQoICNTC73UeNShx
         KUQiJyPYQD9mBDQtqoSMCwT1XGrS0mCIwlGcLpyocasWve+wFFuHDCSinXLdi2sBmD
         Bt+HR7pUiizog==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 7F94E609D6;
        Fri,  1 Oct 2021 17:45:45 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fixes for Linux v5.15-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YVcw4sXKg6alXhmx@8bytes.org>
References: <YVcw4sXKg6alXhmx@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YVcw4sXKg6alXhmx@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.15-rc3
X-PR-Tracked-Commit-Id: f0b636804c7c4c564efbca5981e3c56b5c6fe0c5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 89e503592385fbed872c7ea1fb89931ece3409a5
Message-Id: <163311034546.16016.5734147883884656976.pr-tracker-bot@kernel.org>
Date:   Fri, 01 Oct 2021 17:45:45 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 1 Oct 2021 18:01:38 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.15-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/89e503592385fbed872c7ea1fb89931ece3409a5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
