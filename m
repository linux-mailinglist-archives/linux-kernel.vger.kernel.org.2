Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA7FC3FBDDC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 23:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236975AbhH3VFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 17:05:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:39354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236633AbhH3VFM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 17:05:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 7AB1160F92;
        Mon, 30 Aug 2021 21:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630357458;
        bh=HRWBcdgJ+aLKUkoh9iGvNxGfqO2wBuXFh1d/ifrINzI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=bS4HRQY8kUyMew2pJ4E8xEK9JQA2kuhgzX1pAigAVKtXXKrPLJOpUQ4svzPK2Rko7
         xI0oQ2Bl4TfO394mMkv1aB1fGiFE0HuEVzcfRaiOF0+mjm3upad9IjGsGlHw8ddFn+
         H9LFG7eFKUYGOSsASOQbq9ELgev8ckXKBmasAldL+KcJO365DQKHNznRkDFvmUxnJR
         2h0p/tP4pMfrnjNTZMIpMYSGJWcLlYJUM5WKMD2gm1Vd3XNooKLcupqnvez/KNFOOA
         zIy/Et/0VyzQxMEJ8UC/TCzvzgmifaISkNMUAYiiyLI4AGWec+CSaAVL3jeYxeEUhF
         Z7tmjJuA1TROw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 6AA2C60A6F;
        Mon, 30 Aug 2021 21:04:18 +0000 (UTC)
Subject: Re: [GIT PULL] EFI changes for v5.15
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YSyug0TnmiHyhHEZ@gmail.com>
References: <YSyug0TnmiHyhHEZ@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YSyug0TnmiHyhHEZ@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-core-2021-08-30
X-PR-Tracked-Commit-Id: 1be72c8e0786727df375f11c8178ce7e65eea20e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 46f4945e2b39dda4b832909434785483e028419d
Message-Id: <163035745843.10236.3732332992160310940.pr-tracker-bot@kernel.org>
Date:   Mon, 30 Aug 2021 21:04:18 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 30 Aug 2021 12:10:11 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-core-2021-08-30

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/46f4945e2b39dda4b832909434785483e028419d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
