Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C81CD3F3502
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 22:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240562AbhHTUK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 16:10:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:38940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238427AbhHTUJt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 16:09:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 3111B601FF;
        Fri, 20 Aug 2021 20:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629490151;
        bh=PbX2Hj4FpuYYCVDGQLoE35eKLD1v4JJovskOxor4DqY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=RkYpUfWnkgo+dgeeCnXOeNJ5ACyhBOXzCEm+0Zzw3pt7vW+Lhvli9HRhbZqUa3UHJ
         rTwtQVA94udQPlxqjwCKffUBCyyHaOsN8c5DpM121k0+h82TJ5qMtIpVAWBmEKBe0Z
         84rn9gvJDBtB/cdheUmlQgsQesQ6ecFmpnYtdDo1vK4RaZBFj8GGaBfF9vV1ubCcLt
         7WL8P+SDNlyRDnu/eW4gM8b08f2FdG5o/hw7TokDwNSfqDYXvs1duimI/rzMFPUzF9
         RkSaJbs7/aoMba7aHvU6ECLHCaw8il2L6DBiPJ2vkHYGx0Nmw9fIvOdfmGVSbfxKM2
         yT1gpqLHZOTog==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 1ED5760A21;
        Fri, 20 Aug 2021 20:09:11 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fixes for -rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210820085302.GA17037@willie-the-truck>
References: <20210820085302.GA17037@willie-the-truck>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <20210820085302.GA17037@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes
X-PR-Tracked-Commit-Id: bde8fff82e4a4b0f000dbf4d5eadab2079be0b56
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 54e9ea3cdb13884b8d3a0c13b9b92bab4a1c96f5
Message-Id: <162949015106.21370.16530945310394925488.pr-tracker-bot@kernel.org>
Date:   Fri, 20 Aug 2021 20:09:11 +0000
To:     Will Deacon <will@kernel.org>
Cc:     torvalds@linux-foundation.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, maz@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 20 Aug 2021 09:53:03 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/54e9ea3cdb13884b8d3a0c13b9b92bab4a1c96f5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
