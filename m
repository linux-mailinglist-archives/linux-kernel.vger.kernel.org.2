Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E392331AE88
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Feb 2021 00:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbhBMXe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Feb 2021 18:34:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:58104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229690AbhBMXe0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Feb 2021 18:34:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id C038364E3D;
        Sat, 13 Feb 2021 23:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613259225;
        bh=48BTI87qPxYwZwb0+TlbgSOrURgCaQ7hgYp6X1cvtXs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=lsfUMDbgbrwTj81LSnJuy8NaqhIzWDf+qSFDBps8HRfAGaxs5eeQ0J3Jgr2eKdpVz
         65FKpBaM6hicxyv42Je/9yXIuOgA7Trc93tnEl/nFo5/h8xqnmyUlRJhMe2XK0KE4X
         uBL5Tuv1qiS32l8tcDFZkcu/Y6o0TCvRGRBNc49yFICa9FBPmKfrUDpL+LeFHgBhXF
         539nF02lPyJ1DoOGBTI6t60AkfBOPeAlVf4hFzKS1Kj9s1eSUqLZMcy0hqh4k2D2jf
         LfXS7zYV/8PcSn38ts+5HxCMVoEpc2KG4HWmLM1s0vG5RD2aScJxSznMjmA+7G7373
         2MpUXGuzn8U2g==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id BAE4560A2A;
        Sat, 13 Feb 2021 23:33:45 +0000 (UTC)
Subject: Re: [GIT PULL] clk fix for v5.11-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210213211952.1071982-1-sboyd@kernel.org>
References: <20210213211952.1071982-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210213211952.1071982-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus
X-PR-Tracked-Commit-Id: 245090ab2636c0869527ce563afbfb8aff29e825
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 358feceebbf68f33c44c6650d14455389e65282d
Message-Id: <161325922575.6166.15566733362572520126.pr-tracker-bot@kernel.org>
Date:   Sat, 13 Feb 2021 23:33:45 +0000
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 13 Feb 2021 13:19:52 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/358feceebbf68f33c44c6650d14455389e65282d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
