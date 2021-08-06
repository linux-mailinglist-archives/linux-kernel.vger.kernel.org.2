Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA8B3E2F78
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 20:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243450AbhHFSsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 14:48:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:44636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242857AbhHFSsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 14:48:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 57ACB60EE8;
        Fri,  6 Aug 2021 18:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628275688;
        bh=WI4hW/haGgEwIIV9vMXBm5ce9NDTymfVw60guHCqDs4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Bi4VVHCdtYdDBUGdBfWbVg0sRGNQ3NzEiyqTfqyEmtEKMjX/htCfstUY6HSjhFwXU
         NPqnASxh5X+oHpkPg85azpTXmKw3w5C3VsDxJQaA2LqGX63ZsZNEOSxnQ8IDiitLdu
         m9Z50JR91aTZPMXV1nVJtdwylLA5B4e8Zq/iEbNd16R8HH6bm72iAc/SPt7iO1VxqU
         1llwxEG6Ibkl+T0w20S+ge73N69256MzVO2aaO3PGWlKocXs5n2PvvhvxyKlJcTWC2
         zHd7I4ig/JSJ5KLGrqOe44GorI90joXF4kLpD5vhA7XF9qJB186zwTggJV1N6IP1BB
         vlLH1/XAt1NrQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 4D52460A72;
        Fri,  6 Aug 2021 18:48:08 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fixes for -rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210806135331.GA2951@willie-the-truck>
References: <20210806135331.GA2951@willie-the-truck>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210806135331.GA2951@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes
X-PR-Tracked-Commit-Id: 0c32706dac1b0a72713184246952ab0f54327c21
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 73f25536f27182ae3dcf4c0b91b1280cbbac7be3
Message-Id: <162827568831.18689.10193362789451281830.pr-tracker-bot@kernel.org>
Date:   Fri, 06 Aug 2021 18:48:08 +0000
To:     Will Deacon <will@kernel.org>
Cc:     torvalds@linux-foundation.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 6 Aug 2021 14:53:32 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/73f25536f27182ae3dcf4c0b91b1280cbbac7be3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
