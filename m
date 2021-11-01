Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8F864423CB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 00:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbhKAXNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 19:13:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:60336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232377AbhKAXNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 19:13:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 673856109D;
        Mon,  1 Nov 2021 23:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635808257;
        bh=UwNa1ttIG0ovAc5FceGNT27iqto28XNErMaksty6ggU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=D+K+MccbXI2rxwt1OiKLVSx+8H8fW16zpcQTFiXvgr0qC5dvik/EGwm936xs3/A8E
         KfBuNNnMqYCdSFcvV9MujDuf1G+/Lhg7fLJq4xjtg3TE3+379M3qll80W8loRal3Z8
         vW3o61rZB7GWE2sB4K4LBIrsdGnalt1xKINqHLSp3UcE9wqP0X2i0Put32ie7EG17U
         NocXCfUuMPHjBVwlk/NdJkDk0wKbrq/SaCt4SkngPZMRZAXmm+8l6XUwVwvFa1D5BR
         Gigii7e92WJiSvF3qT3U9yQtfkbLDcUzZpqfioxD4WytYzkgVj+FUasgb5vX76hjQE
         OSY7CyetK9FdA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 54F9F60AA4;
        Mon,  1 Nov 2021 23:10:57 +0000 (UTC)
Subject: Re: [GIT PULL] x86/sgx for v5.16
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YX/IJN+v6JMRrhMh@zn.tnic>
References: <YX/IJN+v6JMRrhMh@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YX/IJN+v6JMRrhMh@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_sgx_for_v5.16_rc1
X-PR-Tracked-Commit-Id: ae095b16fc652f459e6c16a256834985c85ecc4d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 879dbe9ffebc1328717cd66eab7e4918a3f499bd
Message-Id: <163580825734.31036.7407046061256121350.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Nov 2021 23:10:57 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 1 Nov 2021 11:57:40 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_sgx_for_v5.16_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/879dbe9ffebc1328717cd66eab7e4918a3f499bd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
