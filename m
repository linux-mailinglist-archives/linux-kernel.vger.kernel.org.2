Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 304FC4423C8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 00:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbhKAXNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 19:13:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:60352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232367AbhKAXNa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 19:13:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 09E8960F5A;
        Mon,  1 Nov 2021 23:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635808257;
        bh=6fqqVCVv9NJ47XoffYOmmBl36X/ZGcyOlUfJVnPy0a8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=aZAUOjeuM2pct+5sUtrfA5bG2VbLC6TSf2awbf6m0Y37i1eqDemqluSHY4uboi03E
         epEU/gNWKZMVds5oVcmh50XzEbVBjzA903H9BapsvIvMvo1dxYOhJALIUyQ2AbaKGC
         muPyr4QdplFHb7SfZnsrj62MemT8lb7g4RqCnmr2NzQKAaZrLJxBpvIIKIUuJ3pbKG
         hG5n0cQ1QODYvqrxs6e7ML5X0EVCZarobmosddC/fRPujDb+pUTk+MxmjrBolch4Vl
         FbA4cj8HLh6JIWcroSgv/V3uubnKh+gz1HQSpz5wPrFCwbSV0NW1DJTNa/qlCjgzIZ
         rDVj96yZKt8Bw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id E34A960AA4;
        Mon,  1 Nov 2021 23:10:56 +0000 (UTC)
Subject: Re: [GIT PULL] x86/cleanups for v5.16
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YX+6TDV7B8USNUji@zn.tnic>
References: <YX+6TDV7B8USNUji@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YX+6TDV7B8USNUji@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cleanups_for_v5.16_rc1
X-PR-Tracked-Commit-Id: a757ac555ce1dafca848aa090b66cd04b5ce40e7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 18398bb825eaa12c0d2f490767c2b85e531e0a4c
Message-Id: <163580825692.31036.10052536821834683170.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Nov 2021 23:10:56 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 1 Nov 2021 10:58:36 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cleanups_for_v5.16_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/18398bb825eaa12c0d2f490767c2b85e531e0a4c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
