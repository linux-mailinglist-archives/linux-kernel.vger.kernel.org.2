Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0F537588B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 18:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236005AbhEFQg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 12:36:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:35040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235793AbhEFQgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 12:36:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 8D12C6113D;
        Thu,  6 May 2021 16:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620318927;
        bh=BMF+/cwRTuDiNf22Ih7rCcmsfWG+yJgPZFWrdXoEx6c=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=n+U4SVY4iBOBmPu8oDh1jERM8X0iXCxvnHTn08Sse6w7keaCvssmHqBRFCBzP20hW
         ESKnIO6QnuLQ69E/D4Xcdy7yANwuGbaLxDywxnxYk5yNP+vqhZl2Vb6O8pbNXWYkgX
         8i6vp2MjO+VdgOhoYPxHBa34yvKHBs7Zbi8dSh+QGzdobzFXc6tEWK7AwjJv4pSWdx
         zzkP9IlOaq5mlMrL3wgQfPQgyPpVn/9qHX7PSFA/+xmOnN1s9pIPUEZyVmHcwYUkxr
         Tv0me1z+zADY77hbFqHjg3tH3R/eQbpVaBwDVoOgeBCAmXjuPTeZr3kXW9+K2a48Fe
         n3EdgQoD/K7Sw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 8819A60A0C;
        Thu,  6 May 2021 16:35:27 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Patches for the 5.13 Merge Window, Part 1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-723be372-8df5-44b9-9e4f-def2eb929f8e@palmerdabbelt-glaptop>
References: <mhng-723be372-8df5-44b9-9e4f-def2eb929f8e@palmerdabbelt-glaptop>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-723be372-8df5-44b9-9e4f-def2eb929f8e@palmerdabbelt-glaptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.13-mw0
X-PR-Tracked-Commit-Id: f54c7b5898d31eda3d6608da13b55c0466ba49fe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 939b7cbc00906b02c6eae6a380ad6c24c7a1e043
Message-Id: <162031892755.29346.4410305055923494242.pr-tracker-bot@kernel.org>
Date:   Thu, 06 May 2021 16:35:27 +0000
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 05 May 2021 22:51:36 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.13-mw0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/939b7cbc00906b02c6eae6a380ad6c24c7a1e043

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
