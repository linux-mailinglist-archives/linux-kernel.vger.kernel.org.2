Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1451F457746
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 20:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236210AbhKSTtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 14:49:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:45418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236149AbhKSTtR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 14:49:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 6F14B61AF0;
        Fri, 19 Nov 2021 19:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637351173;
        bh=BAPSiMNf24oxFkbo20Vax0yqWQI23M7l8iPHUj2eZGE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=tDOW7zZN8PmiCe5cG620D2bsCBmgRi3AokGIp6kXul9p0Xk5oxdfYugn8lxL1qUVZ
         nOa3l2p1SfwvwXOKf8Bohy82l2QAIfbeZUB2bZeEnBHAgdfv56zbrDRCAqUX405MuY
         ediD1B+9rXHuXA5UGtA2Azp68O93hEmMeYjZIXKkhsEJcDYS1eqNdkzZK4o0SFv8in
         ybJkIBAPPUw+I3Lp2n3I2HjIIAmaa5CaT5QtqFCNEWSVgMEhhqZh1y7K+fBtF/AI2d
         zwi43NVAyCaHrIB+9+siPu9/WR8ooraOQ6OFEHrmbDZ+gfy4gOChC6jNWBw1YunvrG
         73bKXdXbL7cnw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 5DE8960977;
        Fri, 19 Nov 2021 19:46:13 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Fixes for 5.16-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-fbf2cd0e-320d-4e42-a2f2-d5343d0a58b0@palmer-ri-x1c9>
References: <mhng-fbf2cd0e-320d-4e42-a2f2-d5343d0a58b0@palmer-ri-x1c9>
X-PR-Tracked-List-Id: <linux-riscv.lists.infradead.org>
X-PR-Tracked-Message-Id: <mhng-fbf2cd0e-320d-4e42-a2f2-d5343d0a58b0@palmer-ri-x1c9>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.16-rc2
X-PR-Tracked-Commit-Id: 5a19c7e06236a9c55dfc001bb4d1a8f1950d23e7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9539ba4308ad5bdca6cb41c7b73cbb9f796dcdd7
Message-Id: <163735117332.2946.15185064032950139254.pr-tracker-bot@kernel.org>
Date:   Fri, 19 Nov 2021 19:46:13 +0000
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 19 Nov 2021 08:18:46 -0800 (PST):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.16-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9539ba4308ad5bdca6cb41c7b73cbb9f796dcdd7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
