Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D97644F4C6
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 20:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236054AbhKMTSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 14:18:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:53484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236033AbhKMTSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 14:18:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 659FC611EE;
        Sat, 13 Nov 2021 19:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636830911;
        bh=ScIWgWYvJ8P2kY6dDbMwPLMWNZW3j6/OQjomJoWBAfs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=O2zgksMRjJ7SJfuyYYyF/p97SWJ8qTruV48d8gYPcj9+RTgefUbsDEwsfvslQXwES
         ptbwD8uRAWHnKdIuFX3l2qiRrgWEV8I/ToTSbnkPlQF1mSP96d9DyYgpd+Y2EUVUl4
         FpizGcCJauYBsilxIsYHqtfsFriC1nv9rN84Qv0B6AnZ4H9cG9nOuNVY4v7LUWnsXk
         lWX2VOyyzwL7zHpMfhMysopWSeS6XxonSDbHDrFsf72y+7llenICpOtfgRAmvcD5LO
         +AJU02E4vzMvucyaYAuQK1Xr3G/MPbyRBzUPthGSFuVS8P8ffhtOaDy7RU+yD/pMlb
         pzQvlfLOVFdbg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 52A3860987;
        Sat, 13 Nov 2021 19:15:11 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Patches for the 5.16 Merge Window, Part 1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-109b0503-bc7c-4da8-8621-28aec8d9df59@palmer-ri-x1c9>
References: <mhng-109b0503-bc7c-4da8-8621-28aec8d9df59@palmer-ri-x1c9>
X-PR-Tracked-List-Id: <linux-riscv.lists.infradead.org>
X-PR-Tracked-Message-Id: <mhng-109b0503-bc7c-4da8-8621-28aec8d9df59@palmer-ri-x1c9>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.16-mw1
X-PR-Tracked-Commit-Id: ffa7a9141bb70702744a312f904b190ca064bdd7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b89f311d7e25eb246376ac10de46d6ecc6b6ed5c
Message-Id: <163683091127.10343.18209516046778739113.pr-tracker-bot@kernel.org>
Date:   Sat, 13 Nov 2021 19:15:11 +0000
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 12 Nov 2021 09:32:15 -0800 (PST):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.16-mw1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b89f311d7e25eb246376ac10de46d6ecc6b6ed5c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
