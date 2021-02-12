Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF83131A5DC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 21:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbhBLUNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 15:13:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:50876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230235AbhBLUNX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 15:13:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 7836964E92;
        Fri, 12 Feb 2021 20:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613160763;
        bh=P8k0fC9BSG9nrXSXE+Vd61XPd/KsPVIhH5V7FyvhpF8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=RZk/KN34LM9J0f1Dh9l3maPRYb+H3KuqZ2gq7B5wSRGgfH86mCphZ5NBSvAlNVBX2
         pE2mfuAcerYIcqliIyB4Hi+Wgk77WEjAFN1ZQr7R/wlMUien2Yn4Wwy9BRLEYpbQBo
         iFIBDhPTDA0nRGq9q24IijESHz8VibCPjGYnt8Vp7sbszkIvHxQRhDo++LkXU2X6R7
         LW5zQPnU/M2S/VRvBIuVU0ZmLSee/K9ouVyMv/DOw08jGy42rioOHF8rnNKjH+gph1
         GFE6rS437S4SDcPQpO+2bh63MiDkZHEdVVRT8iG4+t0YKU/3PUilc74NV8k9aLfXXw
         SfiE58MrozYzQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 6A8A260A2B;
        Fri, 12 Feb 2021 20:12:43 +0000 (UTC)
Subject: Re: [GIT PULL] A Single RISC-V Fix for 5.11-rc8 (or 5.11)
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-30cf4392-0de1-4d1c-89f6-d260a072350d@palmerdabbelt-glaptop>
References: <mhng-30cf4392-0de1-4d1c-89f6-d260a072350d@palmerdabbelt-glaptop>
X-PR-Tracked-List-Id: <linux-riscv.lists.infradead.org>
X-PR-Tracked-Message-Id: <mhng-30cf4392-0de1-4d1c-89f6-d260a072350d@palmerdabbelt-glaptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.11-rc8
X-PR-Tracked-Commit-Id: 3da3cc1b5f47115b16b5ffeeb4bf09ec331b0164
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f9516259804123c416c4a9de40bc2e14d686478e
Message-Id: <161316076342.13717.9203449225320030174.pr-tracker-bot@kernel.org>
Date:   Fri, 12 Feb 2021 20:12:43 +0000
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 12 Feb 2021 10:30:04 -0800 (PST):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.11-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f9516259804123c416c4a9de40bc2e14d686478e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
