Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4B9312072
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 00:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbhBFXVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 18:21:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:50148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229753AbhBFXVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 18:21:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id B40CE64DEC;
        Sat,  6 Feb 2021 23:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612653668;
        bh=TsfNUic6kbkF8Abe0yXNVuOcQxnbY8mWONq8jkHpyBU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=udn9k+8JuWC7Czyya0PPFAD6grxdy+S4qCjtid5SGp9T4IMbP+YqGruuceGZ5UaMO
         AAt0B75hmSho9T65kWO5detBcAZX8b5Q3DeXqk1pMxf8x0Ro0dylxqwRBSVkBlDG6O
         rnqjBWwUzefJiFrY4Y85Lop55sBUNoFOIWAUl4EBH2niKIv6cix3xAgUxdkJn4VlqA
         yGz70OR8WjVbTwfKhS8scJRMN11kSrMBNRcKkJTovn54XZL8bF3dN8qfTjsHkkJ6mk
         +2mY7a4yx1XnPwVYVT4GuvlCech3qMMgj8vQdP67mba1PKJvsRowUCmH74y//6eOXE
         INsk4bOTUoePw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id AB548609CE;
        Sat,  6 Feb 2021 23:21:08 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Fixes for 5.11-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-7c050ab0-3c41-4b21-b011-47b64a4b713e@palmerdabbelt-glaptop>
References: <mhng-7c050ab0-3c41-4b21-b011-47b64a4b713e@palmerdabbelt-glaptop>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-7c050ab0-3c41-4b21-b011-47b64a4b713e@palmerdabbelt-glaptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.11-rc7
X-PR-Tracked-Commit-Id: de5f4b8f634beacf667e6eff334522601dd03b59
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f7455e5d6897f275aaf5b6d964103ba295ac0cdd
Message-Id: <161265366869.26028.15837848350940601026.pr-tracker-bot@kernel.org>
Date:   Sat, 06 Feb 2021 23:21:08 +0000
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 06 Feb 2021 11:38:56 -0800 (PST):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.11-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f7455e5d6897f275aaf5b6d964103ba295ac0cdd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
