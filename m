Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1718F377864
	for <lists+linux-kernel@lfdr.de>; Sun,  9 May 2021 22:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbhEIUUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 16:20:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:48708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229815AbhEIUUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 16:20:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 4AF076141D;
        Sun,  9 May 2021 20:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620591539;
        bh=2wIOdcfwhq813dWms2tN8Q0G1DldsmeHmVFjzR5GYt0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=WChIrNCWM9mS2SXAkAA5jX7I9JqTaBBDtP+7XxpispkSEdQR0fnRaSefyrHRlUi9C
         8w9oqSIF3F8gP38w3UfNHckNQB8Uqult/6HnN8gwDGhUUNIXH2So5jQkDFy9lPUb24
         dipLirJHh9cLI78Ju/kLH1OW+yMrzscp+VJvK9tw72LdiELN52k5FbcVql0WiDQPdA
         n460Lc/K22CdU0ME7vl+hIqG+ssVXuPBNLH9cJ2jwhn2xdWCtfOaqCmBJCsiCnDvkt
         fOFu09wTRduy7tSiucPyWxAgsA4BHsVG9z3j5j/ASaFyxZIj5ayntivdWEgOJE23xE
         txv6KEqNyU57A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 4601B60A0B;
        Sun,  9 May 2021 20:18:59 +0000 (UTC)
Subject: Re: [GIT pull] locking/urgent for v5.13-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <162056748544.14888.14677703647311034371.tglx@nanos>
References: <162056748544.14888.14677703647311034371.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <162056748544.14888.14677703647311034371.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2021-05-09
X-PR-Tracked-Commit-Id: 51cf94d16860a324e97d1b670d88f1f2b643bc32
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 732a27a0891cb5db1a0f9c33a018ea6eca9a4023
Message-Id: <162059153928.28372.12536817317915375085.pr-tracker-bot@kernel.org>
Date:   Sun, 09 May 2021 20:18:59 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 09 May 2021 13:38:05 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2021-05-09

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/732a27a0891cb5db1a0f9c33a018ea6eca9a4023

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
