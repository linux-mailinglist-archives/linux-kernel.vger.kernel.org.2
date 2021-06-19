Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD3AE3ADAC8
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 17:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234692AbhFSQAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 12:00:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:46162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234676AbhFSQAj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 12:00:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 337A161159;
        Sat, 19 Jun 2021 15:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624118308;
        bh=CCnEEpYjax/88/40kieIEn+5Hb9pnHYH+EwEkzyEOLY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ccU9c33kOR26j6t2T8xICsk0r5dPlwZaulQFZoUVZ72Dx+ZCux8CJACWfhxPcZ019
         oXhZ/IuwxFDpOsRM8PBTihfDHoUIyumzoxj6DKwws8T6KkZEicyOHbSasGa0e9WSAf
         bsUIUe2HHIqMxaAdc8NmpW68u0lyTvr+aMIyIiMTlt4hzn6oK3aAwl+FuX/hUuxZgm
         LHpKQmv6nom1iN9A6Lnujo5yfvDzSabDG8mV+PsuOTOaBV7vazjmHX0jTrrm1HNpwm
         NNQ/xUUFSwRw0zthWyZFDbbCWbU5bMAjiIl1LCNsxuWJPQsEA/DDa/Zd4TMXnHgs6L
         marHk6F3prXdA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 27EF460A02;
        Sat, 19 Jun 2021 15:58:28 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Fixes for 5.13-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-768bd541-d21a-4a3e-9c92-da08277ab3ba@palmerdabbelt-glaptop>
References: <mhng-768bd541-d21a-4a3e-9c92-da08277ab3ba@palmerdabbelt-glaptop>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-768bd541-d21a-4a3e-9c92-da08277ab3ba@palmerdabbelt-glaptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.13-rc7
X-PR-Tracked-Commit-Id: 7ede12b01b59dc67bef2e2035297dd2da5bfe427
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d9403d307dba1a71ee6462b22300c2d3be773b1c
Message-Id: <162411830815.5022.4024485479331822245.pr-tracker-bot@kernel.org>
Date:   Sat, 19 Jun 2021 15:58:28 +0000
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 19 Jun 2021 08:42:59 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.13-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d9403d307dba1a71ee6462b22300c2d3be773b1c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
