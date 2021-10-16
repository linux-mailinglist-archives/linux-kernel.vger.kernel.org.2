Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34ABB4303F1
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 19:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244431AbhJPRaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 13:30:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:50766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244409AbhJPRa2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 13:30:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 0B5FE610D1;
        Sat, 16 Oct 2021 17:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634405300;
        bh=1bn5gas+3rMRPrZGUa7pX/L5IwS3pGFwO5XAb/1LvT4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=PkTYoWtiKXZo0WpyGKK/BBHUq1EqkTUrsm3IGij09ej3FDBMKmSmvumNTbcnPgEM9
         nbRJTV2/xa2dMu1cHmVDroHMdIvD0EOsXb+t3m+RNaGDrIb6qF7EA/tZKWDSZVfxkJ
         TJ9yNfoW1BxhxR7CW2g2U5GGP4PUA8y/gsn+tvtlBhIraETQ5IpRbRT6465Jim/pWR
         O+fuKooN2Qr6w0/+75d8AALVCZUVq6YRsfoxygeDf6Kmjnmeuq8+gF4LjXgbldDznC
         xLdW8yJqfjrcx1DP0k11EL9z2Eo9CF7xOlvzCgpslVvmIdrMSk13GKgOpXefycqJbw
         szUlowOTRizMg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id ECECB609D3;
        Sat, 16 Oct 2021 17:28:19 +0000 (UTC)
Subject: Re: [GIT PULL] clk fixes for v5.15-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211016000534.972778-1-sboyd@kernel.org>
References: <20211016000534.972778-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-clk.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211016000534.972778-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus
X-PR-Tracked-Commit-Id: 92c02ff1a43edce37cf1b092bfad37d84d7e4ea6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6985c40ab6c5d63a494ce9adce9a4768364f2507
Message-Id: <163440529991.22586.5137798362034760928.pr-tracker-bot@kernel.org>
Date:   Sat, 16 Oct 2021 17:28:19 +0000
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 15 Oct 2021 17:05:34 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6985c40ab6c5d63a494ce9adce9a4768364f2507

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
