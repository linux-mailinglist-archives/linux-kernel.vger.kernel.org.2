Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77CD53FAE43
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 21:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235882AbhH2Tzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 15:55:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:35252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233841AbhH2Tzw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 15:55:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 662AC60F38;
        Sun, 29 Aug 2021 19:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630266900;
        bh=qSZaGWrXv2BvjRQjy3dNV9sjJAusEBmIqCkbKcnCv3Q=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=I47Ih+YHG4w4GyCNCYmvwZcx4mnpG4wnAktq0HR43yFcGRapoUwndGmP4QEcle62N
         kQGbG49MfJdOLBBTS1zGeGRC7v1JJFJc1HGAcH3dOvX1PHii2c3AI9qFB4GH0Wanv7
         C73aSUFZN4BBwOD7TWfyVOpgDDwbtqV/8fA9nfsiQ9+VALM1eGIY8ofFKk+1jYjJIV
         PA0MUBNtI1U442Hbf7xVrLQATdOZ6O1yuL2qkHBr+bjS0Wcyez+tCZef5qks6maCpp
         SlXEdFHVMTYt3k5Bn/a3YeYW9UvMKCufaXu7qgqyX3e4puYoudjiRd2g6t/AB7u60z
         vU9IoqmNzFbBg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 5394E60A27;
        Sun, 29 Aug 2021 19:55:00 +0000 (UTC)
Subject: Re: [GIT PULL] clk fixes for v5.14-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210829194748.682333-1-sboyd@kernel.org>
References: <20210829194748.682333-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-clk.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210829194748.682333-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus
X-PR-Tracked-Commit-Id: 1669a941f7c4844ae808cf441db51dde9e94db07
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 90ac80dcd3136da7c5694835d6cad2010aa08798
Message-Id: <163026690028.341.316701234015266919.pr-tracker-bot@kernel.org>
Date:   Sun, 29 Aug 2021 19:55:00 +0000
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 29 Aug 2021 12:47:48 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/90ac80dcd3136da7c5694835d6cad2010aa08798

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
