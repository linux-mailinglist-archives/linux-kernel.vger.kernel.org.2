Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0AE44313D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 16:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233417AbhKBPJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 11:09:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:47328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232959AbhKBPJs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 11:09:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id A2C7760EE9;
        Tue,  2 Nov 2021 15:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635865633;
        bh=vGgOIedU91inK904/ppQAJzo1WWdA4MXUC4N5eNrS7Q=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=V1cwWAkln9Gbq5ABv0zxe2nfnohLp50rjKak1Nw1mVgwK1FKClT2EBpNv6ahsIW+0
         9DPuHV4X2nd8oSg0kJugBG/YG8lOKfEtbnlwkoQRPaKR14B3WZZv4GaWxCS9AkO9QF
         vi+gWHhkpYaa/zrOzscFaIDfi4W/aMq0/UF08XZeU1UTaT57qV2uVt+Y5DK5Y/IePo
         M1itjhybNFd8SQ1eFPXRhNWtUgNUjgboT7j/gsJbJ7t0EzkGrZvat7EjvO6KJgnHyn
         2ITp+I4hqCputaoMgJhrFSnr+f7E1fVEX89r+k3ysSzYG1DKWhrmOe3HSOmULR96BW
         Mq3GEEFYmKgSw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 8EEEF60A90;
        Tue,  2 Nov 2021 15:07:13 +0000 (UTC)
Subject: Re: [GIT PULL (not really)] x86/core for v5.16
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YX/AmFgkQ0AEqDaG@zn.tnic>
References: <YX/AmFgkQ0AEqDaG@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YX/AmFgkQ0AEqDaG@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_core_for_v5.16_rc1
X-PR-Tracked-Commit-Id: a72fdfd21e01c626273ddcf5ab740d4caef4be54
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cc0356d6a02e064387c16a83cb96fe43ef33181e
Message-Id: <163586563352.9311.11256252862591599788.pr-tracker-bot@kernel.org>
Date:   Tue, 02 Nov 2021 15:07:13 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 1 Nov 2021 11:25:28 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_core_for_v5.16_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cc0356d6a02e064387c16a83cb96fe43ef33181e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
