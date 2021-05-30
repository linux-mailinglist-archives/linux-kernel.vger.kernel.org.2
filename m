Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E325B394F5B
	for <lists+linux-kernel@lfdr.de>; Sun, 30 May 2021 06:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbhE3Eb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 May 2021 00:31:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:50354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229610AbhE3Ebm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 May 2021 00:31:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 8B995611C2;
        Sun, 30 May 2021 04:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622349005;
        bh=CaEJl3x3VEThIk7xZIuEjNc+efMtgrlaI3SpxobHbkY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=q5axJgZlB7xPLEGlRH8rXLkitLF4RdQ0xTfjBecCwjj7plmYX149drR37HMe0oIa2
         P3KGfymprvpUNx8ErcJiCKeHQCRLr/xGumRPpbB/d/b6BEXQZqQZ3epMxE3AnEoQ6S
         RVsyVQWJ07tCgqCUKYXOENysyeXGBFdovJTR7jyYEn/afQIf/2geUYLgCZgImi4Ef0
         wZ6c1ND+6XNsx6xlLNF7vo437ENaUu2m7wnol510jPXfcuAZlN3ISObmycJzecHxxG
         Xri1wUOkpevrglLD1mPoGW9KvhWO8OE/u8VQXmFjKp+/Zm/hPydUIxHESLYrsDoLW9
         aXLitplFhl3Sg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 84DE3609D9;
        Sun, 30 May 2021 04:30:05 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Fixes for 5.13-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-5051d261-3f3c-405c-a9a0-68fb70aa7c71@palmerdabbelt-glaptop>
References: <mhng-5051d261-3f3c-405c-a9a0-68fb70aa7c71@palmerdabbelt-glaptop>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-5051d261-3f3c-405c-a9a0-68fb70aa7c71@palmerdabbelt-glaptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.13-rc4
X-PR-Tracked-Commit-Id: bab0d47c0ebb50ae0bcfa4e84986a60113bf7d6b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9d68fe84f8c52942c30febfec289c6219fe4f285
Message-Id: <162234900553.23697.6619086393235550234.pr-tracker-bot@kernel.org>
Date:   Sun, 30 May 2021 04:30:05 +0000
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 29 May 2021 10:22:16 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.13-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9d68fe84f8c52942c30febfec289c6219fe4f285

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
