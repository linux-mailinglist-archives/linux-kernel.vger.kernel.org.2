Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4F67407B1C
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 02:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234797AbhILAn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 20:43:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:44110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234191AbhILAnY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 20:43:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 0757C611C0;
        Sun, 12 Sep 2021 00:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631407331;
        bh=GYdlDYOD6WSKtAsowWnoOCTQHnkwdaUHqgJbDkDX6/I=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=R/KUgGcdkksStVuXXC/V9sK7p302yZy7psl04VzVAakYN+aEvIj90XFf4/RYigQq9
         kZjMYN2bhvW/YEFPdHir0gr5YwV2TUuadoAZh40iokqTCvVKkMe8S6WGVR8u0J8vpF
         SsLK/rhLZrYW8lOP1SERzHNP94pnqNEtJxSWXj4vShYmsrfUBy14a6mmeAVdr7q6NG
         AZCtV6bBqR6xUM4g4hPc6WSj1kJ/iyPIkf9GGKOomKIxYy20FpPpM2rw7Yd+eRBZfE
         vu8ZalY0aQTXe9ceCAE+lJvpiY6LvDNaH6byl8SxV1hxH4HpSQtPjjlBRp1eETvSMI
         iqVcjRaR49LSg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 012F960A0D;
        Sun, 12 Sep 2021 00:42:11 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Patches for the 5.15 Merge Window, Part 2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-b2b622b6-e788-4923-8cf2-ada90a2a095f@palmerdabbelt-glaptop>
References: <mhng-b2b622b6-e788-4923-8cf2-ada90a2a095f@palmerdabbelt-glaptop>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-b2b622b6-e788-4923-8cf2-ada90a2a095f@palmerdabbelt-glaptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.15-mw1
X-PR-Tracked-Commit-Id: 6f55ab36bef505b449723300a5a445ddc76a94d7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b79bd0d5102b4a3ea908018fda6b84a4c8fd6235
Message-Id: <163140733099.30830.91602493286682383.pr-tracker-bot@kernel.org>
Date:   Sun, 12 Sep 2021 00:42:10 +0000
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 11 Sep 2021 10:43:47 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.15-mw1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b79bd0d5102b4a3ea908018fda6b84a4c8fd6235

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
