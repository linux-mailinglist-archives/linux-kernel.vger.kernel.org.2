Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB3F441B849
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 22:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242572AbhI1U1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 16:27:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:45376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242315AbhI1U1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 16:27:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 31B8561052;
        Tue, 28 Sep 2021 20:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632860722;
        bh=zMMlt5PKyuh+lIN7U4JmYlNnD2nxTxFYyGFkSR4dRFE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MXvrpia1nNe9ood3xQYd6U+mNtWjmQ+N3dFVL+aOp6nwU9HrgsnF2wnX1Z7DvH6Ka
         eVGuiTGSvYJ7nbi+3TnLzD1cVUpMqHEoDrjWLOE11/ZHaZS5O4x6wBVVPcQ/nc3NVz
         QpOWCaBA0DK1+aQ1DVdArhrd7Nd/gD7HPOCwauObdiAsajIKLEmyFMybqZKcX3bdH+
         JnD1M6ZYzkEBwYYfqgfEq/NTbfyGlLi6NZ95zIXdXO8BaPpbbPo9kEg7JMSShhp6XK
         8z7bAT/JDT2xs8PX5QsyFBB0unnMGit5i017xa62oGa2qhTy1lhJL//96zCf1Iaaie
         em5TZFtc1UuQQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 25AF2609D2;
        Tue, 28 Sep 2021 20:25:22 +0000 (UTC)
Subject: Re: [GIT PULL] NIOS2: fixes for v5.15
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210928130803.249346-1-dinguyen@kernel.org>
References: <20210928130803.249346-1-dinguyen@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210928130803.249346-1-dinguyen@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git tags/nios2_fixes_for_v5.15_part1
X-PR-Tracked-Commit-Id: 9523b33cc31cf8ce703f8facee9fd16cba36d5ad
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dca50f08a03eba5bc7a6afecca3f8ab0029b7a6e
Message-Id: <163286072209.20126.4287645746699261384.pr-tracker-bot@kernel.org>
Date:   Tue, 28 Sep 2021 20:25:22 +0000
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     torvalds@linux-foundation.org, dinguyen@kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 28 Sep 2021 08:08:03 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git tags/nios2_fixes_for_v5.15_part1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dca50f08a03eba5bc7a6afecca3f8ab0029b7a6e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
