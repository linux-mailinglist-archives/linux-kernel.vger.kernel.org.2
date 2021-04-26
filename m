Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6134E36B70F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 18:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234685AbhDZQlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 12:41:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:49024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234599AbhDZQlC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 12:41:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 240AA613BE;
        Mon, 26 Apr 2021 16:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619455221;
        bh=jlNeNLHEofEGtQaw6tDw4g2w9SO88WkFF+0m3/VinBc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gW/QNagjb1JXqpmDOKv0I4gANASbNFxq2+fwyta1K+tsScU7SQooiOx+YpxlrZdpg
         qP2s5jepSvz9sinKEYUZ+r0q/rU6YZS/tAQ4So1mU/ygSJsoEV0izR3q6tP8LNCYsm
         joj5+7mkHWb+3VzyAxAQ1f9SKaZecvalY/2XlAMkgqnDp5mgsVcRBXVRLDI3xCB7fH
         UVbTbvR0w0qlBE+2pa4po4tZ8B3Lar6dY5l0YkogHzkMTZqCN7WzPNcNoDnWDXNJlx
         5ijaXhs45b11LxgoOC35ZU8CipDiXejACLfe6/Haqaw/gjE1VIByZBqAJ1q/BADyw4
         +qLveN5178R5A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 1DD136094F;
        Mon, 26 Apr 2021 16:40:21 +0000 (UTC)
Subject: Re: [GIT PULL] x86/sgx for v5.13
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YIaWh9VSEMQnn5E2@zn.tnic>
References: <YIaWh9VSEMQnn5E2@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YIaWh9VSEMQnn5E2@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_sgx_for_v5.13
X-PR-Tracked-Commit-Id: 523caed9efbb049339706b124185c9358c1b6477
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 81a489790a4b9e269dbfc50aa054e71d554a910b
Message-Id: <161945522111.27394.4658331357992841374.pr-tracker-bot@kernel.org>
Date:   Mon, 26 Apr 2021 16:40:21 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 26 Apr 2021 12:31:35 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_sgx_for_v5.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/81a489790a4b9e269dbfc50aa054e71d554a910b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
