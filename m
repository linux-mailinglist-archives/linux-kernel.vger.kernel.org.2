Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A84203266EE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 19:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbhBZScr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 13:32:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:59770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230222AbhBZSck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 13:32:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id EFEA764F2B;
        Fri, 26 Feb 2021 18:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614364320;
        bh=nfr9bsKgpkokkCMWV4NOLsLtV7H42YxXyVLg5Qio1pQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Tg+isQXM4OPE3BeRNFTlxkIQpjFAwBax2iNLTUnf80TGGoxlPrksbWA/7XEXj751I
         XlfERXc2sjwNhJJIwY742IzyqvcV09YxVK8tIg6vaZL/HmDD2eCcGsydQYu6qpY+L4
         xRXAaHH2OV2/yW5YzAFc1eVD5VMvf6/QstdJeOBjeN7324YxN4RoIS7l8O3fuqtnKE
         262yPazZSGxnyAQ0LEqPAfRD3kWcZOFEbMw8srEACvZZ88vDAUgZIrO/4eJLBWODgc
         +gqFn/BrO76W/csi3LqZmCpDAWw6KQC+R534G/I0SnZZr4RNp+u0PWD5EjxNyynCyh
         Z9mlS28dlRMQQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id DC7B160A0E;
        Fri, 26 Feb 2021 18:31:59 +0000 (UTC)
Subject: Re: [GIT PULL] arm64: Fixes for -rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210226110916.GA14247@willie-the-truck>
References: <20210226110916.GA14247@willie-the-truck>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <20210226110916.GA14247@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes
X-PR-Tracked-Commit-Id: 3c02600144bdb0a1280a9090d3a7e37e2f9fdcc8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8f47d753d4ecc6d3e306e22d885d6772625a3423
Message-Id: <161436431984.9780.6197020488143132898.pr-tracker-bot@kernel.org>
Date:   Fri, 26 Feb 2021 18:31:59 +0000
To:     Will Deacon <will@kernel.org>
Cc:     torvalds@linux-foundation.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        kernel-team@android.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM Kernel Mailing List 
        <linux-arm-kernel@lists.infradead.org>, maz@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 26 Feb 2021 11:09:16 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8f47d753d4ecc6d3e306e22d885d6772625a3423

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
