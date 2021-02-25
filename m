Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5AD3255B1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 19:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbhBYSjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 13:39:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:34826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233981AbhBYSha (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 13:37:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 4577964F25;
        Thu, 25 Feb 2021 18:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614278205;
        bh=kj4MiQx9IGPkpbsJ9A5gzeDR+u+FuD6x29WVjU9ClKE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=UJ6xPLir1VIYNKe2SqddlpXXmkYJGfcgElwxktH472z7fUAzhkDE53x09TOAGmJWB
         MFHtm9ug0UpA5ttbn6beNAr0PDh/eR/g+Lcsu0q3AW20LXLVy0RKg+ZJa1LbXE4vVR
         6WOuQZkyRe5NZ8IVjMtsr7wqHoANUiR2WwT2RV0gVJFjzb03vGRlB1r5h6JvCmVXlR
         6HAn9oPna3cubRU9ADBJpE7J454JI/X6mkgaCgdZrwXhYZ9zVnkFbjzr2oOELsmOAP
         bDWGdj//sbKdTGx6zivFdMojT2xQ/yGguZQHoyRxvbES8kb/j9yNpi3nDws/YBzrmQ
         Oak1fXi3DorNA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 40809609F5;
        Thu, 25 Feb 2021 18:36:45 +0000 (UTC)
Subject: Re: [GIT PULL] nds32 patches for 5.12-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAEbi=3f2UN+zn+L6Umhn30nGULp94QtVOT=H9+iYGrxyzmcR=w@mail.gmail.com>
References: <CAEbi=3f2UN+zn+L6Umhn30nGULp94QtVOT=H9+iYGrxyzmcR=w@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAEbi=3f2UN+zn+L6Umhn30nGULp94QtVOT=H9+iYGrxyzmcR=w@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/greentime/linux.git tags/nds32-for-linux-5.12
X-PR-Tracked-Commit-Id: 40e0dd851e7b7afe219820fb270b09016e41d4fc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6c15f9e805f22566d7547551f359aba04b611f9d
Message-Id: <161427820525.26451.13273472866779491469.pr-tracker-bot@kernel.org>
Date:   Thu, 25 Feb 2021 18:36:45 +0000
To:     Greentime Hu <green.hu@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Nickhu <nickhu@andestech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 25 Feb 2021 15:35:17 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/greentime/linux.git tags/nds32-for-linux-5.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6c15f9e805f22566d7547551f359aba04b611f9d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
