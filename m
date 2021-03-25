Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97087349A0C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 20:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbhCYTNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 15:13:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:43202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229833AbhCYTNQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 15:13:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id ED83761A31;
        Thu, 25 Mar 2021 19:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616699596;
        bh=Vwdd0VfnA4avDTfY8Km38Gx6ouWMoa0rt3xnJ2sB1Z8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ZEGPUVTKQznFjmXZzFBEQAuw7YANwzcJyUP2ZPCkKVrvsBk8d9u5lKrJSRngC1zNx
         XChXgZtZsJHbYB7VLAP+aWhGn28A+jKvmf68BKZACEdq9FiOuvQiK41XuKBet3Ezqu
         6bRUyg3JOSxF2jbmMJOi6wv8duwR0MwBt7VfPgr4dj6eaBQ4uR7IOK0U1OUEIL0veF
         itOaBrgGkKUamMEdX+Zxorch5viS9DY3fafEBv2New/Kf0MzEKKUgNsDCwGSK8Hg61
         /VXyYMzgsEX+XAVR82/MkvDYR+Cu58/KBrPcus2DtO0pO/HTSmkWoAT3IG506Ipb23
         avGN51jnThsXw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id E855C6008E;
        Thu, 25 Mar 2021 19:13:15 +0000 (UTC)
Subject: Re: [GIT PULL] arm64: Fixes for -rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210325145443.GA15172@willie-the-truck>
References: <20210325145443.GA15172@willie-the-truck>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210325145443.GA15172@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes
X-PR-Tracked-Commit-Id: 20109a859a9b514eb10c22b8a14b5704ffe93897
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 43f0b562590e7ac16b74b298ab80b5fb290d02af
Message-Id: <161669959594.4184.4251112826359081830.pr-tracker-bot@kernel.org>
Date:   Thu, 25 Mar 2021 19:13:15 +0000
To:     Will Deacon <will@kernel.org>
Cc:     torvalds@linux-foundation.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM Kernel Mailing List 
        <linux-arm-kernel@lists.infradead.org>, kernel-team@android.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 25 Mar 2021 14:54:43 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/43f0b562590e7ac16b74b298ab80b5fb290d02af

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
