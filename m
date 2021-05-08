Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76CDF3773BE
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 20:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbhEHTAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 May 2021 15:00:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:52272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229552AbhEHTAo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 May 2021 15:00:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 86C4B610A7;
        Sat,  8 May 2021 18:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620500382;
        bh=tx918tkZbZwk5k4/pxpWS1CEZAX0ZmOIuptimUUWpZU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=UtRDVlrN+0I7NVTze6fxdx6ZWB8SR7HcB0rBVSwzCyNtvsk3nUlRGtdNGXwbZd+7Z
         OJq235Ii5ziA/UAN6xnDpH0pGcwK67KoqL0dJKjZfw8M3Gb6s7RAGAMtmZ0r4x/a2v
         ltaeb4Ppmv+3F3q0kUR4hCJ7g6Zl+tg3E4o2eV2UJJISbwD3eKBu1zWDHOASShv1xq
         GLP5hcS+u/6xP2bHkPRWh1gZdjj0C8NIDPsbv5ZHlNYl6p6xQxjHi36l35QwMwvevv
         Nv7qYfMxelixm2/yKpUrqqDWjjOEVE22Q7vL4MjjOuXDLQ6QayUGhVmtfThRu+l1Ff
         55gRINx2g7zPg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 739AE60A0C;
        Sat,  8 May 2021 18:59:42 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Fixes for the Merge Window, Part 2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-00f4b683-5870-489d-b713-aa5f18aaa6c5@palmerdabbelt-glaptop>
References: <mhng-00f4b683-5870-489d-b713-aa5f18aaa6c5@palmerdabbelt-glaptop>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-00f4b683-5870-489d-b713-aa5f18aaa6c5@palmerdabbelt-glaptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.13-mw1
X-PR-Tracked-Commit-Id: beaf5ae15a13d835a01e30c282c8325ce0f1eb7e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b741596468b010af2846b75f5e75a842ce344a6e
Message-Id: <162050038240.29908.7380888985130805845.pr-tracker-bot@kernel.org>
Date:   Sat, 08 May 2021 18:59:42 +0000
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 08 May 2021 11:25:56 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.13-mw1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b741596468b010af2846b75f5e75a842ce344a6e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
