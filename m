Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93B55429A74
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 02:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234695AbhJLAco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 20:32:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:45774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234084AbhJLAcm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 20:32:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 6DF8F606A5;
        Tue, 12 Oct 2021 00:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633998639;
        bh=bkMwLeKH3ox0U0DeJOTmFxxsfpGMgfAOO5x+b8hptYY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=W+kZ2Yy1fKgNWEeEX3iL2c1bssUdWxW6QvDkGIFIK2obSK+U458TpyRTg9SVI9oHI
         DO/MznPeU3afDSTquMGwnT6zLuCDTXukbg/Y+TsVCCIOZCsbYA6B0ihlxigZBvlTax
         uZ1jsmtdqnRbXmLOjdnttaTo4XHx/QwASN+QDVyv8T8aN7qqye1E2KxeE3dRog3ovT
         AlmVLQbm82L6MV9pWu9APglqxmfFf6dS1XwUVEzeSOGl/eF+Hjb1uyGtUkGtlxaIrA
         PprbEOSipCEDFW2VK2dP+BVUxnz85oJMUmYjR9wUGHfuD2YmZ434Pe79UlC3CIHnS9
         Er0VMIqxgV2LQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 626D8600DF;
        Tue, 12 Oct 2021 00:30:39 +0000 (UTC)
Subject: Re: [GIT PULL] workqueue fixes for v5.15-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YWSz3QlxFgafawt6@slm.duckdns.org>
References: <YWSz3QlxFgafawt6@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YWSz3QlxFgafawt6@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-5.15-fixes
X-PR-Tracked-Commit-Id: 57116ce17b04fde2fe30f0859df69d8dbe5809f6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0a5d6c641b671370f019cbe20fe51ee3ef00264c
Message-Id: <163399863939.7007.12638816961258721600.pr-tracker-bot@kernel.org>
Date:   Tue, 12 Oct 2021 00:30:39 +0000
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 11 Oct 2021 11:59:57 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-5.15-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0a5d6c641b671370f019cbe20fe51ee3ef00264c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
