Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43B2D3FF491
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 22:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236589AbhIBUGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 16:06:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:44016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231140AbhIBUGU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 16:06:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id D658B61053;
        Thu,  2 Sep 2021 20:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630613121;
        bh=TKz9wQjgogmm5POQohlH3M/HvBAUuWrZHO/LRP6AxoU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GsxatSSCrvg18ysWI2GIYCtPmS+rZfwN2hvo135pfawmUsR2SLkLiF3w9+cb6UWbw
         yqBH3njX3J1Obhxz1JqFhqOfKyFnm1lFxI2KhJ/DKxThHue1SBowEm+LHKAAujmaue
         huPggTEvGCX/pz3gwilRrL93aHQOHW5NQZrlohH1M3QulPwP1CDrlbbW9hZDM40aM+
         e2FI0NFu1QivjnDm8E/+3KDnbdEjDhsAL36BL9OWK0CwLp+idQpyI11aP8FaUUGnI/
         65KETKvem2kNKuonQ4F4re7MZrdsT8tlKWBoWmtlPcLjhD/lthY2ChdgS715x0na3F
         4m1OTEBKWaZ0w==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id C04E8609D9;
        Thu,  2 Sep 2021 20:05:21 +0000 (UTC)
Subject: Re: [GIT PULL] memblock
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YS4h4R2dmpd2qDQ9@kernel.org>
References: <YS4h4R2dmpd2qDQ9@kernel.org>
X-PR-Tracked-List-Id: <linux-mm.kvack.org>
X-PR-Tracked-Message-Id: <YS4h4R2dmpd2qDQ9@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock tags/memblock-v5.15-rc1
X-PR-Tracked-Commit-Id: e888fa7bb882a1f305526d8f49d7016a7bc5f5ca
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 612b23f27793ea1cf41621ca6dc552eb4699f41c
Message-Id: <163061312172.10011.12887233719604757389.pr-tracker-bot@kernel.org>
Date:   Thu, 02 Sep 2021 20:05:21 +0000
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 31 Aug 2021 15:34:41 +0300:

> https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock tags/memblock-v5.15-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/612b23f27793ea1cf41621ca6dc552eb4699f41c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
