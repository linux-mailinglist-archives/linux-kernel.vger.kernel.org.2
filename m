Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6D93D2B98
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 20:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbhGVRTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 13:19:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:32952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229906AbhGVRTy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 13:19:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id AD7A56135F;
        Thu, 22 Jul 2021 18:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626976829;
        bh=NqPkRR7g/po4paDQaTml+qqx2l9t3M+pxAkEBuqR8Zo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QonTv+FdT0iqZNhJSENMWKuToZklURDFrZP4LYI0s18O3cEAZWllkt4xEDwZaHlTy
         LlcehFGoeudem8gvLGg6ACMRS7JaEQw+iem8G5y7Ar7y3hmOpHFxDn2u8HT1Iwaf8c
         plspfQ1B6RXS39Wniv0Ua+kDHyN176Oj/FdpqWkYi+KhZ6clAgsFgHvxv5mgCAz5Ju
         0ctcTDkT2zV8AG0dp5jf3TdMlAaHMj4fjpOZdu305K+7byMx5qW2mX5Zal4Pq3Qy3I
         fT0bJFV3lS3JcxGESaFjuY7Gretoc36PcZ6aSjXrVQ9s3rn3XX8LkMFtD+/zFKO1O9
         ox0hg9xPtiSlQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id A7E5860173;
        Thu, 22 Jul 2021 18:00:29 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fixes for -rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210722155509.GA12627@willie-the-truck>
References: <20210722155509.GA12627@willie-the-truck>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <20210722155509.GA12627@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes
X-PR-Tracked-Commit-Id: d8a719059b9dc963aa190598778ac804ff3e6a87
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9f42f674a89200d4f465a7db6070e079f3c6145f
Message-Id: <162697682968.6012.16190544810150306970.pr-tracker-bot@kernel.org>
Date:   Thu, 22 Jul 2021 18:00:29 +0000
To:     Will Deacon <will@kernel.org>
Cc:     torvalds@linux-foundation.org, catalin.marinas@arm.com,
        maz@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        mpe@ellerman.id.au
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 22 Jul 2021 16:55:10 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9f42f674a89200d4f465a7db6070e079f3c6145f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
